import 'package:flutter/material.dart';

void main() => runApp(const NestedScrollViewExampleApp());

class NestedScrollViewExampleApp extends StatelessWidget {
  const NestedScrollViewExampleApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NestedScrollViewExample(),
    );
  }
}

class NestedScrollViewExample extends StatelessWidget {
  const NestedScrollViewExample({Key? key});

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab 3'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Nested Scroll View Example'),
                pinned: true,
                expandedHeight: 150.0,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: tabs.map((String name) => Tab(text: name)).toList(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'images/img1.jpg', // Reemplaza con la ruta de tu imagen
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.extentAfter == 0) {
                          // Simulación de carga de más elementos en la lista
                          Future.delayed(Duration(seconds: 1), () {
                            showNotification(context, 'Cargando más elementos...');
                          });
                        }
                        return true; // Necesario para recibir notificaciones
                      },
                      child: Center(
                        child: CustomScrollView(
                          key: PageStorageKey<String>(name),
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: SliverFixedExtentList(
                                itemExtent: 72.0,
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text('Elemento $index en $name'),
                                      subtitle: Text('Descripción del elemento $index'),
                                      leading: Icon(Icons.star),
                                      onTap: () {
                                        showNotification(context, 'Tocaste el elemento $index en $name');
                                      },
                                    );
                                  },
                                  childCount: 20, // Cambia la cantidad de elementos en cada lista
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
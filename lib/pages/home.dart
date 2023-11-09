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
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text(''),
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
                          showNotification(context, 'Has llegado al final de la lista');
                        }
                        return true; // Necesario para recibir notificaciones
                      },
                      child: CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text('Ejemplo $index'),
                                  );
                                },
                                childCount: 31,
                              ),
                            ),
                          ),
                        ],
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
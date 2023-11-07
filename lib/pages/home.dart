import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfile(),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  double appBarOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Tania Juárez'),
                background: Image.asset(
                  'images/img.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              // Manejar el evento de desplazamiento aquí
              // Por ejemplo, actualizar el perfil del usuario si es necesario.
            }
            return false;
          },
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Align(
                  alignment: Alignment.center,
                  child: Text('Publicación $index', style: TextStyle(fontSize: 16.0)),
                ),
                subtitle: Align(
                  alignment: Alignment.center,
                  child: Text('Descripción de la publicación $index', style: TextStyle(fontSize: 14.0)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
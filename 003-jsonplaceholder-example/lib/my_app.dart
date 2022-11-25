import 'package:flutter/material.dart';
import 'package:jsonplaceholder_example/features/posts/presentation/views/posts_view.dart';
import 'package:jsonplaceholder_example/features/users/presentation/views/users_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jsonplaceholder example',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  static const List<Widget> _views = [
    UsersView(),
    PostsView(),
  ];
  static const _titles = ['Users', 'Posts'];

  /// Selected index.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _views[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: 'Posts',
          ),
        ],
      ),
    );
  }
}

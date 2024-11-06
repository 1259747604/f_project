import 'package:f_project/dao/login_dao.dart';
import 'package:f_project/util/navigator_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get _logoutBtn => ElevatedButton(
      onPressed: () => {LoginDao.logOut()}, child: const Text('登出'));

  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [_logoutBtn],
      ),
    );
  }
}

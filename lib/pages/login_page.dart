import 'package:f_project/dao/login_dao.dart';
import 'package:f_project/util/navigator_util.dart';
import 'package:f_project/util/string_util.dart';
import 'package:f_project/util/view_util.dart';
import 'package:f_project/widget/input_widget.dart';
import 'package:f_project/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [..._background(), _content()]));
  }

  _background() {
    return [
      Positioned.fill(
          child: Image.asset(
        "images/login-bg1.jpg",
        fit: BoxFit.cover,
      )),
      Positioned.fill(
          child: Container(
        decoration: const BoxDecoration(color: Colors.black54),
      ))
    ];
  }

  _content() {
    return Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(
          children: [
            hiSpace(height: 100),
            const Text(
              "账号密码登录",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            hiSpace(height: 40),
            InputWidget("请输入账号", onChanged: (text) {
              username = text;
              _checkInput();
            }, obscureText: false),
            hiSpace(height: 10),
            InputWidget("请输入密码", onChanged: (text) {
              password = text;
              _checkInput();
            }, obscureText: true),
            hiSpace(height: 45),
            LoginButton("登录",
                enable: loginEnable, onPressed: () => _login(context)),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => _jumpRegistration(),
                child: const Text(
                  "注册账号",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }

  _checkInput() {
    setState(() {
      bool enable = false;
      if (isNotEmpty(username) && isNotEmpty(password)) {
        enable = true;
      } else {
        enable = false;
      }
      loginEnable = enable;
    });
  }

  void _login(context) async {
    try {
      //需要添加await等登录完成没有问题后在跳转到首页
      var result =
          await LoginDao.login(userName: username!, password: password!);
      print('登录成功');
      NavigatorUtil.goToHome(context);
    } catch (e) {
      print(e.toString());
    }
  }

  void _jumpRegistration() async {
    Uri uri = Uri.parse(
        "https://api.geekailab.com/uapi/swagger-ui.html#/Account/registrationUsingPOST");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $uri";
    }
  }
}

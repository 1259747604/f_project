import 'package:f_project/dao/login_dao.dart';
import 'package:f_project/widget/banner_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final List<String> bannerList = [
    'https://gips3.baidu.com/it/u=119870705,2790914505&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720',
    'https://gips3.baidu.com/it/u=1907453080,4211057612&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f1000_1000',
    'https://gips0.baidu.com/it/u=3602490144,362167302&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
    'https://img0.baidu.com/it/u=2702865616,2265069128&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800',
  ];
  final double appBarAlphaOffset = 100;
  double appBarAlpha = 0;
  get _appBar => Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Center(
          child: Padding(padding: EdgeInsets.only(top: 40), child: Text('首页')),
        ),
      ));

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          _logoutBtn,
          const SizedBox(
            height: 800,
            child: Center(
              child: Text('首页内容'),
            ),
          ),
        ],
      );

  get _logoutBtn =>
      TextButton(onPressed: () => {LoginDao.logOut()}, child: const Text('登出'));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(children: [
      MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification &&
                notification.depth == 0) {
              _onScroll(notification.metrics.pixels);
            }
            return false;
          },
          child: _listView,
        ),
      ),
      _appBar,
    ]));
  }

  _onScroll(double offset) {
    double alpha = offset / appBarAlphaOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  bool get wantKeepAlive => true;
}

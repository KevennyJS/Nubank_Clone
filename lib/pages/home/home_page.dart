import 'package:flutter/material.dart';
import 'package:nubank_clone/pages/home/widgets/my_app_bar.dart';
import 'package:nubank_clone/pages/home/widgets/my_dots_app.dart';
import 'package:nubank_clone/pages/home/widgets/page_view_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showMenu;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _AlturaDaTela = MediaQuery.of(context).size.height;
    double _LarguraDaTela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            ontap: () {
              setState(() {
                _showMenu = !_showMenu;
              });
            },
          ),
          PageViewApp(
            top: _AlturaDaTela * .24,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Positioned(
            top: _AlturaDaTela * .80,
            child: MyDotsApp(
              currentIndex: _currentIndex,
            ),
          )
        ],
      ),
    );
  }
}

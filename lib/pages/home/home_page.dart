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
  double _yPosition;

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _AlturaDaTela = MediaQuery.of(context).size.height;
    if (_yPosition == null) {
      _yPosition = _AlturaDaTela * .24;
    }
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
                _yPosition = _showMenu ? _AlturaDaTela * .75 : _AlturaDaTela * .24;
              });
            },
          ),
          PageViewApp(
            showMenu: _showMenu,
            top: _yPosition,
            //!_showMenu ? _AlturaDaTela * .24 : _AlturaDaTela * .75,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onPanUpdate: (details) {
              double positionToplimit = _AlturaDaTela * .24;
              double positionBottonlimit = _AlturaDaTela * .75;
              double middlePosition = positionToplimit - positionBottonlimit;
              middlePosition = middlePosition / 2;
              setState(() {
                _yPosition += details.delta.dy;
                _yPosition = _yPosition < positionToplimit
                    ? positionToplimit
                    : _yPosition;
                _yPosition = _yPosition > positionBottonlimit
                    ? positionBottonlimit
                    : _yPosition;
                if (_yPosition != positionBottonlimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionToplimit + middlePosition - 50
                          ? positionBottonlimit
                          : _yPosition;
                }
                if (_yPosition != positionToplimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottonlimit - middlePosition
                      ? positionToplimit
                      : _yPosition;
                }
                if (_yPosition == positionBottonlimit) {
                  _showMenu = true;
                } else if (_yPosition == positionToplimit) {
                  _showMenu = false;
                }
              });
            },
          ),
          MyDotsApp(
            top: _AlturaDaTela * .80,
            currentIndex: _currentIndex,
          )
        ],
      ),
    );
  }
}

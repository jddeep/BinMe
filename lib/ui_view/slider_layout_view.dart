import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rrr/constants/constants.dart';
import 'package:rrr/model/slider.dart';
import 'package:rrr/screens/signup/loginPage.dart';
import 'package:rrr/widgets/slide_dots.dart';
import 'package:rrr/widgets/slide_items/slide_item.dart';
import 'package:rrr/utils/customRouteTransition.dart';
import 'package:rrr/screens/mainPage.dart';

class SliderLayoutView extends StatefulWidget {
  final FirebaseUser user;
  SliderLayoutView({@required this.user});
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  CustomRouteTransition _customRouteTransition = CustomRouteTransition();

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   if (_currentPage < 2) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      print(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (ctx, i) => SlideItem(i),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                        child: InkWell(
                          onTap: () {
                            if (_currentPage == sliderArrayList.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                _customRouteTransition.createPageRoute(
                                  navigateTo: widget.user == null
                                      ? LoginPage()
                                      : MainPage(
                                          selIndex: 0,
                                          user: widget.user,
                                        ),
                                ),
                              );
                            } else {
                              _pageController.animateToPage(
                                _currentPage = _currentPage + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Text(
                            Constants.NEXT,
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              _customRouteTransition.createPageRoute(
                                navigateTo: widget.user == null
                                    ? LoginPage()
                                    : MainPage(
                                        selIndex: 0,
                                        user: widget.user,
                                      ),
                              ),
                            );
                          },
                          child: Text(
                            Constants.SKIP,
                            style: TextStyle(
                                fontFamily: Constants.OPEN_SANS,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}

library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nav_bar/screens/Sermon.dart';
import 'package:nav_bar/screens/about-us.dart';
import 'package:nav_bar/screens/direction.dart';
import 'package:nav_bar/screens/give-online.dart';


class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = 
  [
    Sermon(),
    Direction(),
    AboutUs(),
    GiveOnline(),    
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        currentIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onTappedBar: (int index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.ondemand_video, color: Colors.red,),
            title: Text('Sermon',style: TextStyle(color: Colors.black,)),
            activeColor: Colors.grey.shade900,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.location_on, color: Colors.lightGreen,),
            title: Text('Direction',style: TextStyle(color: Colors.black,)),
            activeColor: Colors.grey.shade900,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bubble_chart,color: Colors.pinkAccent),
            title: Text('About Us',style: TextStyle(color: Colors.black,)),
            activeColor: Colors.grey.shade900,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Colors.blueGrey,),
            title: Text('Give Online',style: TextStyle(color: Colors.black,)),
            activeColor: Colors.grey.shade900,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  final int currentIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onTappedBar;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  BottomNavyBar({
    Key key,
    this.currentIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onTappedBar,
    this.curve = Curves.linear,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onTappedBar != null);
    assert(curve != null);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onTappedBar(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == currentIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key key,
    @required this.item,
    @required this.isSelected,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    @required this.iconSize,
    this.curve = Curves.linear,
  })  : assert(isSelected != null),
        assert(item != null),
        assert(backgroundColor != null),
        assert(animationDuration != null),
        assert(itemCornerRadius != null),
        assert(iconSize != null),
        assert(curve != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor == null
                            ? item.activeColor
                            : item.inactiveColor,
                  ),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;

  BottomNavyBarItem({
    @required this.icon,
    @required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}

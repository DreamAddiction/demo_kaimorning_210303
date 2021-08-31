
import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BodyTab extends StatefulWidget {

  final int selectedTab;
  final Function tab1;
  final Function tab2;
  final Function tab3;

  BodyTab({this.selectedTab = 0, this.tab1, this.tab2, this.tab3});

  @override
  State<StatefulWidget> createState() => _BodyTabState();
}

class _BodyTabState extends State<BodyTab> {


  @override
  Widget build( BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 50.0,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      '대기중',
                      style: TextStyle(color: widget.selectedTab == 0 ? Colors.lightGreen : Colors.black26,),
                    ),
                  ),
                  onTap: widget.tab1,
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      '진행중',
                      style: TextStyle(color: widget.selectedTab == 1 ? Colors.lightBlue : Colors.black26,),
                    ),
                  ),
                  onTap: widget.tab2,
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      '완료',
                      style: TextStyle(color: widget.selectedTab == 2 ? Colors.red : Colors.black26,),
                    ),
                  ),
                  onTap: widget.tab3,
                ),
              ),
            ],
          ),
        ),
        _selectedIndicator()
      ],
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 53;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: widget.selectedTab == 0
          ? Alignment.centerLeft
          : widget.selectedTab == 1
          ? Alignment.center
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 3,
        color: widget.selectedTab == 0
            ? Colors.lightGreen
            : widget.selectedTab == 1
            ? Colors.lightBlue
            : Colors.red,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

}
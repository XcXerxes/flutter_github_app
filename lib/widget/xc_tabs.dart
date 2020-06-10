
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XcTabs extends StatelessWidget {
  final currentIndex;
  final List<String>tabs;
  final Function onPressed;
  XcTabs(this.tabs, this.currentIndex, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      height: ScreenUtil().setHeight(76),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        // borderRadius: BorderRadius.circular(5.0)
      ),
      child: Row(
        children: tabs.map((e) => InkWell(
          onTap: () {
            if (tabs.indexOf(e) != currentIndex) {
              onPressed(tabs.indexOf(e));
            }
          },
          child: Container(
            width: ScreenUtil.mediaQueryData.size.width / tabs.length,
            alignment: Alignment.center,
            child: Text(e, style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: currentIndex == tabs.indexOf(e) ? Colors.white : Colors.white60
            ),),
          ),
        )).toList(),
      ),
    );
  }
}

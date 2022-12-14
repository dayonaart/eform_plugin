import 'package:eformplugin/doa/lib/src/components/header-form.dart';
import 'package:flutter/material.dart';

class CustomBodyWidgets extends StatelessWidget {
  const CustomBodyWidgets(
      {Key? key,
      required this.content,
      this.pathHeaderIcons = "",
      this.headerTextStep = '',
      required this.headerTextDetail,
      this.isWithIconHeader = true,
      this.headerMarginTop = 0,
      this.marginleft = 24,
      this.marginright = 24,
      this.headerMarginBottom = 32,
      this.headerMarginLeft = 0,
      this.headerMarginRight = 0})
      : super(key: key);
  final Widget content;
  final bool isWithIconHeader;
  final String pathHeaderIcons, headerTextStep;
  final Widget headerTextDetail;
  final double headerMarginTop,
      headerMarginBottom,
      headerMarginLeft,
      marginleft,
      marginright,
      headerMarginRight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isWithIconHeader
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: headerMarginBottom,
                      top: headerMarginTop,
                      right: headerMarginRight,
                      left: headerMarginLeft),
                  child: headerForm(
                      pathHeaderIcons, headerTextStep, headerTextDetail),
                )
              : SizedBox(),
          isWithIconHeader
              ? SizedBox()
              : SizedBox(
                  height: 24,
                ),
          Padding(
            padding: EdgeInsets.only(left: marginleft, right: marginright),
            child: content,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:motta/utils/colors.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key, required this.isActive,
  });
final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
        bottom: 2,
      ),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(color:CRMAppColorPallete.lightBlue,borderRadius: BorderRadius.all(Radius.circular(12))),
      height: 4,
      width: isActive ? 20 : 0,
      
    );
  }
}
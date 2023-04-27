import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AnimationButtonBar extends StatelessWidget {
  final GestureTapCallback function;
  final bool check;
  final String icon, title;

  const AnimationButtonBar(
      {required this.function,
        required this.check,
        required this.icon,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(
              icon,
              width: check ? 17 : 20,
              color: check
                  ? AppTheme.colorAccent
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title.toUpperCase(),
            style: TextStyle(
                color: check
                    ?  AppTheme.colorAccent
                    :  Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
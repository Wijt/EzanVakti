import 'package:EzanVakti/ui/helper/AppStrings.dart';
import 'package:EzanVakti/ui/styles/appBorderRadius.dart';
import 'package:EzanVakti/ui/styles/appBoxShadow.dart';
import 'package:EzanVakti/ui/styles/appTextStyles.dart';
import 'package:EzanVakti/ui/widgets/appLogo.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.0),
      child: Container(
        decoration: _buildBoxDecoration,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppLogo(color: Theme.of(context).primaryColor, height: 30),
                Helper.sizedBoxW20,
                Text(AppStrings.appName, style: AppTextStyles.appBarTextStyles),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration get _buildBoxDecoration =>
      BoxDecoration(color: Colors.white, borderRadius: AppBorderRadius.appBarRadius, boxShadow: [AppBoxShadow.materialShadow]);

  @override
  Size get preferredSize => Size.fromHeight(90.0);
}

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum AppButtonStyle { primary, secondary }

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final AppButtonStyle style;

  const AppButton(
      {required this.title,
      this.onPressed,
      this.style = AppButtonStyle.primary,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      color: style._color,
      child: Text(
        title,
        style: TextStyle(color: style._textColor, fontSize: 16),
      ).tr(),
      onPressed: onPressed,
      cupertino: (context, platform) => CupertinoButtonData(),
      materialFlat: (context, platform) => MaterialFlatButtonData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding:
            const EdgeInsets.only(bottom: 15, top: 15, left: 50, right: 50),
      ),
    );
  }
}

extension on AppButtonStyle {
  Color get _color {
    switch (this) {
      case AppButtonStyle.primary:
        return AppColor.primary;

      case AppButtonStyle.secondary:
        return AppColor.secondary;
    }
  }

  Color get _textColor {
    switch (this) {
      case AppButtonStyle.primary:
        return AppColor.text;

      case AppButtonStyle.secondary:
        return AppColor.backgroundLight1;
    }
  }
}

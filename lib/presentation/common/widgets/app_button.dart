import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum AppButtonStyle { primary, secondary }

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final AppButtonStyle style;
  final double radius;
  final bool loading;

  const AppButton(
      {required this.title,
      this.onPressed,
      this.style = AppButtonStyle.primary,
      this.radius = 24.0,
      this.loading = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      color: style._color,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: style._textColor, fontSize: 16),
            ).tr(),
          ),
          loading ?
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                color: style._textColor,
                strokeWidth: 2,
              ),
            ),
          ) : const SizedBox.shrink()
        ],
      ),
      onPressed: onPressed,
      disabledColor: AppColor.backgroundLight2,
      cupertino: (context, platform) => CupertinoButtonData(
        borderRadius: BorderRadius.circular(radius),
      ),
      materialFlat: (context, platform) => MaterialFlatButtonData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        disabledTextColor: AppColor.textDark3,
        padding:
            const EdgeInsets.only(bottom: 15, top: 15, right: 16),
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

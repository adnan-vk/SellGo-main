import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class snackBarWidget {
  iconSnackSuccess(context, {label}) {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.success,
      label: label,
    );
  }

  iconSnackFail(context, {label}) {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: label,
    );
  }

  topsnackBar(context, {message}) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }

  iconSnackAlert(context, {label}) {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.alert,
      label: label,
    );
  }
}

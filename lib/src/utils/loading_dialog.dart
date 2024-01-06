import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(),
          child: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset('assets/lottie/download.json'),
            ),
          ),
        ),
      );
    },
  );
}

void hideLoading({required BuildContext? context}) async {
  if (context != null) Navigator.pop(context);
}

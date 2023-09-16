import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showDialog(
      {String? title,
      String? content,
      String? confirmText,
      void Function()? onConfirm}) {
    Get.defaultDialog(
      confirm: TextButton(
        onPressed: () {
          onConfirm!();
          Get.back();
        },
        child: Text(
          confirmText ?? 'Đồng ý',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Huỷ bỏ'),
      ),
      titlePadding: const EdgeInsets.only(top: 15, bottom: 15),
      title: title ?? 'Xác nhận',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      radius: 14,
      middleText: content ?? "Do you want?",
    );
  }
}

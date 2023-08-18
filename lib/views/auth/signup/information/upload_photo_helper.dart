import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint(pickedFile.path);
      return File(pickedFile.path);
    }
    else {
      return null;
    }
  } catch (e) {
    throw 'No file attached';
  }
}

Future<File?> pickImageFromCamera() async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      debugPrint(pickedFile.path);
      return File(pickedFile.path);
    }
    else {
      return null;
    }
  } catch (e) {
      throw 'Permission denied';
  }
}
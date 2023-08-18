import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/views/auth/helpers/error_message.dart';
import 'package:lettutor_client/views/auth/signup/information/upload_photo_helper.dart';

class UploadImageCubit extends Cubit<File?> {
  UploadImageCubit() : super(null);

  Future<void> uploadImage(BuildContext context) async {
    try {
      final image = await pickImageFromGallery();
      emit(image);
    } catch (e) {
      Navigator.pop(context);
      errorMessage('Vui lòng cấp quyền truy cập thư viện ảnh', context);
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      final image = await pickImageFromCamera();
      emit(image);
    } catch(e) {
      Navigator.pop(context);
      errorMessage('Vui lòng cấp quyền truy cập camera', context);
    }
  }

  Future<void> deleteImage() async {
    emit(null);
  }
}
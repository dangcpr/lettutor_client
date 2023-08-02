// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/constants/server.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  ),
);
    

class AccountController {
  static Future<bool> login() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> signup(String email, String password, String rePassword) async {
    try {
      Response response = await dio.post('$urlServer/signup', 
        data: {
          'email': email,
          'password': password,
          'rePassword': rePassword
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            'Content-Type': 'application/json',
          }
        ),
      );

      //Status Code
      if (response.statusCode == 200) {
        return 1;
      }

      if (response.statusCode == 401) {
        if(response.data['error'] == 210) {
          return 0;
        }
        else {
          return 2;
        }
      } else {
        return 2;
      }
    } on DioException catch (e) {
      debugPrint(e.type.toString());
      if(e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout) {
        return 3;
      }

      if(e.type == DioExceptionType.unknown) {
        return 4;
      }
      
      return 5;
    }
  }
}
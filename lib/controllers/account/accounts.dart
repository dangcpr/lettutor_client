// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/constants/server.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: '$urlServer/account',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ),
);
    

class AccountController {
  static Future<int> login(String email, String password) async {
    try {
      Response response = await dio.post('/signup', 
        data: {
          'email': email,
          'password': password,
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

      //Đăng nhập thành công
      if(response.statusCode == 200) {
        return 1;
      }

      //Lỗi về input
      if(response.statusCode == 400) {
        return 2;
      }

      if(response.statusCode == 401) {
        //Lỗi email không tồn tại
        if(response.data['error'] == 110) {
          return 3;
        }
        //Lỗi password không đúng
        else {
          return 4;
        }
      }
      else {
        return 0;
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

  static Future<int> signup(String email, String password, String rePassword) async {
    try {
      Response response = await dio.post('/signup', 
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
// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/constants/server.dart';
import 'package:lettutor_client/models/accounts.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: '$urlServer/account',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ),
);
    

class AccountController {
  Future<Account> login(String email, String password) async {
    try {
      Response response = await dio.post('/login', 
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

      if(response.statusCode == 200) {
        //Lấy cookies của response
        debugPrint(response.headers['set-cookie']![0].split(';').toString());
        debugPrint(response.headers['set-cookie']![1].split(';').toString());
        return Account.fromJson(jsonEncode(response.data['result']));
      }
      else {
        debugPrint('failed');
        throw 'Wrong Email or Password';
      }
      
    } on DioException catch (e) {
      debugPrint(e.type.toString());
      if(e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      }

      if(e.type == DioExceptionType.unknown) {
        throw 'Internet Error';
      }
      throw 'Server Error';
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
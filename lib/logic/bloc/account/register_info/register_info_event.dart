import 'package:dio/dio.dart';

abstract class RegisterInfoEvent {}

class RegisterInfoPressed extends RegisterInfoEvent {
  FormData formData;
  RegisterInfoPressed({required this.formData});
}

class RegisterInfoInitialEvent extends RegisterInfoEvent {}
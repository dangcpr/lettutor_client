import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_client/constants/categories.dart';
import 'package:lettutor_client/constants/countries.dart';
import 'package:lettutor_client/constants/levels.dart';
import 'package:lettutor_client/logic/bloc/account/register_info/register_info_bloc.dart';
import 'package:lettutor_client/logic/bloc/account/register_info/register_info_event.dart';
import 'package:lettutor_client/logic/bloc/account/register_info/register_info_state.dart';
import 'package:lettutor_client/logic/cubit/register_info/upload_image.dart';
import 'package:lettutor_client/views/auth/helpers/error_message.dart';
import 'package:lettutor_client/views/auth/helpers/success_message.dart';
import 'package:lettutor_client/views/auth/signup/information/upload_photo_popup.dart';
import 'package:lettutor_client/views/settings/button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterInfomationScreen extends StatefulWidget {
  const RegisterInfomationScreen({super.key});

  @override
  State<RegisterInfomationScreen> createState() => _RegisterInfomationScreenState();
}

class _RegisterInfomationScreenState extends State<RegisterInfomationScreen> {
  //Parameter
  File? imageFile;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController DOB = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? _country;
  String? _level;
  List<String?> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RegisterInfoBloc>(context).add(RegisterInfoInitialEvent());
  }

  @override
  Widget build(BuildContext context) {    
    final user = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    debugPrint(user!['email']);
    var brightness = Theme.of(context).brightness;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          actions: [
            const ButtonSettingSystem(),
          ],
        )
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0), 
                child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.registerInfo, style: Theme.of(context).textTheme.headlineLarge))
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0), 
                child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.registerInfoSub, style: Theme.of(context).textTheme.headlineSmall)),
              ),
              SizedBox(
                height: 400,
                child: Align(alignment: Alignment.center, 
                  child: ListView(
                    children: [
                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: context.watch<UploadImageCubit>().state == null ? Image.asset('assets/images/no_avatar.png', height: 100, width: 100) : Image.file(context.watch<UploadImageCubit>().state!, height: 100, width: 100),
                          ),
                          Column(
                            children: [
                              IconButton(
                                iconSize: 25,
                                onPressed: () async {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context)=> ChooseOptionImage(context),
                                  );
                                },
                                icon: Icon(Icons.file_upload),
                              ),
                              IconButton(
                                iconSize: 25,
                                onPressed: () async {
                                  context.read<UploadImageCubit>().deleteImage();
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )
                        ]
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.firstandlast,
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.firstandlastHelper;
                              }
                              return null;
                            },
                          ),
                        )
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            validator: (value) {
                              if(value == null) {
                                return AppLocalizations.of(context)!.countryHelper;
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.country,
                              prefixIcon: Icon(Icons.flag),
                            ),
                            items: countries.map((country) {
                              return DropdownMenuItem(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            onChanged: (val) {
                              _country = val as String?;
                            },
                            value: _country,
                          )
                        )
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.phone,
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.phoneHelper;
                              }
                              if(value.length < 10 || value.length > 11) {
                                return AppLocalizations.of(context)!.phoneHelperTenChacs;
                              }
                              return null;
                            },
                          ),
                        )
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: DOB,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.dob,
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.dobHelper;
                              }
                              return null;
                            },
                            onTap: () {
                              _selectDate(context, brightness);
                            },
                          ),
                        )
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            validator: (value) {
                              if(value == null) {
                                return AppLocalizations.of(context)!.levelHelper;
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.level,
                              prefixIcon: Icon(Icons.stairs),
                            ),
                            value: _level,
                            items: levels.map((level) {
                              return DropdownMenuItem(
                                value: level,
                                child: level == 'PA1' ? Text('Pre A1 - Pre Beginner') : 
                                level == 'A1' ? Text('A1 - Beginner') :
                                level == 'A2' ? Text('A2 - Elementary') :
                                level == 'B1' ? Text('B1 - Intermediate') :
                                level == 'B2' ? Text('B2 - Upper Intermediate') :
                                level == 'C1' ? Text('C1 - Advanced') :
                                Text('C2 - Proficiency')
                              );
                            }).toList(),
                            onChanged: (val) {
                              _level = val as String;
                            },
                          )
                        )
                      ),
                      SizedBox(
                        height: 150,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: MultiSelectChipField(
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.topicHelper;
                              }
                              return null;
                            },
                            searchIcon: Icon(Icons.category),
                            items: categories.map((category) => MultiSelectItem<String?>(category, category)).toList(),
                            initialValue: _selectedCategories,
                            title: Text(AppLocalizations.of(context)!.topic, style: Theme.of(context).textTheme.bodyMedium),
                            headerColor: Colors.transparent,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0)
                            ),
                            selectedChipColor: Theme.of(context).primaryColor,
                            selectedTextStyle: TextStyle(color: Colors.white),
                            onTap: (values) {
                              _selectedCategories = values;
                            },
                          )            
                        )
                      )
                    ]
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate() == false) {
                      return null;
                    } else {
                      BlocProvider.of<RegisterInfoBloc>(context).add(
                        RegisterInfoPressed(
                          formData: FormData.fromMap({
                            'email': user['email'],
                            'password': user['pass'],
                            'name': name.text,
                            'country': _country,
                            'phone': phone.text,
                            'DOB': DOB.text,
                            'level': _level,
                            'learn': _selectedCategories,
                            'avatar': context.read<UploadImageCubit>().state == null ? null : await MultipartFile.fromFile(context.read<UploadImageCubit>().state!.path)
                          })
                        )
                      );
                    }
                  },
                  child: BlocBuilder<RegisterInfoBloc, RegisterInfoState>(
                    builder: (context, state) {
                      if(state is RegisterInfoLoading) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );
                      }

                      if(state is RegisterInfoSuccess) {
                        successMessage("Đăng ký thành công", context);
                        return Text(AppLocalizations.of(context)!.registerInfo);
                      }

                      if(state is RegisterInfoError) {
                        if(state.message == 'Wrong information') {
                          errorMessage("Thông tin chưa chính xác", context);
                        }
                        else if (state.message == 'Connection Timeout') {
                          errorMessage(AppLocalizations.of(context)!.timeoutError, context);
                        }
                        else if (state.message == 'Internet Error') {
                          errorMessage(AppLocalizations.of(context)!.internetError, context);
                        }
                        else {
                          errorMessage(AppLocalizations.of(context)!.serverError, context);
                        }
                        return Text(AppLocalizations.of(context)!.registerInfo);
                      }

                      return Text(AppLocalizations.of(context)!.registerInfo);
                    }
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.alreadyHaveAccount + ' '),
                    RichText(
                      text: TextSpan (
                        text: AppLocalizations.of(context)!.loginNow,
                        style: Theme.of(context).textTheme.labelMedium,
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                      )
                    ),
                  ],
                )
              ),
            ],
          )
        )
      )
    );
  }
  
  Future<void> _selectDate(BuildContext context, Brightness brightness) async {
    debugPrint(brightness.toString());
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
        data: brightness == Brightness.light ? ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ) : 
        ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: Colors.black,
        ),
        child: child!,
      ),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      debugPrint(picked.toString());
      selectedDate = picked;
      DOB.text = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
    } else {
      DOB.text = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
    }
  }

}
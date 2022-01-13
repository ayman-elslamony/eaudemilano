import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/UserProvider.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _locale;
  bool isPassword = true;
  bool _nameValidator = false;
  bool _emailValidator = false;
  bool _mobileValidator = false;
  bool _passwordValidator = false;

  @override
  void initState() {
    super.initState();
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
     nameController.text = Helper.userName;
     emailController.text = Helper.userEmail;
     mobileController.text = Helper.userPhone;
  }

  void changePasswordVisibility() {
    setState(() {
      isPassword = !isPassword;
    });
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate() &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        mobileController.text.isNotEmpty) {
      form.save();
      Provider.of<UserDataProvider>(context, listen: false).UpdateProfile(
        context: context,
        locale: _locale,
        name: nameController.text,
        phone: mobileController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 19,
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('edit_profile')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: media.width,
        height: media.height,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF060606),
                Color(0xFF747474),
              ],
            ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Consumer<UserDataProvider>(
              builder: (context, updateProfile, child) => Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: media.height * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        //color: secondaryColor,
                        border: Border.all(color: primeColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Image.asset(
                          'images/user.png',
                          color: secondaryColor,
                          fit: BoxFit.fill,
                          height: media.height * 0.13,
                          width: media.width * 0.25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultFormField(
                      label:
                          '${AppLocalizations.of(context).trans('user_name')}',
                      onTap: () {
                        setState(() {
                          _nameValidator = false;
                        });
                      },
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String val) {
                        if (val == null || val.isEmpty) {
                          setState(() {
                            _nameValidator = true;
                          });
                        } else {
                          setState(() {
                            _nameValidator = false;
                          });
                        }
                        return null;
                      },
                    ),
                    _nameValidator
                        ? Align(
                            alignment: AppLocalizations.of(context)
                                        .locale
                                        .languageCode ==
                                    "en"
                                ? Alignment.centerRight
                                : Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                '${AppLocalizations.of(context).trans('invalid_name')}',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 11),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      label: '${AppLocalizations.of(context).trans('email')}',
                      onTap: () {
                        setState(() {
                          _emailValidator = false;
                        });
                      },
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String val) {
                        if (val == null || val.isEmpty) {
                          setState(() {
                            _emailValidator = true;
                          });
                        } else {
                          setState(() {
                            _emailValidator = false;
                          });
                        }
                        return null;
                      },
                    ),
                    _emailValidator
                        ? Align(
                            alignment: AppLocalizations.of(context)
                                        .locale
                                        .languageCode ==
                                    "en"
                                ? Alignment.centerRight
                                : Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                '${AppLocalizations.of(context).trans('invalid_email')}',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 11),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      label: '${AppLocalizations.of(context).trans('mobile')}',
                      onTap: () {
                        setState(() {
                          _mobileValidator = false;
                        });
                      },
                      controller: mobileController,
                      type: TextInputType.phone,
                      validate: (String val) {
                        if (val == null || val.isEmpty) {
                          setState(() {
                            _mobileValidator = true;
                          });
                        } else {
                          setState(() {
                            _mobileValidator = false;
                          });
                        }
                        return null;
                      },
                    ),
                    _mobileValidator
                        ? Align(
                            alignment: AppLocalizations.of(context)
                                        .locale
                                        .languageCode ==
                                    "en"
                                ? Alignment.centerRight
                                : Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                '${AppLocalizations.of(context).trans('invalid_mobile')}',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 11),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      validate: (val) {
                        if (val == null || val.isEmpty) {
                          setState(() {
                            _passwordValidator = true;
                          });
                        } else {
                          setState(() {
                            _passwordValidator = false;
                          });
                        }
                        return null;
                      },
                      onTap: () {
                        setState(() {
                          _passwordValidator = false;
                        });
                      },
                      label:
                          '${AppLocalizations.of(context).trans('password')}',
                      isPassword: isPassword,
                      suffixPressed: changePasswordVisibility,
                      suffix: isPassword == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixColor: Colors.black87,
                      controller: passwordController,
                      type: TextInputType.text,
                    ),
                    _passwordValidator
                        ? Align(
                            alignment: AppLocalizations.of(context)
                                        .locale
                                        .languageCode ==
                                    "en"
                                ? Alignment.centerRight
                                : Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .locale
                                    .languageCode ==
                                    "en"
                                    ? 'Enter password to confirm edit':'ادخل كلمة المرور لتأكيد التعديل',
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 11),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 50.0,
                    ),
                    updateProfile.updateUserDataStage ==
                            GetUpdateUserDataStage.LOADING
                        ? loaderApp()
                        : defaultButton(
                            text:
                                '${AppLocalizations.of(context).trans('edit_profile_now')}',
                            function: _submit,
                          ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

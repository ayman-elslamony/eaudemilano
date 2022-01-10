import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/UserProvider.dart';
import 'package:eaudemilano/Provider/locale_provider.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _locale;
  bool isPassword = false;
  bool _nameValidator = false;
  bool _emailValidator = false;
  bool _mobileValidator = false;
  bool _passwordValidator = false;
  bool _confirmPasswordValidator = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken;

  @override
  void initState() {
    super.initState();
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    firebaseMessaging.getToken().then((token) {
      fcmToken = token;
    });
  }

  void changePasswordVisibility() {
    setState(() {
      isPassword = !isPassword;
    });
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Provider.of<UserDataProvider>(context, listen: false)
          .register(
          context: context,
          locale: _locale,
          name: nameController.text,
          phone: mobileController.text,
          email: emailController.text,
          fcmToken: fcmToken,
          password: passwordController.text,
        password_confirmation: confirmPasswordController.text
         );

    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: media.width,
        height: media.height,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundImage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white60,
            ),
            width: media.width,
            child: Column(
              children: [
                SizedBox(
                  height: media.height * 0.1,
                ),
                Container(
                    width: media.width * 0.35,
                    height: media.height * 0.15,
                    child: Image.asset('images/logoEauDeMilano.png')),
                SizedBox(
                  height: media.height * 0.02,
                ),
                Expanded(
                  child: Container(
                    width: media.width,
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Consumer<UserDataProvider>(
                          builder: (context, userDataState, child) => Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: media.height * 0.035,
                                ),
                                Text(
                                  '${AppLocalizations.of(context).trans('sign_up')}',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                const SizedBox(
                                  height: 30,
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('invalid_name')}',
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 11),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  label:
                                      '${AppLocalizations.of(context).trans('email')}',
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('invalid_email')}',
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 11),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  label:
                                      '${AppLocalizations.of(context).trans('mobile')}',
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('invalid_mobile')}',
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 11),
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
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  suffixColor: isPassword == true
                                      ? Colors.black87
                                      : primeColor,
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('invalid_pass')}',
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 11),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  validate: (val) {
                                    if (val == null || val.isEmpty || val != passwordController.text) {
                                      setState(() {
                                        _confirmPasswordValidator = true;
                                      });
                                    } else {
                                      setState(() {
                                        _confirmPasswordValidator = false;
                                      });
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {
                                      _confirmPasswordValidator = false;
                                    });
                                  },
                                  label:
                                      '${AppLocalizations.of(context).trans('confirm_pass')}',
                                  isPassword: true,
                                  suffixPressed: changePasswordVisibility,
                                  controller: confirmPasswordController,
                                  type: TextInputType.text,
                                ),
                                _confirmPasswordValidator
                                    ? Align(
                                        alignment: AppLocalizations.of(context)
                                                    .locale
                                                    .languageCode ==
                                                "en"
                                            ? Alignment.centerRight
                                            : Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            '${AppLocalizations.of(context).trans('invalid_pass_confirm')}',
                                            style: TextStyle(
                                                color: Colors.red[300],
                                                fontSize: 11),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 25.0,
                                ),
                                userDataState.stage ==
                                        UserDataProviderStage.LOADING
                                    ? loaderApp()
                                    : Column(
                                        children: [
                                          defaultButton(
                                            text:
                                                '${AppLocalizations.of(context).trans('sign_up')}',
                                            function: _submit,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              defaultSubtitleTextOne(
                                                  context: context,
                                                  color:
                                                      const Color(0xFFBDBDBD),
                                                  text:
                                                      '${AppLocalizations.of(context).trans('have_an_account')}'),
                                              defaultTextButton(
                                                  function: () {
                                                    navigateAndFinish(
                                                        context, LoginScreen());
                                                  },
                                                  context: context,
                                                  textKey: 'login'),
                                            ],
                                          ),
                                        ],
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
                )
              ],
            )),
      ),
    );
  }
}

import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';

import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isPassword = false;
  bool _emailValidator = false;
  bool _passwordValidator = false;


  void changePasswordVisibility()
  {
    setState(() {
      isPassword = !isPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: media.width,
        height: media.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundImage.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            width: media.width,
            child: Column(
              children: [
                SizedBox(
                  height: media.height * 0.1,
                ),
                Container(
                    width: media.width * 0.38,
                    height: media.height * 0.2,
                    child: Image.asset('images/logoEauDeMilano.png')),
                SizedBox(
                  height: media.height * 0.09,
                ),
                Expanded(
                  child: Container(
                    width: media.width,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: media.height * 0.05,
                        ),
                        Text(
                          '${AppLocalizations.of(context).trans('login')}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: 50,),
                        defaultFormField(
                          label: '${AppLocalizations.of(context).trans('email')}',
                          onTap: (){
                            setState(() {
                              _emailValidator =false;
                            });
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String val) {
                            if(val == null || val.isEmpty){
                              setState(() {
                                _emailValidator =true;
                              });
                            }
                            else{
                              setState(() {
                                _emailValidator =false;
                              });
                            }
                            return null;
                          },
                        ),
                        _emailValidator ? Align(
                          alignment: AppLocalizations.of(context).locale.languageCode == "en" ? Alignment.centerRight : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text('${AppLocalizations.of(context).trans('invalid_email')}',style: TextStyle(color: Colors.red[300],fontSize: 11),),
                          ),
                        )
                            :
                        const SizedBox(),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          validate: (val){
                            if(val == null || val.isEmpty){
                              setState(() {
                                _passwordValidator =true;
                              });
                            }
                            else{
                              setState(() {
                                _passwordValidator =false;
                              });
                            }
                            return null;
                          },
                          onTap: (){
                            setState(() {
                              _passwordValidator =false;
                            });
                          },

                          label: '${AppLocalizations.of(context).trans('password')}',
                          isPassword: isPassword,
                          suffixPressed: changePasswordVisibility,
                          suffix: isPassword==true ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          suffixColor: isPassword==true? Colors.black87:primeColor,
                          controller: passwordController,
                          type: TextInputType.text,
                        ),
                        _passwordValidator ? Align(
                          alignment: AppLocalizations.of(context).locale.languageCode == "en" ? Alignment.centerRight : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text('${AppLocalizations.of(context).trans('invalid_pass')}',style: TextStyle(color: Colors.red[300],fontSize: 11),),
                          ),
                        )
                            :
                        const SizedBox(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            InkWell(
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: defaultSubtitleTextTwo(
                                  context: context,
                                  text: '${AppLocalizations.of(context).trans('forgot_pass')}',
                                  textColor: Color(0xFFBDBDBD)),
                              onTap: () {
                               // navigateTo(context,ForgetPasswordScreen());

                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          text:
                          '${AppLocalizations.of(context).trans('login')}',
                          function: () {
                           // navigateTo(context, NavigationHome());
                            // if (formKey.currentState.validate()) {
                            //   print(phoneController.text);
                            //   print(passwordController.text);
                            // }
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultSubtitleTextOne(
                                context: context,
                                color: Color(0xFFBDBDBD),
                                text: '${AppLocalizations.of(context).trans('have_no_acc_register')}'),
                            defaultTextButton(
                                function: () {
                                  navigateAndFinish(context, SignUpScreen());
                                },
                                context: context,
                                textKey: 'sign_up'),
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
                )
              ],
            )),
      ),
    );
  }
}

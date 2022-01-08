import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _activeCurrentStep = 0;
  bool _nameValidator = false;
  bool _emailValidator = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  Widget validatorForm(
      {BuildContext context, bool isNotValid, String arText, String enText}) {
    return isNotValid
        ? Align(
            alignment: AppLocalizations.of(context).locale.languageCode == "en"
                ? Alignment.centerRight
                : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                AppLocalizations.of(context).locale.languageCode == "en"
                    ? enText
                    : arText,
                style: TextStyle(color: Colors.red[300], fontSize: 11),
              ),
            ),
          )
        : const SizedBox();
  }

  List<Widget> stepList() => [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      defaultFormField(
                        label: '${AppLocalizations.of(context).trans('name')}',
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
                      validatorForm(
                          context: context,
                          isNotValid: _nameValidator,
                          enText: 'please',
                          arText: 'من فضلك')
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      defaultFormField(
                        label:
                            '${AppLocalizations.of(context).trans('surname')}',
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
                      validatorForm(
                          context: context,
                          isNotValid: _nameValidator,
                          enText: 'please',
                          arText: 'من فضلك')
                    ],
                  ),
                )
              ],
            ),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('company_name')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('country_region')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('zip')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('city')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('province')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('telephone')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('email_address')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('invoice_receipt')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('fiscal_code')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
            defaultFormField(
              label: '${AppLocalizations.of(context).trans('user_name')}',
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
            validatorForm(
                context: context,
                isNotValid: _nameValidator,
                enText: 'please',
                arText: 'من فضلك'),
          ],
        ),
        Column(
          children: [],
        ),
        Column(
          children: [],
        )
      ];

  List<Step> steps() => [
        Step(
            state: _activeCurrentStep <= 0
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 0,
            title: _activeCurrentStep != 0
                ? SizedBox()
                : Text(
                    '${AppLocalizations.of(context).trans('best_selling')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
            content: SizedBox(
              height: 0.0,
              width: 0.0,
            )),
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: _activeCurrentStep != 1
                ? SizedBox()
                : Text(
                    '${AppLocalizations.of(context).trans('best_selling')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
            content: SizedBox(
              height: 0.0,
              width: 0.0,
            )),
        Step(
            state: _activeCurrentStep <= 2
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: _activeCurrentStep != 2
                ? SizedBox()
                : Text(
                    '${AppLocalizations.of(context).trans('best_selling')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
            content: SizedBox(
              height: 0.0,
              width: 0.0,
            ))
      ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ImageIcon(
            AssetImage('images/back.png'),
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('checkout')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
            child: Theme(
                data: ThemeData(
                    canvasColor: Color(0xFF060606),
                    colorScheme: ColorScheme.light(
                      //background: Colors.transparent,
                      primary: primeColor,
                      onSurface: Colors.grey[600],
                    )),
                child: SizedBox(
                  width: media.width,
                  height: 75,
                  child: Stepper(
                    type: StepperType.horizontal,
                    steps: steps(),
                    onStepContinue: () {
                      if (_activeCurrentStep < (stepList().length - 1)) {
                        setState(() {
                          _activeCurrentStep += 1;
                        });
                      }
                    },

                    // onStepCancel takes us to the previous step
                    onStepCancel: () {
                      if (_activeCurrentStep == 0) {
                        return;
                      }

                      setState(() {
                        _activeCurrentStep -= 1;
                      });
                    },

                    // onStepTap allows to directly click on the particular step we want
                    onStepTapped: (int index) {
                      setState(() {
                        _activeCurrentStep = index;
                      });
                    },
                  ),
                )),
            preferredSize: Size(media.width, 70)),
      ),
      body: Container(
        width: media.width,
        height: media.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF060606),
              Color(0xFF747474),
            ],
          ),
        ),
        child: stepList()[_activeCurrentStep],
      ),
    );
  }
}

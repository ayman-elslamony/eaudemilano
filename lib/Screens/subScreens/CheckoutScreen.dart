import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';

import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';
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
  bool _showDoneWidget = false;
  bool _nameValidator = false;
  bool _emailValidator = false;

//  var nameController = TextEditingController();
//  var emailController = TextEditingController();

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

  Widget spacerWidget = const SizedBox(
    height: 6,
  );

  Widget showRecipt({String title, String salary}) {
    return SizedBox(
      height: 28,
      child: ListTile(
        contentPadding:const EdgeInsets.all(0.0),
        isThreeLine: false,
        title: Text(
          'Sheer Beauty',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.white,
              ),
        ),
        trailing: Text(
          '60\$',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  List<Widget> stepList() => [
        SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          defaultFormField(
                            hintText:
                                '${AppLocalizations.of(context).trans('name')}',
                            onTap: () {
                              setState(() {
                                _nameValidator = false;
                              });
                            },
                            // controller: nameController,
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
                            hintText:
                                '${AppLocalizations.of(context).trans('surname')}',
                            onTap: () {
                              setState(() {
                                _emailValidator = false;
                              });
                            },
                            // controller: emailController,
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
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('company_name')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
                  type: TextInputType.text,
                  validate: (String val) {
                    return null;
                  },
                ),
                validatorForm(
                    context: context,
                    isNotValid: _nameValidator,
                    enText: 'please',
                    arText: 'من فضلك'),
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('country_region')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  //controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('street_number')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText: '${AppLocalizations.of(context).trans('zip')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText: '${AppLocalizations.of(context).trans('city')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  //   controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText: '${AppLocalizations.of(context).trans('province')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  //controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('telephone')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('email_address')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
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
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('invoice_receipt')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  //  controller: nameController,
                  type: TextInputType.text,
                  validate: (String val) {
                    return null;
                  },
                ),
                validatorForm(
                    context: context,
                    isNotValid: _nameValidator,
                    enText: 'please',
                    arText: 'من فضلك'),
                spacerWidget,
                defaultFormField(
                  hintText:
                      '${AppLocalizations.of(context).trans('fiscal_code')}',
                  onTap: () {
                    setState(() {
                      _nameValidator = false;
                    });
                  },
                  // controller: nameController,
                  type: TextInputType.text,
                  validate: (String val) {
                    return null;
                  },
                ),
                validatorForm(
                    context: context,
                    isNotValid: _nameValidator,
                    enText: 'please',
                    arText: 'من فضلك'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44.0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: defaultTextButton(
                              function: () {
                                Navigator.of(context).pop();
                              },
                              context: context,
                              textKey: 'back'),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: defaultButton(
                              function: goToNextStep,
                              text:
                                  '${AppLocalizations.of(context).trans('next')}'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.grey[600])),
                    child: CircleAvatar(radius: 8, backgroundColor: primeColor),
                  ),
                  Text(
                    '${AppLocalizations.of(context).trans('paypal_credit card')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              defaultSubtitleTextOne(
                  context: context,
                  text:
                      '${AppLocalizations.of(context).trans('pay_with_paypal')}'),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                hintText: '${AppLocalizations.of(context).trans('email')}',
                onTap: () {
                  setState(() {
                    _nameValidator = false;
                  });
                },
                // controller: nameController,
                type: TextInputType.text,
                validate: (String val) {
                  return null;
                },
              ),
              validatorForm(
                  context: context,
                  isNotValid: _nameValidator,
                  enText: 'please',
                  arText: 'من فضلك'),
              spacerWidget,
              defaultSubtitleTextTwo(
                  context: context,
                  textColor: Colors.white70,
                  text:
                      '${AppLocalizations.of(context).trans('your_personal_data')}'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 44.0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: defaultTextButton(
                            function: backToPreviousStep,
                            context: context,
                            textKey: 'back'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: defaultButton(
                            function: goToNextStep,
                            text:
                                '${AppLocalizations.of(context).trans('next')}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        _showDoneWidget
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 95,
                      height: 95,
                      margin: EdgeInsets.only(right: 8.0),
                      padding: EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF27AE60), shape: BoxShape.circle),
                      child: Image.asset(
                        "images/done.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      '${AppLocalizations.of(context).trans('you_made_payment_successfully')}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                   const SizedBox(
                      height: 50,
                    ),
                    Consumer<ChangeIndex>(
                      builder: (context, changeIndex, child) => InkWell(
                        onTap: () {
                          changeIndex.changeIndexFunction(0);
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                    NavigationHome(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                                  (Route<dynamic> route) => false);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 44.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${AppLocalizations.of(context).trans('go_back_shopping')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                    height: 0.7,
                                    color: primeColor,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              ImageIcon(
                                AssetImage('images/arrow.png'),
                                size: 14,
                                color: primeColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).trans('your_order')}',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    showRecipt(),
                    showRecipt(),
                    showRecipt(),
                    showRecipt(),
                    SizedBox(
                      height: 10,
                    ),
                    myDivider(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).trans('subtotal')}',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        Text(
                          '85\$',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white,
                              ),
                        )
                      ],
                    ),
                    myDivider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).trans('expedition')}',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        Text(
                          '10\$',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white,
                              ),
                        )
                      ],
                    ),
                    myDivider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).trans('total')}',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        Text(
                          '95\$',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: defaultTextButton(
                                  function: backToPreviousStep,
                                  context: context,
                                  textKey: 'back'),
                            ),
                          const  SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 2,
                              child: defaultButton(
                                  function: () {
                                    setState(() {
                                      _showDoneWidget = true;
                                    });
                                  },
                                  text:
                                      '${AppLocalizations.of(context).trans('pay')}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
            content: const SizedBox(
              height: 0.0,
              width: 0.0,
            )),
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: _activeCurrentStep != 1
                ?const  SizedBox()
                : Text(
                    '${AppLocalizations.of(context).trans('payment_details')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
            content: const SizedBox(
              height: 0.0,
              width: 0.0,
            )),
        Step(
            state: _activeCurrentStep <= 2
                ? StepState.indexed
                : StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: _activeCurrentStep != 2
                ? const SizedBox()
                : Text(
                    _showDoneWidget
                        ? '${AppLocalizations.of(context).trans('done')}'
                        : '${AppLocalizations.of(context).trans('finish')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
            content: const SizedBox(
              height: 0.0,
              width: 0.0,
            )),
      ];

  void backToPreviousStep() {
    if (_activeCurrentStep == 0) {
      return;
    }

    setState(() {
      _activeCurrentStep -= 1;
    });
  }

  void goToNextStep() {
    if (_activeCurrentStep < (stepList().length - 1)) {
      setState(() {
        _activeCurrentStep += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
//        leading: IconButton(onPressed: (){
//          if(_showDoneWidget==true){
//            Navigator.pushAndRemoveUntil(
//                context,
//                PageRouteBuilder(
//                  pageBuilder:
//                      (context, animation1, animation2) =>
//                      NavigationHome(),
//                  transitionDuration:const Duration(seconds: 0),
//                ),
//                    (Route<dynamic> route) => false);
//          }
//          if(_activeCurrentStep !=0 &&_showDoneWidget == false){
//            backToPreviousStep();
//          }else {
//            if(_showDoneWidget == false){
//              Navigator.of(context).pop();
//            }
//
//          }
//        },  icon:const ImageIcon(
//              AssetImage('images/back.png'),
//            ),),
        leading: Consumer<ChangeIndex>(
          builder: (context, changeIndex, child) => IconButton(
            onPressed: () {
              if (_showDoneWidget) {
                changeIndex.changeIndexFunction(0);
                Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          NavigationHome(),
                      transitionDuration:const Duration(seconds: 0),
                    ),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pop();
              }
            },
            icon:const ImageIcon(
              AssetImage('images/back.png'),
            ),
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
                    canvasColor:const  Color(0xFF060606),
                    colorScheme: ColorScheme.light(
                      //background: Colors.transparent,
                      primary: _showDoneWidget ?const  Color(0xFF27AE60) : primeColor,
                      onSurface: _showDoneWidget
                          ? const Color(0xFF27AE60)
                          : Colors.grey[600],
                    )),
                child: SizedBox(
                  width: media.width,
                  height: 75,
                  child: Stepper(
                    type: StepperType.horizontal,
                    steps: steps(),
                    onStepContinue: goToNextStep,
                    // onStepCancel takes us to the previous step
                    onStepCancel: backToPreviousStep,

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
        decoration:const  BoxDecoration(
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

import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/CartProvider.dart';
import 'package:eaudemilano/Provider/CheckOutProvider.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';

import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';
import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'PaymentWebView.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckOutProvider _checkOutProvider;
  CartProvider _cartProvider;
  int _activeCurrentStep = 0;
  bool _showDoneWidget = false;
  bool _nameValidator = false;
  bool _surNameValidator = false;
  bool _countryRegionValidator = false;
  bool _streetNumberValidator = false;
  bool _zipValidator = false;
  bool _cityValidator = false;
  bool _provinceValidator = false;
  bool _telephoneValidator = false;
  bool _emailValidator = false;
  bool _pay_with_paypalValidator = false;

  var nameController = TextEditingController();
  var surNameController = TextEditingController();
  var countryRegionController = TextEditingController();
  var streetNumberController = TextEditingController();
  var zipController = TextEditingController();
  var cityController = TextEditingController();
  var provinceController = TextEditingController();
  var telephoneController = TextEditingController();
  var emailAddressController = TextEditingController();
  var pay_with_paypalController = TextEditingController();
  var formKeyForUserData = GlobalKey<FormState>();
  var formKeyForPay = GlobalKey<FormState>();
  var _locale;

  Widget validatorForm(
      {BuildContext context, bool isNotValid, String textValidator}) {
    return isNotValid
        ? Align(
            alignment: AppLocalizations.of(context).locale.languageCode == "en"
                ? Alignment.centerRight
                : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                AppLocalizations.of(context).locale.languageCode == "en"
                    ? 'please Enter $textValidator'
                    : '$textValidatorمن فضلك ادخل ',
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
        contentPadding: const EdgeInsets.all(0.0),
        isThreeLine: false,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.white,
              ),
        ),
        trailing: Text(
          '$salary\$',
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  int radioTilePaymentResult = 0;

  Widget radioTileCard({BuildContext context, int index, String titleKey}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      width: 330,
      height: 55.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(11.0),
          ),
          border: Border.all(color: Colors.grey[300])),
      child: SizedBox(
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey[300]),
          child: RadioListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            activeColor: Theme.of(context).primaryColor,
            title: Text(
              '${AppLocalizations.of(context).trans(titleKey)}',
              style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: 15
              ),
            ),

            value: index,
            groupValue: radioTilePaymentResult,
            onChanged: (value) {
              setState(() {
                print(value);
                radioTilePaymentResult = value;
              });
            }, //  <-- leading Checkbox
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
            child: Form(
              key: formKeyForUserData,
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
                              textValidator:
                                  '${AppLocalizations.of(context).trans('name')}',
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            defaultFormField(
                              onTap: () {
                                setState(() {
                                  _surNameValidator = false;
                                });
                              },
                              hintText:
                                  '${AppLocalizations.of(context).trans('surname')}',
                              controller: surNameController,
                              type: TextInputType.emailAddress,
                              validate: (String val) {
                                if (val == null || val.isEmpty) {
                                  setState(() {
                                    _surNameValidator = true;
                                  });
                                } else {
                                  setState(() {
                                    _surNameValidator = false;
                                  });
                                }
                                return null;
                              },
                            ),
                            validatorForm(
                              context: context,
                              isNotValid: _surNameValidator,
                              textValidator:
                                  '${AppLocalizations.of(context).trans('surname')}',
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText:
                        '${AppLocalizations.of(context).trans('telephone')}',
                    onTap: () {
                      setState(() {
                        _telephoneValidator = false;
                      });
                    },
                    controller: telephoneController,
                    type: TextInputType.phone,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _telephoneValidator = true;
                        });
                      } else {
                        setState(() {
                          _telephoneValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _telephoneValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('telephone')}',
                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText:
                        '${AppLocalizations.of(context).trans('email_address')}',
                    onTap: () {
                      setState(() {
                        _emailValidator = false;
                      });
                    },
                    controller: emailAddressController,
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
                    isNotValid: _emailValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('email_address')}',
                  ),
//                  spacerWidget,
//                  defaultFormField(
//                    hintText:
//                        '${AppLocalizations.of(context).trans('company_name')}',
//                    controller: companyNameController,
//                    type: TextInputType.text,
//                    validate: (String val) {
//                      return null;
//                    },
//                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText:
                        '${AppLocalizations.of(context).trans('country_region')}',
                    controller: countryRegionController,
                    onTap: () {
                      setState(() {
                        _countryRegionValidator = false;
                      });
                    },
                    type: TextInputType.text,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _countryRegionValidator = true;
                        });
                      } else {
                        setState(() {
                          _countryRegionValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _countryRegionValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('country_region')}',
                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText:
                        '${AppLocalizations.of(context).trans('province')}',
                    onTap: () {
                      setState(() {
                        _provinceValidator = false;
                      });
                    },
                    controller: provinceController,
                    type: TextInputType.text,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _provinceValidator = true;
                        });
                      } else {
                        setState(() {
                          _provinceValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _provinceValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('province')}',
                  ),

                  spacerWidget,
                  defaultFormField(
                    hintText: '${AppLocalizations.of(context).trans('city')}',
                    onTap: () {
                      setState(() {
                        _cityValidator = false;
                      });
                    },
                    controller: cityController,
                    type: TextInputType.text,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _cityValidator = true;
                        });
                      } else {
                        setState(() {
                          _cityValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _cityValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('city')}',
                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText:
                        '${AppLocalizations.of(context).trans('street_number')}',
                    onTap: () {
                      setState(() {
                        _streetNumberValidator = false;
                      });
                    },
                    controller: streetNumberController,
                    type: TextInputType.text,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _streetNumberValidator = true;
                        });
                      } else {
                        setState(() {
                          _streetNumberValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _streetNumberValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('street_number')}',
                  ),
                  spacerWidget,
                  defaultFormField(
                    hintText: '${AppLocalizations.of(context).trans('zip')}',
                    onTap: () {
                      setState(() {
                        _zipValidator = false;
                      });
                    },
                    controller: zipController,
                    type: TextInputType.number,
                    validate: (String val) {
                      if (val == null || val.isEmpty) {
                        setState(() {
                          _zipValidator = true;
                        });
                      } else {
                        setState(() {
                          _zipValidator = false;
                        });
                      }
                      return null;
                    },
                  ),
                  validatorForm(
                    context: context,
                    isNotValid: _zipValidator,
                    textValidator:
                        '${AppLocalizations.of(context).trans('zip')}',
                  ),

                  spacerWidget,
//                  defaultFormField(
//                    hintText:
//                        '${AppLocalizations.of(context).trans('invoice_receipt')}',
//                    controller: invoiceReceiptController,
//                    type: TextInputType.text,
//                    validate: (String val) {
//                      return null;
//                    },
//                  ),
//                  spacerWidget,
//                  defaultFormField(
//                    hintText:
//                        '${AppLocalizations.of(context).trans('fiscal_code')}',
//                    controller: fiscalCodeController,
//                    type: TextInputType.number,
//                    validate: (String val) {
//                      return null;
//                    },
//                  ),
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
                          const SizedBox(
                            width: 8,
                          ),
                          Consumer<CheckOutProvider>(
                            builder: (context, checkOutProvider, child) =>
                                Expanded(
                              flex: 2,
                              child: checkOutProvider.checkOutProviderStage ==
                                      GetCheckOutProviderStage.LOADING
                                  ? SpinKitWave(
                                      color: primeColor,
                                      type: SpinKitWaveType.center,
                                      size: 35,
                                    )
                                  : defaultButton(
                                      function: goToNextStep,
                                      text:
                                          '${AppLocalizations.of(context).trans('next')}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Form(
            key: formKeyForPay,
            child: Column(
              children: [
                Row(
                  children: [
//                    Container(
//                      margin: const EdgeInsets.only(right: 8.0),
//                      padding: const EdgeInsets.all(1.0),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(100),
//                          border:
//                              Border.all(width: 2, color: Colors.grey[600])),
//                      child: const CircleAvatar(
//                          radius: 8, backgroundColor: primeColor),
//                    ),
                    Text(
                      '${AppLocalizations.of(context).trans('payment_methods')}',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                radioTileCard(
                  context: context,
                  index: 1,
                  titleKey: 'my_fatora',
                ),
                radioTileCard(
                  context: context,
                  index: 2,
                  titleKey: 'Cash_on_delivery',
                ),
                defaultSubtitleTextOne(
                    context: context,
                    //  textColor: Colors.white70,
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
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: defaultButton(
                              background: radioTilePaymentResult == 0
                                  ? secondaryColor
                                  : primeColor,
                              function: radioTilePaymentResult == 0
                                  ? null
                                  : goToNextStep,
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
                   const SizedBox(
                      height: 50,
                    ),
                    Text(
                        _checkOutProvider.paymentMethod==2?'${AppLocalizations.of(context).trans('your_order_will_arrive_soon')}':'${AppLocalizations.of(context).trans('you_made_payment_successfully')}',
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
                    const SizedBox(
                      height: 15.0,
                    ),
                    ListView.builder(
                        itemCount: _cartProvider.getAllProductsInCart.specificProduct.length,
  itemBuilder: (context,index)=>showRecipt(
    title:  _cartProvider.getAllProductsInCart.specificProduct[index].product.title,
    salary: _cartProvider.getAllProductsInCart.specificProduct[index].total
  ),
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),

                        ),
                   const SizedBox(
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
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 2,
                              child: defaultButton(
                                  function: () async{
                                    //My fatora
                                    if(_checkOutProvider.paymentMethod==1){
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context,animation1, animation2) => PaymentWebView(
                                            url: _checkOutProvider.directLink,
                                          ),
                                          transitionDuration:
                                          const Duration(milliseconds: 1000),
                                        ),
                                      ).then((value){
                                        if(value==true){
  setState(() {
                                        _showDoneWidget = true;
                                      });
                                        }
                                      });

                                    }
                                    //cache on del...
                                    if(_checkOutProvider.paymentMethod==2){
                                      setState(() {
                                        _showDoneWidget = true;
                                      });
                                    }

                                  },
                                  text:
                                      _checkOutProvider.paymentMethod==2?'${AppLocalizations.of(context).trans('finish')}':'${AppLocalizations.of(context).trans('pay')}'),
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
                ? const SizedBox()
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

  Future<void> goToNextStep() async {
    if (_activeCurrentStep < (stepList().length - 1)) {
      print(_activeCurrentStep);
      if (_activeCurrentStep == 1) {
        _checkOutProvider.setPaymentMethod(radioTilePaymentResult);
        if(radioTilePaymentResult == 1){

        }else{

        }
        setState(() {
          _activeCurrentStep += 1;
        });
      }

      if (_activeCurrentStep == 0) {
        final form = formKeyForUserData.currentState;
        if (form.validate() == true &&
            nameController.text.isNotEmpty &&
            surNameController.text.isNotEmpty &&
            countryRegionController.text.isNotEmpty &&
            streetNumberController.text.isNotEmpty &&
            zipController.text.isNotEmpty &&
            cityController.text.isNotEmpty &&
            provinceController.text.isNotEmpty &&
            telephoneController.text.isNotEmpty &&
            emailAddressController.text.isNotEmpty) {
          print('efgegerg');
          form.save();
          String areaId =
              '${countryRegionController.text}/${provinceController.text}/${cityController.text}';
         _checkOutProvider.sendUserData(
              locale: _locale,
              context: context,
              name: nameController.text,
              sur_name: surNameController.text,
              email: emailAddressController.text,
              mobile: telephoneController.text,
              city: areaId,
              street: streetNumberController.text,
              area_id: 1,
              zip_code: zipController.text).then((result){
           if (result == true) {
            // _cartProvider.resetAllProductsInCart();
             setState(() {
               _activeCurrentStep += 1;
             });
             return;
           }
         });
        }
      }

    }
  }

  @override
  void initState() {
    nameController.text = Helper.userName;
    telephoneController.text = Helper.userPhone;
    emailAddressController.text = Helper.userEmail;

  surNameController.text='kamel';
   streetNumberController.text='ahmed oraby street';
 zipController.text='2050';
    countryRegionController.text='egypt';
    provinceController.text='mansoura';
    cityController.text='mansoura';
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    _checkOutProvider = Provider.of<CheckOutProvider>(context, listen: false);
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
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
                      transitionDuration: const Duration(seconds: 0),
                    ),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const ImageIcon(
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
                    canvasColor: const Color(0xFF060606),
                    colorScheme: ColorScheme.light(
                      //background: Colors.transparent,
                      primary: _showDoneWidget
                          ? const Color(0xFF27AE60)
                          : primeColor,
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
        child: stepList()[_activeCurrentStep],
      ),
    );
  }
}

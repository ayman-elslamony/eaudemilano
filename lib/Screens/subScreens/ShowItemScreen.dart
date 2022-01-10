import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ShowItemScreen extends StatefulWidget {
  @override
  _ShowItemScreenState createState() => _ShowItemScreenState();
}

class _ShowItemScreenState extends State<ShowItemScreen> {
  int currentIndex = 1;

  int _currentCount = 0;

  void _increment() {
    setState(() {
      _currentCount++;
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 32.0, minHeight: 44.0),
      onPressed: onPressed,
      elevation: 2.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 15.0,
      ),
      shape: const CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: media.width,
          height: media.height,
          padding: const EdgeInsets.all(0.0),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: media.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        width: media.width,
                        height: media.height * 0.49,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.grey[500],
                          child: const SizedBox(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: media.width,
                          height: media.height * 0.484,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon:const  ImageIcon(
                                        AssetImage('images/back.png'),
                                        color: primeColor,
                                      ),
                                    ),
                                    const  Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const ImageIcon(
                                        AssetImage('images/share.png'),
                                        color: primeColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: media.height * 0.28,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          "images/toBeMan$currentIndex.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
//                                      height: media.height*0.28,
                                        width: media.width * 0.2,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentIndex = index + 1;
                                              });
                                            },
                                            child: Container(
                                              margin:const  EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 5.0),
                                              padding:const  EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 5),
                                              decoration:const  BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  color: Color(0xFF8C8C8C)),
                                              child: Image.asset(
                                                "images/toBeMan${index + 1}.png",
                                                height: media.height * 0.07,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          shrinkWrap: true,
                                          itemCount: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '40\$',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text('Roberto Cavalli EDP',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    color: Colors.grey[800])),
                                      ],
                                    ),
                                    const  Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: ImageIcon(
                                        const AssetImage('images/fav.png'),
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Column(
                    children: [
                      Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween
                        children: [
                          Text(
                            '${AppLocalizations.of(context).trans('choose')}',
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      color: Colors.white70,
                                    ),
                          ),
                          Container(
                            width: 75,
                            height: 30.0,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MaterialButton(
                              onPressed: () {},
                              child:const  Text(
                                '100ml',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              color: const Color(0xFF8C8C8C),
                            ),
                          ),
                          Container(
                            width: 75,
                            height: 30.0,
                            child: MaterialButton(
                              onPressed: () {},
                              child: const Text(
                                '50ml',
                                style:  TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              border: Border.all(color:const  Color(0xFF8C8C8C)),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: media.width,
                          child: Text(
                            'Log This text was generated from the Arabic text generator Log This text was generated from the Arabic text generator Log This text was generated from the Arabic text generator Log This text was generated from the Arabic text generator',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SizedBox(
                          width: media.width,
                          height: 44.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1
                                ,child: Container(
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    border: Border.all(color: const Color(0xFF8C8C8C)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _createIncrementDicrementButton(
                                          Icons.remove, () => _dicrement()),
                                      Text(_currentCount.toString()),
                                      _createIncrementDicrementButton(
                                          Icons.add, () => _increment()),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                flex: 2
                                ,
                                child: Container(
                                  child: MaterialButton(
                                    onPressed: () {
                                      Fluttertoast.showToast(
                                        msg: '${AppLocalizations.of(context).trans('add_to_card')}',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.black,
                                        fontSize: 16.0,
                                      );
                                    },
                                    child: Text(
                                        '${AppLocalizations.of(context).trans('add_to')}',
                                      style:const  TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                    color: primeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalizations.of(context).trans('similar_products')}',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            '${AppLocalizations.of(context).trans('see_all')}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: primeColor,
                                    decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics:const  NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>const  SizedBox(
                          height: 5.0,
                        ),
                        itemBuilder: (context, index) => defaultCard(
                          title: '455',
                          subTitle: 'Cool Water EDT',
                          titleContent: '',
                          context: context,
                          currentIndex: index,
                          media: media,
                        ),
                        itemCount: 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

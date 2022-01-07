import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listOfTitle = ['Men', 'Woman', 'children'];

  createCard({double width, double height,bool switchCard = true}) {
    switch(switchCard) {
      case true:
        return SizedBox(
          width: width * 0.55,
          child: Stack(
            children: [
              Positioned(
                width: width * 0.525,
                height: height * 0.256,
                top: 8,
                left: 8,

                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  color: Colors.white,
                  child: Text('red'),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 6.4,
                child: SizedBox(
                  width: width * 0.533,
                  height: height * 0.26,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    color: Colors.grey[500],
                    child: Text('front'),
                  ),
                ),
              )
            ],
          ),
        );
        break; // The switch statement must be told to exit, or it will execute every case.
      case false:
       return SizedBox(
          width: width * 0.55,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                width: width * 0.53,
                height: height * 0.29,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  color: Colors.grey[500],
                  child: Text('red'),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: width * 0.53,
                  height: height * 0.291,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    color: Colors.white,
                    child: Text('front'),
                  ),
                ),
              )
            ],
          ),
        );
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
          title: Container(
            child: SizedBox(
              height: 40,
              child: defaultFormField(
                validate: (val) {
                  return null;
                },
                onTap: () {
                  //changeIndex.changeIndexFunction(2);
                },
                readOnly: true,
                suffix: Icons.search,
                label: '${AppLocalizations.of(context).trans('search')}',
                isClickable: false,
                type: TextInputType.text,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                child: ClipOval(
                  child: Image.asset(
                    "images/backgroundImage.png",
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: media.width,
          height: media.height,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  width: media.width,
                  child: Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context).trans('popular')}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => Center(
                            child: Text(
                              listOfTitle[index],
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          itemCount: 3,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'See All',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: primeColor,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  width: media.width,
                  height: media.height*0.32,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ListView.separated(

                        itemBuilder: (context, index) =>
                            index%2==0?
                            createCard(width: media.width, height: media.height,switchCard: true):createCard(width: media.width, height: media.height,switchCard: false),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

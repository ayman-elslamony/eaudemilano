import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NavigationHome.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<int> countList = [1, 2];
  bool enableWriteInSearch = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            openDrawer();
          },
          icon: ImageIcon(
            AssetImage('images/drawer.png'),
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('search_bar')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: (){
              navigateTo(context, ProfileScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.asset(
                    "images/profile.png",
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        ],
        bottom: enableWriteInSearch == true
            ? PreferredSize(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0, right: 18, left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 40,
                        child: defaultFormField(
                          validate: (val) {
                            return null;
                          },
                          onTap: () {
                            //changeIndex.changeIndexFunction(2);
                          },
                          suffix: Icons.search,
                          label:
                          enableWriteInSearch?'':'${AppLocalizations.of(context).trans('what_do_you_want')}',
                          type: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        '1 ${AppLocalizations.of(context).trans('result')}',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size(media.width, 90))
            : null,
      ),
      body: Container(
        width: media.width,
        height: media.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
        child: enableWriteInSearch == false
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: defaultFormField(
                        validate: (val) {
                          return null;
                        },
                        onTap: () {
                          setState(() {
                            enableWriteInSearch = true;
                          });
                        },
                        readOnly: true,
                        suffix: Icons.search,
                        label:
                            '${AppLocalizations.of(context).trans('what_do_you_want')}',
                        isClickable: false,
                        type: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('${AppLocalizations.of(context).trans('try_these_keywords')}',
                      style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 8,),
                    Wrap(
                     children: List.generate(20,
                             (index) => Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                               child: GestureDetector(
                                 onTap: (){},
                                   child: Text('Ornare',
                                   style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white70),
                                   ),
                               ),
                             ),),
                    ),
                  ],
                ),
              )
            : MediaQuery.removePadding(
          context: context,
              removeTop: true,
              removeLeft: true,
              removeRight: true,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 5.0,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultCard(
                      titleContent: '2',
                      title: '455',
                      subTitle: 'Cool Water EDT',
                      context: context, currentIndex: index, media: media),
                ),
                itemCount: 1,
              ),
            ),
      ),
    );
  }
}

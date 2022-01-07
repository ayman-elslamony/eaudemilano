import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<int> countList = [1,2];
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: ImageIcon(
          AssetImage('images/drawer.png'),
        ),),
        title: Row(
          children: [
            Text(
              '${AppLocalizations.of(context).trans('favourite')}',
              style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              '(2 ${AppLocalizations.of(context).trans('items')})',
              style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.grey[600]
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: (){
              navigateAndFinish(context, ProfileScreen());
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
      ),
      body: Container(
        width: media.width,
        height: media.height*0.8,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 5.0,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: defaultCard(
                      titleContent: '2',
                      title: '455',
                      subTitle: 'Cool Water EDT',
                      context: context, currentIndex: index, media: media,
                      justEnableDeleteIcon: true,
                      onDeletePressed: (){
                        showDialog(
                            context: context,
                            builder: (context) =>  AlertDialog(
                              title: Text(
                                '${AppLocalizations.of(context).trans('remove_item')}',
                                style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black87,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                              content: SizedBox(
                                height:80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox()
                                    ,defaultTextButton(function: (){
                                      Navigator.of(context).pop();
                                    }, textKey: 'cancel',context: context),
                                    defaultButton(function: (){
                                      setState(() {
                                        countList.removeAt(index);
                                        Navigator.of(context).pop();
                                      });

                                    }, text: '${AppLocalizations.of(context).trans('remove')}',width: 120,)
                                  ],
                                ),
                              ),
                            ));
                      },

                  ),
                ),
                itemCount: countList.length ,
              ),
            ],
          ),
        ),
      ),

    );
  }
}

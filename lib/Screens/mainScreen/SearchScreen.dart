import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/SearchProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';

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
  String _locale;
  String lastSearch = '';

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
//    Provider.of<SearchProvider>(context, listen: false)
//        .disableWriteInSearchFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<SearchProvider>(
      builder: (context, searchResult, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          leading: Consumer<ChangeIndex>(
            builder: (context, changeIndex, child) => IconButton(onPressed: () {
              changeIndex.openDrawer();
            },
            icon: const ImageIcon(
              AssetImage('images/drawer.png'),
            ),
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
              onTap: () {
                navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 18,
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      color: primeColor,
                      width: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
          ],
          bottom:
//          searchResult.enableWriteInSearch == true ?
          PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, right: 18, left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: defaultFormField(
                            autoFocus: false,
                            removeContainer: true,
                            validate: (val) {
                              return null;
                            },
                            onTap: () {
                              //changeIndex.changeIndexFunction(2);
                            },
                            onChange: (String val) async {
                              if(val==null || val.isEmpty){
                                searchResult.resetSearchResult();
                              }
                              if (val != null &&
                                  val.isNotEmpty &&
                                  lastSearch != val) {
                                await searchResult.getSearchResultFunction(
                                    context: context,
                                    locale: _locale,
                                    text: val);
                                lastSearch = val;
                              }
                            },
                            suffix: Icons.search,
                            hintText: '${AppLocalizations.of(context).trans('what_do_you_want')}',
                            type: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Visibility(
                          visible: searchResult.getSearchResult.isNotEmpty,
                          child: Text(
                            '${searchResult.getSearchResult.length} ${AppLocalizations.of(context).trans('result')}',
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size(media.width, 90))
             // : null,
        ),
        body: Container(
          width: media.width,
          height: media.height * 0.82,
          padding: const EdgeInsets.only(left: 14.0,right: 14.0, bottom: 12.0),
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
          child:
//          searchResult.enableWriteInSearch == false
//              ? SingleChildScrollView(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      const SizedBox(height: 8.0,),
//                      SizedBox(
//                        height: 40,
//                        child: defaultFormField(
//                          removeContainer: true,
//                          validate: (val) {
//                            return null;
//                          },
//                          onTap: () {
//                            print('dgvd');
//                            searchResult.enableWriteInSearchFunction();
//                          },
//                          readOnly: true,
//                          suffix: Icons.search,
//                          label:
//                              '${AppLocalizations.of(context).trans('what_do_you_want')}',
//                          isClickable: false,
//                          type: TextInputType.text,
//                        ),
//                      ),
//                      const SizedBox(
//                        height: 20,
//                      ),
//                      Text(
//                        '${AppLocalizations.of(context).trans('try_these_keywords')}',
//                        style: Theme.of(context)
//                            .textTheme
//                            .headline4
//                            .copyWith(color: Colors.white),
//                      ),
//                      const SizedBox(
//                        height: 8,
//                      ),
//                      Wrap(
//                        children: List.generate(
//                          9,
//                          (index) => Padding(
//                            padding: const EdgeInsets.symmetric(
//                                horizontal: 4, vertical: 2),
//                            child: GestureDetector(
//                              onTap: () {},
//                              child: Text(
//                                'product ${index + 1}',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .headline5
//                                    .copyWith(color: Colors.white70),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                )
//              :
          searchResult.getSearchResult.isEmpty && lastSearch!=''&& searchResult.searchResultStage == GetSearchResultStage.DONE
              ? Center(
            child: defaultSubtitleTextOne(
                context: context, text: '${AppLocalizations.of(context).trans('There_is_no_result')}'),
          )
              :SingleChildScrollView(
                child: Column(
                children: [
                  MediaQuery.removePadding(
                              context: context,
                              child: MediaQuery.removePadding(
                                context: context,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => Padding(
                                          padding:
                                              const EdgeInsets.only(top:12.0),
                                          child: searchResult.searchResultStage == GetSearchResultStage.LOADING?
                                            loadingCard(media: media):defaultCard(
                                            productId: searchResult
                                                .getSearchResult[index].id,
                                              titleContent: '',
                                              price: searchResult
                                                  .getSearchResult[index].price,
                                              imgUrl: searchResult
                                                  .getSearchResult[index].image,
                                              subTitle: searchResult
                                                  .getSearchResult[index].title,
                                              context: context,
                                              currentIndex: index,
                                              media: media),
                                        ),
                                        itemCount: searchResult.searchResultStage == GetSearchResultStage.LOADING?8:searchResult.getSearchResult.length,
                                      ),
                                  ),
                            ),
                  const SizedBox(height: 12.0,)
                ],
            ),
              ),
          ),
        ),
    );
  }
}

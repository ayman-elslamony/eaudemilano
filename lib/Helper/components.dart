import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//final List<String> imgList = [
//  'https://thumbs.dreamstime.com/t/gym-24699087.jpg',
//  'https://media.istockphoto.com/photos/empty-gym-picture-id1132006407?k=20&m=1132006407&s=612x612&w=0&h=Z7nJu8jntywb9jOhvjlCS7lijbU4_hwHcxoVkxv77sg=',
//  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX26664924.jpg',
//  'https://media.istockphoto.com/photos/muscular-trainer-writing-on-clipboard-picture-id675179390?k=20&m=675179390&s=612x612&w=0&h=7LP7-OamGu-b8XG-VKcJuamK5s80ke-4oJ5siUrjFVA=',
//  'https://www.muscleandfitness.com/wp-content/uploads/2019/11/Young-Muscular-Man-Doing-Lunges-In-Dark-Gym.jpg?w=1109&h=614&crop=1&quality=86&strip=all',
//  'https://www.giggsmeat.com/wp-content/uploads/2020/10/4wqKj5zM2a-min.jpg'
//];

Widget defaultButton({
  double width = double.infinity,
  Color background = primeColor,
  double radius = 12.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 44.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultShowTime({BuildContext context, String textTime}) {
  return Row(
    children: [
      Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red[500],
            ),
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          width: 11,
          height: 11,
          child: SizedBox()),
      SizedBox(
        width: 5.0,
      ),
      defaultSubtitleTextTwo(context: context, text: textTime),
    ],
  );
}

Widget defaultTextInCard(
    {BuildContext context,
    String title = '80\$',
    String subTitle = 'Sheer Beauty EDT',
    String titleContent = ''}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleContent == ''
            ? Text(
                title,
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              )
            : Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' x $titleContent',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  )
                ],
              ),
        SizedBox(
          height: 4,
        ),
        Text(subTitle,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.grey[800])),
      ],
    ),
  );
}

Widget addFavouriteAndRemoveInCard(
    {String favIconUrl, Function onFavPressed, Function onDeletePressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onFavPressed,
          child: ImageIcon(
            AssetImage(favIconUrl),
            size: 17,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: onDeletePressed,
          child: ImageIcon(
            AssetImage('images/delete.png'),
            size: 17,
            color: Color(0xFF7D3030),
          ),
        ),
      ],
    ),
  );
}

Widget defaultCard(
        {@required int currentIndex,
        @required BuildContext context,
        Size media,
        String title,
        String subTitle,
        String titleContent,
        String favIconUrl = '',
          bool justEnableDeleteIcon=false,
        Function onFavPressed,
        Function onDeletePressed}) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xFF8C8C8C)),
            child: Image.asset(
              "images/perfume${currentIndex + 1}.png",
              width: media.width * 0.19,
              height: media.height * 0.11,
              fit: BoxFit.fill,
            ),
          ),
          defaultTextInCard(
              context: context,
              subTitle: subTitle,
              title: title,
              titleContent: titleContent),
          favIconUrl == ''
              ? SizedBox()
              : addFavouriteAndRemoveInCard(
                  onDeletePressed: onDeletePressed,
                  onFavPressed: onFavPressed,
                  favIconUrl: favIconUrl),
          justEnableDeleteIcon==true?Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onDeletePressed,
                  child: ImageIcon(
                    AssetImage('images/delete.png'),
                    size: 17,
                    color: Color(0xFF7D3030),
                  ),
                ),
              ],
            ),
          ):SizedBox()
        ],
      ),
    );
//
//Widget defaultLocationWithIcon(
//    {@required BuildContext context, String textLocation}) {
//  return InkWell(
//    onTap: () {},
//    child: Row(
//      children: [
//      defaultSubtitleTextOne(context: context, text: text)
//        SizedBox(
//          width: 5.0,
//        ),
//        defaultSubtitleTextTwo(context: context, text: textLocation),
//      ],
//    ),
//  );
//}

Widget subtitleOfHomeScreen(
    {Function function,
    BuildContext context,
    String textKey,
    bool isHomeScreen = false,
    bool isEnableSpaceBeforeArrow = false}) {
  return InkWell(
    onTap: function,
    child: Row(
      children: [
        Text(
          '${AppLocalizations.of(context).trans(textKey)}',
          style: Theme.of(context).textTheme.headline4,
        ),
        isEnableSpaceBeforeArrow == true ? Spacer() : SizedBox(),
        Icon(
          Icons.arrow_forward_ios,
          size: 18.0,
          color: isHomeScreen == true ? Colors.grey[800] : Colors.grey[300],
        ),
        isEnableSpaceBeforeArrow == false ? Spacer() : SizedBox()
      ],
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required BuildContext context,
  @required String textKey,
  Color textColor
}) =>
    TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: function,
      child: Text('${AppLocalizations.of(context).trans(textKey)}',
          style: Theme.of(context).textTheme.button.copyWith(
                color: textColor==null?Color(0xFFBDBDBD):textColor,
              )),
    );

Widget defaultSubtitleTextOne(
        {@required BuildContext context, @required String text, Color color}) =>
    Text(text,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: color ?? Colors.white));

Widget showTextWithIcon(
    {@required BuildContext context,
    String iconUrl,
    String titleText,
    Color colorOfWidget = Colors.red}) {
  return Row(
    children: [
      ImageIcon(
        AssetImage(iconUrl),
        size: 15,
        color: colorOfWidget,
      ),
      SizedBox(
        width: 5.0,
      ),
      defaultSubtitleTextTwo(
          context: context,
          text: titleText,
          textColor: colorOfWidget != Colors.red ? colorOfWidget : null),
    ],
  );
}

Widget showAvilableTimeInOneDay(
    {BuildContext context, String dayName, String startTime, String endTime}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    child: Column(
      children: [
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Center(
              child: defaultSubtitleTextTwo(
                  context: context,
                  text: dayName ?? 'الأحد',
                  textColor: Colors.white)),
        ),
        SizedBox(
          height: 8.0,
        ),
        defaultShowTime(context: context, textTime: startTime ?? 'من 30 10 ص'),
        defaultShowTime(context: context, textTime: endTime ?? 'إلى 50 11 ص'),
      ],
    ),
  );
}

Widget defaultSubtitleTextTwo(
        {@required BuildContext context,
        @required String text,
        Color textColor}) =>
    Text(text,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: textColor ?? Colors.grey[700],
            ));

Widget bottomNavigationBar(
    {@required BuildContext context,
    @required int currentIndex,
    @required Function onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Color(0xFF060606).withOpacity(0.5),
//                        spreadRadius: 5,
//                        blurRadius: 7,
//                        offset:
//                            const Offset(0, 3), // changes position of shadow
//                      ),
//                    ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 53,
              child: ImageIcon(
                AssetImage('images/homeGrey.png'),
                size: 25,
              ),
            ),
            label: '',
            activeIcon: Container(
              height: 53,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white,width: 2))
              ),
              child: ImageIcon(
                AssetImage('images/home.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              height: 53,
              child: ImageIcon(
                AssetImage('images/shoppingCartGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white,width: 2))
              ),
              child: ImageIcon(
                AssetImage('images/shoppingCart.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              height: 53,
              child: ImageIcon(
                AssetImage('images/searchGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white,width: 2))
              ),
              child: ImageIcon(
                AssetImage('images/search.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              height: 53,
              child: ImageIcon(
                AssetImage('images/favouriteGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white,width: 2))
              ),
              child: ImageIcon(
                AssetImage('images/favourite.png'),
                size: 25,
              ),
            ),
          ),
        ],
        enableFeedback: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedIconTheme:
        IconThemeData(color: Colors.grey, size: 25),
// selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: TextStyle(
          fontSize: 0,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 0,
        ),
      ),
    ),
  );
}

//bottomNavigationBar: Consumer<ChangeIndex>(
//builder: (context, changeIndex, child) =>bottomNavigationBar(
//context: context,
//onTap: (index){
//setState(() {
//changeIndex.index=index;
//});
//Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
//pageBuilder:
//(context, animation1, animation2) =>
//NavigationHome(),
//transitionDuration: Duration(seconds: 0),
//),(Route<dynamic> route) => false);
//},
//media: media,
//currentIndex: changeIndex.index
//),
//),

Widget defaultFormField({
  TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  String label,
  IconData prefix,
  IconData suffix,
  Color suffixColor,
  Function suffixPressed,
  bool isClickable = true,
  bool readOnly = false,
}) =>
    SizedBox(
      height: 55.0,
      child: InkWell(
        onTap: isClickable == false ? onTap : null,
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          enabled: isClickable,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap ?? () {},
          validator: validate,
          cursorColor: primeColor,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: prefix != null
                ? Icon(
                    prefix,
                  )
                : null,
            labelStyle: TextStyle(color: Color(0xFF4F4F4F), fontSize: 14),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                      color: suffixColor,
                    ),
                  )
                : null,
            fillColor: Color(0xFF8C8C8C),
            filled: true,
            errorStyle: TextStyle(color: primeColor),
            floatingLabelStyle: TextStyle(color: primeColor),
            contentPadding: EdgeInsets.only(bottom: 10, right: 15, left: 15),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIconColor: primeColor,
          ),
          style: TextStyle(color: Color(0xFF060606), fontSize: 16),
          readOnly: readOnly,
        ),
      ),
    );
OutlineInputBorder textFormFieldBorder = InputBorder.none;

//Widget defaultAppBar(
//        {@required BuildContext context,
//        String titleKey,
//        bool enableLeading = true,
//        bool isTextNotKey = false,
//        bool automaticallyImplyLeading = true,
//        List<Widget> actions,
//        Function onClickedBackButton}) =>
//    AppBar(
//      automaticallyImplyLeading: automaticallyImplyLeading,
//      leading: enableLeading == true
//          ? IconButton(
//              onPressed: onClickedBackButton == null
//                  ? () {
//                      Navigator.pop(context);
//                    }
//                  : onClickedBackButton,
//              icon: const ImageIcon(
//                AssetImage(
//                  'images/arrowLeft.png',
//                ),
//                size: 16,
//              ))
//          : null,
//      centerTitle: !enableLeading,
//      title: Text(
//        isTextNotKey
//            ? titleKey
//            : '${AppLocalizations.of(context).trans(titleKey)}',
//      ),
//      titleSpacing: 2.0,
//      actions: actions,
//    );

Widget myDivider() => Divider(
  height: 30,
  thickness: 0.15,
  color: Colors.grey[300],
);

void navigateTo(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

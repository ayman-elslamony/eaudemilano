import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Screens/subScreens/ShowItemScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

//final List<String> imgList = [
//  'https://thumbs.dreamstime.com/t/gym-24699087.jpg',
//  'https://media.istockphoto.com/photos/empty-gym-picture-id1132006407?k=20&m=1132006407&s=612x612&w=0&h=Z7nJu8jntywb9jOhvjlCS7lijbU4_hwHcxoVkxv77sg=',
//  'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX26664924.jpg',
//  'https://media.istockphoto.com/photos/muscular-trainer-writing-on-clipboard-picture-id675179390?k=20&m=675179390&s=612x612&w=0&h=7LP7-OamGu-b8XG-VKcJuamK5s80ke-4oJ5siUrjFVA=',
//  'https://www.muscleandfitness.com/wp-content/uploads/2019/11/Young-Muscular-Man-Doing-Lunges-In-Dark-Gym.jpg?w=1109&h=614&crop=1&quality=86&strip=all',
//  'https://www.giggsmeat.com/wp-content/uploads/2020/10/4wqKj5zM2a-min.jpg'
//];

//Shimmer.fromColors(
//baseColor: Colors.black12.withOpacity(0.1),
//highlightColor: Colors.black.withOpacity(0.2),
//child: Padding(
//padding: const EdgeInsets.only(top: 6),
//child: Container(
//decoration: BoxDecoration(
//borderRadius: BorderRadius.circular(10),
//color: Colors.blue[100],
//),
//height: infoWidget.screenHeight * 0.15,
//),
//),
//)
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
          style: const TextStyle(
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
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          width: 11,
          height: 11,
          child: const SizedBox()),
      const SizedBox(
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
        const SizedBox(
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
        const SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: onDeletePressed,
          child: const ImageIcon(
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
        String imgUrl = '',
        String titleContent,
        String favIconUrl = '',
        bool justEnableDeleteIcon = false,
        Function onFavPressed,
        Function onDeletePressed}) =>
    InkWell(
      onTap: () {
        navigateTo(context, ShowItemScreen());
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xFF8C8C8C)),
              child: imgUrl != ''
                  ? Image.network(
                      imgUrl,
                      width: media.width * 0.19,
                      height: media.height * 0.11,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      "images/perfume${currentIndex + 1}.png",
                      width: media.width * 0.19,
                      height: media.height * 0.11,
                      fit: BoxFit.fill,
                    ),
            ),
            defaultTextInCard(
                context: context,
                subTitle: subTitle,
                title: '$title \$',
                titleContent: titleContent),
            favIconUrl == ''
                ? const SizedBox()
                : addFavouriteAndRemoveInCard(
                    onDeletePressed: onDeletePressed,
                    onFavPressed: onFavPressed,
                    favIconUrl: favIconUrl),
            justEnableDeleteIcon == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: onDeletePressed,
                          child: const ImageIcon(
                            AssetImage('images/delete.png'),
                            size: 17,
                            color: Color(0xFF7D3030),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );

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
        isEnableSpaceBeforeArrow == true ? const Spacer() : const SizedBox(),
        Icon(
          Icons.arrow_forward_ios,
          size: 18.0,
          color: isHomeScreen == true ? Colors.grey[800] : Colors.grey[300],
        ),
        isEnableSpaceBeforeArrow == false ? const Spacer() : const SizedBox()
      ],
    ),
  );
}

Widget defaultTextButton(
        {@required Function function,
        @required BuildContext context,
        @required String textKey,
        Color textColor}) =>
    TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: function,
      child: Text('${AppLocalizations.of(context).trans(textKey)}',
          style: Theme.of(context).textTheme.button.copyWith(
                color: textColor == null ? const Color(0xFFBDBDBD) : textColor,
              )),
    );

Widget defaultSubtitleTextOne(
        {@required BuildContext context, @required String text, Color color}) =>
    Text(text,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: color ?? Colors.white));

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
    decoration: const BoxDecoration(
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
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 53,
              child: const ImageIcon(
                AssetImage('images/homeGrey.png'),
                size: 25,
              ),
            ),
            label: '',
            activeIcon: Container(
              height: 53,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 2))),
              child: const ImageIcon(
                AssetImage('images/home.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              height: 53,
              child: const ImageIcon(
                AssetImage('images/shoppingCartGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 2))),
              child: const ImageIcon(
                AssetImage('images/shoppingCart.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: const SizedBox(
              height: 53,
              child: ImageIcon(
                AssetImage('images/searchGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 2))),
              child: const ImageIcon(
                AssetImage('images/search.png'),
                size: 25,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: const SizedBox(
              height: 53,
              child: ImageIcon(
                AssetImage('images/favouriteGrey.png'),
                size: 25,
              ),
            ),
            activeIcon: Container(
              height: 53,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 2))),
              child: const ImageIcon(
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
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 25),
// selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: const TextStyle(
          fontSize: 0,
        ),
        unselectedLabelStyle: const TextStyle(
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
  String hintText,
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
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 15, bottom: 12, left: 5, right: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF8C8C8C),
            borderRadius: BorderRadius.circular(15),
          ),
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
              hintText: hintText,
              prefixIcon: prefix != null
                  ? Icon(
                      prefix,
                    )
                  : null,
              hintStyle:
                  const TextStyle(color: Color(0xFF4F4F4F), fontSize: 14),
              labelStyle:
                  const TextStyle(color: Color(0xFF4F4F4F), fontSize: 14),
              suffixIcon: suffix != null
                  ? IconButton(
                      padding: EdgeInsets.only(bottom: 7),
                      onPressed: suffixPressed,
                      icon: Icon(
                        suffix,
                        color: suffixColor,
                      ),
                    )
                  : null,
              fillColor: const Color(0xFF8C8C8C),
              filled: true,
              errorStyle: const TextStyle(color: Color(0xFF4F4F4F)),
              floatingLabelStyle: const TextStyle(color: Color(0xFF4F4F4F)),
              contentPadding: const EdgeInsets.only(
                  bottom: 10, right: 15, left: 15, top: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIconColor: primeColor,
            ),
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.grey[900],
              fontSize: 16,
            ),
            readOnly: readOnly,
          ),
        ),
      ),
    );
OutlineInputBorder textFormFieldBorder = InputBorder.none;

Widget myDivider({double height = 30}) => Divider(
      height: height,
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

Widget loaderApp() {
  return const SpinKitSpinningLines(
    color: Colors.black87,
    lineWidth: 4,
    size: 60,
  );
}

showAlertDialog(BuildContext context,
    {Widget alertTitle, String content, onOk}) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      AppLocalizations.of(context).trans("ok"),
      style: TextStyle(
          color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    ),
    onPressed: onOk ??
        () {
          Navigator.pop(context);
        },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0))),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    title: alertTitle ?? const SizedBox(),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

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

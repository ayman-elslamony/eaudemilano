// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eaudemilano/Helper/components.dart';
import 'package:flutter/material.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

const String kNavigationExamplePage =
    '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class PaymentWebView extends StatefulWidget {
  var url;
  PaymentWebView({this.url});
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int position = 1 ;
  var _locale;

  @override
  void initState() {
    super.initState();

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  String successfulUrl = '';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          iconSize: 19,
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('my_fatora')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),

      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: IndexedStack(
        index: position,
        children: [
          Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: '${widget.url}',

              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
                setState(() {
                  position = 1;
                });
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');

//                defaultTextButton(
//                  context: context,
//                  textKey: 'finish',
//                  textColor: Colors.white,
//                  function: (){
//                    Navigator.of(context).pop(true);
//                  },
//                );
                if(url.contains('api/payment_operation?operation=success')){
                  Navigator.of(context).pop(true);
                  setState(() {
                    successfulUrl = url;
                    position = 0;
                  });
                }
                  setState(() {
                    position = 0;
                  });

              },
              gestureNavigationEnabled: true,
            );
          }),
          Center(
            child: loaderApp(),
          )
//          successfulUrl.contains('api/payment_operation?operation=success')
//              ? Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Spacer(),
//                    Align(
//                      alignment: Alignment.center,
//                      child: Container(
//                        height: 45,
//                        width: media.width,
//                        child: Center(
//                            child: Text(
//                          '${AppLocalizations.of(context).trans('donepayment')}',
//                          style: TextStyle(
//                              color: Colors.grey[800],
//                              fontSize: 18,
//                              fontFamily: 'CairoSemiBold'),
//                        )),
//                      ),
//                    ),
//                      Spacer(),
//                    InkWell(
//                      onTap: () {
////                        Provider.of<PaymentProvider>(context, listen: false)
////                            .getMyWalletInformation(locale: _locale)
////                            .then((value) => Navigator.pushAndRemoveUntil(
////                                context,
////                                MaterialPageRoute(
////                                    builder: (context) => MyWallet()),
////                                (route) => false));
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 30),
//                        child: Container(
//                          height: 45,
//                          width: media.width,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(10),
//                            gradient: LinearGradient(
//                              colors: [
//                                Color(0xFF61976d),
//                                Color(0xFFa97460),
//                                Color(0xFFd85e57),
//                              ],
//                              begin: Alignment.centerRight,
//                              end: Alignment.centerLeft,
//                            ),
//                          ),
//                          child: Center(
//                              child: Text(
//                            '${AppLocalizations.of(context).trans('exit')}',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 16,
//                                fontFamily: 'CairoSemiBold'),
//                          )),
//                        ),
//                      ),
//                    ),
//                  ],
//                )
//              : const SizedBox(),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}


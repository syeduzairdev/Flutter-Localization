import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trans/second_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //get localization delegate
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_bar.title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //translated text from json file
            Text(translate('language.selected_message', args: {
              'language': translate(
                  'language.name.${localizationDelegate.currentLocale.languageCode}')
            })),
            Padding(
                padding: EdgeInsets.only(top: 25, bottom: 160),
                child: CupertinoButton.filled(
                  child: Text(translate('button.change_language')),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 36.0),
                  onPressed: () => _onActionSheetPress(context),
                )),
            //second screen
            CupertinoButton.filled(
              child: Text(translate('button.go_to_second_screen')),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
              onPressed: () {
                //when navigatre on second screen, the language will be changed to en
                changeLocale(context, 'en_US');
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => SecondScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// show action sheet to change language
  void showDemoActionSheet(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

//action button to change language
  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language.selection.title')),
        message: Text(translate('language.selection.message')),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("English"),
            onPressed: () => Navigator.pop(context, 'en_US'),
          ),
          CupertinoActionSheetAction(
            child: Text("Spanish"),
            onPressed: () => Navigator.pop(context, 'es'),
          ),
          CupertinoActionSheetAction(
            child: Text("Arabic"),
            onPressed: () => Navigator.pop(context, 'ar'),
          ),
          CupertinoActionSheetAction(
            child: Text("Russian"),
            onPressed: () => Navigator.pop(context, 'ru'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate('button.cancel')),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }
}

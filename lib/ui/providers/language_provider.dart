import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{
   String currentLocale='en';
  void updateLocale(String newlocale){
    currentLocale = newlocale;
    notifyListeners();
  }
}
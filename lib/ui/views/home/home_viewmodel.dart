import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nationyme/app/app.locator.dart';
import 'package:nationyme/service/nationalize_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final TextEditingController _textEditingController = TextEditingController();
  final nationalizeService = locator<NationalizeService>();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;
  List<Map<String, dynamic>> nationalizeData = [];

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  Future<void> handleSearchNationalizeByName(String name) async {
    Map<String, dynamic> resData =
        await nationalizeService.getNationalizeByName(name);
    print(resData['country']);
    List bunchOfCountry = resData['country'] ?? [];
    nationalizeData = bunchOfCountry.map((e) {
      return {
        'country_id': e['country_id'],
        'probability': e['probability'],
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length)]
      };
    }).toList();
    print(nationalizeData);
    rebuildUi();
  }
}

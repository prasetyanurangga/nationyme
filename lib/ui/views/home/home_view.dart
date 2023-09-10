import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nationyme/ui/common/ui_helpers.dart';
import 'package:nationyme/ui/widgets/pie_chart_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameTextController = useTextEditingController();
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter some text',
                      ),
                      onSubmitted: (value) =>
                          model.handleSearchNationalizeByName(
                              nameTextController.text),
                    ),
                    verticalSpaceMedium,
                    model.nationalizeData.isNotEmpty
                        ? SizedBox(
                            width: 300,
                            height: 300,
                            child: PieChartWidget(
                              nationalizeData: model.nationalizeData,
                            ))
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }


}

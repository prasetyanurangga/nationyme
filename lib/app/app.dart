import 'package:nationyme/service/dio_service.dart';
import 'package:nationyme/service/nationalize_service.dart';
import 'package:nationyme/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DioService),
    LazySingleton(classType: NationalizeService),
    // @stacked-service
  ],
  logger: StackedLogger(),
)
class App {}

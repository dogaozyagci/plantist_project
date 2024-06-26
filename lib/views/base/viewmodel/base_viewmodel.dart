import 'package:flutter/material.dart';
import 'package:plantist_project/views/core/init/navigation/navigation_service.dart';

abstract class BaseViewModel with ChangeNotifier {
  NavigationService navigation = NavigationService.instance;

}

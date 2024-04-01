
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/services/routes/app_route_keys.dart';
import 'package:flutter_pokemon_app/ui/dashboard_screen/dashboard_screen.dart';
import 'package:flutter_pokemon_app/ui/details_screen/details_screen.dart';
import 'package:flutter_pokemon_app/ui/list_screen/list_screen.dart';

Route<dynamic>? AppRouter(RouteSettings settings) {
  switch (settings.name) {
    case AppRouteKeys.dashboard:
    return nativePageRoute(builder: (context) {
      return DashboardScreen();
    }, settings: settings);
    case AppRouteKeys.list:
    return nativePageRoute(builder: (context) {
      return ListScreen();
    }, settings: settings);
    case AppRouteKeys.details:
    return nativePageRoute(builder: (context) {
      return DetailsScreen();
    }, settings: settings);
  }

  return null;
}

PageRoute<T>? nativePageRoute<T>({  
  required WidgetBuilder builder,
  required RouteSettings settings,
  String? iosTitle,
}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
    );
  } else {
    return CupertinoPageRoute<T>(
      builder: builder,
      settings: settings,
      title: iosTitle,
    );
  }
}
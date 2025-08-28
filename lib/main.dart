import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/page/detail/detail.dart';
import 'package:resto_app/page/main/main.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/provider/detail/review_add_provider.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/provider/main/index_nav_provider.dart';
import 'package:resto_app/provider/search/resto_search_provider.dart';
import 'package:resto_app/static/navigation_route.dart';
import 'package:resto_app/style/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(
          create: (context) => RestoListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestoSearchProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewAddProvider(context.read<ApiService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto App',
      theme: RestoTheme.lightTheme,
      darkTheme: RestoTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,

      routes: {
        NavigationRoute.mainRoute.name: (context) => const Main(),
        NavigationRoute.detailRoute.name: (context) => Detail(
          resto: ModalRoute.of(context)?.settings.arguments as RestoBrief,
        ),
      },
    );
  }
}

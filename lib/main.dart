import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/common/routes.dart';
import 'package:jubelio/controller/list_offline/list_offline_cubit.dart';
import 'package:jubelio/controller/product_list/product_list_cubit.dart';
import 'package:jubelio/controller/search/search_cubit.dart';
import 'package:jubelio/view/cart/cart_page.dart';
import 'package:jubelio/view/detail_page/detail_page.dart';
import 'package:jubelio/view/list_page/list_page.dart';
import 'package:jubelio/view/search/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>ProductListCubit()..getProductList()),
        BlocProvider(create: (_)=>ListOfflineCubit()..offlineData(),),
        BlocProvider(create: (_)=>SearchCubit()),
      ],
      child: MaterialApp(
        title: 'Elevenia Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListPage(),
        onGenerateRoute: (routes){
          switch(routes.name){
            case RoutesPage.homePage:
              return MaterialPageRoute(builder: (context)=>const ListPage());
            case RoutesPage.detailPage:
              var args = routes.arguments as Map;
              return MaterialPageRoute(builder: (context)=> DetailPage(prdNo: args['prdNo'],));
            case RoutesPage.cartPage:
              return MaterialPageRoute(builder: (context)=> const CartPage());
            case RoutesPage.searchPage:
              return MaterialPageRoute(builder: (context)=> const SearchPage());
            default:
              return MaterialPageRoute(
                  builder: (context)=> Container(color: Colors.white, child: const Text('Page not found'),)
              );
          }
        }
      ),
    );
  }
}

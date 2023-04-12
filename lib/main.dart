import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_system/controllers/db_helper.dart';
import 'package:food_ordering_system/controllers/products_list_controller.dart';
import 'package:food_ordering_system/views/screens/LoginPage.dart';
import 'package:food_ordering_system/views/screens/SignUp.dart';
import 'package:food_ordering_system/views/screens/cart_screen.dart';
import 'package:food_ordering_system/views/screens/detail_screen.dart';
import 'package:food_ordering_system/views/screens/favorite_screen.dart';
import 'package:food_ordering_system/views/screens/home.dart';
import 'package:food_ordering_system/views/screens/home_page.dart';
import 'package:food_ordering_system/views/screens/home_screen.dart';
import 'package:food_ordering_system/views/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();


  final ProductListController productListController =
      Get.put(ProductListController());

  await ProductDBHelper.productDBHelper.insertData();

  productListController.setProductList();

  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash_screen",
      getPages: [
        GetPage(name: "/", page: () => Login()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/homepage", page: () => HomePage()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/splash_screen", page: () => const SplashScreen()),
        GetPage(name: "/details_screen", page: () => DetailScreen()),
        GetPage(name: "/home_screen", page: () => HomeScreen()),
        GetPage(name: "/cart_screen", page: () => CartScreen()),
        GetPage(name: "/favourite_screen", page: () => FavoriteScreen()),
      ],
    ),
  );
}

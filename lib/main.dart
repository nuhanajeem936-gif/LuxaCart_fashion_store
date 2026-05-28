import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'screens/splash_screen.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/order_viewmodel.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  /// ================= PRIMARY COLOR =================
  static const Color primaryColor =
      Color(0xFFF48FB1);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) =>
              AuthViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              ProductViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              CartViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              OrderViewModel(),
        ),
      ],

      child: MaterialApp(

        debugShowCheckedModeBanner:
            false,

        title:
            "LuxaCart Fashion Store",

        /// ================= THEME =================
        theme: ThemeData(

          useMaterial3: true,

          fontFamily: "Poppins",

          scaffoldBackgroundColor:
              const Color(
            0xFFFDF4F7,
          ),

          colorScheme:
              ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            brightness:
                Brightness.light,
          ),

          /// ================= APP BAR =================
          appBarTheme:
              const AppBarTheme(

            backgroundColor:
                Colors.white,

            foregroundColor:
                Colors.black,

            centerTitle: true,

            elevation: 0,

            scrolledUnderElevation: 0,

            iconTheme: IconThemeData(
              color: Colors.black,
            ),

            titleTextStyle:
                TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          /// ================= ELEVATED BUTTON =================
          elevatedButtonTheme:
              ElevatedButtonThemeData(

            style:
                ElevatedButton.styleFrom(

              backgroundColor:
                  primaryColor,

              foregroundColor:
                  Colors.white,

              elevation: 0,

              minimumSize:
                  const Size(
                double.infinity,
                55,
              ),

              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),

              textStyle:
                  const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          /// ================= INPUT FIELD =================
          inputDecorationTheme:
              InputDecorationTheme(

            filled: true,

            fillColor:
                Colors.white,

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),

            hintStyle:
                TextStyle(
              color:
                  Colors.grey.shade500,
            ),

            prefixIconColor:
                primaryColor,

            border:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  BorderSide.none,
            ),

            enabledBorder:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  BorderSide(
                color:
                    Colors.pink.shade100,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  const BorderSide(
                color:
                    primaryColor,
                width: 1.5,
              ),
            ),
          ),

          /// ================= CARD =================
          cardTheme:
              CardThemeData(

            color: Colors.white,

            elevation: 0,

            margin:
                EdgeInsets.zero,

            shadowColor:
                Colors.black12,

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                22,
              ),
            ),
          ),

          /// ================= ICON THEME =================
          iconTheme:
              const IconThemeData(
            color: primaryColor,
          ),

          /// ================= TEXT THEME =================
          textTheme:
              const TextTheme(

            headlineLarge:
                TextStyle(
              fontSize: 30,
              fontWeight:
                  FontWeight.bold,
              color: Colors.black,
            ),

            headlineMedium:
                TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
              color: Colors.black,
            ),

            bodyLarge:
                TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),

            bodyMedium:
                TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          /// ================= BOTTOM NAVIGATION =================
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(

            backgroundColor:
                Colors.white,

            selectedItemColor:
                primaryColor,

            unselectedItemColor:
                Colors.grey,

            selectedLabelStyle:
                TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),

            type:
                BottomNavigationBarType.fixed,

            elevation: 8,
          ),

          /// ================= PROGRESS INDICATOR =================
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(
            color: primaryColor,
          ),

          /// ================= CHECKBOX =================
          checkboxTheme:
              CheckboxThemeData(

            fillColor:
                WidgetStateProperty.all(
              primaryColor,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                5,
              ),
            ),
          ),

          /// ================= CHIP =================
          chipTheme:
              ChipThemeData(

            backgroundColor:
                Colors.white,

            selectedColor:
                primaryColor,

            secondarySelectedColor:
                primaryColor,

            labelStyle:
                const TextStyle(
              color: Colors.black,
            ),

            secondaryLabelStyle:
                const TextStyle(
              color: Colors.white,
            ),

            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),
            ),
          ),
        ),

        /// ================= START SCREEN =================
        home: const SplashScreen(),
      ),
    );
  }
}
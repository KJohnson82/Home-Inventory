import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hvtest1/theme.dart';
import 'Routes/Homes.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'theme.dart';

// var homes = <int, Home>{};
FirebaseFirestore db = FirebaseFirestore.instance;

// appThemeDark() {
//   darkTheme:
//   FlexThemeData.dark(
//     scheme: FlexScheme.blueWhale,
//     surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//     blendLevel: 15,
//     appBarStyle: FlexAppBarStyle.background,
//     bottomAppBarElevation: 2.0,
//     subThemesData: const FlexSubThemesData(
//       blendOnLevel: 40,
//       blendTextTheme: true,
//       useM2StyleDividerInM3: true,
//       thickBorderWidth: 2.0,
//       elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
//       elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
//       outlinedButtonOutlineSchemeColor: SchemeColor.primary,
//       toggleButtonsBorderSchemeColor: SchemeColor.primary,
//       segmentedButtonSchemeColor: SchemeColor.primary,
//       segmentedButtonBorderSchemeColor: SchemeColor.primary,
//       unselectedToggleIsColored: true,
//       sliderValueTinted: true,
//       inputDecoratorSchemeColor: SchemeColor.primary,
//       inputDecoratorBackgroundAlpha: 22,
//       inputDecoratorRadius: 10.0,
//       chipRadius: 10.0,
//       popupMenuRadius: 6.0,
//       popupMenuElevation: 6.0,
//       drawerWidth: 280.0,
//       drawerIndicatorSchemeColor: SchemeColor.primary,
//       bottomNavigationBarMutedUnselectedLabel: false,
//       bottomNavigationBarMutedUnselectedIcon: false,
//       menuRadius: 6.0,
//       menuElevation: 6.0,
//       menuBarRadius: 0.0,
//       menuBarElevation: 1.0,
//       navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
//       navigationBarMutedUnselectedLabel: false,
//       navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
//       navigationBarMutedUnselectedIcon: false,
//       navigationBarIndicatorSchemeColor: SchemeColor.primary,
//       navigationBarIndicatorOpacity: 1.00,
//       navigationBarElevation: 2.0,
//       navigationBarHeight: 70.0,
//       navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
//       navigationRailMutedUnselectedLabel: false,
//       navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
//       navigationRailMutedUnselectedIcon: false,
//       navigationRailIndicatorSchemeColor: SchemeColor.primary,
//       navigationRailIndicatorOpacity: 1.00,
//     ),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     useMaterial3: true,
//     swapLegacyOnMaterial3: true,
//     // To use the Playground font, add GoogleFonts package and uncomment
//     // fontFamily: GoogleFonts.notoSans().fontFamily,
//     // If you do not have a themeMode switch, uncomment this line
// // to let the device system mode control the theme mode:
// // themeMode: ThemeMode.system,
//   );
// }
//
// appThemeLight() {
//   FlexThemeData.light(
//     scheme: FlexScheme.blueWhale,
//     surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//     blendLevel: 25,
//     appBarStyle: FlexAppBarStyle.background,
//     bottomAppBarElevation: 1.0,
//     subThemesData: const FlexSubThemesData(
//       blendOnLevel: 20,
//       blendTextTheme: true,
//       useM2StyleDividerInM3: true,
//       thickBorderWidth: 2.0,
//       elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
//       elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
//       outlinedButtonOutlineSchemeColor: SchemeColor.primary,
//       toggleButtonsBorderSchemeColor: SchemeColor.primary,
//       segmentedButtonSchemeColor: SchemeColor.primary,
//       segmentedButtonBorderSchemeColor: SchemeColor.primary,
//       unselectedToggleIsColored: true,
//       sliderValueTinted: true,
//       inputDecoratorSchemeColor: SchemeColor.primary,
//       inputDecoratorBackgroundAlpha: 15,
//       inputDecoratorRadius: 10.0,
//       inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
//       chipRadius: 10.0,
//       popupMenuRadius: 6.0,
//       popupMenuElevation: 6.0,
//       appBarScrolledUnderElevation: 8.0,
//       drawerWidth: 280.0,
//       drawerIndicatorSchemeColor: SchemeColor.primary,
//       bottomNavigationBarMutedUnselectedLabel: false,
//       bottomNavigationBarMutedUnselectedIcon: false,
//       menuRadius: 6.0,
//       menuElevation: 6.0,
//       menuBarRadius: 0.0,
//       menuBarElevation: 1.0,
//       navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
//       navigationBarMutedUnselectedLabel: false,
//       navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
//       navigationBarMutedUnselectedIcon: false,
//       navigationBarIndicatorSchemeColor: SchemeColor.primary,
//       navigationBarIndicatorOpacity: 1.00,
//       navigationBarElevation: 2.0,
//       navigationBarHeight: 70.0,
//       navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
//       navigationRailMutedUnselectedLabel: false,
//       navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
//       navigationRailMutedUnselectedIcon: false,
//       navigationRailIndicatorSchemeColor: SchemeColor.primary,
//       navigationRailIndicatorOpacity: 1.00,
//     ),
//     visualDensity: FlexColorScheme.comfortablePlatformDensity,
//     useMaterial3: true,
//     swapLegacyOnMaterial3: true,
//     // To use the playground font, add GoogleFonts package and uncomment
//     // fontFamily: GoogleFonts.notoSans().fontFamily,
//     // If you do not have a themeMode switch, uncomment this line
// // to let the device system mode control the theme mode:
// // themeMode: ThemeMode.system,
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData.from(colorScheme: homeventory),
      title: 'HOMVENTORY',
      home: Scaffold(
        // bottomNavigationBar: BottomAppBar(
        //   color: homeventory.primary,
        //   surfaceTintColor: homeventory.primary,
        //   elevation: 2,
        //   notchMargin: 10,
        //   shape: AutomaticNotchedShape(
        //     RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(
        //       Radius.circular(30),
        //     )),
        //     StadiumBorder(),
        //   ),
        //   child: Row(
        //     children: <Widget>[
        //       Icon(Icons.holiday_village),
        //       Icon(Icons.warehouse),
        //       Icon(Icons.list)
        //     ],
        //   ),
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //     elevation: 3,
        //     backgroundColor: homeventory.primary,
        //     selectedItemColor: Colors.white,
        //     items: <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home_filled), label: 'Homes'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.add_home_work), label: 'Rooms'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.insert_chart_rounded), label: 'Items'),
        //     ]),
        appBar: AppBar(
          title: const Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}

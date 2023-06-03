import 'package:commonhelpdesk/service/emailService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commonhelpdesk/service/adminImageRegistry.dart';
import 'package:commonhelpdesk/service/adminImageRegistrySelect.dart';
import 'package:commonhelpdesk/service/advertisement.dart';
import 'package:commonhelpdesk/service/asset.dart';
import 'package:commonhelpdesk/service/branding.dart';
import 'package:commonhelpdesk/service/building.dart';
import 'package:commonhelpdesk/service/changePassword.dart';
import 'package:commonhelpdesk/service/contract.dart';
import 'package:commonhelpdesk/service/count.dart';
import 'package:commonhelpdesk/service/department.dart';
import 'package:commonhelpdesk/service/discipline.dart';
import 'package:commonhelpdesk/service/division.dart';
import 'package:commonhelpdesk/service/feedbakRating.dart';
import 'package:commonhelpdesk/service/floor.dart';
import 'package:commonhelpdesk/service/getxListener.dart';
import 'package:commonhelpdesk/service/location.dart';
import 'package:commonhelpdesk/service/loginService.dart';
import 'package:commonhelpdesk/service/name.dart';
import 'package:commonhelpdesk/service/natureOfComplaint.dart';
import 'package:commonhelpdesk/service/registerSave.dart';
import 'package:commonhelpdesk/service/servicePageInitState.dart';
import 'package:commonhelpdesk/service/serviceRequest.dart';
import 'package:commonhelpdesk/service/spot.dart';
import 'package:commonhelpdesk/service/trackTable.dart';
import 'package:commonhelpdesk/service/trackView.dart';
import 'package:commonhelpdesk/service/verifyOtp.dart';
import 'package:commonhelpdesk/splash.dart';
import 'package:commonhelpdesk/styles/common%20Color.dart';
import 'Screens/Login/login.dart';

void main() {
  Get.put(EmailController());
  Get.put(LoginController());
  Get.put(OTPController());
  Get.put(ChangePasswordController());
  Get.put(AdvertisementControl());
  Get.put(ContractControl());
  Get.put(LocationControl());
  Get.put(BuildingControl());
  Get.put(ServiceRequestInitStateControl());
  Get.put(ServiceRequestControl());
  Get.put(FloorControl());
  Get.put(SpotControl());
  Get.put(DepartmentControl());
  Get.put(DisciplineControl());
  Get.put(DivisionControl());
  Get.put(RegisterSaveControl());
  Get.put(NatureOfComplaintControl());
  Get.put(ListenerControl());
  Get.put(AssetControl());
  Get.put(TrackTableControl());
  Get.put(TrackViewControl());
  Get.put(BrandingControl());
  Get.put(AdminImageRegistrySaveControl());
  Get.put(AdminImageRegistrySelectControl());
  Get.put(CountControl());
  Get.put(NameControl());
  Get.put(FeedbackRating());
  String? un = Uri.base.queryParameters["un"].toString();
  String? pass = Uri.base.queryParameters["pass"].toString();
  runApp(MyApp(
    un: un,
    pass: pass,
  ));
}

class MyApp extends StatelessWidget {
  String? un, pass;
  MyApp({super.key, this.un, this.pass});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            backgroundColor: Styles.scaffoldBackgroundColor,
            titleTextStyle:
                const TextStyle(fontFamily: 'Eras Demi', fontSize: 20)),
        buttonTheme: const ButtonThemeData(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: const CircleBorder(),
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(const Color(0xFF21446F)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        dividerColor: buttonForeground,
        primaryColor: const Color(0xFF21446F),
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
        scrollbarTheme: Styles.scrollbarTheme,
      ),
      title: 'HELPDESK',
      home: Splash(un: un, pass: pass),
    );
  }
}

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:commonhelpdesk/styles/common%20Color.dart';
import '../../service/branding.dart';
import '../../service/building.dart';
import '../../service/changePassword.dart';
import '../../service/department.dart';
import '../../service/emailService.dart';
import '../../service/floor.dart';
import '../../service/location.dart';
import '../../service/registerSave.dart';
import '../../service/spot.dart';
import '../../service/verifyOtp.dart';
import '../../styles/CommonSize.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/Responsive.dart';
import '../../styles/entryDropDownStyles.dart';
import '../../widgets/snackBar.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(),
      otpControl = TextEditingController(),
      passwordControl = TextEditingController(),
      confirmPasswordControl = TextEditingController();
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final EmailController _emailController = Get.find<EmailController>();
  final OTPController _otpController = Get.find<OTPController>();
  final LocationControl _locationControl = Get.find<LocationControl>();
  final BuildingControl _buildingControl = Get.find<BuildingControl>();
  final FloorControl _floorControl = Get.find<FloorControl>();
  final SpotControl _spotControl = Get.find<SpotControl>();
  final DepartmentControl _departmentControl = Get.find<DepartmentControl>();
  final BrandingControl _brandingControl = Get.find<BrandingControl>();
  final RegisterSaveControl _registerSaveControl =
      Get.find<RegisterSaveControl>();
  final ChangePasswordController _changePassController =
      Get.find<ChangePasswordController>();
  final _formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<FormState>();
  List<dynamic> listToSearch = [
    {'name': 'Amir', 'class': 12},
    {'name': 'Raza', 'class': 11},
    {'name': 'Praksh', 'class': 10},
    {'name': 'Nikhil', 'class': 9},
    {'name': 'Sandeep', 'class': 8},
    {'name': 'Tazeem', 'class': 7},
    {'name': 'Najaf', 'class': 6},
    {'name': 'Izhar', 'class': 5},
  ];
  bool formEnable = false, disableDropDown = true;
  var selected;
  String? locationIDPK, buildingIDPK, floorIDPK, spotIDPK, departmentIDPK;
  int? modIndex;
  List locationData = [],
      buildingData = [],
      floorData = [],
      spotData = [],
      departmentData = [];
  late List selectedList;
  List<dynamic> brandingData = [];
bool step = true;

  @override
  void initState() {
    super.initState();
    brandingFunc();
    locationFunc();
  }

  Future<void> brandingFunc() async {
    final response = _brandingControl.brandingData;
    setState(() {
      brandingData = response;
    });
  }

  locationFunc() async {
    final response = await _locationControl.locationApi(null);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        locationData = data;
      });
    }
  }

  buildingFunc() async {
    final locId = int.parse(locationIDPK!);
    final response = await _buildingControl.buildingApi(null, locId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        buildingData = data;
      });
    }
  }

  floorFunc() async {
    final locId = int.parse(locationIDPK!);
    final buildingId = int.parse(buildingIDPK!);
    final response = await _floorControl.floorApi(null, locId, buildingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        floorData = data;
      });
    }
  }

  spotFunc() async {
    final locId = int.parse(locationIDPK!);
    final buildingId = int.parse(buildingIDPK!);
    final floorId = int.parse(floorIDPK!);
    final response =
        await _spotControl.spotApi(null, locId, buildingId, floorId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        spotData = data;
      });
    }
  }

  departmentFunc() async {
    final response = await _departmentControl.departmentApi();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        spotData = data;
      });
    }
  }

  registerSaveFunc() async {
    if (kIsWeb) {
      modIndex = 2;
    } else {
      modIndex = 3;
    }
    final locId = int.parse(locationIDPK!);
    final buildingId = int.parse(buildingIDPK!);
    final floorId = int.parse(floorIDPK!);
    final spotId = int.parse(spotIDPK!);
    final response = await _registerSaveControl.registerSaveApi(
        context,
        null,
        locId,
        buildingId,
        floorId,
        spotId,
        null,
        null,
        null,
        null,
        "",
        "",
        "",
        "",
        null,
        null,
        "",
        "",
        modIndex,
        0);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = (json['Output']['data']);
      setState(() {
        spotData = data;
      });
    }
  }

  Future<void> mail() async {
    _emailController.emailApi(context, emailController.text);
  }

  Future<void> opt() async {
    final response = await _otpController.otpApi(
        context, emailController.text, otpControl.text);
    if (response.statusCode == 200) {
      setState(() {
        formEnable = true;
        disableDropDown = false;
        step = false;
      });
    }
  }

  Future<void> submitFunc() async {
    final response = await _changePassController.changePasswordApi(
        context, passwordControl.text, confirmPasswordControl.text);
    if (response.statusCode == "200") {
      // registerSaveFunc();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: mobile(),
      desktop: Scaffold(body: webView()),
    );
  }

  Widget mobile() {
    return const Text('register');
  }

  Widget webView() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(brandingData[0]['WebLoginSlide1Path']),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox(
          height: displayHeight(context) * 0.87,
          width: displayWidth(context) * 0.90,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  const Text('Register To Create Your Account', style: headerStyle),
                  SizedBox(
                    height: 60,
                    width: displayWidth(context) * 0.27,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: secondaryColor,
                          radius: 15,
                          child: Icon(Icons.edit,
                              size: 15, color: Colors.white),
                        ),
                        SizedBox(
                            width: displayWidth(context) * 0.20,
                            child: Divider(
                                indent: 10,
                                endIndent: 10,
                                color: step == true ? Colors.grey.shade300 : secondaryColor,
                                thickness: 0.8)),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: step == true ? Colors.grey.shade300 : secondaryColor,
                          child: Icon(Icons.hourglass_full_rounded,
                              size: 15,
                              color: step == true ? secondaryColor :  Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.60,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            key: _formKey,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  mailId(primaryColor,
                                      displayWidth(context) * 0.27,38),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: sendOtp(),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  securityCode(displayWidth(context) * 0.27),
                                ],
                              ),

                            ],
                          ),
                          Visibility(
                            visible: step == false ? true :false,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                   contactNo(displayWidth(context) * 0.27),
                                   userName(displayWidth(context) * 0.27),
                                   password(displayWidth(context) * 0.27),
                                   confirmPassword(displayWidth(context) * 0.27),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.10,
                    child: step == true ? verifyOtp() : submit(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have a account ?',
                            style: txtBtn1),
                        InkWell(
                            onTap: () => Get.off(
                                Login(un: 'null', pass: 'null')),
                            child: const Text('Login',
                                style: textBtn))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mailId(Color color, double val,double height) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerName('Email id'),
            SizedBox(
              height: height,
              width: val,
              child: TextFormField(
                // validator: (String? value) {
                //   if (value == null || value.isEmpty) {
                //     return "Email should not be empty";
                //   }
                //   if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                //     return "Please enter a valid email address";
                //   }
                //   else {
                //     return null;
                //   }
                // },
                cursorColor: secondaryColor,
                controller: emailController,
                decoration: loginInput(grey50, 'Enter your email address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget securityCode(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerName('Security Code'),
          SizedBox(
            height: 38,
            width: val,
            child: TextFormField(
              controller: otpControl,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: secondaryColor,
              decoration: loginInput(grey50, 'Enter Security Code'),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactNo(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Contact Number', style: inputHeader),
          ),
          SizedBox(
            height: 38,
            width: val,
            child: TextFormField(
              enabled: formEnable,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: secondaryColor,
              decoration: loginInput(grey50, 'Enter Contact Number'),
            ),
          ),
        ],
      ),
    );
  }

  Widget userName(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerName('User Name'),
          SizedBox(
            height: 38,
            width: val,
            child: TextFormField(
              enabled: formEnable,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              cursorColor: secondaryColor,
              decoration: loginInput(grey50, 'Enter User Name'),
            ),
          ),
        ],
      ),
    );
  }

  Widget password(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerName('Password'),
          SizedBox(
            height: 38,
            width: val,
            child: TextFormField(
              controller: passwordControl,
              enabled: formEnable,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              cursorColor: secondaryColor,
              decoration: loginInput(grey50, 'Enter Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmPassword(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerName('Confirm Password'),
          SizedBox(
            height: 38,
            width: val,
            child: TextFormField(
              validator: (String? value) {
                if (passwordControl.text == null) {
                  print('password should not be empty');
                  return "password should not be empty";
                }
                if (passwordControl.text == confirmPasswordControl.text) {
                  print('New password and confirm password same');
                  return "New password and confirm password isn't same";
                }
                return null;
              },
              controller: confirmPasswordControl,
              enabled: formEnable,
              keyboardType: TextInputType.number,
              cursorColor: secondaryColor,
              decoration: loginInput(grey50, 'Enter Confirm Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget sendOtp() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: secondaryColor,
      ),
      onPressed: () {
        if(emailController.text.isEmpty ){
          StackDialog.show('Invalid Email', 'Email should not be empty',
              Icons.error_outline, red);
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
            StackDialog.show('Invalid Email', 'Please enter a valid email address',
                Icons.error_outline, red);
          }else{
          mail();
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child:
            Text("Send Security Code", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget verifyOtp() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: secondaryColor,
      ),
      onPressed: () {
        opt();

      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Verify Code", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget cancel() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(135, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: Colors.white,
      ),
      onPressed: () {
        // Get.to(MySite());
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text("cancel", style: TextStyle(color: secondaryColor)),
      ),
    );
  }

  Widget next() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(135, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: secondaryColor,
      ),
      onPressed: () {
        setState(() {
          step = false;
        });
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Next", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget submit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(135, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        primary: secondaryColor,
      ),
      onPressed: () {
        submitFunc();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

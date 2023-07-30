import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/app/my_app.dart';
import 'package:food_ordering_sp2/core/translation/app_translation.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/login_view/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LoginView extends StatefulWidget {
  LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Center(
                  child: Obx(() {
                    return Icon(
                      controller.isInternetConnected.value
                          ? Icons.wifi
                          : Icons.signal_wifi_off,
                      color: controller.isInternetConnected.value
                          ? Colors.green
                          : Colors.red,
                      size: 48,
                    );
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.language,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Change Language',
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage('en');
                                  Get.updateLocale(getLocal());
                                  Get.back();
                                },
                                child: Text('English')),
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage('ar');
                                  Get.updateLocale(getLocal());
                                  Get.back();
                                },
                                child: Text('العربية')),
                          ],
                        ));
                  },
                ),
                SizedBox(
                  height: size.width * 0.25,
                ),
                Text(
                  tr("key_login"),
                  style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlackColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.01, bottom: size.width * 0.1),
                  child: Text(
                    tr('login_details'),
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainTextColor),
                  ),
                ),
                CustomTextField(
                  hitText: 'Your Email',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty || !GetUtils.isEmail(value)) {
                      return 'please check your email';
                    }
                  },
                ),
                CustomTextField(
                  hitText: 'password',
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                  },
                ),
                CustomButton(
                    text: tr('key_login'),
                    onPressed: () {
                      controller.login();
                      //controller.checkLocation();
                      // print("${locationService.getCurrentLocationInfo()} 88");
                      //   controller.login();
                      //   Location location = new Location();
                      //   bool _serviceEnabled;
                      //   PermissionStatus _permissionGranted;
                      //   LocationData _locationData;

                      //   _serviceEnabled = await location.serviceEnabled();
                      //   if (!_serviceEnabled) {
                      //     _serviceEnabled = await location.requestService();
                      //     if (!_serviceEnabled) {
                      //       return;
                      //     }
                      //   }

                      //   _permissionGranted = await location.hasPermission();
                      //   if (_permissionGranted == PermissionStatus.denied) {
                      //     _permissionGranted = await location.requestPermission();
                      //     if (_permissionGranted != PermissionStatus.granted) {
                      //       return;
                      //     }
                      //   }

                      //   _locationData = await location.getLocation();
                      //   print(_locationData);

                      //   List<geo.Placemark> placemarks =
                      //       await geo.placemarkFromCoordinates(
                      //           _locationData.latitude ?? 0.0,
                      //           _locationData.longitude ?? 0.0);

                      //   print(placemarks[0]);
                      //
                    }),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.1),
                  child: Text(
                    'Forget password',
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.mainTextColor),
                  ),
                ),
                Text(
                  'or Login With',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainTextColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.06),
                  child: CustomButton(
                    text: 'Login with Facebook',
                    backgroundColor: AppColors.mainBlueColor,
                    imageName: 'Facebook',
                  ),
                ),
                CustomButton(
                  text: 'Login with Google',
                  backgroundColor: AppColors.mainRedColor,
                  imageName: 'google-plus-logo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

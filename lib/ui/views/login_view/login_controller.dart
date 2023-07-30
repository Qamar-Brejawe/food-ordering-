import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_sp2/core/data/repositories/shared_prefreance_repository.dart';
import 'package:food_ordering_sp2/core/data/repositories/user_repository.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/core/services/base_controller.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  TextEditingController emailController =
      TextEditingController(text: 'Test@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Test@1234');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isInternetConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // checkInternetConnectivity();
  }

  // void checkInternetConnectivity() {
  //   Connectivity().onConnectivityChanged.listen((result) {
  //     if (result == ConnectivityResult.none) {
  //       isInternetConnected.value = false;
  //     } else {
  //       isInternetConnected.value = true;
  //     }
  //   });
  // }

  void login() {
    if (formKey.currentState!.validate()) {
      //    checkConnection(() async {
      runFullLoadingFunction(
          function: userRepository
              .login(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
        value.fold((l) {
          CustomToast.showMeassge(
              message: l, messageType: MessageType.REJECTED);
        }, (r) {
          storage.setLoggedIN(true);
          storage.setTokenInfo(r);
          Get.off(MainView(), transition: Transition.cupertino);
        });
      }));
      //   });
    }
  }

  void cupertinoTransition(Widget view) {
    Get.off(view, transition: Transition.cupertino);
  }

  Future<Void?> checkLocation() async {
    if (await locationService.isLocationEnabled() &&
        await locationService.isPermissionGranted()) {
      login();
    } else {
      Get.dialog(AlertDialog(
        title: Text('Location Permission'),
        content: Text('Please grant location permission to use this app.'),
        actions: [
          TextButton(
              child: Text('ok'),
              onPressed: () {
                locationService.getCurrentLocation();
              }),
          TextButton(
            child: Text('Exit'),
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      ));
    }
    ;
  }
}

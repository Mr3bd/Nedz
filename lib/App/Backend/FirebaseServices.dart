import 'dart:developer';

import 'package:get/get.dart';
import 'package:neds/App/Models/Main/UserModel.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';

class FirebaseServices {
  Future<bool> signUp(String name, String email, String password) async {
    bool result = false;

    print(password);
    print(email);
    print(name);
    final AuthenticationManager authManager = Get.find();
    await authManager.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      authManager.appUser!.value = value.user;

      UserModel userModel = UserModel(
          userID: authManager.appUser!.value!.uid, name: name, email: email);

      await authManager.firebaseFirestore
          .collection('Users')
          .doc(userModel.userID)
          .set(userModel.toJson())
          .then((value) {
        authManager.appUserData.value = UserModel.fromJson(userModel.toJson());
        result = true;
      }).catchError((value) {
        log(value);
      });
    }).catchError((e) {
      log(e);
    });

    return result;
  }

  Future<bool> signIn(String email, String password) async {
    final AuthenticationManager authManager = Get.find();
    bool result = false;
    await authManager.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      authManager.appUser!.value = value.user;
      await authManager.firebaseFirestore
          .collection('Users')
          .doc(authManager.appUser!.value!.uid)
          .get()
          .then((value) {
        authManager.appUserData.value = UserModel.fromJson(value.data()!);
        result = true;
      }).catchError((e) {
        return;
      }).catchError((e) {
        return;
      });
    }).catchError((e) {
      return;
    });

    return result;
  }

  Future<bool> resetPassword({required String email}) async {
    final AuthenticationManager authManager = Get.find();
    bool result = false;

    await authManager.firebaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) => result = true);

    return result;
  }
}

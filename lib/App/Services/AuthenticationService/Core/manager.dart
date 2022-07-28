import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neds/App/Backend/Api.dart';
import 'package:neds/App/Backend/FirebaseServices.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/UserModel.dart';
import 'package:neds/App/Services/AuthenticationService/Core/cache.dart';
import 'package:neds/App/Utilities/Methods/tools.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final Api api = Api();
  RxInt currentChildId = 0.obs;
  Rx<User?>? appUser;
  Rx<UserModel> appUserData = UserModel().obs;
  RxList<AutisticPatient> autisticPatients = <AutisticPatient>[].obs;
  final FirebaseServices firebaseServices = new FirebaseServices();
  final CommonTools commonTools = new CommonTools();
  final isLogged = false.obs;
  final GetStorage storage = GetStorage();

  Future<void> logOut() async {
    isLogged.value = false;
    // await storage.erase();
    //appUser!.value = AppUser();
    await firebaseAuth.signOut();
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  Future<void> checkLoginStatus() async {
    // logOut();
    appUser = firebaseAuth.currentUser.obs;
    if (appUser!.value != null) {
      isLogged.value = true;
      await firebaseFirestore
          .collection('Users')
          .doc(appUser!.value!.uid)
          .get()
          .then((value) {
        appUserData.value = UserModel.fromJson(value.data()!);
        getAutisticPatients();
      });
    }
  }

  void changeCurrentChild(int id) {
    currentChildId.value = id;
    storage.write('currentChildId${appUser!.value!.email}', id);
  }

  void getAutisticPatients() {
    var data = storage.read('localAutisticPatients');
    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    autisticPatients.value = temp.isEmpty
        ? []
        : temp
            .map<AutisticPatient>((jsonItem) {
              return AutisticPatient.fromJson(jsonItem);
            })
            .toList()
            .where((ap) => ap.careGiverId == appUser!.value!.uid)
            .toList();
    currentChildId.value =
        storage.read('currentChildId${appUser!.value!.email}') ?? 0;
  }

  AutisticPatient getCurrentChild() {
    return autisticPatients.where((ap) => ap.id == currentChildId.value).first;
  }
}

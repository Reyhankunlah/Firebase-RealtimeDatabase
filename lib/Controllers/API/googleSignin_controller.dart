import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GooglesigninController extends GetxController {
  final GoogleSignIn googleSigninService = GoogleSignIn();

  var photoProfile = ''.obs;
  var nameProfile = ''.obs;
  var emailProfile = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    photoProfile.value = prefs.getString('google_photo') ?? '';
    nameProfile.value = prefs.getString('google_name') ?? '';
    emailProfile.value = prefs.getString('google_email') ?? '';
    isLoggedIn.value =
        nameProfile.value.isNotEmpty && emailProfile.value.isNotEmpty;
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSigninService
          .signIn();
      if (googleUser == null) {
        Get.snackbar("Login", "Login dibatalkan");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 🔥 Masuk ke Firebase pakai credential Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // 🔹 Ambil data user dari Firebase
      final user = userCredential.user;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('google_token', googleAuth.idToken ?? '');
      await prefs.setString('google_name', user?.displayName ?? '');
      await prefs.setString('google_email', user?.email ?? '');
      await prefs.setString('google_photo', user?.photoURL ?? '');

      print("📸 photoURL: ${user?.photoURL}");

      nameProfile.value = user?.displayName ?? '';
      emailProfile.value = user?.email ?? '';
      photoProfile.value = user?.photoURL ?? '';
      isLoggedIn.value = true;

      Get.snackbar("Login", "Berhasil login sebagai ${user?.displayName}");
    } catch (e) {
      Get.snackbar("Error", "Gagal login: $e");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await googleSigninService.signOut();

    photoProfile.value = '';
    nameProfile.value = '';
    emailProfile.value = '';
    isLoggedIn.value = false;

    Get.snackbar("Logout", "Berhasil logout");
  }
}

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn;

  GoogleAuth({required GoogleSignIn googleSignIn})
      : _googleSignIn = googleSignIn;

  void signInWithGoogle() async {
    final user = await _googleSignIn.signInSilently();
    if (user != null) {}
  }
}

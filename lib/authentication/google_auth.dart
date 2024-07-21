import 'dart:convert';
import 'package:cloud_doc/constants/urls.dart';
import 'package:cloud_doc/models/response_model.dart';
import 'package:cloud_doc/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  GoogleAuth({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ResponseModel> signInWithGoogle() async {
    ResponseModel? responseModel;
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          name: user.displayName!,
          email: user.email,
          profilePicUrl: user.photoUrl!,
          uid: '',
          token: '',
        );

        var res = await _client.post(Uri.parse('$emulatorHost/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            );
            responseModel = ResponseModel(errorMsg: null, data: newUser);
            break;
        }
      }
    } catch (e) {
      responseModel = ResponseModel(errorMsg: e.toString(), data: null);
    }

    return responseModel!;
  }
}

import 'package:cloud_doc/authentication/google_auth.dart';
import 'package:cloud_doc/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authProvider = Provider(
  (ref) => GoogleAuth(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

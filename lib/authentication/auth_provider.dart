import 'package:cloud_doc/authentication/google_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authProvider = Provider(
  (ref) => GoogleAuth(
    googleSignIn: GoogleSignIn(),
  ),
);

import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn getGoogleService() {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  return _googleSignIn;
}

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    clientId:
        "587280846592-cskp3v2kc015g2smnpi3j38tsn0j5rf4.apps.googleusercontent.com",
  );

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

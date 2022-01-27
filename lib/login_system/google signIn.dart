import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GoogleSignInLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
//final   FirebaseUser _user;

  Future signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        test(userCredential);
        return userCredential.user;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
  test(UserCredential result){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User? user = result.user;

    users.doc(result.user!.uid).set({
      'name':result.user!.displayName,
      'email':result.user!.email,
      'image' : result.user!.photoURL,
      'phone' : result.user!.phoneNumber,
    });

  }
}

import 'dart:io' as dartio;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  String? url;
  Future uploadFile(String destination, dartio.File file) async {
    try {
      print("point 1");
      final ref = FirebaseStorage.instance.ref(destination);

      await ref.putFile(file);
      String url = await (ref.getDownloadURL());

      this.url = url;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  String? returnUrl() {
    print("the url was sent $url");

    return url;
  }
}

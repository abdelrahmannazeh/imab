import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageService{

  Future<void> uploadFile(File file, String path) async {

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(path)
          .putFile(file).then((value){
            print('Added');
      });

    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
    }
  }

  Future<String> downloadURL(String path) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(path)
        .getDownloadURL().then((value) => value);

    // Within your widgets:
    // Image.network(downloadURL);
  }
}
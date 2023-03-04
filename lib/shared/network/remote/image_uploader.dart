import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// Generate a random string of a specified length, including letters and digits
String randomStringWithNum(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    int charCode;
    if (rand.nextBool()) {
      charCode = rand.nextInt(26) + 97; // lowercase letter
    } else {
      charCode = rand.nextInt(10) + 48; // digit
    }
    return charCode;
  });

  return String.fromCharCodes(codeUnits);
}

// Generate a random string of a specified length, consisting of digits only
// String randomStringNumOnly(int length) {
//   var rand = Random();
//   var codeUnits = List.generate(length, (index) {
//     return rand.nextInt(10) + 48; // digit
//   });

//   return String.fromCharCodes(codeUnits);
// }

// Generate a random string of a specified length
// String randomStringOnly(int length) {
//   var rand = Random();
//   var codeUnits = List.generate(length, (index) {
//     return rand.nextInt(26) + 97;
//   });

//   return String.fromCharCodes(codeUnits);
// }

class ImageUploader {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference = _storage.ref().child(fileName);
    final UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.then((p0) {
      debugPrint('finish upload image');
    });
    final String url = await storageReference.getDownloadURL();
    return url;
  }

  Future<bool> storeProblem({
    String? url,
    required String titleDisc,
    required String problemDisc,
    required String locationDisc,
  }) async {
    try {
      String id = randomStringWithNum(8); // generate a random ID of length 10
      await FirebaseFirestore.instance.collection('problems').doc(id).set({
        'image_url': url,
        'title_disc': titleDisc,
        'problem_disc': problemDisc,
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': Timestamp.now(),
        'locationDisc': locationDisc,
        'report_id': id,
      });
      debugPrint('finish upload problem');
      return true;
    } catch (e) {
      return false;
    }
  }
}

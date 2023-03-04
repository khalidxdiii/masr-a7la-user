import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MAProblemModel {
  final String? id;
  final String? uID;
  final String? disc;
  final String? title;
  final String? prTime;
  final String? imageUrl;
  final String? locationDisc;

  MAProblemModel({
    this.id,
    this.uID,
    this.disc,
    this.prTime,
    this.imageUrl,
    this.title,
    this.locationDisc,
  });

  factory MAProblemModel.fromJSON(Map json) {
    final date = (json["timestamp"] as Timestamp).toDate();
    return MAProblemModel(
      uID: json["user_id"],
      disc: json["problem_disc"],
      prTime: DateFormat('yyyy-MM-dd - kk:mm').format(date),
      imageUrl: json["image_url"],
      title: json["title_disc"],
      locationDisc: json["locationDisc"],
    );
  }

  Map toJSON() {
    return {
      "id": id,
      "user_id": uID,
      "title_disc": disc,
      "timestamp": prTime,
      "image_url": imageUrl,
      "locationDisc": locationDisc,
    };
  }
}

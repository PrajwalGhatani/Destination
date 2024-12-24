import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/modals/hotelmodal.dart';
import 'package:destination/modals/placemodal.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecommendedService {
  /////////for place
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      final path = 'place_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<void> createPlace(PlaceModal place) async {
    try {
      await FirebaseFirestore.instance
          .collection('Recommendations')
          .add(place.toJson());
    } catch (e) {
      ('Error creating recommendation: $e');
    }
  }

  Future<void> updatePlace(placeId, PlaceModal place) async {
    try {
      await FirebaseFirestore.instance
          .collection('Recommendations')
          .doc(placeId)
          .update(place.toJson());
    } catch (e) {
      ('Error updating place: $e');
    }
  }

////////For Hotel
  Future<String?> uploadHotelImage(File imageFile) async {
    try {
      final path = 'hotel_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<void> createHotel(HotelModal hotel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Recommendations')
          .doc('hoteldata')
          .collection('Hotels')
          .add(hotel.toJson());
    } catch (e) {
      throw ('Error creating hotel: $e');
    }
  }

  // Future<void> updateHotel(hotelId, HotelModal hotel) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('Recommendations.Hotels')
  //         .doc(hotelId)
  //         .update(hotel.toJson());
  //   } catch (e) {
  //     ('Error updating place: $e');
  //   }
  // }
}

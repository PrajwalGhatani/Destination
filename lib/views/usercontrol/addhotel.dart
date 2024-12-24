import 'dart:io';

import 'package:destination/modals/hotelmodal.dart';
import 'package:destination/services/snackbar.dart';
import 'package:destination/services/uploadingservices.dart';
import 'package:destination/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddHotel extends StatefulWidget {
  const AddHotel({super.key});

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  final List<String> _selectedImages = [];
  void openCamera(ImageSource source) async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImages.add(image.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hotelName = TextEditingController();
  final TextEditingController _hotelEmail = TextEditingController();
  final TextEditingController _hotelNum = TextEditingController();
  void _addHotel() async {
    List<String>? imageUrls = [];
    for (final eachImage in _selectedImages) {
      final imageUrl =
          await RecommendedService().uploadImageToFirebase(File(eachImage));
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      }
    }

    final hotel = HotelModal(
      hotelName: _hotelName.text,
      hotelEmail: _hotelEmail.text,
      hotelImg: imageUrls,
      hotelNum: _hotelNum.text,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    await RecommendedService().createHotel(hotel).then((value) => {});

    ESnackBar.showSuccess(context, 'sucessfully added product');
    _hotelName.clear();
    _hotelEmail.clear();
    _hotelNum.clear();
    setState(() {
      _selectedImages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Place data',
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimary,
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Hotel Name',
                            style: TextStyle(
                                color: kSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a hotel name';
                              }
                              return null;
                            },
                            controller: _hotelName,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Hotel Name'))),
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Contact Number',
                            style: TextStyle(
                                color: kSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                        controller: _hotelNum,
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Contact Number'),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Email Address',
                          style: TextStyle(
                              color: kSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please write your email';
                              }
                              return null;
                            },
                            controller: _hotelEmail,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Email Address'))),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Add Hotel Images',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      openCamera(ImageSource.camera);
                                    },
                                    icon: const Icon(Icons.camera_alt,
                                        color: kSecondary, size: 25)),
                                IconButton(
                                    onPressed: () {
                                      openCamera(ImageSource.gallery);
                                    },
                                    icon: const Icon(Icons.photo,
                                        size: 25, color: kSecondary))
                              ])
                            ])),
                    _selectedImages.isNotEmpty
                        ? SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _selectedImages.length,
                                itemBuilder: (context, index) {
                                  final image = _selectedImages[index];
                                  return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Stack(children: [
                                        Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image:
                                                        FileImage(File(image)),
                                                    fit: BoxFit.cover))),
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                                color: kWhite,
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedImages
                                                        .removeAt(index);
                                                  });
                                                },
                                                icon: const Icon(Icons.clear)))
                                      ]));
                                }))
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: kSecondary),
                                ),
                                child: const Center(
                                  child: Text('Please Select Image'),
                                ))),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('${_selectedImages.length} selceted image'),
                    )
                  ]))),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _addHotel();
            }
          },
          label: const Text('Add Hotel'),
          icon: const Icon(Icons.place_sharp)),
    );
  }
}

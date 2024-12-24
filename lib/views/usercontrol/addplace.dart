// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:destination/modals/placemodal.dart';
import 'package:destination/services/snackbar.dart';
import 'package:destination/utils/colors.dart';
import 'package:destination/services/uploadingservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  String category = 'culture';
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
  final TextEditingController _placeName = TextEditingController();
  final TextEditingController _placeDescription = TextEditingController();
  void _addPlace() async {
    List<String>? imageUrls = [];
    for (final eachImage in _selectedImages) {
      final imageUrl =
          await RecommendedService().uploadImageToFirebase(File(eachImage));
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      }
    }
    final place = PlaceModal(
      category: category,
      placeName: _placeName.text,
      placeDescription: _placeDescription.text,
      images: imageUrls,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    await RecommendedService().createPlace(place).then((value) => {});

    ESnackBar.showError(context, 'Failed to add product');

    _placeName.clear();
    _placeDescription.clear();
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
                          child: Text('Place Name',
                              style: TextStyle(
                                  color: kSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a place name';
                                }
                                return null;
                              },
                              controller: _placeName,
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
                                  labelText: 'Place Name'))),
                      const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Add a category',
                              style: TextStyle(
                                  color: kSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              iconEnabledColor: kSecondary,
                              icon: const Icon(Icons.category),
                              value: category,
                              isExpanded: true,
                              hint: const Text('Select Category'),
                              items: const [
                                DropdownMenuItem(
                                  value: 'culture',
                                  child: Text("Culture"),
                                ),
                                DropdownMenuItem(
                                  value: 'mountains',
                                  child: Text("Mountains"),
                                ),
                                DropdownMenuItem(
                                    value: 'heritages',
                                    child: Text("Heritages")),
                                DropdownMenuItem(
                                    value: 'flora/fauna',
                                    child: Text("Flora/Fauna"))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  category = value!.toString();
                                });
                              })),
                      const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Location Description',
                            style: TextStyle(
                                color: kSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a location description';
                                }
                                return null;
                              },
                              controller: _placeDescription,
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
                                  hintText: 'Location Description'),
                              maxLines: 5)),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Add destination images',
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
                                                      image: FileImage(
                                                          File(image)),
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
                                                  icon:
                                                      const Icon(Icons.clear)))
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
                _addPlace();
              }
            },
            label: const Text('Add Place'),
            icon: const Icon(Icons.place_sharp)));
  }
}

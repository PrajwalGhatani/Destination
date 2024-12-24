import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/global_variables.dart';
import 'package:destination/utils/colors.dart';
import 'package:destination/views/usercontrol/addhotel.dart';
import 'package:destination/views/usercontrol/hoteldata.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<dynamic> images = [];
  @override
  Widget build(BuildContext context) {
    // late String userName = '';
    // void getUserData() async {
    //   if (userId != null) {
    //     final userData = await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(userId)
    //         .get();
    //     setState(() {
    //       email = userData['email'];
    //       // userName = '${userData['firstName']} ${userData['lastName']}';
    //     });
    //   }
    // }

    // getUserData();
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    userId = data['userId'];
    images = data['images'];

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Text(data['placeName'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        // autoPlayCurve: Curves.easeInCirc,
                      ),
                      items: images
                          .map(
                            (item) => Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          .toList()),
                  Positioned(
                    top: 150,
                    right: 20,
                    left: 20,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      height: 250,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: kSecondary)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'About:',
                                style: TextStyle(
                                    color: kSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                data['category'],
                                style: const TextStyle(
                                    color: kSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              height: 180,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(22)),
                              child: SingleChildScrollView(
                                child: ReadMoreText(
                                  data['placeDescription'],
                                  trimLines: 2,
                                  textAlign: TextAlign.justify,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: " Show More ",
                                  trimExpandedText: " Show Less ",
                                  lessStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  moreStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 2,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Near By Hotels",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color:
                              kSecondary, // Background color of the Container
                          shape: BoxShape.circle, // Shape of the Container
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "/AddHotel");
                            Get.to(const AddHotel());
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white, // Color of the icon
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Recommendations')
                            .doc('hoteldata')
                            .collection('Hotels')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error Loading data'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No Data Available'),
                            );
                          } else {
                            final data = snapshot.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/Detail',
                                        arguments: {
                                          'id': data[index].id,
                                          'hotelName': data[index]['placeName'],
                                          'hotelEmail': data[index]
                                              ['hotelEmail'],
                                          'hotelImg': data[index]['hotrlImg'],
                                          'hotelNum': data[index]['hotelNum'],
                                          'userId': data[index]['userId'],
                                        });
                                  },
                                  child: HotelData(
                                    hotelName: data[index]['hotelName'],
                                    hotelImg: data[index]['hotelImg'][0],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              ' Write Your Review ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

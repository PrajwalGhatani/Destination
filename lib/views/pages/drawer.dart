// ignore_for_file: use_build_context_synchronously
import 'package:destination/global_variables.dart';
import 'package:destination/services/log_reg_authentication.dart';

import 'package:destination/utils/colors.dart';
import 'package:destination/views/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTab extends StatefulWidget {
  const DrawerTab({super.key});

  @override
  State<DrawerTab> createState() => _DrawerTabState();
}

class _DrawerTabState extends State<DrawerTab> {
  void _logOut() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Authentication().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/Login', (route) => false);
                },
                child: const Text('Log Out'),
              )
            ],
          );
        },
      );
    } catch (e) {
      print('Error logging out: $e');
      // Handle error (e.g., display error message to user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 300,
        child: ListView(
          children: [
            SizedBox(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kSecondary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            profileUrl == null
                                ? 'images/DestiNation2.jpg'
                                : profileUrl!,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Wish You Luck!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "$firstName $lastName",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(77, 104, 58, 183),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          iconColor: kSecondary,
                          onTap: () {
                            Get.to(() => const Profile());
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: const Icon(Icons.place),
                          iconColor: kSecondary,
                          title: const Text('Added Places',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          onTap: () {
                            Get.toNamed('/MyPlaces');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: const Icon(Icons.home),
                          iconColor: kSecondary,
                          title: const Text('Added Hotels',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          onTap: () {
                            Get.toNamed('/MyHotels');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: const Icon(Icons.fastfood),
                          iconColor: kSecondary,
                          title: const Text('Added Dishes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          onTap: () {
                            Get.toNamed('/MyDishes');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: const Icon(Icons.emoji_events),
                          iconColor: kSecondary,
                          title: const Text('Added Activities',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          onTap: () {
                            Get.toNamed('/MyActivities');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout),
                      iconColor: Colors.red,
                      title: const Text('Log Out'),
                      onTap: () {
                        _logOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:destination/categories/intropages.dart';
import 'package:destination/views/usercontrol/addhotel.dart';
import 'package:destination/views/usercontrol/addplace.dart';
import 'package:destination/views/usercontrol/placedetail.dart';
import 'package:destination/views/usercontrol/myplaces.dart';
import 'package:destination/views/edit.dart/editprofile.dart';
import 'package:destination/views/edit.dart/editplace.dart';
import 'package:destination/views/edit.dart/editactivitydata.dart';
import 'package:destination/views/edit.dart/changepw.dart';
import 'package:destination/views/pages/login&register/loginpage.dart';
import 'package:destination/views/reminder.dart';
import 'package:destination/views/bookmarks.dart';
import 'package:destination/views/direction.dart';
import 'package:destination/views/home.dart';
import 'package:destination/views/pages/homepage.dart';
import 'package:destination/views/pages/login&register/registernow.dart';

import 'package:destination/views/pages/profile.dart';

import 'package:get/get.dart';

var routes = [
  GetPage(
    name: '/AddHotel',
    page: () => const AddHotel(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/EditProfile',
    page: () => const EditProfile(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/ActivityData',
    page: () => const ActivityData(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Profile',
    page: () => const Profile(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/AddPlace',
    page: () => const AddPlace(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/EditPlace',
    page: () => const EditPlace(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/ChangePassword',
    page: () => const ChangePassword(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/MyPlaces',
    page: () => const MyPlaces(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Login',
    page: () => const LoginPage(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Register',
    page: () => const RegisterNow(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Home',
    page: () => const Home(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Reminder',
    page: () => const Reminder(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Direction',
    page: () => const Direction(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/BookMarks',
    page: () => const BookMarks(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/HomePage',
    page: () => const HomePage(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/Detail',
    page: () => const Detail(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/IntroPages',
    page: () => const IntroPages(),
    transitionDuration: const Duration(milliseconds: 250),
    transition: Transition.cupertino,
  ),
  // GetPage(
  //   name: '/GridList',
  //   page: () => const CategoriesGridList(
  //     categoryItem: [],
  //   ),
  //   transitionDuration: const Duration(milliseconds: 250),
  //   transition: Transition.cupertino,
  // ),
];

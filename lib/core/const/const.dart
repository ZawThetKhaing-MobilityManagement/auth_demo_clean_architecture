import 'package:flutter/material.dart';

const String USER_CACHED = "USER_CACHED";
const String LOCATION_CACHED = "LOCATION_CACHED";
const String LEAVE_CACHED = "LEAVE_CACHED";
const String ATTENDENCE_CACHED = "ATTENDENCE_CACHED";

const String CHECK_IN = "check-in";
const String CHECK_OUT = "check-out";

const Color mainColor = Color.fromRGBO(220, 53, 69, 1);
const Color backGroundColor = Color.fromARGB(133, 239, 239, 239);

class Urls {
  static const String baseUrl = 'http://192.168.110.144:8000/api';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';
  static const String attendenceCheckIn = '$baseUrl/attendence';
  static const String regionList = '$baseUrl/region-list';
  static const String dealerList = '$baseUrl/dealer-list';
  static const String changePassword = '$baseUrl/user/passwordchange';
  static const String attendenceList = '$baseUrl/attendence-list';
  static const String leaveRequest = '$baseUrl/leave-request';
  static const String leaveRequestStatus = '$baseUrl/leave-request-status';
  static String attendenceCheckOut(int id) => '$baseUrl/attendence/$id';
}

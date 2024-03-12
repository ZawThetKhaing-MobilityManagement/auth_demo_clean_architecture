import 'package:flutter/material.dart';

const String USER_CACHED = "USER_CACHED";
const String LOCATION_CACHED = "LOCATION_CACHED";
const String LEAVE_CACHED = "LOCATION_CACHED";

const String CHECK_IN = "check-in";
const String CHECK_OUT = "check-out";

const Color mainColor = Color.fromRGBO(214, 58, 66, 1);
const Color backGroundColor = Color.fromARGB(133, 239, 239, 239);

class Urls {
  static const String baseUrl = 'http://192.168.110.144:8000/api';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';
  static const String attendence = '$baseUrl/attendence';
  static const String attendenceList = '$baseUrl/attendence-list';
  static const String leaveRequest = '$baseUrl/leave-request';
  static const String leaveRequestStatus = '$baseUrl/leave-request-status';
}

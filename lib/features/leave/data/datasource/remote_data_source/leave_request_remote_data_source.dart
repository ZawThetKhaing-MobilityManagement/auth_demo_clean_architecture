import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/leave/data/model/leave_model.dart';
import 'package:demo_login_ui/features/leave/domain/entities/leave_entity.dart';
import 'package:demo_login_ui/features/leave/domain/usecases/request_leave_usecase.dart';
import 'package:http/http.dart' as http;

abstract class LeaveRemoteDataSource {
  ResultFuture<void> requestLeave(LeaveParams params);
  ResultFuture<LeaveResponseEntity> getLeaveList(String token);
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  const LeaveRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  ResultFuture<LeaveResponseEntity> getLeaveList(String token) async {
    Uri uri = Uri.parse(Urls.leaveRequestStatus);
    try {
      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final LeaveResponseModel model =
            LeaveResponseModel.fromJson(jsonDecode(response.body));

        return Right(model);
      } else {
        return const Left(ServerFaliure(messages: 'no data'));
      }
    } catch (e) {
      return Left(ServerFaliure(messages: '$e'));
    }
  }

  @override
  ResultFuture<void> requestLeave(LeaveParams params) async {
    Uri uri = Uri.parse(Urls.leaveRequest);

    LeaveModel model = LeaveModel(
      reason: params.reason,
      startDate: params.startDate,
      endDate: params.endDate,
      permissionType: params.permissionType,
    );
    try {
      final response = await client.post(uri,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${params.token}',
          },
          body: model.toJson());

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFaliure(messages: 'Leave request failed!'));
      }
    } catch (e) {
      return const Left(ServerFaliure(
          messages: 'Something Wrong! Please check your internet connection.'));
    }
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/const/const.dart';
import 'package:demo_login_ui/core/error/exception.dart';
import 'package:demo_login_ui/core/error/failure.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/data/model/dealer_list_model.dart';
import 'package:demo_login_ui/features/attendence/data/model/region_list_model.dart';
import 'package:http/http.dart' as http;

abstract class RegionRemoteDataSource {
  ResultFuture<RegionListModel> getRegionList();
  ResultFuture<DealerListModel> getDealerList();
}

class RegionRemoteDataSourceImpl implements RegionRemoteDataSource {
  const RegionRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  ResultFuture<RegionListModel> getRegionList() async {
    final uri = Uri.parse(Urls.regionList);

    try {
      final response = await client.get(
        uri,
      );

      if (response.statusCode == 200) {
        return Right(RegionListModel.fromJson(jsonDecode(response.body)));
      } else {
        return const Left(ServerFaliure(messages: "Failed"));
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  ResultFuture<DealerListModel> getDealerList() async {
    final uri = Uri.parse(Urls.dealerList);

    try {
      final response = await client.get(
        uri,
      );

      if (response.statusCode == 200) {
        return Right(
          DealerListModel.fromJson(
            jsonDecode(response.body),
          ),
        );
      } else {
        return const Left(ServerFaliure(messages: "Failed"));
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

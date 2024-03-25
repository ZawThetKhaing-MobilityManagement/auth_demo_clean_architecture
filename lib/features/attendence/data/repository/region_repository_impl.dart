import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/data/datasource/remote_data_source/region_remote_data_source.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/dealer_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/region_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/region_repository.dart';

class RegionRepositoryImpl implements RegionRepository {
  const RegionRepositoryImpl({required this.regionRemoteDataSource});

  final RegionRemoteDataSource regionRemoteDataSource;

  @override
  ResultFuture<RegionListEntity> getAllRegion() =>
      regionRemoteDataSource.getRegionList();

  @override
  ResultFuture<DealerListEntity> getDealer() =>
      regionRemoteDataSource.getDealerList();
}

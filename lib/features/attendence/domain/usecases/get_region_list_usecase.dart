import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/region_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/region_repository.dart';

class GetRegionListUsecase implements UsecaseWithoutParams<RegionListEntity> {
  const GetRegionListUsecase({required this.regionRepository});

  final RegionRepository regionRepository;

  @override
  ResultFuture<RegionListEntity> call() => regionRepository.getAllRegion();
}

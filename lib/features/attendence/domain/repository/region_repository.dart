import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/dealer_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/region_entity.dart';

abstract class RegionRepository {
  ResultFuture<RegionListEntity> getAllRegion();
  ResultFuture<DealerListEntity> getDealer();
}

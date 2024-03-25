import 'package:demo_login_ui/core/usecase/usecase.dart';
import 'package:demo_login_ui/core/utils/typedef.dart';
import 'package:demo_login_ui/features/attendence/domain/entities/dealer_entity.dart';
import 'package:demo_login_ui/features/attendence/domain/repository/region_repository.dart';

class GetDealerListUsecase implements UsecaseWithoutParams<DealerListEntity> {
  const GetDealerListUsecase({required this.regionRepository});

  final RegionRepository regionRepository;

  @override
  ResultFuture<DealerListEntity> call() => regionRepository.getDealer();
}

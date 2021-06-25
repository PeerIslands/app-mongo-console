import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';
import 'package:flutter_auth/features/network_access/domain/use_cases/fetch_network_access_list.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_event.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkAccessBloc extends Bloc<NetworkAccessEvent, NetworkAccessState> {
  final FetchNetworkAccessList fetchNetworkAccessList;

  NetworkAccessBloc(this.fetchNetworkAccessList) : super(Empty());

  @override
  Stream<NetworkAccessState> mapEventToState(NetworkAccessEvent event) async* {
    if (event is GetNetworkAccessRequests) {
      yield NetworkAccessListLoading();

      Either<Failure, List<NetworkAccess>> failureOrNetworkAccessList =
          await fetchNetworkAccessList(NoParams());

      yield* _eitherSuccessOrErrorState(failureOrNetworkAccessList);
    }
  }

  Stream<NetworkAccessState> _eitherSuccessOrErrorState(
      Either<Failure, List<NetworkAccess>> failureOrNetworkAccessList) async* {
    yield failureOrNetworkAccessList.fold(
      (failure) =>
          NetworkAccessListFailed(message: (failure as ServerFailure).message),
      (networkAccessList) =>
          NetworkAccessListLoaded(networkAccessList: networkAccessList),
    );
  }
}

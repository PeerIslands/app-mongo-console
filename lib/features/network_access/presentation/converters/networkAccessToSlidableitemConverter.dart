import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';

class NetworkAccessToSlidableItemConverter {
  SlidableModal convert(NetworkAccess networkAccess) {
    if (networkAccess.isNotNull)
      return SlidableModal(networkAccess.id, networkAccess.comment, '');

    return null;
  }
}

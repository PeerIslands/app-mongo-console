enum MeasurementType {
  CONNECTIONS,
  NETWORK_BYTES_IN,
  NETWORK_BYTES_OUT,
  NETWORK_NUM_REQUESTS,
  OPCOUNTER_CMD,
  OPCOUNTER_QUERY,
  OPCOUNTER_UPDATE,
  OPCOUNTER_DELETE,
  OPCOUNTER_GETMORE,
  OPCOUNTER_INSERT,
  LOGICAL_SIZE
}

extension MeasurementTypeExtension on MeasurementType {
  String get description {
    switch (this) {
      case MeasurementType.CONNECTIONS:
        return 'Connections';
      case MeasurementType.NETWORK_BYTES_IN:
        return 'Bytes In';
        break;
      case MeasurementType.NETWORK_BYTES_OUT:
        return 'Bytes Out';
        break;
      case MeasurementType.NETWORK_NUM_REQUESTS:
        return 'Requests';
        break;
      case MeasurementType.OPCOUNTER_CMD:
        return 'Commands';
        break;
      case MeasurementType.OPCOUNTER_QUERY:
        return 'Queries';
        break;
      case MeasurementType.OPCOUNTER_UPDATE:
        return 'Updates';
        break;
      case MeasurementType.OPCOUNTER_DELETE:
        return 'Deletes';
        break;
      case MeasurementType.OPCOUNTER_GETMORE:
        return 'GetMore';
        break;
      case MeasurementType.OPCOUNTER_INSERT:
        return 'Insert';
        break;
      case MeasurementType.LOGICAL_SIZE:
        return 'Logical Size';
        break;
      default:
        return '';
    }
  }
}

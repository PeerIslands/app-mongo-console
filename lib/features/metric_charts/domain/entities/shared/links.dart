import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String href;
  final String rel;

  Links(this.href, this.rel);

  @override
  List<Object> get props => [href, rel];
}

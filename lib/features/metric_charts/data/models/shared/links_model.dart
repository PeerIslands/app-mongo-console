import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/shared/links.dart';

class LinksModel extends Links {
  LinksModel({@required href, @required rel}) : super(href, rel);

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      LinksModel(href: json['href'], rel: json['rel']);

  Map<String, dynamic> toJson() => {'href': href, 'rel': rel};
}

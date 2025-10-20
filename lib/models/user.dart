import 'package:json_annotation/json_annotation.dart';
import 'package:pmdm_ra02/models/address.dart';
import 'package:pmdm_ra02/models/company.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  @override
  String toString() {
    return toJson().toString();
  }
}
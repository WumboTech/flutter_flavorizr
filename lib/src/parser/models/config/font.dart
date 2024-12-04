import 'package:json_annotation/json_annotation.dart';

part 'font.g.dart';

@JsonSerializable(anyMap: true, createToJson: false)
class Font {
  @JsonKey(required: false, disallowNullValue: true)
  final String? regular;

  @JsonKey(required: false, disallowNullValue: true)
  final String? bold;

  Font({
    this.regular,
    this.bold,
  });

  String? get regularExt => regular?.split('.').last;
  String? get boldExt => bold?.split('.').last;

  factory Font.fromJson(Map<String, dynamic> json) => _$FontFromJson(json);
}

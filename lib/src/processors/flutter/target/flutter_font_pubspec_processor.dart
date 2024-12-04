import 'package:flutter_flavorizr/src/processors/commons/string_processor.dart';
import 'package:flutter_flavorizr/src/utils/constants.dart';

class FlutterFontPubspecProcessor extends StringProcessor {
  FlutterFontPubspecProcessor({
    super.input,
    required super.config,
  });

  @override
  String execute() {
    input ??= '';

    final font = config.app?.font;
    if (font != null) {
      for (var ext in K.fontExtensions) {
        if (font.regular?.isNotEmpty == true) {
          input!.replaceFirst(
              '${K.fontRegular}.$ext', '${K.fontRegular}.${font.regularExt}');
        }
        if (font.bold?.isNotEmpty == true) {
          input!.replaceFirst(
              '${K.fontBold}.$ext', '${K.fontBold}.${font.boldExt}');
        }
      }
    }
    return input!;
  }
}

/*
 * Copyright (c) 2024 Angelo Cassano
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

import 'package:flutter_flavorizr/src/parser/models/flavorizr.dart';
import 'package:flutter_flavorizr/src/processors/commons/copy_file_processor.dart';
import 'package:flutter_flavorizr/src/processors/commons/delete_file_processor.dart';
import 'package:flutter_flavorizr/src/processors/commons/existing_file_processor.dart';
import 'package:flutter_flavorizr/src/processors/commons/existing_file_string_processor.dart';
import 'package:flutter_flavorizr/src/processors/commons/queue_processor.dart';
import 'package:flutter_flavorizr/src/processors/flutter/target/flutter_font_pubspec_processor.dart';
import 'package:flutter_flavorizr/src/utils/constants.dart';

class FlutterFontsFileProcessor extends QueueProcessor {
  FlutterFontsFileProcessor(
    String destination, {
    required Flavorizr config,
  }) : super(
          [
            if (config.app?.font?.regular?.isNotEmpty == true)
              ...K.fontExtensions.map((ext) => ExistingFileProcessor(
                    '$destination/${K.fontRegular}.$ext',
                    DeleteFileProcessor(
                      '$destination/${K.fontRegular}.$ext',
                      config: config,
                    ),
                    config: config,
                  )),
            if (config.app?.font?.bold?.isNotEmpty == true)
              ...K.fontExtensions.map((ext) => ExistingFileProcessor(
                    '$destination/${K.fontBold}.$ext',
                    DeleteFileProcessor(
                      '$destination/${K.fontBold}.$ext',
                      config: config,
                    ),
                    config: config,
                  )),
            if (config.app?.font?.regular?.isNotEmpty == true)
              CopyFileProcessor(
                config.app!.font!.regular!,
                '$destination/${K.fontRegular}.${config.app!.font!.regularExt}',
                config: config,
              ),
            if (config.app?.font?.bold?.isNotEmpty == true)
              CopyFileProcessor(
                config.app!.font!.bold!,
                '$destination/${K.fontBold}.${config.app!.font!.boldExt}',
                config: config,
              ),
            ExistingFileStringProcessor(
              'pubspec.yaml',
              FlutterFontPubspecProcessor(config: config),
              config: config,
            ),
          ],
          config: config,
        );

  @override
  String toString() => 'FlutterFontsFileProcessor';
}

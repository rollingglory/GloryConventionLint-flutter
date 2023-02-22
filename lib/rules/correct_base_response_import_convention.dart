// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../../helper/string_extention.dart';
import '../helper/documentation_constants.dart';

class CorrectBaseResponseImportConvention extends DartLintRule {
  const CorrectBaseResponseImportConvention() : super(code: _incorrectImport);

  static const _incorrectImport = LintCode(
      name: 'correct_base_response_import_convention',
      problemMessage:
          '⚠️The BaseResponse and BaseListResponse must be imported from rollingglory_codebase',
      correctionMessage: 'Try to correct the source of your base responses.'
          '\n\n${DocumentationConstants.baseResponseImportConvention}',
      errorSeverity: ErrorSeverity.WARNING);

  static const _baseNotImplementedError = LintCode(
    name: 'correct_base_response_import',
    problemMessage:
        'This method should implement BaseResponse or BaseListResponse',
    correctionMessage: 'Add BaseResponse or BaseListResponse to your method'
        '\n\n${DocumentationConstants.baseResponseImportConvention}',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit(
      (node) {
        final declaredElement = node.declaredElement;
        if (declaredElement != null) {
          final path = declaredElement.source.uri.path;
          if (path.isPathServices()) {
            final classes = declaredElement.classes;
            for (final element in classes) {
              for (final field in element.methods) {
                if (!field.toString().isCorrectUsingBaseResponse()) {
                  reporter.reportErrorForOffset(
                    _baseNotImplementedError,
                    field.nameOffset,
                    field.nameLength,
                  );
                }
              }
            }
            final imports = node.directives;
            for (final import in imports) {
              if (import.toString().isCorrectFileBaseResponse()) {
                if (!path.isPathRGBCodeBase()) {
                  reporter.reportErrorForOffset(
                    code,
                    import.offset,
                    import.length,
                  );
                }
              }
            }
          }
        }
      },
    );
  }
}

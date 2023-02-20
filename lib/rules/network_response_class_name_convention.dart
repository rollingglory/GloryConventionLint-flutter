// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/lint/linter.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../../helper/string_extention.dart';
import '../helper/lint_type_constant.dart';

class NetworkResponseClassNameConvention extends DartLintRule {
  const NetworkResponseClassNameConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'network_response_class_name_convention',
      problemMessage:
          "⚠️The class name isn't a correct name for response class. Example : 'ExampleResponse'",
      correctionMessage: 'Try changing the name that ends with "Response".');

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
          final fileName = declaredElement.source.uri.path;
          final classess = declaredElement.classes;

          for (final classInstance in classess) {
            final offset = classInstance.nameOffset;
            final length = classInstance.nameLength;
            final name = classInstance.name;

            if (fileName.isPathResponse()) {
              if (!name.isCorrectClassResponseName()) {
                reporter.reportErrorForOffset(
                  _code,
                  offset,
                  length,
                  [fileName],
                );
              }
            }
          }
        }
      },
    );
  }
  @override
  List<Fix> getFixes() => [_RenameResponseClassName()];
}

class _RenameResponseClassName extends DartFix {
  @override
  void run(
      CustomLintResolver resolver,
      ChangeReporter reporter,
      CustomLintContext context,
      AnalysisError analysisError,
      List<AnalysisError> others,
      ) {
    context.registry.addCompilationUnit(
          (node) {
        final declaredElement = node.declaredElement;
        final classes = declaredElement?.classes;

        if (classes == null || classes.isEmpty) return;
        final className = classes.first.name;
        final correctName =
        className.renameClass(type: LintTypeConstant.responseLint);

        final offset = classes.first.nameOffset;
        final length = classes.first.nameLength;

        reporter.createChangeBuilder(
          message: 'Change to $correctName',
          priority: 1,
        )
        .addDartFileEdit(
              (builder) {
            builder.addSimpleReplacement(
              SourceRange(offset, length),
              correctName,
            );
          },
        );
      },
    );
  }
}

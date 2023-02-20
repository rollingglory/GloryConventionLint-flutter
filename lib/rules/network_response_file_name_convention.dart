// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../../helper/string_extention.dart';
import '../helper/lint_type_constant.dart';

class NetworkResponseFileNameConvention extends DartLintRule {
  NetworkResponseFileNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_response_file_name_convention',
    problemMessage:
        "⚠️The file name '{0}' isn't a correct name for response file.",
    correctionMessage: 'Try changing the name that ends with "_response".',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit(
      (node) {
        var declaredElement = node.declaredElement;
        if (declaredElement != null) {
          var path = declaredElement.source.uri.path;
          var classess = declaredElement.classes;

          for (var classInstance in classess) {
            var offset = classInstance.nameOffset;
            var length = classInstance.nameLength;

            if (path.isPathResponse()) {
              if (!path.isCorrectFileResponseName()) {
                reporter.reportErrorForOffset(_code, offset, length);
              }
            }
          }
        }
      },
    );
  }
  @override
  List<Fix> getFixes() => [_RenameResponseClass()];
}

class _RenameResponseClass extends DartFix {
  @override
  void run(
      CustomLintResolver resolver,
      ChangeReporter reporter,
      CustomLintContext context,
      AnalysisError analysisError,
      List<AnalysisError> others,
      ) {
    context.registry.addCompilationUnit((node) {
      var declaredElement = node.declaredElement;
      var classes = declaredElement?.classes;

      if (classes == null || classes.isEmpty) return;
      var className = classes.first.name;
      String correctName = className.renameClass(type: LintTypeConstant.responseLint);

      var offset = classes.first.nameOffset;
      var length = classes.first.nameLength;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Change to $correctName',
        priority: 1,
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset, length),
          correctName,
        );
      });
    });
  }
}

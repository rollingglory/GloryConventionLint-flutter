// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import '../../helper/string_extention.dart';

class PreferStaticConstLangVariable extends DartLintRule {
  const PreferStaticConstLangVariable() : super(code: _code);

  static const _code = LintCode(
      name: 'prefer_static_const_lang_variable',
      problemMessage: '⚠️It is better to use static const variables.',
      correctionMessage: 'Try add static const to the variable.');

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclarationList(
      (node) {
        final variables = node.variables;
        String sourceCode = node.toSource();
        if (sourceCode.isPathLang()) {
          for (final variable in variables) {
            if (!variable.isConst) {
              reporter.reportErrorForToken(_code, variable.name);
            }
          }
        }
      },
    );
  }
}

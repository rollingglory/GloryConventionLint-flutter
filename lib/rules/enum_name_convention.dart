import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../helper/documentation_constants.dart';
import '../helper/lint_type_constant.dart';
import '../helper/string_extention.dart';

class EnumNameConvention extends DartLintRule {
  const EnumNameConvention() : super(code: _code);

  static const _code = LintCode(
      name: 'enum_name_convention',
      problemMessage: '⚠️The enum name incorrect name for enum. '
          'Enum should only contains their name without prefixes. Example: GiftEnum. ',
      errorSeverity: ErrorSeverity.WARNING,
      correctionMessage: DocumentationConstants.enumNameConvention);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      final declaredElement = node.declaredElement;
      if (declaredElement != null) {
        final fileName = declaredElement.source.uri.path;
        final enums = declaredElement.enums;

        for (final enumInstance in enums) {
          final offset = enumInstance.nameOffset;
          final length = enumInstance.nameLength;
          final name = enumInstance.name;

          if (fileName.isPathEnum()) {
            if (!name.isCorrectClassEnumName()) {
              reporter.reportErrorForOffset(code, offset, length);
            }
          }
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_RenameEnumsClass()];
}

class _RenameEnumsClass extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addCompilationUnit((node) {
      final declaredElement = node.declaredElement;
      final enums = declaredElement?.enums;

      if (enums == null || enums.isEmpty) {
        return;
      }
      final className = enums.first.name;
      final correctName =
          className.renameClass(type: LintTypeConstant.enumLint);

      final offset = enums.first.nameOffset;
      final length = enums.first.nameLength;

      reporter
          .createChangeBuilder(
        message: 'Change to $correctName',
        priority: 1,
      )
          .addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(offset, length),
          correctName,
        );
      });
    });
  }
}

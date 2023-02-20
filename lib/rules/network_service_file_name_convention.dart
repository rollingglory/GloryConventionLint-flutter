import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:glory_convention_lint/helper/string_extention.dart';

import '../helper/documentation_constants.dart';

class NetworkServiceFileNameConvention extends DartLintRule {
  NetworkServiceFileNameConvention() : super(code: _code);

  static const _code = LintCode(
    name: 'network_service_file_name_convention',
    problemMessage:
        "⚠️The file name isn't a correct name for services file. file name should end with '_services'",
    correctionMessage: 'Try changing the file name that ends with "_services". Example: user_services.dart. \n\n${DocumentationConstants.serviceFileNameConvention}',
      errorSeverity: ErrorSeverity.WARNING

  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      var declaredElement = node.declaredElement;
      if (declaredElement != null) {
        var fileName = declaredElement.source.uri.path;
        var classes = declaredElement.classes;

        if (classes.isEmpty){
          if (fileName.isPathServices()) {
            if (!fileName.isCorrectFileServiceName()) {
              reporter.reportErrorForOffset(code, 0, 0);
            }
          }
          return;
        }

        var offset = classes.first.nameOffset;
        var length = classes.first.nameLength;
        if (fileName.isPathServices()) {
          if (!fileName.isCorrectFileServiceName()) {
            reporter.reportErrorForOffset(code, offset, length);
          }
        }
      }
    });
  }
}

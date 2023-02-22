//Always make sure to end with #
// ignore_for_file: prefer_single_quotes, unnecessary_brace_in_string_interps

const baseDocumentationUrl =
    'https://github.com/rollingglory/GloryConventionLint-flutter/blob/master/README.md#';

const viewDocumentation = 'View Documentation:\n';

class DocumentationConstants {
  static const modelClassNameConvention =
      "$viewDocumentation${baseDocumentationUrl}model-class-name-convention";
  static const modelFileNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}model-file-name-convention";
  static const modelAnnotationConvention =
      "${viewDocumentation}${baseDocumentationUrl}model-annotation-convention";
  static const preferNullableForModels =
      "${viewDocumentation}${baseDocumentationUrl}prefer-nullable-for-models";

  static const serviceClassNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}service-class-name-convention";
  static const serviceFileNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}service-file-name-convention";
  static const serviceAnnotationConvention =
      "${viewDocumentation}${baseDocumentationUrl}service-annotation-convention";

  static const enumNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}enum-class-name-convention";
  static const enumFileNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}enum-file-name-convention";

  static const requestClassNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}request-class-name-convention";
  static const requestFileNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}request-file-name-convention";

  static const responseClassNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}response-class-name-convention";
  static const responseFileNameConvention =
      "${viewDocumentation}${baseDocumentationUrl}response-file-name-convention";

  static const namingConvention = "${viewDocumentation}${baseDocumentationUrl}naming-convention";
  static const preferSingleClassPerFile =
      "${viewDocumentation}${baseDocumentationUrl}prefer-single-class-or-enum-or-top-level-declaration-per-file-convention";
  static const preferStaticConstLangVariable =
      "${viewDocumentation}${baseDocumentationUrl}prefer-static-const-lang-variable";
  static const baseResponseImportConvention =
      "${viewDocumentation}${baseDocumentationUrl}base-response-import-convention";
  static const preferOneVariableForLanguage =
      "${viewDocumentation}${baseDocumentationUrl}prefer-one-variable-for-language";
}

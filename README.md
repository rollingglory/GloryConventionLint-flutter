<img align="left" width="60" height="60" src="https://avatars1.githubusercontent.com/u/30823810?s=100&v=4"> </img>

**RollingGlory** is Company or Creative Digital Media studio based in Bandung, Indonesia.

&nbsp;
&nbsp;
# GloryConventionLint-Flutter
GloryConventionLint is code judgment for Convention Lint Flutter support IDE Android Studio/Visual Studio Code.
&nbsp;



## Setup
- add glory_convention_lint into `package.yaml`
~~~ bash
$ flutter pub add --dev glory_convention_lint
~~~

~~~yaml
dev_dependencies:
  glory_convention_lint: ^1.0.0
  custom_lint: ^0.2.5
~~~

- add plugin analyzer into `analysis_options.yaml`


~~~yaml
analyzer:
  plugins:
    - custom_lint
~~~


## Conventions

#### Model Convention
* [Model class name convention](#model-class-name-convention)
* [Model file name convention](#model-file-name-convention)
* [Model annotation convention](#model-annotation-convention)
* [Prefer nullable for models convention](#prefer-nullable-for-models-convention)

#### Service Convention
* [Service class name convention](#service-class-name-convention)
* [Service file name convention](#service-file-name-convention)
* [Service annotation convention](#service-annotation-convention)

#### Enum Convention
* [Enum name convention](#enum-name-convention)
* [Enum file name convention](#enum-file-name-convention)

#### Request Convention
* [Request class name convention](#request-class-name-convention)
* [Request file name convention](#request-file-name-convention)

#### Response Convention
* [Response class name convention](#response-class-name-convention)
* [Response file name convention](#response-file-name-convention)

#### Other Convention
* [Naming Convention](#naming-convention)
* [Prefer single class per file convention](#prefer-single-class-per-file-convention)    
* [Prefer static const lang variable convention](#prefer-static-const-lang-variable-convention)    
* [Base response import convention](#base-response-import-convention) 
* [One variable for lang convention](#prefer-one-variable-for-language-convention) 

&nbsp;
## Examples

#### Model Convention Example
* [Model class name convention example](#model-class-name-convention-example)
* [Model file name convention example](#model-file-name-convention-example)
* [Model annotation convention example](#model-annotation-convention-example)
* [Prefer nullable for models convention example](#prefer-nullable-for-models-convention-example)

#### Service Convention Example
* [Service class name convention example](#service-class-name-convention-example)
* [Service file name convention example](#service-file-name-convention-example)
* [Service annotation convention example](#service-annotation-convention-example)

#### Enum Convention Example
* [Enum name convention example](#enum-name-convention-example)
* [Enum file name convention example](#enum-file-name-convention-example)

&nbsp;
---
# Conventions
## Model Convention
### Model class name convention
Ensure to add Model word at the end of class name in models file
~~~dart
//DO
class ProductModel {}
//DON'T
class ProductModel {}
~~~
### Model file name convention
The file name for models must end with _model.dart
~~~dart
//DO
product_model.dart
//DON'T
product.dart
productmodel.dart
~~~
Model file must always be put inside of model directory.
~~~
|- data
  |- network
    |- models
~~~

### Model annotation convention
Add @JsonSerializable() from Retrofit to above your class model name
~~~dart
//DO
@JsonSerializable()
class ProductModel {
  int? id;
}
//DON'T
class ProductModel {
  int? id;
}
@JsonSerializable()
~~~
### Prefer nullable for models convention
Fields of Model class is preferable to have nullable field. example : String? instead of String
~~~dart
//DO
  class Product {
  String? name;
  Product({this.name});
}
//DON'T
  class Product {
  String name;
  Product({this.name});
}
~~~

## Service Convention
### Service class name convention
Ensure to add Services word at the end of class name in models file
~~~dart
//DO
  class GiftServices{}
  class ProductServices{}
//DON'T
  class Gift{}
  class ProductService{} // singular instead of plural
~~~
### Service file name convention
The file name for services must end with service.dart
~~~dart
//DO
  gift_services.dart
  product_services.dart
//DON'T
  product_service.dart //singular instead of plural
  ProductRequest.dart
~~~
Service file must always be put inside of services directory.
~~~
|- data
  |- network
    |- services
~~~

### Service annotation convention
Add @RestApi() from Retrofit to above your class service name
~~~dart
//DO
@RestApi() //RestApi Annotation is added
abstract class ProductServices {}
//DON'T
//Forget to add RestApi Annotation
abstract class ProductServices {}
~~~

## Enum Convention
#### Enum class name convention
Ensure to add Enum word at the end of enum class name in the file.
~~~dart
//DO
enum AvatarEnum {}
//DON'T
enum EnumAvatar {}
~~~

### Enum file name convention
Ensure to add _enum.dart prefix at the end of file name.
~~~dart
//DO
  gift_enum.dart
  product_enum.dart
//DON'T
  ProductEnum.dart
~~~
Enum file must always be put inside of enum directory or network enum directory.
~~~
//Network enum directory
|- data
  |- network
    |- enums

//Enum directory
|- data
  |- enums
~~~

## Request Convention
### Request class name convention
Request class always end with "Request", and must use *PascalCase*.
~~~dart
//DO
class GiftRequest{}
class ProductRequest{}

//DON'T
class Gift{}
class product_request{}
~~~

### Request file name convention
Request file must always end with "_request"  and should always use *snake_case* for file naming.
~~~
//DO
product_request.dart

//DON'T
ProductRequest.dart
~~~
Request file must always be put inside of request directory.
~~~
|- data
  |- network
    |- request
~~~
&nbsp;
## Response Convention
### Response class name convention
Response class always end with "Response", and must use *PascalCase*.
~~~dart
//DO
class GiftResponse{}
class ProductResponse{}

//DON'T
class Gift{}
class product_response{}
~~~

### Response file name convention
Response file must always end with "_response"  and should always use *snake_case* for file naming.
~~~
//DO
product_response.dart

//DON'T
ProductResponse.dart
~~~
Response file must always be put inside of response directory.
~~~
|- data
  |- network
    |- response
~~~

&nbsp; 
## Other Convention
### Naming Convention 
<table>
    <tbody>
        <tr>
           <td rowspan=2>&nbsp;</td>
        </tr>
         <tr>
           <td>PascalCase</td>
           <td>CamelCase</td>
            <td>Plural</td>
           <td>SnakeCase</td>
           <td>Examples</td>
        </tr>
        <tr>
           <td>Class</td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td></td>
            <td>class ModelResponse{}</td>
        </tr>
        <tr>
           <td>Service Class</td>
            <td>✅</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td>class ModelServices{}</td>
        </tr>
        <tr>
           <td>Constant Class</td>
            <td>✅</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td>class NetworkConstants{}</td>
        </tr>
        <tr>
           <td>Extension</td>
            <td>✅</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td>extension StringExtensions on String</td>
        </tr>
        <tr>
           <td>Field</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td>int id;</td>
        </tr>
        <tr>
           <td>Variable</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td>int variable;</td>
        </tr>
        <tr>
           <td>Local variable</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td>✅</td>
            <td>int _variable;</td>
        </tr>
        <tr>
           <td>Parameter</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td>String param</td>
        </tr>
        <tr>
           <td>Method</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td>void methodName(){}</td>
        </tr>
        <tr>
           <td>Local Method</td>
            <td></td>
            <td>✅</td>
            <td></td>
            <td>✅</td>
            <td>void _methodName(){}</td>
        </tr>
        <tr>
           <td>Enum Type</td>
            <td>✅</td>
            <td></td>
            <td></td>
            <td></td>
            <td>enum Status{}</td>
        </tr>  
    </tbody>
</table>

### Prefer single class per file convention
Avoid Declaring multiple classes in one file. It is best practice to declare one class in one file instead of multiple of class in one files, to reduce
confusion. 
~~~dart
//DO
-- test.dart --
class One = {};

//DON'T
-- test.dart --
class One = {};
class Two = {};
~~~

### Prefer static const lang variable convention
Declare variable as static const.
~~~dart
//DO
class One {
  static const variableOne = "Value"
}

//DON'T
class One {
  String variableOne = "Value";
}
~~~

### Base response import convention
Both BaseResponse and BaseListResponse must be implemented and imported from rollingglory_codebase
When an application communicates to the backend via API calls, we usually receive two type of responses. single object and multi objects.
both types need to be implemented in service file, the service file is actually an abstract class that contains 
a set of methods which is needed in order to get data from API.
~~~dart
//DO
class One {
  Future<BaseListResponse<Episode>> getEpisodes();
  Future<BaseResponse<Episode>> getEpisodeDetail();
}

//DON'T
class One {
  Future<Episode> myMethod();
}
~~~

### Prefer one variable for language convention
Ensure to separate the variable that represents a language, one class is supposed to have one variable.

~~~dart
//DO
-- languages/id_lang.dart --
Map<String,String> id = {};

-- languages/en_lang.dart --
Map<String,String> en = {};


//DON'T
-- languages.dart --
Map<String,String> id = {};
Map<String,String> en = {};
~~~

## Example

### Incorrect services rules
<img src="https://github.com/rollingglory/GloryConventionLint-flutter/blob/main/resource/incorrect_service_rule.png"> </img>


### Visual Studio Code problem reports 
<img src="https://github.com/rollingglory/GloryConventionLint-flutter/blob/main/resource/incorrect_service_rule_problems.png"> </img>

&nbsp;
### Other Information
You can follow us at <https://rollingglory.com/>

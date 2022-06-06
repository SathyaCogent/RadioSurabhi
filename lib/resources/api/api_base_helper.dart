import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'api_error_response.dart';
import 'app_exception.dart';
import 'dart:convert' as convert;

class FileObject {
  final String fieldName;
  final List fileNames;

  FileObject(this.fieldName, this.fileNames);
}

class ApiBaseHelper {
  static String fileBaseUrl = "https://api.radiosurabhi.com/";
  //"https://sfsuat.smartfarmspace.com/uatapi/";
  //"http://18.118.253.186:8000/devapi/";
  //"https://qa-api.smartfarmspace.com/uatapi";
// "http://3.138.118.34:8000/qaapi/";
  final String _baseUrl = fileBaseUrl;
  static ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  static Locale language = const Locale('en', 'IN');
  Future<String> getFile(String serverPath, String fileName) async {
    fileName = directory!.path + '/' + fileName;
    File file = File(fileName);
    try {
      final response = await http.get(Uri.parse(serverPath));
      file.writeAsBytes(response.bodyBytes);
    } catch (exception) {
      debugPrint(exception.toString());
      return serverPath;
    }
    return fileName;
  }

  Future<dynamic> get(String methodUri, [dynamic queryParam = '']) async {
    if (directory == null) _initLocalPath();
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    try {
      String requestUrl = _baseUrl + methodUri + queryParam;
      debugPrint(requestUrl);
      Map<String, String> headers = await _createHeaders();

      final response = await http.get(Uri.parse(requestUrl), headers: headers);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      responseJson = _returnResponse(response);
      debugPrint(responseJson);
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String methodUri, [dynamic queryParam = '']) async {
    if (directory == null) _initLocalPath();
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    try {
      String requestUrl = _baseUrl + methodUri + queryParam;
      debugPrint(requestUrl);
      Map<String, String> headers = await _createHeaders();

      final response =
          await http.delete(Uri.parse(requestUrl), headers: headers);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      responseJson = _returnResponse(response);
      debugPrint(responseJson);
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic request) async {
    if (directory == null) _initLocalPath();
    debugPrint(_baseUrl + url);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;

    var requestJson = jsonEncode(request);
    debugPrint(requestJson);
    try {
      Map<String, String> headers = await _createHeaders();
      debugPrint(headers.toString());
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: headers, body: requestJson);
      responseJson = _returnResponse(response);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = false;
    });
    return responseJson;
  }

  Future<dynamic> postMultipartForm(String url, Map<dynamic, dynamic> request,
      {FileObject? file}) async {
    String responseJson;
    var data = convert.jsonEncode((request));
    debugPrint(data);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);
      debugPrint(headers.toString());
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: {"data": convert.jsonEncode(request)},
        encoding: Encoding.getByName('utf-8'),
      );
      responseJson = _returnResponse(response);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patchMultipartForm(String url, Map<dynamic, dynamic> request,
      {FileObject? file}) async {
    String responseJson;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    var dataaa = convert.jsonEncode(request);
    debugPrint(dataaa);

    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);
      debugPrint(headers.toString());
      final response = await http.patch(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: {"data": convert.jsonEncode(request)},
        encoding: Encoding.getByName('utf-8'),
      );
      responseJson = _returnResponse(response);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postMultipartFormFile(
      String url, Map<dynamic, dynamic> request, FileObject? file) async {
    debugPrint(_baseUrl + url);

    debugPrint(jsonEncode(request));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    String responseJson;

    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);

      debugPrint(headers.toString());

      var uri = Uri.parse(_baseUrl + url);

      var multipartRequest = http.MultipartRequest("POST", uri);

      for (var headerKey in headers.keys) {
        multipartRequest.headers[headerKey] = headers[headerKey]!;
      }

      multipartRequest.fields["data"] = convert.jsonEncode(request);

      if (file != null) {
        for (var fileName in file.fileNames) {
          multipartRequest.files.add(http.MultipartFile.fromBytes(
              file.fieldName, await File(fileName).readAsBytes(),
              filename: fileName.split("/").last));

          debugPrint(fileName);
        }
      }

      http.StreamedResponse response = await multipartRequest.send();

      responseJson = await (_returnStreamedResponse(response));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> patchMultipartFormFileList(String url,
      Map<dynamic, dynamic> request, List<Map<String, String>> file) async {
    debugPrint(_baseUrl + url);

    debugPrint(jsonEncode(request));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    String responseJson;

    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);

      debugPrint(headers.toString());

      var uri = Uri.parse(_baseUrl + url);

      var multipartRequest = http.MultipartRequest("PATCH", uri);
      for (var headerKey in headers.keys) {
        multipartRequest.headers[headerKey] = headers[headerKey]!;
      }

      multipartRequest.fields["data"] = convert.jsonEncode(request);

      if (file.isNotEmpty) {
        for (var filedata in file) {
          multipartRequest.files.add(http.MultipartFile.fromBytes(
              filedata["fileName"]?.toLowerCase() ?? "",
              await File(filedata["filePath"] ?? "").readAsBytes(),
              filename: "${filedata["fileName"]?.toLowerCase()}.pdf"));
        }
      }
      http.StreamedResponse response = await multipartRequest.send();

      responseJson = await (_returnStreamedResponse(response));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> postMultipartFormFileList(String url,
      Map<dynamic, dynamic> request, List<Map<String, String>> file) async {
    debugPrint(_baseUrl + url);

    debugPrint(jsonEncode(request));
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    String responseJson;

    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);

      debugPrint(headers.toString());

      var uri = Uri.parse(_baseUrl + url);

      var multipartRequest = http.MultipartRequest("POST", uri);
      for (var headerKey in headers.keys) {
        multipartRequest.headers[headerKey] = headers[headerKey]!;
      }

      multipartRequest.fields["data"] = convert.jsonEncode(request);

      if (file.isNotEmpty) {
        for (var filedata in file) {
          multipartRequest.files.add(http.MultipartFile.fromBytes(
              filedata["fileName"]?.toLowerCase() ?? "",
              await File(filedata["filePath"] ?? "").readAsBytes(),
              filename: "${filedata["fileName"]?.toLowerCase()}.pdf"));
        }
      }
      http.StreamedResponse response = await multipartRequest.send();

      responseJson = await (_returnStreamedResponse(response));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> patchMultipartFormFile(
      String url, Map<dynamic, dynamic> request, FileObject? file) async {
    debugPrint(_baseUrl + url);
    debugPrint(jsonEncode(request));

    String responseJson;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });

    try {
      Map<String, String> headers = await _createHeaders(isMultipartForm: true);

      debugPrint(headers.toString());

      var uri = Uri.parse(_baseUrl + url);

      var multipartRequest = http.MultipartRequest("PATCH", uri);

      for (var headerKey in headers.keys) {
        multipartRequest.headers[headerKey] = headers[headerKey]!;
      }

      multipartRequest.fields["data"] = convert.jsonEncode(request);
      if (file != null) {
        for (var fileName in file.fileNames) {
          multipartRequest.files.add(http.MultipartFile.fromBytes(
              file.fieldName, await File(fileName).readAsBytes(),
              filename: fileName.split("/").last));
        }
      }
      debugPrint(multipartRequest.toString());
      http.StreamedResponse response = await multipartRequest.send();

      responseJson = await (_returnStreamedResponse(response));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> _returnStreamedResponse(
      http.StreamedResponse response) async {
    debugPrint(response.statusCode.toString());
    debugPrint(response.request!.url.toString());
    String responseData = await response.stream.bytesToString();
    switch (response.statusCode) {
      case 200:
        debugPrint('success ' + responseData);
        return responseData;
      case 400:
        debugPrint('400 error ' + responseData);
        return responseData;

      case 500:
        debugPrint('400/500 error ' + responseData);
        var responseJson = json.decode(responseData);
        var error = ApiErrorResponse.fromJson(responseJson);
        throw BadRequestException(error.errorMessage);

      case 401:
        debugPrint(
            DateTime.now().toIso8601String() + '401/403 error ' + responseData);
        throw UnauthorisedException(responseData);

      case 403:
        debugPrint(
            DateTime.now().toIso8601String() + '401/403 error ' + responseData);
        throw UnauthorisedException(responseData);

      default:
        debugPrint('default error ' +
            response.statusCode.toString() +
            ' ' +
            responseData);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> patch(String url, dynamic request) async {
    if (directory == null) _initLocalPath();
    debugPrint(_baseUrl + url);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loading.value = true;
    });
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;

    var requestJson = jsonEncode(request);
    debugPrint(requestJson);
    try {
      Map<String, String> headers = await _createHeaders();
      debugPrint(headers.toString());
      final response = await http.patch(Uri.parse(_baseUrl + url),
          headers: headers, body: requestJson);
      responseJson = _returnResponse(response);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
    } on SocketException {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loading.value = false;
      });
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, String>> _createHeaders(
      {bool isMultipartForm = false}) async {
    Map<String, String> headers = <String, String>{};
    // if (ArimaSecureStore.hasToken) {
    //   var xAuthToken =
    //       await ArimaSecureStore.getSecureStore(ArimaSecureStore.xAuthToken);
    // debugPrint(xAuthToken);
    headers['content-type'] = 'application/json';

    headers['accept'] = 'application/json, text/plain, */*, application/json';
    //headers['xAuthToken'] = xAuthToken;

    if (isMultipartForm) {
      headers['content-type'] = 'application/x-www-form-urlencoded';
    }
    //}

    return headers;
  }

  dynamic _returnResponse(var response) {
    debugPrint(response.statusCode.toString());
    switch (json.decode(response.statusCode.toString())) {
      case 200:
        debugPrint('success ' + response.body.toString());
        return response.body;
      case 400:
        debugPrint('400/500 error ' + response.body.toString());
        var responseJson = json.decode(response.body.toString());
        var error = ApiErrorResponse.fromJson(responseJson);
        throw BadRequestException(error.errorMessage);
      case 500:
        debugPrint('400/500 error ' + response.body.toString());
        var responseJson = json.decode(response.body.toString());
        var error = ApiErrorResponse.fromJson(responseJson);
        throw BadRequestException(error.errorMessage);

      case 401:
        debugPrint('401/403 error ' + response.body.toString());
        debugPrint(response.body);

        throw UnauthorisedException(response.body.toString());

      case 403:
        debugPrint('401/403 error ' + response.body.toString());
        throw UnauthorisedException(response.body.toString());

      default:
        debugPrint('default error ' +
            response.statusCode.toString() +
            ' ' +
            response.body.toString());
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  static Directory? directory;
  static Future _initLocalPath() async {
    directory ??= await getApplicationDocumentsDirectory();
    debugPrint(directory.toString());
  }
}

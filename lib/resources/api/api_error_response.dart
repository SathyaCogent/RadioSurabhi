class ApiErrorResponse {
  String? errorMessage = '';

  ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      if (json['error'] is Map<String, dynamic>) {
        Map<String, dynamic> errorMap = json['error'];
        for (var key in errorMap.keys) {
          errorMessage =
              errorMap[key].toString().replaceAll('[', '').replaceAll(']', '') +
                  " ";
        }
      } else if (json['error'] is String) {
        errorMessage = json['error'];
      }
    } else {
      if (json['status'] == "error") {
        errorMessage = json['msg'];
      }
    }

    if (errorMessage!.isEmpty) {
      errorMessage = "Unknown error";
    }
  }
}

class ErrorResponse{
  final List<ApiError> errors;
  final String message;

  ErrorResponse({required this.errors, required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json){
    List<ApiError> errors = [];

    // Handle different error response formats
    if(json["errors"] != null){
      var errorsList = json["errors"] as List;
      errors = errorsList.map((error) => ApiError.fromJson(error)).toList();
    }

    return ErrorResponse(
      errors: errors,
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "errors" : errors.map((error) => error.toJson()).toList(),
      "message" : message,
    };
  }
}

class ApiError{
  final String code;
  final String message;

  ApiError({required this.code, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json){
    return ApiError(code: json["code"] ?? json["error_code"] ?? "", message: json["message"]??json["error_message"]??json["detail"] ?? "");
  }

  Map<String, dynamic> toJson(){
    return {
      "code" : code,
      "message" : message,
    };
  }
}
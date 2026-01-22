class EndPonits {
  static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String signIn = "user/signin";
  static String signUp = "user/signup";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }

  static String updateUserEndPoint(String id) {
    return "user/update-user/$id";
  }

  static String deleteUserEndPoint(String id) {
    return "user/delete-user/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMassage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "Message";
  static String name = "name";
  static String phone = "phone";
  static String profilePic = "profilePic";
  static String location = "location";
  static String confirmPassword = "confirmPassword";
  static String id = "id";
}

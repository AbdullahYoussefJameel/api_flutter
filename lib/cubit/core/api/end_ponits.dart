/// Centralized API Endpoints
class EndPoints {
  static const String baseUrl = 'https://food-api-omega.vercel.app/api/v1';

  // ---------------- Auth ----------------
  static const String signIn = '/user/signin';
  static const String signUp = '/user/signup';

  // ---------------- User ----------------
  static String getUser(String id) => '/user/get-user/$id';
  static String updateUser(String id) => '/user/update-user/$id';
  static String deleteUser(String id) => '/user/delete-user/$id';
}

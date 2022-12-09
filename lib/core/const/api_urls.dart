class ApiUrls {
  static const String _baseUrl = "https://clean.codeella.com/public/api";

  static const String login = "$_baseUrl/auth/signIn/email";
  static const String register = "$_baseUrl/auth/register";
  static const String signOut = "$_baseUrl/signOut";

  static const String updateUser = "$_baseUrl/update_user";

  static const String newCompilation = "$_baseUrl/complaints";
  static const String compilationType = "$_baseUrl/complaint_type";
  static const String getCompilations = "$_baseUrl/complaints";

  static const String getComments = "$_baseUrl/comments/";
  static const String addComments = "$_baseUrl/comments";
}
// 
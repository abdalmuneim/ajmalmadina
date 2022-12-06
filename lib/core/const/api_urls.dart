class ApiUrls {
  static const String _baseUrl = "https://clean.codeella.com/public/api";

  static const String urlNewCompilation = "$_baseUrl/complaints";
  static const String urlCompilationType = "$_baseUrl/complaint_type";

  static const String urlLogin = "$_baseUrl/auth/signIn/email";
  static const String urlRegister = "$_baseUrl/auth/register";
  static const String getCompilations = "$_baseUrl/complaints";
  static const String urlSignOut = "$_baseUrl/signOut";
}

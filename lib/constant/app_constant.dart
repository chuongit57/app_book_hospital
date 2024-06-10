class AppConstant {
  static const String BASE_URL = "http://10.0.2.2:8080";
  static const String SIGN_IN_URL = BASE_URL + "/app_doctor/api/auth/login";
  static const String SIGN_UP_URL = BASE_URL + "/app_doctor/api/auth/register";
  static const String CHECK_AUTH_URL = BASE_URL + "/app_doctor/api/auth/check";

  static const String DEPARTMENT_GET_ALL = BASE_URL + "/app_doctor/api/department/all";
  static const String DEPARTMENT_SELECT = BASE_URL + "/app_doctor/api/department/select-department";

  static const String DOCTOR_LIST_DOCTOR_TOP = BASE_URL + "/app_doctor/api/doctor/top-5-doctor";

  static const String DOCTOR_APPOINTMENT_SIGN_UP = BASE_URL + "/app_doctor/api/doctor-appointment/sign-up";
  static const String DOCTOR_APPOINTMENT_DONE = BASE_URL + "/app_doctor/api/doctor-appointment/done";

  static const String USER_BOOK_BOOK = BASE_URL + "/app_doctor/api/user_book/book";
  static const String USER_BOOK_REMOVE_BOOK = BASE_URL + "/app_doctor/api/user_book/remove-book";

  static const String BLOODGROUP_GET_ALL = BASE_URL + "/app_doctor/api/bloodgroup/get-all-bloodgroup";
}
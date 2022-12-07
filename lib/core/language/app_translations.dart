import '../resources/app_strings.dart';
import '../error/failures.dart';
import 'ar_translation.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'ar': ar,
  };
}

abstract class LocaleKeys {
  static const networkFailure = 'networkFailure';
  static const incorrectEmailAddress = 'incorrectEmailAddress';
  static const incorrectNameAddress = 'incorrectNameAddress';
  static const emptyEmailAddress = 'emptyEmailAddress';
  static const emptyPassword = 'emptyPassword';
  static const morePasswordChars = 'morePasswordChars';
  static const validateError = 'validateError';
  static const confirmPassValidate = 'confirmPassValidate';
  static const noImage = 'noImage';
  static const imageNotLoaded = 'imageNotLoaded';
  static const locationError = 'locationError';

  static const compilations = 'compilations';
  static const noCompilations = 'noCompilations';
  static const addCompilations = 'addCompilations';
  static const addNewCompilations = 'addNewCompilations';
  static const compilationsType = 'compilationsType';
  static const chosesCompilationsType = 'chosesCompilationsType';
  static const tackPhoto = 'tackPhoto';
  static const validateDecLength = 'validateDecLength';
  static const hintDescription = 'hintDescription';
  static const userUpdate = 'userUpdate';
  static const enterDescription = 'enterDescription';
  static const validationName = 'validationName';
  static const aboutApp = 'aboutApp';
  static const logout = 'logout';
  static const createAccount = 'createAccount';
  static const create = 'create';
  static const login = 'login';
  static const loginToApp = 'loginToApp';
  static const password = 'password';
  static const confirmPasswordValidation = 'confirmPasswordValidation';
  static const confirmPassword = 'confirmPassword';
  static const confirmPasswordVal = 'confirmPasswordVal';
  static const confirmPasswordValidation2 = 'confirmPasswordValidation2';
  static const name = 'name';
  static const email = 'email';
  static const hintEmail = 'hintEmail';
  static const editAccount = 'editAccount';
  static const validateEmail = 'validateEmail';
  static const validateEmail2 = 'validateEmail2';
  static const userId = 'userId';
  static const comments = 'comments';
  static const addComment = 'addComment';
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return failure.message;
    case NetworkFailure:
      return AppStrings.NETWORK_FAILURE;

    default:
      return AppStrings.UNEXPECTED_ERROR;
  }
}

// ignore_for_file: non_constant_identifier_names

String Api_Survey = 'http://192.168.1.87:2222/'; //DEMO Server

String Api_Login = '${Api_Survey}auth'; // Login
String Api_GetSurveyPayment =
    '${Api_Survey}survey/satisfaction'; // GetsurveyPayment
String Api_GetSurveyPaymentZero =
    '${Api_Survey}survey/satisfaction/?status=0'; // GetsurveyPaymentZero
String Api_DeleteSurveyPayment =
    '${Api_Survey}survey/satisfaction/delete/'; // DeleteSurveyPayment
String Api_DeleteSurveyPaymentALL =
    '${Api_Survey}survey/satisfaction/clear/'; // DeleteSurveyPayment
String Api_PostCreateSurvey =
    '${Api_Survey}survey/satisfaction/create/'; // PostCreateSurvey
String Api_UpdateSurveyStatus =
    '${Api_Survey}survey/satisfaction/update/'; // PostCreateSurvey
class NetworkStrings {
  ////////////////////// API BASE URL //////////////////////////////////
  // static const String baseUrl = 'http://137.184.187.215:8080/yelody/';
  // static const String imageURL = 'http://137.184.187.215:8080/';
  static const String baseUrl = 'http://143.198.9.249:8081/yelody/';
  static const String imageURL = 'http://143.198.9.249:8081/';

  static const String uploadKarokey = 'http://143.198.9.249:5000/upload-karoke';

  static const String loginEndPoint = 'login';
  static const String loginGoogle = 'login/google?token=';
  static const String appleLogin = 'login/apple?accessToken=';
  static const String guestLoginEndPoint = 'user/loginUserGuest';
  static const String loginFacebook = 'login/facebook?token=';
  static const String getGenreList = 'genre/listGenre';
  static const String getAllKewyords = 'keyword/getKeywordList';
  static const String getAllAgeGroups = 'ageGroup/getAgeGroupList';
  static const String getGenreAgeCombined = 'miscellaneous/age_key_genre';
  static const String bannerEndpoint = 'banner/getBannerList';
  static const String getSongById = 'song/getSongById';
  static const String getChartById = 'chart/getChartById';
  static const String getChartSongsById = 'chart/getChartByIdWithSong';
  static const String getSongByPlaylistId = 'playlist/getPlaylistById';
  static const String getPlayListByUserId = 'playlist/getPlaylistByUserId';
  static const String getAllPlayLists = 'playlist/getAllPlaylists';
  static const String GetRecommandedSongByUserId = 'song/getRecommendedSongs';
  static const String getSingHistoryById = 'singHistory/getUserSingHistories';
  static const String chartEndpoint = 'chart/listCharts';
  static const String getBannersListEndpoint = 'banner/getBannerList';
  static const String getUserDetailByIDEndpoint =
      'userpreferences/listPreferencesByUserId?userId=';
  static const String getAllSongsEndpoint = 'song/listSongs';
  static const String addSongToQueEndpoint = 'queue/addSongToQueue?';
  static const String createPlaylist = 'playlist/postPlaylist';
  static const String postSongPlaylist = 'playlist/postSongsToPlaylist';
  static const String deletePlayListByID = 'playlist/deletePlaylistById?id=';
  static const String getQueList = 'queue/getSongQueue?userId=';
  static const String deleteSongFromPlayList =
      'playlist/deleteSongsFromPlaylist';

  static const String updateUSerEndpoint = 'user/postUser';
  static const String updateUserDetailsEndpoint = 'user/updateUser?id=';
  static const String updateUserPrefrences =
      'userpreferences/updatePreference?id=';
  static const String userPrefrencesUpdateEndpoint =
      'userpreferences/postUserPreference';
  static const String getSongByIDEndpoint = 'song/getSongById?id=';
  static const String getXmLBySongID = 'http://143.198.9.249:8081/';

  static const String registerEndpoint = 'register';
  static const String screenOneApi = 'api/users/2';

  static const String userListApi = 'https://reqres.in/api/users?page=2';

  static const String webViewURL =
      "http://137.184.187.215:5173/3a1d1c45-5f0c-4799-abe7-44ec9ba65ada";

  /////// API HEADER TEXT ////////////////////////
  static const String ACCEPT = 'application/json';
  // static const String BEARER_TOKEN = "Bearer Token";

  ////////////////////// API ENDPOINTS  ////////////////////////

  static const String CHAT_ERROR = "Chat not found.";

  ////// API STATUS CODE/////////////
  static const int SUCCESS_CODE = 200;
  static const int SUCCESS_CODE_CREATED = 201;
  static const int UNAUTHORIZED_CODE = 401;
  static const int CARD_ERROR_CODE = 402;
  static const int NOT_FOUND_CODE = 404;
  static const int BAD_REQUEST_CODE = 400;
  static const int FORBIDDEN_CODE = 403;

  /////////// API MESSAGES /////////////////
  static const bool API_SUCCESS_STATUS = true;
  static const String EMAIL_UNVERIFIED = "0";
  static const String EMAIL_VERIFIED = "1";
  static const String PROFILE_INCOMPLETED = "0";
  static const String PROFILE_COMPLETED = "1";

  static const String ADMIN_APROVED = "1";
  static const String ADMIN_NOTAPROVED = "0";
  static const int USER_SUBSCRIBED = 1;
  static const int USER_NOTSUBSCRIBED = 0;

  /////////// API TOAST MESSAGES //////////////////
  static const String NO_INTERNET_CONNECTION = "No Internet Connection!";
  static const String SOMETHING_WENT_WRONG = "Something Went Wrong";
  static const String STATUS_NOT_FOUND = "No Status Found";
  static const String INVALID_CARD_ERROR = "Invalid Card Details.";
  static const String CARD_TYPE_ERROR = "Wrong card type.";
  static const String INVALID_BANK_ACCOUNT_DETAILS_ERROR =
      "Invalid Bank Account Details.";
  static const String MERCHANT_ACCOUNT_ERROR =
      "Error:Merchant Account can not be created.";

//---------------- API SHOW ERROR MESSAGE -------------------//

  static const String NOTIFICATION_EMPTY_ERROR = "Notification not found";
  static const String CONTENT_EMPTY_ERROR = "Content not found";
  static const String CHAT_EMPTY_ERROR = "Chat not found";
  static const String STATUS_EMPTY_ERROR = "Stories not found";
  static const String MY_STATUS_EMPTY_ERROR = "My Stories not found";
  static const String MEDIA_EMPTY_ERROR = "Media not found";
  static const String CONNECTION_REQUEST_EMPTY_ERROR =
      "Connection Request not found";
  static const String PARTNER_EMPTY_ERROR = "Partners not found";
  static const String PENDING_PARTNER_EMPTY_ERROR =
      "Pending partners not found";
  static const String REQUEST_EMPTY_ERROR = "Requests not found";
}

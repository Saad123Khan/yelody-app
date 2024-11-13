import 'package:get/get.dart';
import 'package:yelody_app/models/songs/getsongbyid_model.dart';

class MusicPlayDetailsController extends GetxController {
  // Rxn<GetSongByIdModel> musicDetails = Rxn(null);
  String lyricsText = "";

  updateLyrics(String lyrics) {
    lyricsText = lyrics;
    update();
  }

  @override
  void onReady() {
    super.onInit();
  }
}

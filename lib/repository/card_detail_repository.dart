import 'package:trilhaapp/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    await Future.delayed(const Duration(seconds: 3));
    return CardDetail(
      1,
      "Lorem Ipsum",
      "Maecenas mollis pulvinar finibus. Suspendisse potenti. Donec ullamcorper scelerisque libero elementum cursus. Aenean nec facilisis orci. Curabitur a facilisis felis. Suspendisse euismod tellus vel lorem consectetur, sed tincidunt arcu tempor. Duis erat velit, mollis sed mollis ut, semper ut massa. Praesent id malesuada massa. Proin feugiat sollicitudin lectus dignissim venenatis. Cras at quam ac nisi sodales pulvinar sodales congue libero. Etiam gravida, ipsum.",
      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
    );
  }
}

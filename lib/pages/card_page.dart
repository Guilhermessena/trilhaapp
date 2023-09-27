import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var cardDetail = CardDetail(
    1,
    "Lorem Ipsum",
    "Maecenas mollis pulvinar finibus. Suspendisse potenti. Donec ullamcorper scelerisque libero elementum cursus. Aenean nec facilisis orci. Curabitur a facilisis felis. Suspendisse euismod tellus vel lorem consectetur, sed tincidunt arcu tempor. Duis erat velit, mollis sed mollis ut, semper ut massa. Praesent id malesuada massa. Proin feugiat sollicitudin lectus dignissim venenatis. Cras at quam ac nisi sodales pulvinar sodales congue libero. Etiam gravida, ipsum.",
    "https://hermes.digitalinnovation.one/assets/diome/logo.png",
  );
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          width: double.infinity,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CardDetailPage(cardDetail: cardDetail),
                  ));
            },
            child: Hero(
              tag: cardDetail.id,
              child: Card(
                shadowColor: Colors.grey,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.network(
                            cardDetail.url,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            cardDetail.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cardDetail.text,
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Ler mais",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

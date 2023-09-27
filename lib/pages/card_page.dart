import 'package:flutter/material.dart';
import 'package:trilhaapp/model/card_detail.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';
import 'package:trilhaapp/repository/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;
  var cardDetailRepository = CardDetailRepository();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    cardDetail = await cardDetailRepository.get();
    setState(() {});
  }

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
          child: cardDetail == null
              ? const LinearProgressIndicator()
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CardDetailPage(cardDetail: cardDetail!),
                        ));
                  },
                  child: Hero(
                    tag: cardDetail!.id,
                    child: Card(
                      shadowColor: Colors.grey,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  cardDetail!.url,
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cardDetail!.title,
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
                              cardDetail!.text,
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

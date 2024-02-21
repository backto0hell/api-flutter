import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _CryptoPricesScreenState createState() => _CryptoPricesScreenState();
}

class _CryptoPricesScreenState extends State<HomePage> {
  Map<String, dynamic> cryptoData = {};

  Future<void> fetchCryptoPrices() async {
    final response = await http.get(Uri.parse(
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB&tsyms=USD'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        cryptoData = data;
      });
    } else {
      throw Exception('Ошибка при загрузке цен');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCryptoPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Networking',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.black12,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cryptoData.length,
                itemBuilder: (context, index) {
                  final crypto = cryptoData.keys.elementAt(index);
                  final price = cryptoData[crypto]['USD'];
                  return ListTile(
                    title: Text(
                      crypto,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 170, 121),
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 250, 173, 72)
                            .withOpacity(0.4), // Оранжевая тень
                        spreadRadius: 5,
                        blurRadius: 25,
                        offset: const Offset(
                            0, 0), // Измените смещение, чтобы поднять тень
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      fetchCryptoPrices(); // Обновление данных при нажатии кнопки
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      child: const Text(
                        'Обновить',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

import 'package:currency/core/constants/font.dart';
import 'package:currency/core/constants/margin_padding.dart';
import 'package:currency/core/constants/path.dart';
import 'package:currency/service/currency_service.dart';
import 'package:flutter/material.dart';

class ConvertionPage extends StatefulWidget {
  int index;
  ConvertionPage({Key? key, required this.index}) : super(key: key);

  @override
  _ConvertionPageState createState() => _ConvertionPageState();
}

class _ConvertionPageState extends State<ConvertionPage> {
  TextEditingController _controllerValuta = TextEditingController();
  TextEditingController _controllerUzbValuta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: '2',
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: CurrencyService.getCurruncy(),
                  builder: (context, snap) {
                    var data = snap.data;
                    if (!snap.hasData) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (snap.hasError) {
                      return const Center(
                        child: Text("INTERNET BILAN MUAMMO BOR"),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: MyPaddingMargin.kExtraSmall,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _controllerValuta,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: (data as List)[widget.index]
                                    .title
                                    .toString(),
                              ),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _controllerUzbValuta =
                                        TextEditingController(
                                      text: (double.parse(
                                                  _controllerValuta.text) *
                                              double.parse(
                                                  data[widget.index].cbPrice))
                                          .toString(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: MyPaddingMargin.kExtraSmall,
                            child: TextFormField(
                              controller: _controllerUzbValuta,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "O'zbek so'mi",
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              MyPath.path[widget.index]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  size: MyFont.kLargeFont,
                                ),
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/uzb.jpeg'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

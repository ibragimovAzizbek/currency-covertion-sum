import 'package:currency/core/constants/color.dart';
import 'package:currency/core/constants/path.dart';
import 'package:currency/models/currency_model.dart';
import 'package:currency/service/currency_service.dart';
import 'package:flutter/material.dart';

class ConvertionPage extends StatefulWidget {
  int index;
  ConvertionPage({Key? key, required this.index}) : super(key: key);

  @override
  _ConvertionPageState createState() => _ConvertionPageState();
}

class _ConvertionPageState extends State<ConvertionPage> {
  TextEditingController _controllerValuta = TextEditingController(text: '1');
  late String dropdownValue;
  String dropdownValue2 = "AED";

  double? results;
  double? defoultRes;

  int nameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.tealColor,
      body: Hero(
        tag: '2',
        child: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: CurrencyService.getCurruncy(),
              builder: (context, AsyncSnapshot<List<CurrencyModel>> snap) {
                if (!snap.hasData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (snap.hasError) {
                  return const Center(child: Text("NO INTENET"));
                } else {
                  var data = snap.data;
                  dropdownValue = data![widget.index].code.toString();
                  return Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Center(
                        child: Text(
                          "Last Update: " + data[widget.index].date.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          // ? Background Color kerak
                          controller: _controllerValuta,
                          decoration: InputDecoration(
                            prefixIcon: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.03),
                              height: MediaQuery.of(context).size.height * 0.01,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: ColorConst.kWhite,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundImage: AssetImage(
                                        MyPath.path[widget.index].toString()),
                                  ),
                                  Text(
                                    data[widget.index].code.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.subdirectory_arrow_left_sharp,
                                color: ColorConst.kWhite,
                              ),
                              onPressed: () {
                                // TODO: Valuta Ayirboshlash
                                setState(() {
                                  hisoblash(data);
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dropdown1(data, context),
                          dropdown2(data, context),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        (results != null
                                ? results!.toStringAsFixed(2)
                                : defoultValuta(data)) +
                            " " +
                            data[nameIndex].code.toString(),
                        style: TextStyle(
                            color: ColorConst.kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  hisoblash(List<CurrencyModel> data) {
    for (int i = 0; i < data.length; i++) {
      if (dropdownValue2 == data[i].code) {
        results = double.parse(_controllerValuta.text) *
            double.parse(data[widget.index].cbPrice.toString()) /
            double.parse(data[i].cbPrice.toString());

        nameIndex = i;
      }
    }
  }

  defoultValuta(List<CurrencyModel> data) {
    for (int i = 0; i < data.length; i++) {
      if (dropdownValue2 == data[i].code) {
        defoultRes = double.parse('1') *
            double.parse(data[widget.index].cbPrice.toString()) /
            double.parse(data[i].cbPrice.toString());
        break;
      }
    }
    return defoultRes!.toStringAsFixed(2);
  }

  Container dropdown1(List<CurrencyModel> data, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.058,
      width: MediaQuery.of(context).size.width * 0.24,
      decoration: BoxDecoration(
          color: ColorConst.kWhite, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Wrap(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage(
                  MyPath.path[widget.index],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Text(
                data[widget.index].code.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Icon(Icons.download_done_outlined)
        ],
      ),
    );
  }

  Container dropdown2(List<CurrencyModel> data, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConst.kWhite, borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        alignment: Alignment.center,
        enableFeedback: false,
        value: dropdownValue2,
        items: List.generate(
          data.length,
          (index) {
            return DropdownMenuItem(
              value: data[index].code.toString(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                      MyPath.path[index],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Text(
                    data[index].code.toString(),
                  ),
                ],
              ),
            );
          },
        ),
        onChanged: (v) {
          dropdownValue2 = v.toString();
          setState(() {});
        },
      ),
    );
  }
}

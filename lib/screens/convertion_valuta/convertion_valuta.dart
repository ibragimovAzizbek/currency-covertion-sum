import 'package:currency/core/constants/color.dart';
import 'package:currency/core/constants/path.dart';
import 'package:currency/models/currency_model.dart';
import 'package:currency/service/currency_service.dart';
import 'package:flutter/material.dart';

class ConvertionVluta extends StatefulWidget {
  const ConvertionVluta({Key? key}) : super(key: key);

  @override
  State<ConvertionVluta> createState() => _ConvertionVlutaState();
}

class _ConvertionVlutaState extends State<ConvertionVluta> {
  String dropdownValue = "AED";
  String dropdownValue2 = "USD";

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: CurrencyService.getCurruncy(),
            builder: (context, AsyncSnapshot<List<CurrencyModel>> snap) {
              if (!snap.hasData) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snap.hasError) {
                return const Center(child: Text("ERROR"));
              } else {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dropDownButton(snap),
                        dropDownButton2(snap),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _controller1,
                            decoration: InputDecoration(
                              hintText: "Enter the amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.13),
                          child: const CircleAvatar(
                            child: Icon(Icons.compare_arrows_outlined),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _controller2,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  DropdownButton<String> dropDownButton(
      AsyncSnapshot<List<CurrencyModel>> snap) {
    return DropdownButton(
      alignment: Alignment.center,
      enableFeedback: false,
      value: dropdownValue,
      items: List.generate(
        snap.data!.length,
        (index) {
          return DropdownMenuItem(
            value: snap.data![index].code.toString(),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(
                    MyPath.path[index],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Text(
                  snap.data![index].code.toString(),
                ),
              ],
            ),
          );
        },
      ),
      onChanged: (v) {
        dropdownValue = v.toString();
        setState(() {});
      },
    );
  }

  DropdownButton<String> dropDownButton2(
      AsyncSnapshot<List<CurrencyModel>> snap) {
    return DropdownButton(
      alignment: Alignment.center,
      enableFeedback: false,
      value: dropdownValue2,
      items: List.generate(
        snap.data!.length,
        (index) {
          return DropdownMenuItem(
            value: snap.data![index].code.toString(),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(
                    MyPath.path[index],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Text(
                  snap.data![index].code.toString(),
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
    );
  }
}

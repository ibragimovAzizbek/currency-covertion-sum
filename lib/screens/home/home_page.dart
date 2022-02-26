import 'package:currency/core/components/size_config.dart';
import 'package:currency/core/constants/color.dart';
import 'package:currency/core/constants/font.dart';
import 'package:currency/core/constants/myStyle.dart';
import 'package:currency/core/constants/path.dart';
import 'package:currency/service/currency_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sum = 0;
  bool _isBalance = true;
  bool disabellSell = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorConst.kPrimaryColor,
      body: Hero(
        tag: '2',
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: getH(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          child: Text(
                            "Total Balance",
                            style: MyTextStyle.totalBalance(context),
                          ),
                          onPressed: () {},
                        ),
                        Icon(
                          Icons.file_download_done_rounded,
                          color: ColorConst.kPrimaryTextColor,
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.27),
                    Stack(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: ColorConst.kPrimaryTextColor,
                        ),
                        Positioned(
                          top: 2,
                          right: 0,
                          child: CircleAvatar(
                            radius: MyRadius.kExtraSmallRadiuesAvatar,
                            backgroundColor: ColorConst.kAvatarcha,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: getW(150), top: getH(13)),
                  child:
                      Text("\$2,450.00", style: MyTextStyle.sumBalance(context)),
                ),
                SizedBox(height: getH(59)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        height: getH(65),
                        width: getH(150),
                        decoration: BoxDecoration(
                            color: disabellSell == true
                                ? ColorConst.kWhite
                                : ColorConst.kDisabledButton,
                            borderRadius:
                                BorderRadius.circular(MyRadius.kSmallRadiues)),
                        child: Center(
                          child: Text(
                            "BUY",
                            style: MyTextStyle.buySellButton(context),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (disabellSell == false) {
                          disabellSell = true;
                        }
                        setState(() {});
                      },
                    ),
                    InkWell(
                      radius: 12,
                      child: Container(
                        height: getH(65),
                        width: getH(150),
                        decoration: BoxDecoration(
                            color: disabellSell == false
                                ? Colors.white
                                : ColorConst.kDisabledButton,
                            borderRadius:
                                BorderRadius.circular(MyRadius.kSmallRadiues)),
                        child: Center(
                          child: Text(
                            "SELL",
                            style: MyTextStyle.buySellButton(context),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (disabellSell == true) {
                          disabellSell = false;
                        }
          
                        setState(() {});
                      },
                    ),
                  ],
                ),
                FutureBuilder(
                    future: CurrencyService.getCurruncy(),
                    builder: (context, AsyncSnapshot snap) {
                      if (!snap.hasData) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (snap.hasError) {
                        return const Center(
                          child: Text("INTERNET BILAN MUAMMO BOR"),
                        );
                      } else {
                        List data = snap.data;
                        return Container(
                          margin: EdgeInsets.only(top: getH(54.7)),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getW(20), top: getH(15)),
                                child: Text(
                                  "My partfolios",
                                  style: MyTextStyle.textStyle(context),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.52,
                                child: ListView.builder(
                                  itemCount: 24,
                                  itemBuilder: (_, __) => ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage(MyPath.path[__]),
                                    ),
                                    title: Text(data[__].title.toString(),
                                        style: MyTextStyle.monyNameTextStyle(
                                            context)),
                                    subtitle: Text(
                                      data[__].cbPrice.toString() + ' so\'m',
                                      style: MyTextStyle.priceTextStyle(context),
                                    ),
                                    trailing: Text("so'mda",
                                        style: MyTextStyle.somTextStyle(context)),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/convertion',
                                          arguments: __);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

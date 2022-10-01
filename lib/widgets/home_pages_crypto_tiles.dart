import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/widgets/crypto_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageCryptoTiles extends StatelessWidget {
  const HomePageCryptoTiles({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CryptoTile(
          spotlist: Provider.of<ModelProvider>(context).GetBTCChartlist,
          currency: 'BTC',
          icon: CryptoFontIcons.BTC,
          iconColor: Color(0xFFea973d),
          price: Provider.of<ModelProvider>(context).BTCPrice.toString(),
          beginChartColor: Colors.orangeAccent.withOpacity(0.9),
          endChartColor: Colors.orange.withOpacity(0.1),
          beginBleowChartColor: Color(0xFFea973d).withOpacity(0.8),
          endBleowChartColor: Colors.orangeAccent.withOpacity(0),
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        CryptoTile(
          spotlist: Provider.of<ModelProvider>(context).GetETHChartlist,
          currency: 'ETH',
          icon: CryptoFontIcons.ETH,
          iconColor: Colors.blueAccent.shade400,
          price: Provider.of<ModelProvider>(context).ETHPrice.toString(),
          beginChartColor: Colors.blueAccent.withOpacity(0.9),
          endChartColor: Colors.lightBlue.withOpacity(0.1),
          beginBleowChartColor:
              Color.fromARGB(255, 50, 113, 162).withOpacity(0.8),
          endBleowChartColor: Colors.blueAccent.withOpacity(0),
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        CryptoTile(
          spotlist: Provider.of<ModelProvider>(context).GetUSDTChartlist,
          currency: 'USDT',
          icon: CryptoFontIcons.USDT,
          iconColor: Colors.greenAccent.shade400,
          price: Provider.of<ModelProvider>(context).USDTPrice.toString(),
          beginChartColor: Colors.greenAccent.withOpacity(0.9),
          endChartColor: Color.fromARGB(255, 2, 66, 35).withOpacity(0.1),
          beginBleowChartColor: Color.fromARGB(255, 8, 74, 10).withOpacity(0.8),
          endBleowChartColor: Colors.greenAccent.withOpacity(0),
        ),
      ],
    );
  }
}

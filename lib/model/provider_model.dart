import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/service/networking.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/icons/eth_recent_transaction_icon.dart';

class ModelProvider extends ChangeNotifier {
  //price property
  double BTCPrice = 0.0;
  double ETHPrice = 0.0;
  double USDTPrice = 0.0;

  //balance property
  double BTCBalance = 0.0;
  double ETHBalance = 0.0;
  double USDTBalance = 0.0;
  double USDBalance = 0.0;

  //transaction property
  String beginCurrency = 'USD';
  String endCurrency = 'BTC';
  double count = 0.0;
  bool isIncome = true;

  List<TransactionModel> transactionList = [];

  //chart list
  List BTCChart = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  List ETHChart = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  List USDTChart = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  /// price getter
  double get GetBTCPrice => BTCPrice;
  double get GetETHPrice => ETHPrice;
  double get GetUSDTPrice => USDTPrice;

  ///balance getter
  double get GetBTCBalance => BTCBalance;
  double get GetETHBalance => ETHBalance;
  double get GetUSDTBalance => USDTBalance;
  double get GetUSDBalance => USDBalance;
  //chart list getter
  List get GetBTCChartlist => BTCChart;
  List get GetETHChartlist => ETHChart;
  List get GetUSDTChartlist => USDTChart;
  //price setter
  void setBTCPrice(double btcprice) {
    BTCPrice = btcprice;
    notifyListeners();
  }

  void setETHPrice(double ethprice) {
    ETHPrice = ethprice;
    notifyListeners();
  }

  void setUSDTPrice(double usdtprice) {
    USDTPrice = usdtprice;
    notifyListeners();
  }

  //transaction getter
  String get getBeginCurrency => beginCurrency;
  String get getEndCurrency => endCurrency;
  double get getCountTransaction => count;
  bool get getIsIncomeTransaction => isIncome;

  List get getTransactionList => List.from(transactionList.reversed);

  //balance setter
  void setUSDBalance(double usdbalance) {
    USDBalance = usdbalance;
    notifyListeners();
  }

  void setUSDTBalance(double usdtbalance) {
    USDTBalance = usdtbalance;
    notifyListeners();
  }

  void setETHBalance(double ethbalance) {
    ETHBalance = ethbalance;
    notifyListeners();
  }

  void setBTCBalance(double btcbalance) {
    BTCBalance = btcbalance;
    notifyListeners();
  }

  // transaction setter
  void setBeginCurrency(String beginCurrency) {
    beginCurrency = beginCurrency;
    print(beginCurrency);
    notifyListeners();
  }

  void setEndCurrency(String endCurrency) {
    endCurrency = endCurrency;
    print(endCurrency);
    notifyListeners();
  }

  void setCountTransaction(double count) {
    count = count;
    notifyListeners();
  }

  void setIsIncomeTransaction(bool isIncome) {
    isIncome = isIncome;
    print(isIncome);
    notifyListeners();
  }

  void addLocalTransacion(TransactionModel transactionModel) {
    transactionList.add(transactionModel);
    notifyListeners();
  }

  void resetLocalTransacion(TransactionModel transactionModel) {
    transactionList = [];
    notifyListeners();
  }

//chart setter
  void setBTCChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      BTCChart[i] = chartList[i]['close'] + 0.0;
    }
    notifyListeners();
  }

  void setETHChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      ETHChart[i] = chartList[i]['close'] + 0.0;
    }

    notifyListeners();
  }

  void setUSDTChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      USDTChart[i] = chartList[i]['close'] + 0.0;
      print(USDTChart[i]);
    }

    notifyListeners();
  }

  //inital firestore and local balance
  Future<bool> initialBlance() async {
    String _uid = await FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('balance')
        .doc('balance');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (!documentSnapshot.exists) {
        documentReference
            .set({'USD': 0.0, 'BTC': 0.0, 'ETH': 0.0, 'USDT': 0.0});

        setUSDBalance(0.0);
        setBTCBalance(0.0);
        setETHBalance(0.0);
        setUSDTBalance(0.0);

        notifyListeners();
        print('now existed!');
        return true;
      }
      print('was exi..');

      setUSDBalance(documentSnapshot.get('USD').toDouble());
      setBTCBalance(documentSnapshot.get('BTC').toDouble());
      setETHBalance(documentSnapshot.get('ETH').toDouble());
      setUSDTBalance(documentSnapshot.get('USDT').toDouble());
      notifyListeners();
      return true;
    });
    return true;
  }

  //set local balance variable

  Future<void> UpdateFirestoreBalance() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('balance')
        .doc('balance')
        .update({
      'USD': GetUSDBalance,
      'BTC': GetBTCBalance,
      'ETH': GetETHBalance,
      'USDT': GetUSDTBalance
    });
  }

  //GET price
  double getPrice(String currency) {
    switch (currency) {
      case 'USD':
        return 1.0;

      case 'BTC':
        return GetBTCPrice;
      case 'ETH':
        return GetETHPrice;

      case 'USDT':
        return GetUSDTPrice;
    }
    return 1.0;
  }

  //initial transaction from firebase
  Future<void> initialTransaction() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    final transactions = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .orderBy('dateTime')
        .get();

    late List transactionList;
    print(transactions.docs.length);
    final allData = transactions.docs.map((doc) => doc.data()).toList();
    for (var transaction in allData) {
      addLocalTransacion(TransactionModel(
        type: transaction['type'],
        beginCurrency: transaction['beginCurrency'],
        endCurrency: transaction['endCurrency'],
        count: transaction['count'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            transaction['dateTime'].seconds * 1000),
      ));
    }
  }

  Future<void> setPriceOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,USDT&tsyms=USD';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setBTCPrice(priceData['BTC']['USD'] + 0.0);
    setETHPrice(priceData['ETH']['USD'] + 0.0);
    setUSDTPrice(priceData['USDT']['USD'] + 0.0);
  }

  Future<void> setBTCChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setBTCChartList(priceData['Data']['Data']);
  }

  Future<void> setETHChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=ETH&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setETHChartList(priceData['Data']['Data']);
  }

  Future<void> setUSDTChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=USDT&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setUSDTChartList(priceData['Data']['Data']);
  }

  Future<void> setCharts() async {
    await setBTCChartOnline();
    await setETHChartOnline();
    await setUSDTChartOnline();
  }

  Widget getRecentTransactionIcon(String currency) {
    switch (currency) {
      case 'USD':
        return USDRecentTransactionIcon();
      case 'BTC':
        return BTCRecentTransactionIcon();
      case 'ETH':
        return ETHRecentTransactionIcon();
      case 'USDT':
        return USDTRecentTransactionIcon();
      default:
        return USDRecentTransactionIcon();
    }
  }
}

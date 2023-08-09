import 'package:flutter/material.dart';
import '../models/general_exchange_rate_result.dart';
import '../services/exchange_rate_api_service.dart';

class ExchangeRatePage extends StatefulWidget {
  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  Future<List<GeneralExchangeRateResult>> _exchangeRateData = Future.value([]);

  @override
  void initState() {
    super.initState();
    _loadExchangeRateData();
  }

  Future<void> _loadExchangeRateData() async {
    try {
      final exchangeRateData = await ExchangeRateApiService().fetchExchangeRate();
      setState(() {
        _exchangeRateData = Future.value(exchangeRateData);
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Döviz Kurları'),
      ),
      body: FutureBuilder<List<GeneralExchangeRateResult>>(
        future: _exchangeRateData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Döviz kuru verisi bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                GeneralExchangeRateResult rateResult = snapshot.data![index];
                return ListTile(
                  title: Text(rateResult.name ?? ''),
                  subtitle: Text('Kur: ${rateResult.rate ?? ''}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

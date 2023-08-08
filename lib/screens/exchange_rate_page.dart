import 'package:flutter/material.dart';
import '../models/general_exchange_rate_result.dart';
import '../services/exchange_rate_api_service.dart';

class ExchangeRatePage extends StatefulWidget {
  const ExchangeRatePage({Key? key}) : super(key: key);

  @override
  ExchangeRatePageState createState() => ExchangeRatePageState();
}

class ExchangeRatePageState extends State<ExchangeRatePage> {
  late Future<List<GeneralExchangeRateResult>> _exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    _exchangeRateFuture = _fetchExchangeRate();
  }

  Future<List<GeneralExchangeRateResult>> _fetchExchangeRate() async {
    ExchangeRateApiService apiService = ExchangeRateApiService();
    return await apiService.fetchExchangeRate();
  }
  Future<void> _refreshExchangeRate() async {
    setState(() {
      _exchangeRateFuture = _fetchExchangeRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Döviz Kuru'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshExchangeRate,
        child: FutureBuilder<List<GeneralExchangeRateResult>>(
          future: _exchangeRateFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.hasData) {
                List<GeneralExchangeRateResult>? exchangeRateList = snapshot.data;
                return ListView.builder(
                  itemCount: exchangeRateList!.length,
                  itemBuilder: (context, index) {
                    GeneralExchangeRateResult exchangeRateItem = exchangeRateList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          '${exchangeRateItem.name ?? ''} ',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exchangeRateItem.code ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              exchangeRateItem.calculatedstr ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data available.'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
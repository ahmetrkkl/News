  import 'package:flutter/material.dart';
  import 'package:news/services/pharmacy_api_service.dart';
  import '../models/general_pharmacy_result.dart';

  class PharmacyPage extends StatefulWidget {
    const PharmacyPage({Key? key}) : super(key: key);

    @override
    PharmacyPageState createState() => PharmacyPageState();
  }

  class PharmacyPageState extends State<PharmacyPage> {
    late Future<List<GeneralPharmacyResult>> _pharmacyFuture;

    @override
    void initState() {
      super.initState();
      _pharmacyFuture = _fetchPharmacy();
    }

    Future<List<GeneralPharmacyResult>> _fetchPharmacy() async {
      PharmacyApiService apiService = PharmacyApiService();
      return await apiService.fetchPharmacy();
    }
    Future<void> _refreshPharmacy() async {
      setState(() {
        _pharmacyFuture = _fetchPharmacy();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('NÖBETÇİ ECZANE'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshPharmacy,
          child: FutureBuilder<List<GeneralPharmacyResult>>(
            future: _pharmacyFuture,
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
                  List<GeneralPharmacyResult>? pharmacyList = snapshot.data;
                  return ListView.builder(
                    itemCount: pharmacyList!.length,
                    itemBuilder: (context, index) {
                      GeneralPharmacyResult pharmacyItem = pharmacyList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            '${pharmacyItem.name ?? ''} ECZANESİ',
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
                                pharmacyItem.address ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                pharmacyItem.phone ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                pharmacyItem.dist ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              )
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
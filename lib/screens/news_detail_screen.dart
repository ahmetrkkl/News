import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/general_news_result.dart';

class NewsDetailScreen extends StatelessWidget {
  final GeneralNewsResult newsItem;

  NewsDetailScreen({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text(newsItem.name ?? ''),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag:"newsItem_${newsItem.key}",
            child: newsItem.image != null
                ? Image.network(
              newsItem.image!,
              width: 400,
              height: 200,
              fit: BoxFit.cover,
            )
                : const SizedBox.shrink(),
      ),

            const SizedBox(height: 16),
            Text(
              newsItem.name ?? '',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              newsItem.description ?? '',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 16),
            Text(
              'Kaynak: ${newsItem.source ?? ''}',
              style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

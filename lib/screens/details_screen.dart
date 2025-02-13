// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String country;

  const DetailsScreen({super.key, required this.country});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<List<Map<String, dynamic>>>? details;

  Future<List<Map<String, dynamic>>> fetchSpecificCountry() async {
    String baseUrl = 'https://restcountries.com/v3.1/name/${widget.country}';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load data, statusCode: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    details = fetchSpecificCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Map<String, dynamic>>>(
          future: details,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return Text(snapshot.data![0]['name']['common']);
            }
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: details,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          }

          var data = snapshot.data!;
          return Center(
            child: Column(
              children: [
                Image.network(
                  data[0]['flags']['png'],
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Full Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${data[0]['name']['official']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Capital: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${data[0]['capital']?[0] ?? 'N/A'}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Continent: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " ${data[0]['continents'][0]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Currency: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  " ${data[0]['currencies']?.keys.first ?? 'N/A'}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Population: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " ${data[0]['population']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

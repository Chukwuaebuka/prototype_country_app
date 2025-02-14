import 'package:country_app_prototype/components/language_selection_modal.dart';
import 'package:country_app_prototype/screens/details_screen.dart';
import 'package:country_app_prototype/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _allCountries;
  List<Map<String, dynamic>> _allCountriesList = [];
  List<Map<String, dynamic>> _filteredCountriesList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _allCountries = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    String baseUrl = 'https://restcountries.com/v3.1/all';

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> countries =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      setState(() {
        _allCountriesList = countries;
        _filteredCountriesList = countries;
      });

      return countries;
    } else {
      throw Exception(
          'Failed to load data, statusCode: ${response.statusCode}');
    }
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountriesList = _allCountriesList;
      } else {
        _filteredCountriesList = _allCountriesList
            .where((country) => country['name']['common']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country App'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon: Icon(
                    themeProvider.themeMode == ThemeMode.dark
                        ? Icons.wb_sunny
                        : Icons.nightlight_round,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                labelText: 'Search Country',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return const LanguageSelectionModal();
                  },
                );
              },
              icon: const Icon(Icons.language_outlined),
              label: const Text('EN'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _allCountries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // return Center(child: Text('Error ${snapshot.error}'));
                    return const Center(
                      child: Text(
                          'Unable to load, \nplease check your connection'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: _filteredCountriesList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _filteredCountriesList[index]['flags']['png'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(_filteredCountriesList[index]['name']
                                ['common']),
                            subtitle: Text(
                              _filteredCountriesList[index]
                                      .containsKey('capital')
                                  ? _filteredCountriesList[index]['capital'][0]
                                  : 'No Capital',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    country: _filteredCountriesList[index]
                                        ['name']['common'],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

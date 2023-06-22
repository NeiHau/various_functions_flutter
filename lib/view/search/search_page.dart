import 'package:calendar_app_remake/repository/country_service.dart';
import 'package:calendar_app_remake/repository/firestore_service.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CountryService _countryService = CountryService();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _controller = TextEditingController();
  List<String> _countries = [];
  List<String> _suggestions = [];
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() async {
    _countries = await _countryService.getCountries();
  }

  void _searchCountries(String searchTerm) {
    if (searchTerm.length < 2) {
      // Show recently searched keywords
    } else {
      _suggestions = _countries
          .where((country) =>
              country.toLowerCase().startsWith(searchTerm.toLowerCase()))
          .toList();
    }
  }

  void _saveSearch(String searchTerm) {
    _firestoreService.saveCountry(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Country Search'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                  _searchCountries(_searchTerm);
                });
              },
              onEditingComplete: () {
                _saveSearch(_searchTerm);
                // Navigate to search results screen
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Custom search bar widget for city input with autocomplete
class CitySearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CitySearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends State<CitySearchBar> {
  final TextEditingController _controller = TextEditingController();

  // Popular cities for autocomplete suggestions
  static const List<String> _popularCities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'London',
    'Paris',
    'Tokyo',
    'Sydney',
    'Toronto',
    'Vancouver',
    'Montreal',
    'Ottawa',
    'Calgary',
    'Edmonton',
    'Dubai',
    'Singapore',
    'Hong Kong',
    'Shanghai',
    'Beijing',
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Berlin',
    'Madrid',
    'Rome',
    'Barcelona',
    'Amsterdam',
    'Brussels',
    'Vienna',
    'Prague',
    'Moscow',
    'Istanbul',
    'Cairo',
    'Mexico City',
    'Buenos Aires',
    'Rio de Janeiro',
    'São Paulo',
    'Lima',
    'Bogotá',
    'Santiago',
    'Miami',
    'Boston',
    'Seattle',
    'Denver',
    'Atlanta',
    'Las Vegas',
    'Portland',
    'Austin',
    'Nashville',
    'Detroit',
  ];

  void _handleSearch(String city) {
    if (city.trim().isNotEmpty) {
      widget.onSearch(city.trim());
      _controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 8),
            Expanded(
              child: RawAutocomplete<String>(
                textEditingController: _controller,
                focusNode: FocusNode(),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _popularCities.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _handleSearch(selection);
                },
                fieldViewBuilder: (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: AppConstants.searchHint,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      _handleSearch(value);
                    },
                  );
                },
                optionsViewBuilder: (
                  BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options,
                ) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 300,
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_city,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      option,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () => _handleSearch(_controller.text),
              icon: const Icon(Icons.arrow_forward),
              tooltip: AppConstants.searchButton,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Custom search bar widget for city input
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

  void _handleSearch() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      widget.onSearch(city);
      FocusScope.of(context).unfocus(); // Dismiss keyboard
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
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: AppConstants.searchHint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
            IconButton(
              onPressed: _handleSearch,
              icon: const Icon(Icons.arrow_forward),
              tooltip: AppConstants.searchButton,
            ),
          ],
        ),
      ),
    );
  }
}

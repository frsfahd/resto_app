import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/component/resto_card_widget.dart';
import 'package:resto_app/provider/search/resto_search_provider.dart';
import 'package:resto_app/static/resto_search_result_state.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SearchBar()),

      body: Consumer<RestoSearchProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestoSearchLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestoSearchErrorState(error: var message) => Center(
              child: Text(message),
            ),
            RestoSearchLoadedState(restoData: var restoList) =>
              restoList.isEmpty
                  ? Center(child: Text("no matching resto"))
                  : ListView.builder(
                      itemCount: restoList.length,
                      itemBuilder: (context, index) {
                        final resto = restoList[index];

                        return RestoCardWidget(resto: resto);
                      },
                    ),
            _ => const Center(child: Text("enter a keyword for searching...")),
          };
        },
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  void onReset(BuildContext context) {
    _searchController.clear();
    context.read<RestoSearchProvider>().reset();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              context.read<RestoSearchProvider>().searchResto(value);
            },
            decoration: InputDecoration(
              hintText:
                  'Search for anything (resto, menus, description, address, etc) ...',
              prefixIcon: Icon(Icons.search_rounded),
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onReset(context);
          },
          child: Text("Reset"),
        ),
      ],
    );
  }
}

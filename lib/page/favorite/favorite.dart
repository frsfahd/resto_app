import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/component/resto_card_widget.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllResto();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HeaderSection(),
          SliverToBoxAdapter(child: SizedBox.square(dimension: 10)),
          Consumer<LocalDatabaseProvider>(
            builder: (context, value, child) {
              {
                if (value.restoList == null || value.restoList!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),

                      child: Center(
                        child: Text(
                          "You don't have favorite resto, try adding one !",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ),
                    ),
                  );
                } else if (value.message == "Failed to load your all data") {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          value.message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final resto = value.restoList![index];
                    return RestoCardWidget(resto: resto);
                  }, childCount: value.restoList!.length),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 100,
      collapsedHeight: 100,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16, 20, 0, 0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Favorites",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox.square(dimension: 10),
            Expanded(
              child: Text(
                "Your Favorite Restaurants",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

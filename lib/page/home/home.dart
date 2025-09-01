import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/component/resto_card_widget.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/static/resto_list_result_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<RestoListProvider>().fetchRestoList();
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
          Consumer<RestoListProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                RestoListLoadingState() => SliverToBoxAdapter(
                  child: const Center(child: CircularProgressIndicator()),
                ),

                RestoListErrorState(error: var message) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),

                RestoListLoadedState(restoData: var restoList) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final resto = restoList[index];
                    return RestoCardWidget(resto: resto);
                  }, childCount: restoList.length),
                ),

                _ => SliverToBoxAdapter(child: SizedBox.shrink()),
              };
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
                "Restaurants",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox.square(dimension: 10),
            Expanded(
              child: Text(
                "Recommendation restaurant for you !",
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

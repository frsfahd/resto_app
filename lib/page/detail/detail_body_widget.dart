import 'package:flutter/material.dart';
import 'package:resto_app/data/model/customer_review.dart';
import 'package:resto_app/data/model/resto_detail.dart';

class DetailBodyWidget extends StatelessWidget {
  final RestoDetail resto;
  const DetailBodyWidget({super.key, required this.resto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        slivers: [
          // resto image, name, and rating
          FancyAppBar(resto: resto),

          SliverToBoxAdapter(child: const SizedBox.square(dimension: 16)),

          // resto Header Section (address and category)
          SliverToBoxAdapter(child: HeaderSection(resto: resto)),

          SliverToBoxAdapter(child: const SizedBox.square(dimension: 40)),

          // resto description
          SliverToBoxAdapter(
            child: Text(
              resto.description,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox.square(dimension: 40)),

          // Menu Section
          SliverToBoxAdapter(child: MenuSection(resto: resto)),
        ],
      ),
    );
  }
}

class FancyAppBar extends StatelessWidget {
  const FancyAppBar({super.key, required this.resto});

  final RestoDetail resto;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: true,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,

      expandedHeight: 400,
      collapsedHeight: 80,

      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(12),
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.3),
              BlendMode.darken,
            ),
            child: Hero(
              tag: resto.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        expandedTitleScale: 1.5,
        titlePadding: EdgeInsets.fromLTRB(60, 10, 3, 16),
        title: Wrap(
          clipBehavior: Clip.hardEdge,
          runSpacing: 10,
          children: [
            Text(
              resto.name,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),

            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amberAccent),
                const SizedBox.square(dimension: 4),
                Text(
                  resto.rating.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
                const SizedBox.square(dimension: 4),
                Expanded(
                  child: Text(
                    "(${resto.customerReviews.length.toString()} reviews)",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///
/// create a horizontal scrollable list (SingleChildScrollView&gt;Row) from List&lt;Category&gt;
///
SizedBox menuList({
  required BuildContext context,
  required List<Category> items,
  required String imageUrl,
}) {
  return SizedBox(
    height: 150, // Fixed height for the container
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((food) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 120,
                minWidth: 120,
                maxHeight: 240,
                maxWidth: 240,
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        food.name,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

class MenuSection extends StatelessWidget {
  const MenuSection({super.key, required this.resto});

  final RestoDetail resto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Foods", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox.square(dimension: 10),
        menuList(
          context: context,
          items: resto.menus.foods,
          imageUrl: "assets/images/food.png",
        ),

        const SizedBox.square(dimension: 10),

        Text("Drinks", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox.square(dimension: 10),
        menuList(
          context: context,
          items: resto.menus.drinks,
          imageUrl: "assets/images/drink.png",
        ),
      ],
    );
  }
}

SizedBox reviewList({
  required BuildContext context,
  required List<CustomerReview> items,
}) {
  return SizedBox(
    height: 100, // Fixed height for the container
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((review) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              constraints: const BoxConstraints(
                minHeight: 100,
                minWidth: 120,
                maxHeight: 100,
                maxWidth: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${review.review}"',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "(${review.name} - ${review.date})",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.resto});

  final RestoDetail resto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox.square(dimension: 4),
        // reviews
        reviewList(context: context, items: resto.customerReviews),

        const SizedBox.square(dimension: 30),
        // address
        Row(
          children: [
            Icon(Icons.location_pin, color: Colors.deepOrange),
            const SizedBox.square(dimension: 4),
            Expanded(
              child: Text(
                "${resto.address}, ${resto.city}",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),

        const SizedBox.square(dimension: 20),

        // category
        Wrap(
          spacing: 6,
          children: resto.categories!
              .map(
                (category) => Chip(
                  label: Text("#${category.name}"),
                  padding: EdgeInsets.all(3),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

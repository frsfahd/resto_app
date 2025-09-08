import 'package:flutter/material.dart';
import 'package:resto_app/component/favorite_icon_widget.dart';
import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/static/navigation_route.dart';

class RestoCardWidget extends StatelessWidget {
  final RestoBrief resto;
  const RestoCardWidget({super.key, required this.resto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          NavigationRoute.detailRoute.name,
          arguments: resto,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 80,
                minWidth: 80,
                maxHeight: 120,
                maxWidth: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: resto.pictureId,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox.square(dimension: 8),

            // text area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    resto.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox.square(dimension: 6),

                  // location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          resto.city,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),

                  SizedBox.square(dimension: 6),

                  // rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          resto.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expanded(child: FavoriteIconWidget(resto: resto)),
          ],
        ),
      ),
    );
  }
}

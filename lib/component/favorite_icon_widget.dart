import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/provider/detail/favorite_icon_provider.dart';
import 'package:resto_app/provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestoBrief resto;
  const FavoriteIconWidget({super.key, required this.resto});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestoById(widget.resto.id);
      final value = localDatabaseProvider.checkItemBookmark(widget.resto.id);

      bookmarkIconProvider.isBookmarked = value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final bookmarkIconProvider = context.read<FavoriteIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          await localDatabaseProvider.saveResto(widget.resto);
        } else {
          await localDatabaseProvider.removeRestoById(widget.resto.id);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
        localDatabaseProvider.loadAllResto();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}

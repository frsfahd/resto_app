import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/page/detail/bottom_sheet_form_widget.dart';
import 'package:resto_app/page/detail/detail_body_widget.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/static/resto_detail_result_state.dart';

class Detail extends StatefulWidget {
  final RestoBrief resto;

  const Detail({super.key, required this.resto});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<RestoDetailProvider>().fetchRestoDetail(widget.resto.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestoDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestoDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),

            RestoDetailErrorState(error: var message) => Padding(
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

            RestoDetailLoadedState(restoData: var resto) => DetailBodyWidget(
              resto: resto,
            ),

            _ => const SizedBox.shrink(),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return BottomSheetFormWidget(resto: widget.resto);
            },
          );
        },
        label: Text("Add Review"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:resto_app/data/model/resto_brief.dart';
import 'package:resto_app/data/model/review_add_request.dart';
import 'package:resto_app/provider/detail/review_add_provider.dart';
import 'package:resto_app/static/review_add_result_state.dart';

class BottomSheetFormWidget extends StatefulWidget {
  final RestoBrief resto;
  const BottomSheetFormWidget({super.key, required this.resto});

  @override
  State<BottomSheetFormWidget> createState() => _BottomSheetFormWidgetState();
}

class _BottomSheetFormWidgetState extends State<BottomSheetFormWidget> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _clearForm() {
    _usernameController.clear();
    _reviewController.clear();
    // _formKey.currentState?.reset();
  }

  void _onSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ReviewAddRequest reviewData = ReviewAddRequest(
      id: widget.resto.id,
      name: _usernameController.text,
      review: _reviewController.text,
    );

    context.read<ReviewAddProvider>().addReview(reviewData);
  }

  @override
  void initState() {
    super.initState();

    // Listen for provider state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ReviewAddProvider>();

      // Add a listener to handle state changes
      provider.addListener(() {
        if (provider.resultState is ReviewAddLoadedState) {
          // Clear form on success
          _clearForm();
          // provider.resetState();
          if (mounted) {
            Navigator.pop(context);
          }

          // Show success toast
          Fluttertoast.showToast(
            msg: "Review has been added",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        if (provider.resultState is ReviewAddErrorState) {
          final errorState = provider.resultState as ReviewAddErrorState;
          provider.resetState();

          // Show error toast
          Fluttertoast.showToast(
            msg: errorState.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // resto info
              Row(
                children: [
                  Text("Resto : "),
                  Text(
                    widget.resto.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // name input field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                controller: _usernameController,
                decoration: InputDecoration(
                  hint: Text("Add your name..."),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.all(5),
                ),
              ),

              const SizedBox(height: 16),

              // review input field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Review cannot be empty';
                  }
                  return null;
                },
                controller: _reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hint: Text("Add your review..."),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.all(5),
                ),
              ),
              const SizedBox(height: 16),

              // buttons (cancel & submit)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  Consumer<ReviewAddProvider>(
                    builder: (context, value, child) {
                      if (value.resultState is ReviewAddLoadingState) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: null,
                          child: const CircularProgressIndicator(),
                        );
                      }

                      return TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _onSubmit(context),
                        child: const Text('Submit'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

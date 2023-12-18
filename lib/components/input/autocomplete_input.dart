import 'package:flutter/material.dart';

class AutocompleteInput extends StatelessWidget {
  const AutocompleteInput({super.key});

  static const List<String> _kOptions = <String>[
    'handball',
    'tennis',
    'running',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      initialValue: const TextEditingValue(text: 'tennis'),
    );
  }
}

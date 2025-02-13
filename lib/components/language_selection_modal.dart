import 'package:flutter/material.dart';

class LanguageSelectionModal extends StatefulWidget {
  const LanguageSelectionModal({super.key});

  @override
  State<LanguageSelectionModal> createState() => _LanguageSelectionModalState();
}

class _LanguageSelectionModalState extends State<LanguageSelectionModal> {
  String _selectedLanguage = "EN";

  final List<Map<String, String>> _languages = [
    {"code": "ID", "label": "Bahasa"},
    {"code": "DE", "label": "Deutsch"},
    {"code": "EN", "label": "English"},
    {"code": "ES", "label": "Espagnol"},
    {"code": "FR", "label": "French"},
    {"code": "IG", "label": "Igbo"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Languages",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close_sharp, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_languages[index]['label']!),
                  value: _languages[index]['code']!,
                  groupValue: _selectedLanguage,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

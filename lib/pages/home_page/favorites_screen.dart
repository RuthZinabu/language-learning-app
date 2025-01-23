import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Global favorite items list with a ValueNotifier for tracking changes
final ValueNotifier<List<Map<String, String>>> favoriteItems =
    ValueNotifier<List<Map<String, String>>>([]);

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFF410FA3),
      ),
      body: favoriteItems.value.isEmpty
          ? const Center(
              child: Text(
                'Your Favorites will appear here.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteItems.value.length,
              itemBuilder: (context, index) {
                final item = favoriteItems.value[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['word']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['translation']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeFavorite(context, index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _removeFavorite(BuildContext context, int index) {
    final removedItem = favoriteItems.value[index];

    // Remove the item from the global list
    favoriteItems.value.removeAt(index);
    // Update the ValueNotifier list
    favoriteItems.value = List.from(favoriteItems.value)..removeAt(index);

    // Show a snackbar to confirm the removal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem['word']} removed from favorites'),
      ),
    );

    // Trigger UI update by rebuilding the widget tree
    (context as Element).reassemble();
  }
}

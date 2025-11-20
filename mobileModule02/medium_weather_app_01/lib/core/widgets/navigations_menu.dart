import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medium_weather_app_01/services/geocording_service.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app_01/core/themes/light_theme.dart';
import 'package:medium_weather_app_01/provider/nav/navigation_provider.dart';
import '../routes/routing_helper.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();
    final selectedIndex = provider.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  context.read<NavigationProvider>().searchCity(value);
                },
                onSubmitted: (value) async {
  final provider = context.read<NavigationProvider>();

  // Fetch suggestions if user presses enter without typing fully
  await provider.searchCity(value);

  if (provider.citySuggestions.isNotEmpty) {
    // 👌 Choose first valid suggestion automatically
    provider.selectCitySuggestion(provider.citySuggestions.first);

    // Show chosen name in text field
    final chosenCity = provider.citySuggestions.first;
    controller.text = chosenCity['name'];
  } else {
    // ❌ No valid city from API → do not accept text
    controller.clear();
    provider.clearCity();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No such city found. Choose a valid location."),
        duration: Duration(seconds: 2),
      ),
    );
  }
},


                decoration: const InputDecoration(
                  hintText: "Search location...",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                context.read<NavigationProvider>().getCurrentLocation();
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Consumer<NavigationProvider>(
            builder: (context, provider, child) {
              if (provider.citySuggestions.isEmpty) return const SizedBox.shrink();

              return Container(
                height: 240,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: provider.citySuggestions.length,
                  itemBuilder: (context, index) {
                    final city = provider.citySuggestions[index];
                    return ListTile(
                      title: Text(city['name']),
                      subtitle: Text("${city['admin1'] ?? ''}, ${city['country']}"),
                      onTap: () {
                        controller.text = city['name']; // 👈 keep text visible
                        provider.selectCitySuggestion(city);
                      },
                    );
                  },
                ),
              );
            },
          ),

          // 👇 YOUR THREE SCREENS
          Expanded(
            child: PageView(
              controller: provider.pageController,
              onPageChanged: provider.updateBottomNavItemIndex,
              children: RoutingHelper.screens,
            ),
          ),
        ],
      ),
    );
  }
}

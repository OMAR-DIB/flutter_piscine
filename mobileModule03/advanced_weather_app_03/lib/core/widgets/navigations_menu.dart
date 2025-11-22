import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:advanced_weather_app_03/core/themes/light_theme.dart';
import 'package:advanced_weather_app_03/provider/nav/navigation_provider.dart';
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
        backgroundColor: Colors.orange.withOpacity(0.68),
        elevation: 0,
        toolbarHeight: 60, // Make it a bit taller
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0), // 👈 modest padding on top
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      context.read<NavigationProvider>().searchCity(value);
                    },
                    onSubmitted: (value) async {
                      final provider = context.read<NavigationProvider>();
                      await provider.searchCity(value);
                    
                      if (provider.citySuggestions.isNotEmpty) {
                        provider.selectCitySuggestion(
                          provider.citySuggestions.first,
                        );
                        controller.text = provider.citySuggestions.first['name'];
                      } else {
                        controller.clear();
                        provider.clearCity();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No such city found. Choose a valid location.",
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    
                    decoration: InputDecoration(
                      hintText: "Search location...",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ), // 👈 search icon
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), // 👈 rounded
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.my_location, size: 22),
                    onPressed: () {
                      context.read<NavigationProvider>().getCurrentLocation();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

body: Stack(
    children: [
      // 🔥 One global background
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),

      // 🔥 Your main content on top of background
      Column(
        children: [
          Consumer<NavigationProvider>(
            builder: (context, provider, child) {
              if (provider.citySuggestions.isEmpty)
                return const SizedBox.shrink();

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
                        controller.text = city['name'];
                        provider.selectCitySuggestion(city);
                      },
                    );
                  },
                ),
              );
            },
          ),

          Expanded(
            child: PageView(
              controller: provider.pageController,
              onPageChanged: provider.updateBottomNavItemIndex,
              children: RoutingHelper.screens,
            ),
          ),
        ],
      ),
    ],
  ),

  // 🔥 Bottom bar has NO background image
  bottomNavigationBar: NavigationBarTheme(
    data: NavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(0.7), // 👈 works on image
    ),
    child: NavigationBar(
      height: 80,
      selectedIndex: context.watch<NavigationProvider>().selectedIndex,
      onDestinationSelected: (index) {
        context.read<NavigationProvider>().updateBottomNavItemIndex(index);
      },
      indicatorColor: Colors.orange.withOpacity(0.4),
      destinations: [
        RoutingHelper.buildNavigationItem(index: 0, currentIndex: selectedIndex, icon: Iconsax.home, label: 'Currently', context: context),
        RoutingHelper.buildNavigationItem(index: 1, currentIndex: selectedIndex, icon: Iconsax.message, label: 'Today', context: context),
        RoutingHelper.buildNavigationItem(index: 2, currentIndex: selectedIndex, icon: Iconsax.message, label: 'Weekly', context: context),
      ],
    ),
  ),
);
  }
}

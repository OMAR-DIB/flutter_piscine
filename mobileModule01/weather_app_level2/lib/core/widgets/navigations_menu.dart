import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_level2/core/themes/light_theme.dart';
import 'package:weather_app_level2/provider/nav/navigation_provider.dart';
import '../routes/routing_helper.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    /// Current selected index
    final int selectedIndex = context.watch<NavigationProvider>().selectedIndex;
    final TextEditingController controller = TextEditingController();

    return  Scaffold(
      appBar: AppBar(
        title: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Type something...",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Provider.of<NavigationProvider>(context, listen: false).updateContent(controller.text);
                },
                child: const Text("Search"),
              ),
            ],
          ),
      ),

        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: LightTheme.scaffoldBackgroundColor,
            indicatorColor: LightTheme.primaryColor.withAlpha(200),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                      color: LightTheme.primaryColor, // Selected color
                      fontSize: 14);
                }
                return TextStyle(
                    color: LightTheme.disabledColor,
                    fontSize: 14 // Unselected color
                    );
              },
            ),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: context.watch<NavigationProvider>().selectedIndex,
            onDestinationSelected: (index) {
              context
                  .read<NavigationProvider>()
                  .updateBottomNavItemIndex(index);
            },
            backgroundColor: LightTheme.scaffoldBackgroundColor,
            indicatorColor: LightTheme.primaryColor.withAlpha(800),
            destinations: [
              RoutingHelper.buildNavigationItem(
                index: 0,
                currentIndex: selectedIndex,
                icon: Iconsax.home,
                label: 'Currently',
                context: context,
              ),
              RoutingHelper.buildNavigationItem(
                index: 1,
                currentIndex: selectedIndex,
                icon: Iconsax.message,
                label: 'Today',
                context: context,
              ),
              RoutingHelper.buildNavigationItem(
                index: 1,
                currentIndex: selectedIndex,
                icon: Iconsax.message,
                label: 'weekly',
                context: context,
              ),
            ],
          ),
        ),
        body: RoutingHelper.screens[selectedIndex],
      
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/themes/light_theme.dart';
import 'package:weather_app/provider/nav/navigation_provider.dart';
import '../routes/routing_helper.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    /// Current selected index
    final int selectedIndex = context.watch<NavigationProvider>().selectedIndex;

    return  Scaffold(
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
                label: 'Home',
                context: context,
              ),
              RoutingHelper.buildNavigationItem(
                index: 1,
                currentIndex: selectedIndex,
                icon: Iconsax.message,
                label: 'Messages',
                context: context,
              ),
              
            ],
          ),
        ),
        body: RoutingHelper.screens[selectedIndex],
      
    );
  }
}

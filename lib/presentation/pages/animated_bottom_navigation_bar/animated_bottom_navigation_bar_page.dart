import 'package:flutter/material.dart';

class AnimatedBottomNavigationBarPage extends StatelessWidget {
  const AnimatedBottomNavigationBarPage._();

  static const routeName = '/animated_bottom_navigation_bar';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AnimatedBottomNavigationBarPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: const _FabLocation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB');
        },
        shape: const CircleBorder(),
      ),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 16,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home),
            Icon(Icons.person),
          ],
        ),
      ),
      appBar: AppBar(),
      body: const Center(child: Text('AnimatedBottomNavigationBarPage')),
    );
  }
}

class _FabLocation extends _CenterDockedFabLocation {
  const _FabLocation();

  @override
  double getOffsetY(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) {
    return super.getOffsetY(scaffoldGeometry, adjustment) - 16;
  }

  @override
  String toString() => 'CustomFabLocation';
}

// copied by FloatingActionButtonLocation.centerDocked
class _CenterDockedFabLocation extends StandardFabLocation
    with FabCenterOffsetX, FabDockedOffsetY {
  const _CenterDockedFabLocation();
}

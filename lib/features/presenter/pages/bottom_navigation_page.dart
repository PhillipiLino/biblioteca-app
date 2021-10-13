import 'package:clean_biblioteca/features/presenter/controller/bottom_navigation_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BottomNavigationPage extends StatefulWidget {
  final String? initialPage;

  const BottomNavigationPage(
    this.initialPage, {
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState
    extends ModularState<BottomNavigationPage, BottomNavigationStore> {
  late final items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book), label: 'Meus Livros'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart), label: 'Progresso'),
  ];

  @override
  void initState() {
    super.initState();
    controller.setRoute(widget.initialPage ?? '');
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, int? currentPage) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: BottomNavigationBar(
        items: items,
        currentIndex: currentPage ?? 0,
        elevation: 0,
        onTap: controller.goToPage,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.deepPurple[200],
        selectedIconTheme: IconThemeData(
            size: 30, color: Theme.of(context).colorScheme.primary),
        unselectedIconTheme: const IconThemeData(size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: ScopedBuilder(
        store: store,
        onLoading: _onLoading,
        onState: _onSuccess,
        onError: _onError,
      ),
    );
  }
}

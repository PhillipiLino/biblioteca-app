import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../localizations/menu_localization.dart';
import '../stores/bottom_navigation_page_store.dart';
import '../utils/bottom_navigation_page_data.dart';

class BottomNavigationPage extends StatefulWidget {
  final BottomNavigationPageData data;

  const BottomNavigationPage(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState
    extends MainPageState<BottomNavigationPage, BottomNavigationPageStore>
    with TickerProviderStateMixin {
  final localizations = MenuModuleLocalizations().bottomNavigation;

  late final _tabController =
      TabController(length: store.items.length, vsync: this);

  @override
  void initState() {
    store.setRoute(widget.data);
    super.initState();
  }

  Widget _onLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _onError(BuildContext context, Object? error) {
    return const Expanded(child: Center(child: Text('ERROR')));
  }

  Widget _onSuccess(BuildContext context, int? currentPage) {
    _tabController.animateTo(currentPage ?? 0);

    const selectedColor = Colors.amber;
    final unselectedColor = selectedColor.withOpacity(0.5);

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: unselectedColor, width: 1),
          ),
        ),
        child: TabBar(
          onTap: (index) {
            store.goToPage(index, null);

            trackersHelper.trackCustomEvent(
              'go_to_tab',
              infos: {
                'tab_index': store.items[index].index,
                'tab_name': store.items[index].name,
              },
            );
          },
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: unselectedColor,
          labelColor: selectedColor,
          controller: _tabController,
          indicator: const BoxDecoration(
            border: Border(top: BorderSide(color: selectedColor, width: 1.0)),
          ),
          tabs: store.items.map((item) {
            return Tab(
              height: 56,
              text: item.title,
              icon: Icon(item.icon, size: 24),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: ScopedBuilder(
        store: store,
        onLoading: _onLoading,
        onState: _onSuccess,
        onError: _onError,
      ),
    );
  }
}

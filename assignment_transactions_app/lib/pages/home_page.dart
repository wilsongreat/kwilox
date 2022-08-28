import 'package:assignment_transactions_app/pages/categories.dart';
import 'package:assignment_transactions_app/pages/more.dart';
import 'package:assignment_transactions_app/pages/payments.dart';
import 'package:assignment_transactions_app/pages/piggybank.dart';
import 'package:assignment_transactions_app/pages/transactions_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  final pages = [
    TransactionsPage(),
    CategoriesPage(),
    PaymentsPage(),
    PiggybankPage(),
    MorePage()
  ];
  void _chageTabs(int index, Widget page) {
    setState(() {
      _selectedTab = index;
      currentPage = page;
    });
  }

  Widget currentPage = TransactionsPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: PageStorageBucket(), child: currentPage),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        elevation: 2,
        child: Container(
          height: 70,
          padding: EdgeInsets.only(top: 10),
          // alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          // decoration: BoxDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabItem(
                index: 0,
                icon:
                    '/Users/devbuks/StudioProjects/assignment_transactions_app/assets/icons_nav/transaction.png',
                label: 'Transactions',
                selected: _selectedTab == 0,
                onPressed: () => _chageTabs(0, TransactionsPage()),
              ),
              TabItem(
                index: 1,
                icon:
                    '/Users/devbuks/StudioProjects/assignment_transactions_app/assets/icons_nav/categories.png',
                label: 'categories',
                selected: _selectedTab == 1,
                onPressed: () => _chageTabs(1, CategoriesPage()),
              ),
              TabItem(
                index: 2,
                icon:
                    '/Users/devbuks/StudioProjects/assignment_transactions_app/assets/icons_nav/card.png',
                label: 'Payments',
                selected: _selectedTab == 2,
                onPressed: () => _chageTabs(2, PaymentsPage()),
              ),
              TabItem(
                index: 3,
                icon:
                    '/Users/devbuks/StudioProjects/assignment_transactions_app/assets/icons_nav/piggybank.png',
                label: 'Piggy bank',
                selected: _selectedTab == 3,
                onPressed: () => _chageTabs(3, PiggybankPage()),
              ),
              TabItem(
                index: 4,
                icon:
                    '/Users/devbuks/StudioProjects/assignment_transactions_app/assets/icons_nav/more.png',
                label: 'More',
                selected: _selectedTab == 4,
                onPressed: () => _chageTabs(4, MorePage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TabItem({
    required int index,
    required String icon,
    required Function() onPressed,
    required String label,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: selected ? 40 : 35,
            child: Image.asset(
              icon,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          )
        ],
      ),
    );
  }
}

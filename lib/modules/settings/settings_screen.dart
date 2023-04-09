import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                DropdownMenu(
                  enableSearch: false,
                  initialSelection: CacheHelper.getData(key: 'lang'),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'ar', label: 'Arabic'),
                    DropdownMenuEntry(value: 'en', label: 'English')
                  ],
                  onSelected: (value) {
                    CacheHelper.putData(key: 'lang', value: value);
                  },
                  leadingIcon: Icon(Icons.language),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              signOut(context);
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}

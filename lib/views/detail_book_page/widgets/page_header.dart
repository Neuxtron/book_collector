import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHeader extends StatefulWidget {
  final int bookId;

  const PageHeader({
    super.key,
    required this.bookId,
  });

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  bool _isFavourite = false;

  void toggleFavourite(value) async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.favouriteIds) ?? [];
    List<int> ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();

    if (value) {
      ids.add(widget.bookId);
      final stringIds = ids.map((e) => e.toString()).toList();
      prefs.setStringList(PrefKeys.favouriteIds, stringIds);
    } else {
      ids.removeWhere((id) => id == widget.bookId);
      final stringIds = ids.map((e) => e.toString()).toList();
      prefs.setStringList(PrefKeys.favouriteIds, stringIds);
    }
  }

  void getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.favouriteIds) ?? [];
    List<int> ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();

    setState(() {
      _isFavourite = ids.contains(widget.bookId);
    });
  }

  @override
  void initState() {
    super.initState();
    getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 10),
        child: IconButton(
          onPressed: () {
            setState(() => _isFavourite = !_isFavourite);
            toggleFavourite(_isFavourite);
          },
          iconSize: 40,
          icon: Icon(
            _isFavourite ? Icons.star_rounded : Icons.star_outline_rounded,
            color: AppColors.lightYelllow,
          ),
        ),
      ),
    );
  }
}

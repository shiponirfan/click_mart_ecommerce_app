import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/app/assets_path.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/appbar_icon_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/heading_title_with_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/home_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String route = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _buildSearchInput(),
            const SizedBox(
              height: 10,
            ),
            const HomeSlider(),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'All Categories',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getCategoryList(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'Popular',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getProductList(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'Special',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getProductList(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'New',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getProductList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getCategoryList() {
    List<Widget> categoryList = [];
    for (int i = 0; i < 10; i++) {
      categoryList.add(const Padding(
          padding: EdgeInsets.only(right: 16), child: CategoryCardWidget()));
    }
    return categoryList;
  }

  List<Widget> _getProductList() {
    List<Widget> productList = [];
    for (int i = 0; i < 10; i++) {
      productList.add(const Padding(
          padding: EdgeInsets.only(right: 10), child: SingleProductCard()));
    }
    return productList;
  }

  TextFormField _buildSearchInput() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: AppColors.secondaryTextColor.withOpacity(.2),
        filled: true,
        hintText: 'Search',
        hintStyle: const TextStyle(color: AppColors.primaryTextColor),
        prefixIcon: const Icon(CupertinoIcons.search),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      title: SvgPicture.asset(
        AssetsPath.appLogoNavSvg,
        height: 28,
        fit: BoxFit.fitHeight,
      ),
      actions: [
        AppbarIconButton(
          icon: CupertinoIcons.person,
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        AppbarIconButton(
          icon: CupertinoIcons.phone,
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        AppbarIconButton(
          icon: Icons.notifications_active_outlined,
          onPressed: () {},
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

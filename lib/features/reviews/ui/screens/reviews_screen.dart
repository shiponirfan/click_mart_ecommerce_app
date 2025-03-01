import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/reviews/ui/screens/create_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  static String name = '/product/reviews';

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black12,
                              radius: 15,
                              child: Icon(Icons.person_outline),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Shipon Irfan',
                              style: textTheme.titleMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '''Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator''',
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
          _buildAddReviewsButton(textTheme),
        ],
      ),
    );
  }

  Widget _buildAddReviewsButton(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reviews (1000)',
            style: textTheme.titleMedium,
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(CreateReviewScreen.name);
            },
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

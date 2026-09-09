import 'package:flutter/material.dart';

import 'package:asan/theme.dart';
import 'package:asan/widgets/app_bar.dart';

class MealPlanScreen extends StatelessWidget {
	const MealPlanScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: const AsanAppBar(
        screenTitle: 'Meals',
        icon: Icons.add_rounded,
        ),
			body: Padding(
				padding: const EdgeInsets.all(AsanSpacing.lg),
				child: Text(
					'Your meal plan',
					style: AsanTextTheme.bodyMedium,
				),
			),
		);
	}
}

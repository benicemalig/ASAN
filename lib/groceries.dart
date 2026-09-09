import 'package:flutter/material.dart';

import 'package:asan/theme.dart';
import 'package:asan/widgets/app_bar.dart';

class GroceriesScreen extends StatelessWidget {
	const GroceriesScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: const AsanAppBar(
        screenTitle: 'Groceries',
        icon: Icons.add_rounded,
      ),
			body: Padding(
				padding: const EdgeInsets.all(AsanSpacing.lg),
				child: Text(
					'Your grocery list',
					style: AsanTextTheme.bodyMedium,
				),
			),
		);
	}
}

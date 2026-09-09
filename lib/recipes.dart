import 'package:flutter/material.dart';

import 'package:asan/theme.dart';
import 'package:asan/widgets/app_bar.dart';

class RecipesScreen extends StatelessWidget {
	const RecipesScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: const AsanAppBar(
        screenTitle: 'Recipes',
        icon: Icons.add_rounded,
      ),
			body: Padding(
				padding: const EdgeInsets.all(AsanSpacing.lg),
				child: Text(
					'Your recipes',
					style: AsanTextTheme.bodyMedium,
				),
			),
		);
	}
}

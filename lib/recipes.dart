import 'package:flutter/material.dart';
import 'package:asan/theme.dart';
import 'package:asan/widgets/app_bar.dart';
import 'package:asan/widgets/filled_icon_button.dart';
import 'package:asan/widgets/full_screen_dialog_header.dart';
import 'package:asan/widgets/search_bar.dart';

class RecipesScreen extends StatefulWidget {
	const RecipesScreen({super.key});

	@override
	State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
	void _showAddRecipeDialog(BuildContext context) {
		showDialog(
			context: context,
			useSafeArea: false,
			builder: (context) {
				return Dialog.fullscreen(
					child: SafeArea(
						child: Scaffold(
							appBar: const FullScreenDialogHeader(
								screenTitle: 'Add Recipe',
							),
							body: Padding(
								padding: const EdgeInsets.all(AsanSpacing.lg),
								child: Text(
									'Add a recipe',
									style: AsanTextTheme.bodyMedium,
								),
							),
						),
					),
				);
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AsanAppBar(
        screenTitle: 'Recipes',
		icon: Icons.add_rounded,
				onIconPressed: () => _showAddRecipeDialog(context),
					bottom: PreferredSize(
						preferredSize: const Size.fromHeight(
							38 + AsanSpacing.md,
						),
						child: Padding(
							padding: const EdgeInsets.only(
								top: AsanSpacing.md,
							),
							child: Row(
								children: [
									const Expanded(
										child: AsanSearchBar(
											hintText: 'Search recipes',
										),
									),
									const SizedBox(width: AsanSpacing.sm),
									FilledIconButton(
										icon: Icons.tune_rounded,
										onPressed: () {},
									),
								],
							),
						),
					),
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

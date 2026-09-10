import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class AsanTextField extends StatefulWidget {
	final String label;
	final String? hintText;
	final TextEditingController? controller;
	final ValueChanged<String>? onChanged;
	final bool hasError;

	const AsanTextField({
		super.key,
		required this.label,
		this.hintText,
		this.controller,
		this.onChanged,
		this.hasError = false,
	});

	@override
	State<AsanTextField> createState() => _AsanTextFieldState();
}

class _AsanTextFieldState extends State<AsanTextField> {
	late final TextEditingController _controller;
	late final FocusNode _focusNode;
	late final bool _ownsController;

	@override
	void initState() {
		super.initState();
		_ownsController = widget.controller == null;
		_controller = widget.controller ?? TextEditingController();
		_focusNode = FocusNode()..addListener(_updateState);
		_controller.addListener(_updateState);
	}

	void _updateState() {
		setState(() {});
	}

	@override
	void dispose() {
		_controller.removeListener(_updateState);
		_focusNode
			..removeListener(_updateState)
			..dispose();
		if (_ownsController) {
			_controller.dispose();
		}
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final isActive = _focusNode.hasFocus;
		final hasBorder = isActive || widget.hasError;
		final textColor = _controller.text.isEmpty
				? AsanColorScheme.inactive
				: AsanColorScheme.onSurface;

		return Column(
			crossAxisAlignment: CrossAxisAlignment.stretch,
			children: [
				Text(
					widget.label,
					style: AsanTextTheme.labelSmall.copyWith(
						height: 16 / 12,
						color: AsanColorScheme.secondary,
					),
				),
				const SizedBox(height: 8),
				Container(
					height: 38,
					padding: const EdgeInsets.all(8),
					decoration: BoxDecoration(
						color: hasBorder
								? AsanColorScheme.surface
								: AsanColorScheme.container,
						borderRadius: BorderRadius.circular(8),
						border: hasBorder
								? Border.all(
										color: widget.hasError
												? AsanColorScheme.error
												: AsanColorScheme.primary,
									)
								: null,
					),
					child: TextField(
						controller: _controller,
						focusNode: _focusNode,
						onChanged: widget.onChanged,
						style: AsanTextTheme.bodyMedium.copyWith(
							height: 22 / 16,
							color: textColor,
						),
						decoration: InputDecoration(
							hintText: widget.hintText,
							hintStyle: AsanTextTheme.bodyMedium.copyWith(
								height: 22 / 16,
								color: AsanColorScheme.inactive,
							),
							border: InputBorder.none,
							isCollapsed: true,
						),
						cursorColor: AsanColorScheme.primary,
						textAlignVertical: TextAlignVertical.center,
					),
				),
			],
		);
	}
}

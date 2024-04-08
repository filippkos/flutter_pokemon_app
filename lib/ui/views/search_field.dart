import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/gen/fonts.gen.dart';
import 'package:flutter_pokemon_app/generated/l10n.dart';

class SearchField extends StatefulWidget {
  final VoidCallback pullToRefreshCallback;
  final TextEditingController textEditingController = TextEditingController();

  SearchField({super.key, required this.pullToRefreshCallback});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _isCancelButtonVisible = false;

  @override
  void initState() {
    super.initState();

    widget.textEditingController.addListener(() {
      String? text = widget.textEditingController.text;
      text = text.isEmpty ? null : text;
      setState(() {
        _isCancelButtonVisible = text != null ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          _searchField(),
          _cancelButton(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Expanded(
      child: SearchBar(
        controller: widget.textEditingController,
        constraints: const BoxConstraints(minHeight: 40),
        elevation: MaterialStateProperty.all(0.0),
        hintText: S.of(context).searchFieldPlaceholder,
        hintStyle: MaterialStateProperty.all(
          const TextStyle(
            fontFamily: FontFamily.plusJakartaSans,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: ColorConstants.heather,
          ),
        ),
        side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const BorderSide(
              color: ColorConstants.borderGold,
              width: 2,
            );
          }
          return null; // Defer to default value on the theme or widget.
        }),
        leading: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.surface),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }

  Widget _cancelButton() {
    return Visibility(
      child: TextButton(
        onPressed: () {
          setState(() {
            widget.textEditingController.text = '';
            _isCancelButtonVisible = false;
            widget.pullToRefreshCallback();
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerRight,
        ),
        child: Text(
          S.of(context).searchFieldCancelButtonTitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorConstants.cancelButtonGrey,
              ),
        ),
      ),
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      visible: _isCancelButtonVisible,
    );
  }
}

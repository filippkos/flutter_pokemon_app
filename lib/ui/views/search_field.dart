import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

class SearchField extends StatefulWidget {

  final TextEditingController textEditingController;
  bool isCancelButtonVisible = false;
  final VoidCallback pullToRefreshCallback;
  final Stream<bool> stream;
  StreamController<bool> _searchBarController = StreamController<bool>();
  
  SearchField({super.key, required this.pullToRefreshCallback, required this.textEditingController, required this.stream});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              controller: widget.textEditingController,
              constraints: const BoxConstraints(minHeight: 40),
              elevation: MaterialStateProperty.all(0.0),
              hintText: 'Pokemon name...',
              hintStyle: MaterialStateProperty.all(const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: ColorConstants.heather)),
              side: MaterialStateBorderSide.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) {
                  return const BorderSide(
                      color: ColorConstants.borderGold, width: 2);
                }
                return null; // Defer to default value on the theme or widget.
              }),
              leading: Icon(
                Icons.search,
                color: ColorConstants.abbey,
              ),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(255, 255, 255, 1)),
              shadowColor:
                  MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          Visibility(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.textEditingController.text = '';
                      widget.isCancelButtonVisible = false;
                      widget.pullToRefreshCallback();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: ColorConstants.cancelButtonGrey,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                    ),
                  ),
                )
              ],
            ),
            maintainSize: false, 
            maintainAnimation: true,
            maintainState: true,
            visible: widget.isCancelButtonVisible, 
          )
        ],
      ),
    );
  }

   @override
  void initState() {
    super.initState();
    
      
  
    widget.stream.listen((isVisible) {
      setState(() {
      widget.isCancelButtonVisible = isVisible;
        });
    });
  }
}
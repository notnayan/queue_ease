import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/data/location.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class HomeDropDownMenu extends StatefulWidget {
  final void Function(Location?) onChanged;
  const HomeDropDownMenu({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<HomeDropDownMenu> createState() => _HomeDropDownMenuState();
}

class _HomeDropDownMenuState extends State<HomeDropDownMenu> {
  _HomeDropDownMenuState() {
    _selectedVal = location[0];
  }
  Location? _selectedVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          value: _selectedVal,
          items: location
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.destination),
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedVal = val;
            });
            widget.onChanged(val);
          },
          decoration: const InputDecoration(
            labelText: "Destination",
            prefixIcon: Icon(
              CupertinoIcons.building_2_fill,
              color: QEColors.white,
            ),
          ),
        ),
        const SizedBox(height: QESizes.spaceBtwInputFields),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Rs ${_selectedVal?.price}",
            prefixIcon: const Icon(CupertinoIcons.money_dollar),
          ),
          enabled: false,
        ),
      ],
    );
  }
}

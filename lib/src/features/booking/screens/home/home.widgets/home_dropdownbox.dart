import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';

class HomeDropDownMenu extends StatefulWidget {
  const HomeDropDownMenu({Key? key}) : super(key: key);

  @override
  State<HomeDropDownMenu> createState() => _HomeDropDownMenuState();
}

class _HomeDropDownMenuState extends State<HomeDropDownMenu> {
  _HomeDropDownMenuState() {
    _selectedVal = _officeLocations[0];
  }
  final _officeLocations = ["Chabahil", "Ekantakuna", "Radhe Radhe"];
  String? _selectedVal = "";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedVal,
      items: _officeLocations
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          _selectedVal = val as String;
        });
      },
      decoration: const InputDecoration(
        labelText: "Destination",
        prefixIcon: Icon(CupertinoIcons.building_2_fill, color: QEColors.white,),
      ),
    );
  }
}

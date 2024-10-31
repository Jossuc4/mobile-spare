import 'package:flutter/material.dart';

class FilterButtons extends StatefulWidget {
  final Function updateFilter;

  const FilterButtons({super.key, required this.updateFilter});

  @override
  _FilterButtonsState createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  String _selectedFilter = 'All';

  void _updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    widget.updateFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilterButton(
            'All', _selectedFilter == 'All', () => _updateFilter('All')),
        FilterButton('On', _selectedFilter == 'On', () => _updateFilter('On')),
        FilterButton(
            'Off', _selectedFilter == 'Off', () => _updateFilter('Off')),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton(this.label, this.isSelected, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            isSelected ? Colors.yellow : Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.black : Colors.grey[400]),
      ),
    );
  }
}

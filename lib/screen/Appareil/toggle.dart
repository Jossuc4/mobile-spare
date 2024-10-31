import 'package:flutter/material.dart';

class DeviceToggle extends StatefulWidget {
  final String deviceName;
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const DeviceToggle({
    super.key,
    required this.deviceName,
    required this.isOn,
    required this.onToggle,
  });

  @override
  State<DeviceToggle> createState() => _DeviceToggleState();
}

class _DeviceToggleState extends State<DeviceToggle> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.isOn;
  }

  @override
  void didUpdateWidget(covariant DeviceToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update _isOn if the isOn property changes
    if (oldWidget.isOn != widget.isOn) {
      setState(() {
        _isOn = widget.isOn;
      });
    }
  }

  void _toggleSwitch() {
    setState(() {
      _isOn = !_isOn; // Change the toggle state
    });
    widget.onToggle(_isOn); // Call the callback with the new state
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: _isOn ? Colors.yellow.withOpacity(0.6) : Colors.black12,
              offset: const Offset(2, 4),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isOn ? "On" : "Off",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: _toggleSwitch,
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: _isOn ? Colors.yellow : Colors.grey[500],
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          alignment: _isOn
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 3.5, right: 3.5),
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              constraints: BoxConstraints(
                maxHeight: 70,
                maxWidth: 70,
              ),
              child: Image.asset(
                _isOn
                    ? 'assets/Images/light.png'
                    : 'assets/Images/lightoff.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.deviceName,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

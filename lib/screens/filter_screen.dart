// import 'package:flutter/material.dart';
// import 'package:flutter_intershala_application/widgets/custom_text_field.dart';

// class FilterScreen extends StatefulWidget {
//   final String? initialProfile;
//   final String? initialCity;
//   final String? initialDuration;
//   final Function(String?, String?, String?) onApplyFilters;
//   final Function onClearFilters;

//   FilterScreen({
//     this.initialProfile,
//     this.initialCity,
//     this.initialDuration,
//     required this.onApplyFilters,
//     required this.onClearFilters,
//   });

//   @override
//   _FilterScreenState createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   late TextEditingController profileController;
//   late TextEditingController cityController;
//   String? selectedDuration;

//   @override
//   void initState() {
//     super.initState();
//     profileController = TextEditingController(text: widget.initialProfile);
//     cityController = TextEditingController(text: widget.initialCity);
//     selectedDuration = widget.initialDuration;
//   }

//   @override
//   void dispose() {
//     profileController.dispose();
//     cityController.dispose();
//     super.dispose();
//   }

//   void _clearFilters() {
//     profileController.clear();
//     cityController.clear();
//     setState(() {
//       selectedDuration = null;
//     });
//     widget.onClearFilters();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filter Internships'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomTextField(
//               labelText: "Profile",
//               controller: profileController,
//             ),
//             const SizedBox(height: 15),
//             CustomTextField(
//               labelText: "City",
//               controller: cityController,
//             ),
//             const SizedBox(height: 15),
//             DropdownButtonFormField<String>(
//               value: selectedDuration,
//               items: List.generate(6, (index) => (index + 1).toString())
//                   .map((duration) => DropdownMenuItem(
//                         value: duration,
//                         child: Text('$duration months'),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedDuration = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Duration (in months)',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     _clearFilters();
//                     // Do not pop the screen
//                   },
//                   child: const Text(
//                     'Clear Filters',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     widget.onApplyFilters(
//                       profileController.text,
//                       cityController.text,
//                       selectedDuration,
//                     );
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'Apply Filters',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_intershala_application/widgets/custom_text_field.dart';

class FilterScreen extends StatefulWidget {
  final String? initialProfile;
  final String? initialCity;
  final String? initialDuration;
  final Function(String?, String?, String?) onApplyFilters;
  final Function onClearFilters;

  FilterScreen({
    this.initialProfile,
    this.initialCity,
    this.initialDuration,
    required this.onApplyFilters,
    required this.onClearFilters,
  });

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController profileController;
  late TextEditingController cityController;
  String? selectedDuration;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    profileController = TextEditingController(text: widget.initialProfile);
    cityController = TextEditingController(text: widget.initialCity);
    selectedDuration = widget.initialDuration;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    profileController.dispose();
    cityController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    profileController.clear();
    cityController.clear();
    setState(() {
      selectedDuration = null;
    });
    widget.onClearFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Internships'),
        backgroundColor: Colors.teal,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: "Profile",
                controller: profileController,
                //  icon: Icons.person,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                labelText: "City",
                controller: cityController,
                // icon: Icons.location_city,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedDuration,
                items: List.generate(6, (index) => (index + 1).toString())
                    .map((duration) => DropdownMenuItem(
                          value: duration,
                          child: Text('$duration months'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDuration = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Duration (in months)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _clearFilters();
                      // Do not pop the screen
                    },
                    child: const Text(
                      'Clear Filters',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      widget.onApplyFilters(
                        profileController.text,
                        cityController.text,
                        selectedDuration,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

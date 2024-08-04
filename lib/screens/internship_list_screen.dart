
import 'package:flutter/material.dart';

import 'package:flutter_intershala_application/models/intership.dart';
import 'package:flutter_intershala_application/screens/filter_screen.dart';
import 'package:flutter_intershala_application/services/internship_service.dart';

class InternshipListScreen extends StatefulWidget {
  static const routeName = '/home'; // Add a route name

  @override
  _InternshipListScreenState createState() => _InternshipListScreenState();
}

class _InternshipListScreenState extends State<InternshipListScreen> {
  String? selectedProfile;
  String? selectedCity;
  String? selectedDuration;
  String searchQuery = '';
  bool isSearching = false;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        searchQuery =
            searchController.text.toLowerCase(); // Convert to lower case
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      selectedProfile = null;
      selectedCity = null;
      selectedDuration = null;
      searchQuery = '';
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : const Text('Internships'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name !=
                  InternshipListScreen.routeName) {
                _resetFilters();
                Navigator.of(context)
                    .pushReplacementNamed(InternshipListScreen.routeName);
              }
            },
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  searchQuery = ''; // Clear the search query when closing
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FilterScreen(
                    initialProfile: selectedProfile,
                    initialCity: selectedCity,
                    initialDuration: selectedDuration,
                    onApplyFilters: (profile, city, duration) {
                      setState(() {
                        selectedProfile = profile;
                        selectedCity = city;
                        selectedDuration = duration;
                      });
                    },
                    onClearFilters: () {
                      setState(() {
                        selectedProfile = null;
                        selectedCity = null;
                        selectedDuration = null;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Internship>>(
        future: fetchInternships(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No internships found'));
          } else {
            final internships = snapshot.data!;
            final filteredInternships = internships.where((internship) {
              final lowerCaseSearchQuery = searchQuery.toLowerCase();
              final lowerCaseTitle = internship.title.toLowerCase();

              final matchProfile = selectedProfile == null ||
                  lowerCaseTitle.contains(selectedProfile!.toLowerCase());

              final matchCity = selectedCity == null ||
                  selectedCity!.isEmpty ||
                  internship.locationNames.any((location) {
                    final trimmedLocation = location.toLowerCase().trim();
                    final trimmedCity = selectedCity!.toLowerCase().trim();
                    final cityMatch = trimmedLocation == trimmedCity;

                    return cityMatch;
                  });

              final matchDuration = selectedDuration == null ||
                  internship.duration
                      .toLowerCase()
                      .contains(selectedDuration!.toLowerCase());

              final matchSearchQuery = searchQuery.isEmpty ||
                  lowerCaseTitle.contains(lowerCaseSearchQuery);

              return matchProfile &&
                  matchCity &&
                  matchDuration &&
                  matchSearchQuery;
            }).toList();

            if (filteredInternships.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No matching internships found.'),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredInternships.length,
              itemBuilder: (context, index) {
                final internship = filteredInternships[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4), // Shadow position
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            internship.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (internship.locationNames.isNotEmpty)
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 20, color: Colors.black),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    internship.locationNames.join(', '),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.play_arrow,
                                  size: 20, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                internship.startDate,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 22),
                              const Icon(Icons.calendar_today,
                                  size: 20, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                internship.duration,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.money,
                                  size: 20, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                internship.stipend,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 20, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                'Posted: ${internship.datePosted}', // Display the new field
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement Apply functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Apply',
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
              },
            );
          }
        },
      ),
    );
  }
}

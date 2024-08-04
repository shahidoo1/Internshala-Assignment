class Internship {
  final int id;
  final String title;
  final String companyName;
  final String stipend;
  final String duration;
  final String startDate;
  final List<String> locationNames;
  final String logoUrl;
  final String datePosted;

  Internship({
    required this.id,
    required this.title,
    required this.companyName,
    required this.stipend,
    required this.duration,
    required this.startDate,
    required this.locationNames,
    required this.logoUrl,
    required this.datePosted,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      stipend: json['stipend']?['salary'] ?? '',
      duration: json['duration'] ?? '',
      startDate: json['start_date'] ?? '',
      locationNames: List<String>.from(json['location_names'] ?? []),
      logoUrl: json['company_logo'] ?? '',
      datePosted: json['posted_on'] ?? '',
    );
  }
}

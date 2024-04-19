import 'package:flutter/material.dart';

class AgencyProfileScreen extends StatefulWidget {
  @override
  _AgencyProfileScreenState createState() => _AgencyProfileScreenState();
}

class _AgencyProfileScreenState extends State<AgencyProfileScreen> {
  // ... variables representing agency data go here ...

  int agencyId = 1;// ... variables representing agency data go here ...
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAgencyIdFromArgs();
  }

  void _getAgencyIdFromArgs()  {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args.containsKey('agencyId')) {
      setState(() {
        agencyId = args['agencyId'];
      });
    }}
  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    return Scaffold(
      appBar: AppBar(
        title: Text("Agency Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(agencyId),
            SizedBox(height: 20),
            _buildProfileDetails(agencyId),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(int agencyId) {
    return Center(
        child: Column(
            children: [
            Text("Agency Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        if (agencyId == 1)
    Text("Manipal Police Station", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
     if (agencyId == 2)
    Text("Kasturba Medical College", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ],
    ),
    );
  }


  Widget _buildProfileDetails(int agencyId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact Information:"),
        if (agencyId == 1)
          Text("08202570328"),
        if (agencyId == 2)
          Text("09243777733"),

        Text("Address:"),
        if (agencyId == 1)
          Text("Madhav Nagar, Eshwar Nagar, Manipal, Karnataka 576104"),
        if (agencyId == 2)
          Text("Tiger Circle Road, Madhav Nagar, Eshwar Nagar, Manipal, Karnataka 576104"),
        // ... Add more details as needed ...
      ],
    );
  }
}

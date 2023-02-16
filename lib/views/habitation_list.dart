import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:td_flutter/views/share/habitation_features_widget.dart';

import '../models/habitation.dart';
import '../services/habitation_service.dart';
import 'habitation_details.dart';
import 'share/habitation_option.dart';

class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late List<Habitation> _habitations;
  final bool isHouseList;
  HabitationList(this.isHouseList, {Key? key}) : super(key: key) {
    _habitations =
        isHouseList ? service.getMaisons() : service.getAppartements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des ${isHouseList ? "maisons" : "appartements"}"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _habitations.length,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          itemExtent: 285,
        ),
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HabitationDetails(habitation)),
            );
          },
          child: Card(child: _buildDetails(habitation))),
    );
  }

  _buildDetails(Habitation habitation) {
    var format = NumberFormat("### €");
    return Container(
        child: Column(
      children: [
        Container(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              "assets/images/locations/${habitation.image}",
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(habitation.libelle),
                subtitle: Text(habitation.adresse),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(format.format(habitation.prixmois),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 22)),
            )
          ],
        ),
        HabitationFeaturesWidget(habitation),
      ],
    ));
  }
}

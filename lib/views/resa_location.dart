import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:td_flutter/models/habitation.dart';

import '../share/location_text_style.dart';
import 'share/habitation_features_widget.dart';

class ResaLocation extends StatefulWidget {
  final Habitation _habitation;
  const ResaLocation(this._habitation, {Key? key}) : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];

  var format = NumberFormat("### €");

  @override
  Widget build(BuildContext context) {
    _loadOptionPayantes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(prix: widget._habitation.prixmois),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildResume() {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Expanded(
        child: ListTile(
          leading: const Icon(Icons.home),
          title: Text(widget._habitation.libelle),
          subtitle: Text(widget._habitation.adresse),
        ),
      ),
    );
  }

  _buildDates() {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(dateDebut)),
                    ],
                  )),
                  const CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.calendar_today),
                  Text(DateFormat('dd/MM/yyyy').format(dateFin))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildNbPersonnes() {
    return Container(
        margin: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Nombre de personnes ',
                style: LocationTextStyle.boldTextStyle,
              ),
            ),
            DropdownButton(
              value: nbPersonnes,
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('1'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('2'),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text('3'),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text('4'),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  nbPersonnes = value!;
                });
              },
            ),
          ],
        ));
  }

  _loadOptionPayantes() {
    if (optionPayanteChecks.isEmpty) {
      for (var element in widget._habitation.optionsPayantes) {
        optionPayanteChecks.add(OptionPayanteCheck(
            element.id, element.libelle, false,
            description: element.description, prix: element.prix));
      }
    }
  }

  _buildOptionsPayantes(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
            spacing: 2.0,
            children: Iterable.generate(
                optionPayanteChecks.length,
                (i) => Expanded(
                      child: CheckboxListTile(
                        value: optionPayanteChecks[i].checked,
                        selected: optionPayanteChecks[i].checked,
                        onChanged: (value) => setState(() {
                          optionPayanteChecks[i].checked = value!;
                        }),
                        secondary: const Icon(Icons.shopping_cart),
                        title: Text(optionPayanteChecks[i].libelle,
                            style: LocationTextStyle.boldTextStyle),
                        subtitle: Text(optionPayanteChecks[i].description,
                            style: LocationTextStyle.regularGreyTextStyle),
                      ),
                    )).toList()));
  }

  _buildRentButton() {
    return Container(
        margin: const EdgeInsets.all(4.0),
        height: 40,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            child: const Text('Louer')));
  }

  TotalWidget({required double prix}) {
    double total = prix;
    for (var element in optionPayanteChecks) {
      if (element.checked) {
        total += element.prix;
      }
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      // augmente l'espace entre le bord et le texte
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TOTAL',
            style: LocationTextStyle.boldTextStyle,
          ),
          Text(
            format.format(total),
          ),
        ],
      ),
    );
  }
}

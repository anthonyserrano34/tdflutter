import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:td_flutter/views/share/habitation_features_widget.dart';
import 'package:td_flutter/views/share/habitation_option.dart';
import '../models/habitation.dart';
import '../share/location_style.dart';
import '../share/location_text_style.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              "assets/images/locations/${widget._habitation.image}",
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          _buildItems(),
          _buildOptionsPayantes(),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildItems() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                style: LocationTextStyle.subtitleBoldTextStyle,
                'Inclus',
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    height: 36,
                    thickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
              spacing: 2.0,
              children: Iterable.generate(
                  widget._habitation.options.length,
                  (i) => Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        margin: const EdgeInsets.all(2.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget._habitation.options[i].libelle,
                                style: LocationTextStyle.boldTextStyle),
                            Text(widget._habitation.options[i].description,
                                style: LocationTextStyle.regularGreyTextStyle),
                          ],
                        ),
                      )).toList())
        ],
      ),
    );
  }

  _buildOptionsPayantes() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Text(
                style: LocationTextStyle.subtitleBoldTextStyle,
                'Options',
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    height: 36,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
              spacing: 2.0,
              children: Iterable.generate(
                  widget._habitation.optionsPayantes.length,
                  (i) => Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                        margin: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            Text(widget._habitation.optionsPayantes[i].libelle,
                                style: LocationTextStyle.boldTextStyle),
                            Text(
                                '${widget._habitation.optionsPayantes[i].prix.toString()} €',
                                style: LocationTextStyle.regularGreyTextStyle),
                          ],
                        ),
                      )).toList())
        ]));
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            format.format(widget._habitation.prixmois),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              print('Louer habitation');
            },
            child: Text('Louer'),
          ),
        ),
      ]),
    );
  }
}

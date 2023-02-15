import 'package:td_flutter/models/typehabitat.dart';

class Habitation {
  int id;
  TypeHabitat typeHabitat;
  String image;
  String libelle;
  String adresse;
  int chambres;
  int superficie;
  int nbpersonnes;
  double prixmois;

  Habitation(this.id, this.typeHabitat, this.image, this.libelle, this.adresse,
      this.nbpersonnes, this.chambres, this.superficie, this.prixmois);
}

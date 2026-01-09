import 'package:lpmi_manage/model/offer.dart';

List<Offer> myOffers = [
  Offer(
    id: 1,
    title: 'Stage développeur Flutter',
    description: 'Participation au développement d’applications mobiles Flutter.',
    time: 6,
    startDate: DateTime(2026, 2, 23),
    lieu: 'Dijon',
  ),
  Offer(
    id: 2,
    title: 'Stage développeur Web',
    description: 'Développement de sites web en React et Node.js.',
    time: 4,
    startDate: DateTime(2026, 3, 1),
    lieu: 'Lyon',
  ),
  Offer(
    id: 3,
    title: 'Stage UX / UI Designer',
    description: 'Conception de maquettes et amélioration de l’expérience utilisateur.',
    time: 5,
    startDate: DateTime(2026, 4, 15),
    lieu: 'Paris',
  ),
];

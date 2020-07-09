import 'package:meta/meta.dart';

class Slide {
  final String imgUrl;
  final String title;
  final String description;

  Slide({
    @required this.imgUrl,
    @required this.title,
    @required this.description,
  })  : assert(imgUrl != null),
        assert(title != null);
}

final slideList = [
  Slide(
    imgUrl: 'assets/images/logo.png',
    title: 'This is our Title 1',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam harum laudantium libero pariatur soluta!'
        ' Ad aperiam commodi dicta eaque facilis laboriosam mollitia numquam officiis quae quibusdam?',
  ),
  Slide(
    imgUrl: 'assets/images/logo.png',
    title: 'This is our Title 2',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam harum laudantium libero pariatur soluta!'
        ' Ad aperiam commodi dicta eaque facilis laboriosam mollitia numquam officiis quae quibusdam?',
  ),
  Slide(
    imgUrl: 'assets/images/logo.png',
    title: 'This is our Title 3',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam harum laudantium libero pariatur soluta!'
        ' Ad aperiam commodi dicta eaque facilis laboriosam mollitia numquam officiis quae quibusdam?',
  ),
];

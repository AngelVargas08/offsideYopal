class Cancha {
  final int id, price;
  final String title, description, image, horario, email;
  final List<String> imgList;

  Cancha({required this.id, required this.price, required this.title, 
  required this.description, required this.image, required this.horario, 
  required this.imgList, required this.email});
}




// lista de canchas
List<Cancha> canchas = [
  Cancha(
    id: 1,
    price: 1,
    title: "Cancha sintética Maracana",
    image: "assets/images/user/images/Item_1.png",
    horario: "07:00 a. m - 10:00 p. m",
    email: "canchamaracana@gmail.com",
    imgList: [
      'https://i.imgur.com/qJJEQ7k.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
      'https://i.imgur.com/HgoYrPz.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 2,
    price: 2,
    title: "Cancha sintética Minuto 90",
    image: "assets/images/user/images/Item_2.png",
    horario: "09:00 a. m - 10:00 p. m",
    email: "minuto90@gmail.com",
    imgList: [
      'https://i.imgur.com/e6ToQDY.jpg',
      'https://i.imgur.com/GlXjGyq.jpg',
      'https://i.imgur.com/lIrVIEX.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 3,
    price: 3,
    title: "Cancha sintética Soccer Five",
    image: "assets/images/user/images/Item_3.png",
    horario: "10:00 a. m - 10:00 p. m",
    email: "soccerfive@gmail.com",
    imgList: [
      'https://i.imgur.com/bWPQIXq.jpg',
      'https://i.imgur.com/LYvYPbs.jpg',
      'https://i.imgur.com/rFIINBN.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 4,
    price: 4,
    title: "Cancha sintética El alcaravan",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "elalcaravan@gmail.com",
    imgList: [
      'https://i.imgur.com/i8ClZ1d.jpg',
      'https://i.imgur.com/qeurlDL.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 5,
    price: 5,
    title: "Cancha sintética El corozo",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "elcorozo@gmail.com",
    imgList: [
      'https://i.imgur.com/3x5yGgU.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 6,
    price: 6,
    title: "Cancha sintética Fair play",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "FairPlay@gmail.com",
    imgList: [
      'https://i.imgur.com/BrlYO26.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 7,
    price: 7,
    title: "Cancha sintética Copa mundo",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "Copamundo@gmail.com",
    imgList: [
      'https://i.imgur.com/rMNPkIq.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 8,
    price: 8,
    title: "Cancha sintética Club gol la 14",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "Clubgolla14@gmail.com",
    imgList: [
      'https://i.imgur.com/xokIPi4.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 9,
    price: 9,
    title: "Cancha sintética Monumental 3",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "Monumental3@gmail.com",
    imgList: [
      'https://i.imgur.com/4aMa8rU.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 10,
    price: 10,
    title: "Cancha sintética El amanacedero",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "El amanacedero@gmail.com",
    imgList: [
      'https://i.imgur.com/55ShJXU.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 11,
    price: 11,
    title: "Cancha sintética La campiña",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "lacampina@gmail.com",
    imgList: [
      'https://i.imgur.com/stRBWyT.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 12,
    price: 12,
    title: "Cancha sintética Gol de oro",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "lacampina@gmail.com",
    imgList: [
      'https://i.imgur.com/HgoYrPz.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  Cancha(
    id: 13,
    price: 13,
    title: "Cancha sintética Canchas sinteticas el Hobo",
    image: "assets/images/user/images/Item_2.jpg",
    horario: "10:00 a. m - 10:00 p. m",
    email: "elhobo@gmail.com",
    imgList: [
      'https://i.imgur.com/FpR8KNq.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  
  
];

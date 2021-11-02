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
      'https://i.imgur.com/x3UjLl9.jpg',
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
      'https://i.imgur.com/EgHwWS5.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/HgoYrPz.jpg',
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
      'https://i.imgur.com/HgoYrPz.jpg',
      'https://i.imgur.com/x3UjLl9.jpg',
      'https://i.imgur.com/EgHwWS5.jpg',
    ],
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
  ),
  
];

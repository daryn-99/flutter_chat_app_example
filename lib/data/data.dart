import 'package:chat/models/post_models.dart';
import 'package:chat/models/user_model.dart';

final User currentUser = User(
  name: 'Nelson Acosta',
  imageUrl:
      'https://www.recoroatan.com/wp-content/uploads/2021/05/DJI_0980-1.jpg',
);

final List<User> onlineUsers = [
  User(
    name: 'Luis Padilla',
    imageUrl:
        'https://scontent.fsap1-1.fna.fbcdn.net/v/t1.6435-9/87086754_2612398355475359_7572949571110699008_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=973b4a&_nc_ohc=bIq8YnhugRIAX-gZdfr&_nc_ht=scontent.fsap1-1.fna&oh=8e2572add2f5c781484fa9a687231ad4&oe=60E1621C',
  ),
  User(
    name: 'Mireya Aguilera',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'Benito Martinez',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    name: 'Ana Nazar',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    name: 'Ed Morris',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    name: 'Jenny Barahona',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'Paul Pinnock',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      name: 'Elizabeth Wong',
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    name: 'James Lathrop',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    name: 'Jessie Samson',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'David Brooks',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'Jane Doe',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'Matthew Hinkle',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    name: 'Amy Smith',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    name: 'Ed Morris',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    name: 'Carolyn Duncan',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    name: 'Paul Pinnock',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      name: 'Elizabeth Wong',
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    name: 'James Lathrop',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    name: 'Jessie Samson',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Equipo de distribución',
    timeAgo: '58m',
    imageUrl:
        'https://www.recoroatan.com/wp-content/uploads/2021/05/JLP_7205.jpg',
    likes: 102,
    comments: 84,
  ),
  Post(
    user: onlineUsers[5],
    caption:
        'Please enjoy this placeholder text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '3hr',
    imageUrl: null,
    likes: 12,
    comments: 9,
  ),
  Post(
    user: onlineUsers[4],
    caption: 'These are the typical pinchos.',
    timeAgo: '8hr',
    imageUrl:
        'https://www.recoroatan.com/wp-content/uploads/2021/05/DSC0295.jpg',
    likes: 24,
    comments: 11,
  ),
  Post(
    user: onlineUsers[3],
    caption: 'Adventure 🏔',
    timeAgo: '15hr',
    imageUrl:
        'https://www.recoroatan.com/wp-content/uploads/2021/05/DJI_0982-1.jpg',
    likes: 72,
    comments: 43,
  ),
  Post(
    user: onlineUsers[0],
    caption:
        'Programa de Despeje | Scheduled Outage Interrupción de energía eléctrica programada para el día jueves 24/06/2021 desde las 10:00 AM - 12:00 PM afectando las siguientes zonas: Bo. Los Fuertes, Monte Col. El Paraiso, Col. Monte Carmelo, Col. Santa María, Dixon Cove, Sector Los Bomberos, Spring Garden # 2, Aeropuerto Roatan, Spring Garden #1, Bo. Punta de Coxen Hole, Bo. Palos Altos, Todo el Centro de Coxen Hole, Hospital Roatan, Bo. ManTrapp, Franco Flat, Bo. Willie Warren, Todo el sector de Flowers Bay, Pensacola, Gravel Bay Bo. El Ticket, Franco Flat, Policía Nacional, Roatan 1, Col. Los Maestros. El despeje se realizará para instalación de postes bajo la línea en la salida de los circuitos ubicados frente a plantel de RECO en carretera principal en Col. Monte Placentero. ',
    timeAgo: '23 de junio a las 14:06',
    imageUrl: null,
    likes: 40,
    comments: 37,
  ),
  Post(
    user: onlineUsers[9],
    caption:
        'En Reco actualizamos nuestras plataformas de pago para que nuestros clientes cuenten con opciones accesibles para gestionar el pago de sus facturas de energia eléctrica por medio de los diferentes servicios y plataformas electrónicas, conoce cada una de ellas.',
    timeAgo: '1d',
    imageUrl:
        'https://scontent.fsap1-2.fna.fbcdn.net/v/t1.6435-9/198733143_3874359489279233_9209978753542441681_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=973b4a&_nc_ohc=_u25LcDTV5MAX-EVyge&_nc_ht=scontent.fsap1-2.fna&oh=fb9106d7f6308672ad9d6b4cc394a48d&oe=60E17C5A',
    likes: 23,
    comments: 21,
  )
];

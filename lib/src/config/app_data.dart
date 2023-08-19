import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/models/user/user_model.dart';

ProductItemModel apple = ProductItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  picture: 'assets/fruits/apple.png',
  title: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ProductItemModel grape = ProductItemModel(
  picture: 'assets/fruits/grape.png',
  title: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ProductItemModel guava = ProductItemModel(
  picture: 'assets/fruits/guava.png',
  title: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ProductItemModel kiwi = ProductItemModel(
  picture: 'assets/fruits/kiwi.png',
  title: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ProductItemModel mango = ProductItemModel(
  picture: 'assets/fruits/mango.png',
  title: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ProductItemModel papaya = ProductItemModel(
  picture: 'assets/fruits/papaya.png',
  title: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ProductItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais'
];

List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 2),
  CartItemModel(item: mango, quantity: 2),
  CartItemModel(item: guava, quantity: 2),
];

UserModel user = UserModel(
    name: 'Fulano',
    email: 'fulano@email.com',
    phone: '(99) 9999-9999',
    cpf: '000.000.00-00',
    password: '');

List<OrderModel> orders = [
  // Pedido 01
  OrderModel(
    id: 'asd5mfki8jmsd3',
    createdDateTime: DateTime.parse('2021-06-08 10:00:10.458'),
    overdueDateTime: DateTime.parse('2023-08-08 11:00:10.458'),
    items: [
      CartItemModel(item: apple, quantity: 5),
      CartItemModel(item: mango, quantity: 2),
    ],
    status: 'pending_payment',
    copyAndPaste: 'qwsq12sdf4h6',
    total: 27.50,
  ),

  // Pedido 02
  OrderModel(
    id: 'asd5mfgj4hk7',
    createdDateTime: DateTime.parse('2023-08-08 10:00:10.458'),
    overdueDateTime: DateTime.parse('2023-08-08 11:00:10.458'),
    items: [
      CartItemModel(item: guava, quantity: 2),
    ],
    status: 'delivered',
    copyAndPaste: 'qwsq1ad9s2h6ay',
    total: 23.0,
  )
];

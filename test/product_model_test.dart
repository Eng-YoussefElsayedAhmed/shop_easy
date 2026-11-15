import 'package:flutter_test/flutter_test.dart';
import 'package:shop_easy/models/product.dart';

void main() {
  group('Product JSON Parsing from Live API', () {
    test('parses exact live API JSON sample with mixed types and URLs', () {
      final sampleApiJson = [
        {
          "id": 1,
          "title": "iphone",
          "price": 50000,
          "description": "very expensive",
          "imgUrl":
              "[https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlp_4-bDtt12hdJAKC7DDo5ubySY_Oj-1ulA&s](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlp_4-bDtt12hdJAKC7DDo5ubySY_Oj-1ulA&s)"
        },
        {
          "id": 2,
          "title": "Wireless Noise-Canceling Headphones",
          "price": 299.99,
          "description":
              "Premium over-ear headphones with 30-hour battery life.",
          "imgUrl":
              "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSna2PaQLao22IK4nBbTJFWrjo9PcTauDnnhhXipeDbl1r50zGCe_5Pxfqp9j42UyH0PJwLBvxH3ziWP3_TOATJzRQgudLQrvri6q-GssAdigO8YMAn88g3_jJhlX6zS1Bv1Vw8ddM&usqp=CAc"
        },
        {
          "id": 3,
          "title": "Mechanical Gaming Keyboard",
          "price": 129.5,
          "description":
              "RGB backlit keys with tactile switches for pro gaming.",
          "imgUrl":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeUS50YVZ6wM9OMu07fITBQP5FcjUe5sa9nQ&s"
        },
        {
          "id": 4,
          "title": "Smart Fitness Tracker",
          "price": 79,
          "description": "Monitors heart rate, sleep patterns, and daily steps.",
          "imgUrl":
              "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQGjfdcfz931PBZI-d_Ou5wHRl8Ciz5fjyaYiveFe3lNNgZtk7C5iLY1XYuuuOFd-gfRmN4F01MYdoe955nG6XrtDnfkOlkz37zFjxAUeykRlJWs_iNsrRHV8C508cORUbxg0qR4nc&usqp=CAc"
        },
        {
          "id": 5,
          "title": "Ultra-Wide 4K Monitor",
          "price": 450,
          "description":
              "34-inch curved display perfect for multitasking and design.",
          "imgUrl":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjt_rLDTZUxwD4aVgDmnTnJiBMGkN7V0imXA&s"
        },
        {
          "id": 6,
          "title": "Portable Power Bank",
          "price": 45.99,
          "description": "20,000mAh capacity with fast charging support.",
          "imgUrl":
              "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQsld8ozcQNl45uM1vJJ8Gbnc3KosH9a9BzAy8kNOYwY1H9wt0gXTUvLgKmmuqVdV9rx6gN3-lcascrX3o7_D3wrPFdxxEzaYUa1-bAfP4XrK60nf5D7eAxuk81rMTA3sjTYfA7NiY&usqp=CAc"
        }
      ];

      final products = sampleApiJson.map((j) => Product.fromJson(j)).toList();

      expect(products.length, 6);

      // Check item 1 (int price, markdown URL)
      final p1 = products[0];
      expect(p1.id, '1');
      expect(p1.title, 'iphone');
      expect(p1.name, 'iphone');
      expect(p1.price, 50000.0);
      expect(p1.imgUrl.startsWith('https://'), isTrue);
      expect(p1.imgUrl.contains('['), isFalse);

      // Check item 2 (double price)
      final p2 = products[1];
      expect(p2.id, '2');
      expect(p2.title, 'Wireless Noise-Canceling Headphones');
      expect(p2.price, 299.99);

      // Check item 4 (int price 79)
      final p4 = products[3];
      expect(p4.id, '4');
      expect(p4.price, 79.0);
    });
  });
}

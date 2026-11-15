import '../models/product.dart';

/// Default products matching the live API schema (`https://192.168.21.240:5001/api/products`).
final List<Product> sampleProducts = [
  Product(
    id: '1',
    title: 'iphone',
    price: 50000.0,
    description: 'very expensive',
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlp_4-bDtt12hdJAKC7DDo5ubySY_Oj-1ulA&s',
    category: 'Electronics',
    oldPrice: 55000.0,
    rating: 4.8,
    reviews: 320,
    features: ['Super Retina Display', 'A16 Bionic', 'Pro Camera System', '5G Speed'],
    discountPercent: 9,
  ),
  Product(
    id: '2',
    title: 'Wireless Noise-Canceling Headphones',
    price: 299.99,
    description: 'Premium over-ear headphones with 30-hour battery life.',
    imgUrl:
        'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSna2PaQLao22IK4nBbTJFWrjo9PcTauDnnhhXipeDbl1r50zGCe_5Pxfqp9j42UyH0PJwLBvxH3ziWP3_TOATJzRQgudLQrvri6q-GssAdigO8YMAn88g3_jJhlX6zS1Bv1Vw8ddM&usqp=CAc',
    category: 'Electronics',
    oldPrice: 349.99,
    rating: 4.7,
    reviews: 215,
    features: ['Active Noise Cancel', '30h Battery Life', 'Comfort Fit', 'Bluetooth 5.3'],
    discountPercent: 14,
  ),
  Product(
    id: '3',
    title: 'Mechanical Gaming Keyboard',
    price: 129.5,
    description: 'RGB backlit keys with tactile switches for pro gaming.',
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeUS50YVZ6wM9OMu07fITBQP5FcjUe5sa9nQ&s',
    category: 'Electronics',
    oldPrice: 159.99,
    rating: 4.6,
    reviews: 178,
    features: ['Tactile Switches', 'Per-Key RGB', 'Anti-Ghosting', 'Detachable Cable'],
    discountPercent: 19,
  ),
  Product(
    id: '4',
    title: 'Smart Fitness Tracker',
    price: 79.0,
    description: 'Monitors heart rate, sleep patterns, and daily steps.',
    imgUrl:
        'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQGjfdcfz931PBZI-d_Ou5wHRl8Ciz5fjyaYiveFe3lNNgZtk7C5iLY1XYuuuOFd-gfRmN4F01MYdoe955nG6XrtDnfkOlkz37zFjxAUeykRlJWs_iNsrRHV8C508cORUbxg0qR4nc&usqp=CAc',
    category: 'Electronics',
    oldPrice: 99.99,
    rating: 4.4,
    reviews: 142,
    features: ['Heart Rate Monitor', 'Sleep Tracking', 'IP68 Waterproof', '7-Day Battery'],
    discountPercent: 21,
  ),
  Product(
    id: '5',
    title: 'Ultra-Wide 4K Monitor',
    price: 450.0,
    description: '34-inch curved display perfect for multitasking and design.',
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjt_rLDTZUxwD4aVgDmnTnJiBMGkN7V0imXA&s',
    category: 'Electronics',
    oldPrice: 520.0,
    rating: 4.9,
    reviews: 89,
    features: ['34" Curved Display', '4K Resolution', '144Hz Refresh', 'HDR10 Support'],
    discountPercent: 13,
  ),
  Product(
    id: '6',
    title: 'Portable Power Bank',
    price: 45.99,
    description: '20,000mAh capacity with fast charging support.',
    imgUrl:
        'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQsld8ozcQNl45uM1vJJ8Gbnc3KosH9a9BzAy8kNOYwY1H9wt0gXTUvLgKmmuqVdV9rx6gN3-lcascrX3o7_D3wrPFdxxEzaYUa1-bAfP4XrK60nf5D7eAxuk81rMTA3sjTYfA7NiY&usqp=CAc',
    category: 'Electronics',
    oldPrice: 59.99,
    rating: 4.5,
    reviews: 264,
    features: ['20,000mAh Capacity', '22.5W Fast Charge', 'Dual USB-A & USB-C', 'LED Display'],
    discountPercent: 23,
  ),
];

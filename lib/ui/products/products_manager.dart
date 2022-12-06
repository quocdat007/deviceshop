import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductsManager with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'MacBook M1 Pro 2021',
      description:
          'Laptop MacBook Pro 14 M1 Pro 2021 8-core CPU/16GB/512GB/14-core GPU (MKGR3SA/A)',
      price: 1999.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/44/253581/apple-macbook-pro-14-m1-pro-2021-1.jpg',
      typeP: 'laptop',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'MacBook Pro M2 2022',
      description:
          'Laptop Apple MacBook Pro M2 2022 8GB/256GB/10-core GPU (MNEH3SA/A)',
      price: 1299.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/44/282828/apple-macbook-pro-13-inch-m2-2022-1-1.jpg',
      typeP: 'laptop',
      isFavorite: false,
    ),
    Product(
      id: 'p3',
      title: 'Samsung Galaxy Z Fold4',
      description: 'Điện thoại Samsung Galaxy Z Fold4 256GB ',
      price: 1799.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/42/250625/samsung-galaxy-z-fold4-kem-256gb-600x600.jpg',
      typeP: 'phone',
      isFavorite: false,
    ),
    Product(
      id: 'p4',
      title: 'Samsung Galaxy S22 Ultra',
      description: 'Điện thoại Samsung Galaxy S22 Ultra 5G 256B',
      price: 1099.99,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/42/235838/Galaxy-S22-Ultra-Burgundy-600x600.jpg',
      typeP: 'phone',
      isFavorite: true,
    ),
    Product(
      id: 'p5',
      title: 'iPhone 14 Pro Max',
      description: 'Điện thoại iPhone 14 Pro Max 1TB',
      price: 1599.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/42/251192/iphone-14-pro-max-vang-thumb-600x600.jpg',
      typeP: 'phone',
      isFavorite: false,
    ),
    Product(
      id: 'p6',
      title: ' iPhone 14',
      description: 'Điện thoại iPhone 14 512GB',
      price: 799.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/42/240259/iPhone-14-thumb-tim-1-600x600.jpg',
      typeP: 'phone',
      isFavorite: false,
    ),
    Product(
      id: 'p7',
      title: 'iPad Pro M1 11 inch 5G',
      description: 'Máy tính bảng iPad Pro M1 11 inch 1TB (2021) ',
      price: 1099.99,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/522/269329/pad-pro-m1-11-inch-wifi-cellular-1tb-2021-xam-thumb-600x600.jpeg',
      typeP: 'tablet',
      isFavorite: false,
    ),
    Product(
      id: 'p8',
      title: 'iPad Pro M2 12.9 inch 5G',
      description: 'Máy tính bảng iPad Pro M2 12.9 inch WiFi Cellular 1TB',
      price: 1799.00,
      imageUrl:
          'https://cdn.tgdd.vn/Products/Images/522/295467/ipad-pro-m2-12.5-inch-wifi-5g-xam-thumb-600x600.jpg',
      typeP: 'tablet',
      isFavorite: false,
    ),
    Product(
      id: 'p9',
      title: 'ASUS TUF-AX5400',
      description:
          'Bộ phát wifi Gaming ASUS TUF-AX5400 Chuẩn Wifi 6\n\n+WiFi 6 siêu nhanh - Tận hưởng tốc độ lên đến 5400 Mbps và hiệu quả mạng gấp 4 lần với OFDMA và các kênh 160 MHz.\n\n+Chơi Game Kết Nối Dây Nhanh & Ổn Định - Cổng chơi game chuyên dụng ưu tiên thiết bị chơi game được kết nối.\n\n+Chuyển tiếp cổng dễ dàng trong 3 bước - NAT mở khiến thao tác chuyển tiếp cổng trở nên đơn giản, loại bỏ cấu hình thủ công gây khó chịu và phức tạp.',
      price: 199.99,
      imageUrl:
          'https://anphat.com.vn/media/product/40410_20964_asus_tuf_gaming_ax5400_2.jpg',
      typeP: 'other',
      isFavorite: true,
    ),
    Product(
      id: 'p10',
      title: 'TP-Link Archer AX55',
      description:
          'Thiết bị mạng TP-Link Archer AX55 Router Wi-Fi 6 Băng Tần Kép AX3000',
      price: 109.00,
      imageUrl:
          'https://anphat.com.vn/media/product/250_41254_overview_archer_ax55_01_large_20210816012555f.jpg',
      typeP: 'other',
      isFavorite: false,
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  List<Product> typeP(String typeP) {
    return _items.where((prodItem) => prodItem.typeP == typeP).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    _items.add(
      product.copyWith(
        id: 'p${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void clearFavorite() {
    for (var fav in favorite) {
      fav.isFavorite = false;
    }
  }

  void toggleFavoriteStatus(Product product) {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}

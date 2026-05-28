import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../viewmodels/product_viewmodel.dart';
import 'favorite_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  String selectedCategory = "All";

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    "All",
    "Men",
    "Women",
    "Unisex",
    "Kids",
    "Bags",
    "Cosmetics",
    "Accessories",
    "Footwear",
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// SEARCH FILTER
  List<ProductModel> filterSearch(List<ProductModel> products) {
    if (searchQuery.isEmpty) return products;

    return products.where((p) {
      final query = searchQuery.toLowerCase();
      return p.title.toLowerCase().contains(query) ||
          p.brand.toLowerCase().contains(query);
    }).toList();
  }

  /// YOUR PRODUCT FUNCTION (CONNECTED)
  List<ProductModel> getProducts(String category) {
    List<ProductModel> products = [];

    /// ================= ALL =================
    if (category == "All") {
      products = [
  ProductModel(
    id: "1",
    title: "Nike Classic Logo T-Shirt",
    brand: "Nike",
    image: "assets/images/product1.jpg",
    details:
        "Premium black cotton t-shirt featuring the iconic Nike logo with a comfortable regular fit for sporty and casual everyday fashion.",
    price: 3500,
    category: "Men",
  ),

  ProductModel(
    id: "2",
    title: "Midnight Floral Couple Outfit",
    brand: "CozyBond",
    image: "assets/images/product2.jpg",
    details:
        "Elegant matching black floral outfit set designed for couples who love classy fashion and coordinated styling.",
    price: 7200,
    category: "Unisex",
  ),

  ProductModel(
    id: "3",
    title: "Urban Runner Sneakers",
    brand: "Nike",
    image: "assets/images/product3.jpg",
    details:
        "Stylish black and white sneakers crafted for running, walking, and modern streetwear comfort.",
    price: 6800,
    category: "Footwear",
  ),

  ProductModel(
    id: "4",
    title: "Elegant Mini Handbag",
    brand: "Gucci",
    image: "assets/images/product4.jpg",
    details:
        "Luxury mini handbag with premium leather finish and elegant scarf detail for classy modern fashion.",
    price: 8500,
    category: "Accessories",
  ),

  ProductModel(
    id: "5",
    title: "Royal Blue Luxury Watch",
    brand: "Rolex",
    image: "assets/images/product5.jpg",
    details:
        "Elegant metallic luxury wristwatch with deep blue dial and premium detailing for sophisticated styling.",
    price: 12000,
    category: "Accessories",
  ),

  ProductModel(
    id: "6",
    title: "Puma Streetwear Jacket",
    brand: "Puma",
    image: "assets/images/product6.jpg",
    details:
        "Modern black casual jacket with lightweight comfort and sporty streetwear aesthetics.",
    price: 5500,
    category: "Men",
  ),

  ProductModel(
    id: "7",
    title: "AirFlex Casual Sneakers",
    brand: "Nike",
    image: "assets/images/product7.jpg",
    details:
        "Comfortable white sneakers designed for daily walking, casual styling, and lightweight performance.",
    price: 6400,
    category: "Footwear",
  ),

  ProductModel(
    id: "8",
    title: "Oversized Cozy Hoodie",
    brand: "H&M",
    image: "assets/images/product8.jpg",
    details:
        "Soft oversized hoodie with relaxed fit designed for cozy comfort and trendy street fashion.",
    price: 6000,
    category: "Unisex",
  ),

  ProductModel(
    id: "9",
    title: "Elegant White Heels",
    brand: "Louis Vuitton",
    image: "assets/images/product9.jpg",
    details:
        "Premium pointed high heels with sleek modern styling perfect for formal events and elegant fashion looks.",
    price: 7800,
    category: "Women",
  ),

  ProductModel(
    id: "10",
    title: "Luxury Travel Backpack",
    brand: "Wildcraft",
    image: "assets/images/product10.jpg",
    details:
        "Stylish compact backpack with premium finish designed for travel, casual outings, and daily essentials.",
    price: 4500,
    category: "Accessories",
  ),
];
  }

    /// ================= MEN =================
else if (category == "Men") {
  products = [
    ProductModel(
  id: "m1",
  title: "Signature Grey Luxe Tracksuit",
  brand: "Balenciaga",
  image: "assets/images/m1.jpg",
  details:
      "Premium grey tracksuit designed with a modern athletic fit, soft cotton fabric, and luxury streetwear styling for everyday comfort.",
  price: 12000,
  category: "Men",
),

ProductModel(
  id: "m2",
  title: "Tailored Mocha Overshirt Ensemble",
  brand: "Burberry",
  image: "assets/images/m2.jpg",
  details:
      "Elegant brown overshirt paired with tailored trousers, offering a refined smart-casual look with premium craftsmanship.",
  price: 13500,
  category: "Men",
),

ProductModel(
  id: "m3",
  title: "Monaco White Summer Set",
  brand: "Dior",
  image: "assets/images/m3.jpg",
  details:
      "Stylish white summer co-ord set featuring breathable fabric and minimalist luxury details perfect for vacation wear.",
  price: 11000,
  category: "Men",
),

ProductModel(
  id: "m4",
  title: "Beige Riviera Knit Polo Set",
  brand: "Loro Piana",
  image: "assets/images/m4.jpg",
  details:
      "Sophisticated knit polo outfit crafted with soft premium materials for a classy and relaxed luxury appearance.",
  price: 12500,
  category: "Men",
),

ProductModel(
  id: "m5",
  title: "Heritage Check Casual Fit",
  brand: "Gucci",
  image: "assets/images/m5.jpg",
  details:
      "Designer checkered casual outfit inspired by vintage luxury fashion with a trendy oversized silhouette.",
  price: 14000,
  category: "Men",
),

ProductModel(
  id: "m6",
  title: "Espresso Luxe Sweat Set",
  brand: "Louis Vuitton",
  image: "assets/images/m6.jpg",
  details:
      "Rich brown luxury sweatshirt and jogger set delivering comfort, exclusivity, and iconic premium styling.",
  price: 15000,
  category: "Men",
),

ProductModel(
  id: "m7",
  title: "Earth Tone Street Cargo Look",
  brand: "Fear of God",
  image: "assets/images/m7.jpg",
  details:
      "Modern oversized t-shirt paired with cargo pants, combining urban streetwear aesthetics with luxury comfort.",
  price: 13000,
  category: "Men",
),

ProductModel(
  id: "m8",
  title: "Palm Resort Silk Shirt",
  brand: "Versace",
  image: "assets/images/m8.jpg",
  details:
      "Tropical-inspired printed shirt made with lightweight premium fabric for a bold luxury resort look.",
  price: 14500,
  category: "Men",
),

ProductModel(
  id: "m9",
  title: "Ivory Elite Co-Ord Collection",
  brand: "Prada",
  image: "assets/images/m9.jpg",
  details:
      "Clean white co-ord set with a modern minimalist design, tailored for sophisticated casual fashion lovers.",
  price: 15500,
  category: "Men",
),

ProductModel(
  id: "m10",
  title: "Milan Layered Casual Wear",
  brand: "Armani Exchange",
  image: "assets/images/m10.jpg",
  details:
      "Contemporary layered outfit inspired by Italian fashion trends, ideal for modern luxury street styling.",
  price: 12000,
  category: "Men",
),

ProductModel(
  id: "m11",
  title: "Olive Relaxed Cargo Trousers",
  brand: "Off-White",
  image: "assets/images/m11.jpg",
  details:
      "Wide-leg olive cargo pants featuring premium fabric and a relaxed luxury streetwear silhouette.",
  price: 12500,
  category: "Men",
),

ProductModel(
  id: "m12",
  title: "Camel Slim Urban Joggers",
  brand: "Hugo Boss",
  image: "assets/images/m12.jpg",
  details:
      "Slim-fit camel joggers crafted for smart urban fashion with comfort and premium detailing.",
  price: 11800,
  category: "Men",
),

ProductModel(
  id: "m13",
  title: "Sandstone Premium Sweatshirt Fit",
  brand: "Amiri",
  image: "assets/images/m13.jpg",
  details:
      "Luxury beige sweatshirt outfit designed with a relaxed fit and modern minimalist streetwear influence.",
  price: 16000,
  category: "Men",
),

ProductModel(
  id: "m14",
  title: "Executive Essentials Tee Pack",
  brand: "Calvin Klein Collection",
  image: "assets/images/m14.jpg",
  details:
      "Premium long-sleeve t-shirt collection offering sleek comfort, modern styling, and everyday luxury wear.",
  price: 9000,
  category: "Men",
),

ProductModel(
  id: "m15",
  title: "Ivory Tailored Relaxed Pants",
  brand: "Tom Ford",
  image: "assets/images/m15.jpg",
  details:
      "Elegant cream relaxed-fit trousers designed with sophisticated tailoring and premium comfort.",
  price: 14000,
  category: "Men",
),

ProductModel(
  id: "m16",
  title: "Noir Resort Printed Set",
  brand: "Dolce & Gabbana",
  image: "assets/images/m16.jpg",
  details:
      "Stylish black-and-white resort shirt set with bold tropical prints and high-end vacation fashion appeal.",
  price: 13500,
  category: "Men",
),

ProductModel(
  id: "m17",
  title: "Platinum Athleisure Tracksuit",
  brand: "Moncler",
  image: "assets/images/m17.jpg",
  details:
      "Luxury grey athleisure tracksuit featuring sporty elegance, soft materials, and premium comfort.",
  price: 17000,
  category: "Men",
),

ProductModel(
  id: "m18",
  title: "Black Active Luxe Set",
  brand: "Emporio Armani",
  image: "assets/images/m18.jpg",
  details:
      "Minimal black activewear set designed for modern fitness fashion with a luxury aesthetic.",
  price: 14500,
  category: "Men",
),

ProductModel(
  id: "m19",
  title: "Riviera Striped Linen Shirt",
  brand: "Ralph Lauren Purple Label",
  image: "assets/images/m19.jpg",
  details:
      "Premium striped linen shirt offering breathable comfort and timeless sophisticated styling.",
  price: 15500,
  category: "Men",
),

ProductModel(
  id: "m20",
  title: "Nude Signature Hoodie Set",
  brand: "Palm Angels",
  image: "assets/images/m20.jpg",
  details:
      "Soft beige hoodie set blending luxury streetwear trends with cozy premium-quality fabric.",
  price: 15000,
  category: "Men",
),

ProductModel(
  id: "m21",
  title: "Vintage Denim Street Luxe",
  brand: "Saint Laurent",
  image: "assets/images/m21.jpg",
  details:
      "Fashion-forward denim streetwear outfit combining classic jeans with modern luxury styling.",
  price: 16500,
  category: "Men",
),

ProductModel(
  id: "m22",
  title: "Midnight Navy Polo Elite",
  brand: "Lacoste Premium",
  image: "assets/images/m22.jpg",
  details:
      "Elegant navy polo shirt crafted with refined detailing and a timeless premium casual look.",
  price: 11000,
  category: "Men",
),
}
    /// ================= WOMEN =================
else if (category == "Women") {
  products = [
    ProductModel(
      id: "w1",
      title: "Elegant Pearl Mini Dress",
      brand: "Zara",
      image: "assets/images/w1.jpg",
      details: "White long-sleeve mini dress with classy feminine styling for elegant casual outings.",
      price: 3200,
      category: "Women",
    ),
    ProductModel(
      id: "w2",
      title: "Blossom Grace Maxi Dress",
      brand: "Dior",
      image: "assets/images/w2.jpg",
      details: "Soft pink floral maxi dress with flowy silhouette and romantic summer vibes.",
      price: 3500,
      category: "Women",
    ),
    ProductModel(
      id: "w3",
      title: "Floral Charm Kurti Dress",
      brand: "H&M",
      image: "assets/images/w3.jpg",
      details: "White floral printed ethnic-style dress with modern casual elegance.",
      price: 2800,
      category: "Women",
    ),
    ProductModel(
      id: "w4",
      title: "Chic Winter Co-ord Set",
      brand: "Gucci",
      image: "assets/images/w4.jpg",
      details: "Stylish checked blazer and skirt set paired with long boots for premium fashion styling.",
      price: 6000,
      category: "Women",
    ),
    ProductModel(
      id: "w5",
      title: "Ruby Knit Casual Top",
      brand: "Uniqlo",
      image: "assets/images/w5.jpg",
      details: "Dark red knit sweater styled with cream trousers for cozy everyday fashion.",
      price: 2500,
      category: "Women",
    ),
    ProductModel(
      id: "w6",
      title: "Midnight Floral Dress",
      brand: "Shein",
      image: "assets/images/w6.jpg",
      details: "Black floral midi dress with relaxed fit and elegant street-style appearance.",
      price: 3000,
      category: "Women",
    ),
    ProductModel(
      id: "w7",
      title: "Minimal Beige Streetwear Set",
      brand: "Calvin Klein",
      image: "assets/images/w7.jpg",
      details: "Neutral crop top with cream jogger pants for trendy urban styling.",
      price: 4200,
      category: "Women",
    ),
    ProductModel(
      id: "w8",
      title: "Denim Bloom Outfit",
      brand: "Levi’s",
      image: "assets/images/w8.jpg",
      details: "Denim jacket layered over floral maxi dress for youthful casual fashion.",
      price: 4500,
      category: "Women",
    ),
    ProductModel(
      id: "w9",
      title: "Soft Cream Elegant Dress",
      brand: "Chanel",
      image: "assets/images/w9.jpg",
      details: "Puff sleeve cream dress with soft premium aesthetic and graceful styling.",
      price: 7000,
      category: "Women",
    ),
    ProductModel(
      id: "w10",
      title: "Classic Brown Midi Dress",
      brand: "Mango",
      image: "assets/images/w10.jpg",
      details: "Elegant brown sleeveless midi dress designed for modern minimalist fashion lovers.",
      price: 3300,
      category: "Women",
    ),
    ProductModel(
      id: "w11",
      title: "Pastel Floral Kaftan",
      brand: "Biba",
      image: "assets/images/w11.jpg",
      details: "Loose-fit floral printed ethnic kaftan dress with soft airy comfort.",
      price: 2700,
      category: "Women",
    ),
    ProductModel(
      id: "w12",
      title: "Royal Cape Ethnic Set",
      brand: "Sabyasachi",
      image: "assets/images/w12.jpg",
      details: "White ethnic outfit paired with navy embroidered cape for festive elegance.",
      price: 8500,
      category: "Women",
    ),
    ProductModel(
      id: "w13",
      title: "Crimson Evening Gown",
      brand: "Prada",
      image: "assets/images/w13.jpg",
      details: "Deep red long gown with sophisticated evening party styling.",
      price: 9000,
      category: "Women",
    ),
    ProductModel(
      id: "w14",
      title: "Mocha Floral Maxi Dress",
      brand: "Zara",
      image: "assets/images/w14.jpg",
      details: "Brown fitted top with floral flowing skirt for classy outdoor fashion.",
      price: 3800,
      category: "Women",
    ),
    ProductModel(
      id: "w15",
      title: "Sage Green Ethnic Dress",
      brand: "FabIndia",
      image: "assets/images/w15.jpg",
      details: "Light green traditional-style long dress with elegant embroidery details.",
      price: 2900,
      category: "Women",
    ),
    ProductModel(
      id: "w16",
      title: "Aqua Floral Saree Set",
      brand: "Kalki Fashion",
      image: "assets/images/w16.jpg",
      details: "White and aqua floral ethnic saree set designed for festive occasions.",
      price: 7500,
      category: "Women",
    ),
    ProductModel(
      id: "w17",
      title: "Ivory Embroidered Kurti Set",
      brand: "W for Woman",
      image: "assets/images/w17.jpg",
      details: "Cream embroidered kurti with matching pants for modern ethnic wear.",
      price: 3100,
      category: "Women",
    ),
    ProductModel(
      id: "w18",
      title: "Maroon Heritage Kurti",
      brand: "Biba",
      image: "assets/images/w18.jpg",
      details: "Maroon embroidered kurti paired with white bottoms for traditional elegance.",
      price: 2600,
      category: "Women",
    ),
    ProductModel(
      id: "w19",
      title: "Blush Pink Party Saree",
      brand: "Manyavar Mohey",
      image: "assets/images/w19.jpg",
      details: "Soft pink designer saree with glamorous festive styling and elegant drape.",
      price: 6800,
      category: "Women",
    ),
    ProductModel(
      id: "w20",
      title: "Sky Blue Designer Saree",
      brand: "Tarun Tahiliani",
      image: "assets/images/w20.jpg",
      details: "Elegant pastel blue saree with premium partywear aesthetic and graceful finish.",
      price: 9500,
      category: "Women",
    ),
  ];
}

    /// ================= UNISEX =================
else if (category == "Unisex") {
  products = [
    ProductModel(
      id: "ux1",
      title: "Puzzle Heart Couple Hoodie",
      brand: "CozyBond",
      image: "assets/images/ux1.jpg",
      details: "Matching beige couple hoodies with stylish puzzle-heart design crafted for cozy comfort, romantic fashion, and trendy streetwear looks.",
      price: 3500,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux2",
      title: "Urban Blush Couple Set",
      brand: "Aether",
      image: "assets/images/ux1.jpg",
      details: "Modern pastel pink matching outfit designed for stylish couples who love elegant casual fashion and coordinated streetwear vibes.",
      price: 6200,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux3",
      title: "Sky Chill Couple Outfit",
      brand: "UrbanFlex",
      image: "assets/images/ux3.jpg",
      details: "Relaxed oversized matching hoodie and shorts set made for comfortable travel wear and trendy casual styling.",
      price: 5800,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux4",
      title: "Minimal Harmony Casual Set",
      brand: "Aether",
      image: "assets/images/ux4.jpg",
      details: "Minimalist white t-shirt and loose pants combo designed for modern unisex fashion and effortless daily comfort.",
      price: 5400,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux5",
      title: "Sandstorm Streetwear Set",
      brand: "UrbanEdge",
      image: "assets/images/ux5.jpg",
      details: "Premium beige oversized coordinated outfit with luxury street-style aesthetics and ultra-comfortable fabric.",
      price: 7600,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux6",
      title: "Everyday Comfort Couple Wear",
      brand: "CozyBond",
      image: "assets/images/ux6.jpg",
      details: "Neutral-toned matching sweatshirt and jeans set designed for casual outings, travel, and cozy daily fashion.",
      price: 5200,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux7",
      title: "Golden Stripe Couple Tee",
      brand: "TinyTrendz",
      image: "assets/images/ux7.jpg",
      details: "Stylish striped t-shirt set paired with black bottoms for modern casual fashion and coordinated everyday styling.",
      price: 4300,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux8",
      title: "ColorPop Street Duo",
      brand: "UrbanMini",
      image: "assets/images/ux8.jpg",
      details: "Trendy color-block t-shirt outfit with modern streetwear vibes and lightweight comfort for casual fashion lovers.",
      price: 4700,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux9",
      title: "Love Code Knit Sweater",
      brand: "CozyBond",
      image: "assets/images/ux9.jpg",
      details: "Soft pastel striped sweater with romantic typography design crafted for cozy winter fashion and aesthetic couple styling.",
      price: 5900,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux10",
      title: "BTS Inspired Hoodie Set",
      brand: "KStyle",
      image: "assets/images/ux10.jpg",
      details: "Korean-inspired oversized purple hoodie set designed for trendy street fashion, comfort, and fan-inspired aesthetics.",
      price: 6500,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux11",
      title: "Midnight Glow Couple Hoodie",
      brand: "UrbanFlex",
      image: "assets/images/ux11.jpg",
      details: "Stylish dark purple matching hoodies with modern oversized fit designed for cozy winter nights and streetwear fashion.",
      price: 6100,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux12",
      title: "Royal Blue Formal Duo",
      brand: "Aether",
      image: "assets/images/ux12.jpg",
      details: "Elegant matching formal blazer set designed for luxury fashion styling, events, and modern power-couple aesthetics.",
      price: 8500,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux13",
      title: "Forever Yours Sweatshirt Set",
      brand: "CozyBond",
      image: "assets/images/ux13.jpg",
      details: "Soft oversized matching sweatshirts featuring romantic back-print typography for cute couple fashion and cozy comfort.",
      price: 5700,
      category: "",
    ),
    ProductModel(
      id: "ux14",
      title: "Cream Essence Hoodie Set",
      brand: "UrbanEdge",
      image: "assets/images/ux14.jpg",
      details: "Premium cream-colored oversized hoodies crafted for minimalist fashion lovers seeking comfort and modern streetwear elegance.",
      price: 6000,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux15",
      title: "Midnight Rebel Couple Wear",
      brand: "UrbanFlex",
      image: "assets/images/ux15.jpg",
      details: "Stylish black coordinated outfit with edgy streetwear aesthetics and premium comfort for modern unisex fashion.",
      price: 6800,
      category: "Unisex",
    ),
    ProductModel(
      id: "ux16",
      title: "Shadow Heart Matching Set",
      brand: "CozyBond",
      image: "assets/images/ux16.jpg",
      details: "Matching dark grey heart-print t-shirts and shorts designed for minimalist couple fashion and relaxed everyday comfort.",
      price: 5200,
      category: "Unisex",
    ),
  ];
}

    /// ================= KIDS =================
else if (category == "Kids") {
  products = [
    ProductModel(
      id: "k1",
      title: "Princess Bloom Party Dress",
      brand: "Little Fairy",
      image: "assets/images/k1.jpg",
      details: "Elegant layered pink party dress with soft tulle fabric and princess-inspired styling for birthdays, weddings, and special occasions.",
      price: 8500,
      category: "Kids",
    ),
    ProductModel(
      id: "k2",
      title: "Cool Breeze Summer Set",
      brand: "MiniTrendz",
      image: "assets/images/k2.jpg",
      details: "Stylish boys’ casual summer outfit with a soft blue shirt and matching shorts designed for comfort and trendy outdoor fashion.",
      price: 5200,
      category: "Kids",
    ),
    ProductModel(
      id: "k3",
      title: "Sunny Stripe Casual Set",
      brand: "TinyVogue",
      image: "assets/images/k3.jpg",
      details: "Bright striped shirt with white shorts crafted for playful summer fashion and comfortable daily wear for kids.",
      price: 4800,
      category: "Kids",
    ),
    ProductModel(
      id: "k4",
      title: "Sweet Ribbon Skirt Set",
      brand: "Little Fairy",
      image: "assets/images/k4.jpg",
      details: "Cute pastel top and embroidered skirt combo featuring a charming ribbon design perfect for casual and party styling.",
      price: 4200,
      category: "Kids",
    ),
    ProductModel(
      id: "k5",
      title: "Bunny Dream Winter Set",
      brand: "CozyKids",
      image: "assets/images/k5.jpg",
      details: "Soft knitted bunny-themed sweater with matching skirt designed for cozy winter comfort and adorable fashion styling.",
      price: 5000,
      category: "Kids",
    ),
    ProductModel(
      id: "k6",
      title: "Blossom Pink Sweater Dress",
      brand: "TinyBloom",
      image: "assets/images/k6.jpg",
      details: "Elegant pink sweater paired with a soft white skirt for classy and comfortable winter fashion for little girls.",
      price: 4700,
      category: "Kids",
    ),
    ProductModel(
      id: "k7",
      title: "Tropical Beach Vacation Set",
      brand: "MiniTrendz",
      image: "assets/images/k7.jpg",
      details: "Colorful tropical shirt and shorts outfit designed for beach vacations, summer adventures, and stylish comfort.",
      price: 5500,
      category: "Kids",
    ),
    ProductModel(
      id: "k8",
      title: "Royal Gentleman Suit Set",
      brand: "Tiny Royals",
      image: "assets/images/k8.jpg",
      details: "Elegant boys’ formal suit with vest and bowtie crafted for weddings, birthdays, and premium party styling.",
      price: 6800,
      category: "Kids",
    ),
    ProductModel(
      id: "k9",
      title: "Teddy Denim Romper",
      brand: "BabyNest",
      image: "assets/images/k9.jpg",
      details: "Soft denim romper with adorable teddy embroidery designed for cozy baby comfort and playful daily wear.",
      price: 3900,
      category: "Kids",
    ),
    ProductModel(
      id: "k10",
      title: "Daisy Denim Dress",
      brand: "Little Fairy",
      image: "assets/images/k10.jpg",
      details: "Cute denim dress with floral details and soft inner fabric for stylish and comfortable casual wear.",
      price: 4500,
      category: "Kids",
    ),
    ProductModel(
      id: "k11",
      title: "Sky Blue Princess Dress",
      brand: "TinyBloom",
      image: "assets/images/k11.jpg",
      details: "Elegant sleeveless blue dress featuring a graceful flowy silhouette perfect for parties and special occasions.",
      price: 6200,
      category: "Kids",
    ),
    ProductModel(
      id: "k12",
      title: "Wild Fun Summer Outfit",
      brand: "MiniTrendz",
      image: "assets/images/k12.jpg",
      details: "Trendy animal-print shirt with bright orange shorts designed for playful summer adventures and casual comfort.",
      price: 4300,
      category: "Kids",
    ),
    ProductModel(
      id: "k13",
      title: "Sweet Cherry Casual Set",
      brand: "CozyKids",
      image: "assets/images/k13.jpg",
      details: "Soft pink sweatshirt paired with a stylish white skirt for adorable and comfortable everyday fashion.",
      price: 4600,
      category: "Kids",
    ),
    ProductModel(
      id: "k14",
      title: "Urban Cool Hoodie Set",
      brand: "TinyStreet",
      image: "assets/images/k14.jpg",
      details: "Stylish black hoodie outfit with modern streetwear vibes designed for warmth, comfort, and trendy fashion.",
      price: 5700,
      category: "Kids",
    ),
    ProductModel(
      id: "k15",
      title: "Floral Garden Party Dress",
      brand: "Little Fairy",
      image: "assets/images/k15.jpg",
      details: "Beautiful floral printed frock crafted with lightweight breathable fabric for elegant party and summer styling.",
      price: 6500,
      category: "Kids",
    ),
    ProductModel(
      id: "k16",
      title: "Classic Stripe Casual Set",
      brand: "TinyTrendz",
      image: "assets/images/k16.jpg",
      details: "Comfortable striped t-shirt with matching shorts designed for cool casual summer fashion and daily wear.",
      price: 4900,
      category: "Kids",
    ),
    ProductModel(
      id: "k17",
      title: "Midnight Streetwear Set",
      brand: "UrbanMini",
      image: "assets/images/k17.jpg",
      details: "Trendy black t-shirt and shorts outfit with modern street-style fashion for stylish everyday comfort.",
      price: 5200,
      category: "Kids",
    ),
    ProductModel(
      id: "k18",
      title: "Little Explorer Suspender Set",
      brand: "BabyNest",
      image: "assets/images/k18.jpg",
      details: "Cute suspender shorts with soft shirt and matching cap designed for charming outdoor and casual styling.",
      price: 4900,
      category: "Kids",
    ),
    ProductModel(
      id: "k19",
      title: "Golden Check Princess Dress",
      brand: "TinyBloom",
      image: "assets/images/k19.jpg",
      details: "Elegant yellow checkered dress with soft puff sleeves crafted for premium comfort and adorable fashion looks.",
      price: 5800,
      category: "Kids",
    ),
    ProductModel(
      id: "k20",
      title: "Peach Blossom Baby Dress",
      brand: "Peach Blossom Baby Dress",
      image: "assets/images/k20.jpg",
      details: "Soft peach-colored baby frock with elegant layered styling designed for birthdays, parties, and special occasions.",
      price: 4400,
      category: "Kids",
    ),
  ];
}

/// ================= BAGS =================
else if (category == "Bags") {
  products = [
    ProductModel(
      id: "b1",
      title: "Cute Bunny School Backpack",
      brand: "Pinky Bags",
      image: "assets/images/b1.jpg",
      details: "Spacious pastel pink backpack with bunny ears and soft plush keychain, perfect for school and daily use.",
      price: 3000,
      category: "Bags",
    ),
    ProductModel(
      id: "b2",
      title: "Elegant Leather Handbag",
      brand: "Luxe Carry",
      image: "assets/images/b2.jpg",
      details: "Stylish maroon leather handbag with gold chain details, designed for modern casual and formal fashion.",
      price: 6000,
      category: "Bags",
    ),
    ProductModel(
      id: "b3",
      title: "Classic White Tote Bag",
      brand: "Urban Elegance",
      image: "assets/images/b3.jpg",
      details: "Premium white tote handbag with decorative accessories, suitable for office, shopping, and travel.",
      price: 4000,
      category: "Bags",
    ),
    ProductModel(
      id: "b4",
      title: "Mint Green Fashion Bag Set",
      brand: "Chic Style",
      image: "assets/images/b4.jpg",
      details: "Trendy mint green handbag collection with matching mini pouch and accessories for a fashionable look.",
      price: 5000,
      category: "Bags",
    ),
    ProductModel(
      id: "b5",
      title: "Pearl Chain Shoulder Bag",
      brand: "Golden Glow",
      image: "assets/images/b5.jpg",
      details: "Elegant cream shoulder bag with gold chain strap and floral detailing, ideal for parties and events.",
      price: 4000,
      category: "Bags",
    ),
    ProductModel(
      id: "b6",
      title: "Bow Knit Tote Bag",
      brand: "Cozy Fashion",
      image: "assets/images/b6.jpg",
      details: "Soft knitted cream tote bag with a large bow design, combining comfort and style for everyday use.",
      price: 2700,
      category: "Bags",
    ),
    ProductModel(
      id: "b7",
      title: "Pink Pearl Crochet Handbag",
      brand: "Sweet Charm",
      image: "assets/images/b7.jpg",
      details: "Beautiful pink woven handbag decorated with pearls and charms, perfect for feminine fashion styles.",
      price: 3000,
      category: "Bags",
    ),
    ProductModel(
      id: "b8",
      title: "Professional Laptop Bag",
      brand: "Tech Carry",
      image: "assets/images/b8.jpg",
      details: "Durable grey laptop handbag with padded protection, designed for office work and business travel.",
      price: 4500,
      category: "Bags",
    ),
    ProductModel(
      id: "b9",
      title: "Glossy Mini Shoulder Bag",
      brand: "Velvet Vogue",
      image: "assets/images/b9.jpg",
      details: "Compact dark red shoulder bag with a glossy finish, ideal for evening outings and casual wear.",
      price: 7000,
      category: "Bags",
    ),
    ProductModel(
      id: "b10",
      title: "Quilted Round Sling Bag",
      brand: "Classy Loop",
      image: "assets/images/b10.jpg",
      details: "Elegant quilted cream sling bag with gold chain strap, offering a stylish and modern appearance.",
      price: 5500,
      category: "Bags",
    ),
  ];
}

    /// ================= COSMETICS =================
else if (category == "Cosmetics") {
  products = [
    ProductModel(
      id: "cos1",
      title: "Velvet Matte Lipstick Set",
      brand: "Glam Beauty",
      image: "assets/images/cos1.jpg",
      details: "Collection of rich matte lipsticks with smooth texture and long-lasting color for daily and party makeup.",
      price: 2000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos2",
      title: "Desire Luxury Perfume",
      brand: "Royal Essence",
      image: "assets/images/cos2.jpg",
      details: "Elegant fragrance perfume with a bold and sophisticated scent, suitable for special occasions.",
      price: 8500,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos3",
      title: "Flawless Compact Powder",
      brand: "Pure Glow Cosmetics",
      image: "assets/images/cos3.jpg",
      details: "Lightweight compact face powder that provides smooth coverage and a natural radiant finish.",
      price: 3000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos4",
      title: "Blue Ocean Eau De Parfum",
      brand: "Fresh Aura",
      image: "assets/images/cos4.jpg",
      details: "Refreshing men’s perfume with a cool and modern fragrance for everyday confidence.",
      price: 7000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos5",
      title: "Nude Eyeshadow Palette",
      brand: "Beauty Blend",
      image: "assets/images/cos5.jpg",
      details: "Soft nude-toned eyeshadow palette featuring multiple shades for natural and glamorous eye makeup looks.",
      price: 6000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos6",
      title: "Soft Care Skincare Gift Set",
      brand: "Bloom Skincare",
      image: "assets/images/cos6.jpg",
      details: "Complete skincare collection with creams and lotions designed to nourish and hydrate the skin.",
      price: 9000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos7",
      title: "Purple Glam Makeup Kit",
      brand: "Shine Studio",
      image: "assets/images/cos7.jpg",
      details: "Stylish makeup gift box including lipsticks and beauty essentials for a trendy makeup experience.",
      price: 8000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos8",
      title: "Blossom Beauty Care Set",
      brand: "Pink Petals",
      image: "assets/images/cos8.jpg",
      details: "Sweet-themed skincare and beauty set with gentle products for daily self-care routines.",
      price: 10000,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos9",
      title: "Precision Black Eyeliner",
      brand: "Miss Rose",
      image: "assets/images/cos9.jpg",
      details: "Waterproof liquid eyeliner designed for sharp, bold, and long-lasting eye definition.",
      price: 1500,
      category: "Cosmetics",
    ),
    ProductModel(
      id: "cos10",
      title: "Glossy Lip Tint Duo",
      brand: "Beauty Secret",
      image: "assets/images/cos10.jpg",
      details: "Vibrant lip tint set with shiny finish and moisturizing formula for soft colorful lips.",
      price: 2600,
      category: "Cosmetics",
    ),
  ];
}
    /// ================= ACCESSORIES =================
else if (category == "Accessories") {
  products = [
    ProductModel(
      id: "a1",
      title: "Elegant Ribbon Hair Bow Set",
      brand: "Veloura",
      image: "assets/images/a1.jpg",
      details: "Soft satin ribbon hair bow clips designed for elegant hairstyles, casual fashion, and party wear. Lightweight, stylish, and perfect for everyday feminine looks.",
      price: 1500,
      category: "Accessories",
    ),
    ProductModel(
      id: "a2",
      title: "Round Sunglasses",
      brand: "UrbanRay",
      image: "assets/images/a2.jpg",
      details: "Premium black round-frame sunglasses with UV protection and minimalist luxury styling. Perfect for street fashion and daily wear.",
      price: 3200,
      category: "Accessories",
    ),
    ProductModel(
      id: "a3",
      title: "Golden Pearl Necklace",
      brand: "LuxeGlow",
      image: "assets/images/a3.jpg",
      details: "Delicate gold necklace featuring elegant pearl accents for classy modern styling. Ideal for casual outfits, parties, and formal occasions.",
      price: 2800,
      category: "Accessories",
    ),
    ProductModel(
      id: "a4",
      title: "Executive Black Watch Set",
      brand: "Chronex",
      image: "assets/images/a4.jpg",
      details: "Luxury black wristwatch with matching bracelet accessories crafted for sophisticated and modern fashion lovers. Premium metallic finish with elegant detailing.",
      price: 4500,
      category: "Accessories",
    ),
    ProductModel(
      id: "a5",
      title: "Crystal Charm Ring Set",
      brand: "LuxeGlow",
      image: "assets/images/a5.jpg",
      details: "Elegant multi-layer ring set featuring minimalist crystal and metallic designs for trendy modern fashion. Perfect for casual wear, parties, and aesthetic styling.",
      price: 4000,
      category: "Accessories",
    ),
    ProductModel(
      id: "a6",
      title: "Minimalist Hair Clip Collection",
      brand: "Veloura",
      image: "assets/images/a6.jpg",
      details: "Neutral-toned aesthetic hair claw and clip set made for elegant hairstyles and daily fashion styling. Durable, lightweight, and comfortable to wear.",
      price: 3000,
      category: "Accessories",
    ),
    ProductModel(
      id: "a7",
      title: "Royal Gold Wristwatch",
      brand: "Chronex",
      image: "assets/images/a7.jpg",
      details: "Premium luxury wristwatch featuring gold and silver metallic detailing with a modern sophisticated appearance for formal and casual styling.",
      price: 12000,
      category: "Accessories",
    ),
    ProductModel(
      id: "a8",
      title: "Matte Black Bracelet Stack",
      brand: "UrbanEdge",
      image: "assets/images/a8.jpg",
      details: "Stylish layered black bracelet collection with modern masculine aesthetics and premium comfort fit. Perfect for casual and streetwear fashion.",
      price: 5000,
      category: "Accessories",
    ),
    ProductModel(
      id: "a9",
      title: "Eternal Bond Couple Rings",
      brand: "CozyBond",
      image: "assets/images/a9.jpg",
      details: "Elegant matching couple ring set with premium metallic finish and minimalist romantic design. Perfect for anniversaries, gifts, and everyday couple fashion styling.",
      price: 1200,
      category: "Accessories",
    ),
    ProductModel(
      id: "a10",
      title: "Rose Gold Luxury Watch",
      brand: "Chronex",
      image: "assets/images/a10.jpg",
      details: "Elegant rose gold wristwatch with sparkling crystal details and premium bracelet design for luxury feminine fashion and formal styling.",
      price: 2500,
      category: "Accessories",
    ),
  ];
}

   /// ================= FOOTWEAR =================
else if (category == "Footwear") {
  products = [
    ProductModel(
      id: "f1",
      title: "Urban Flex Runner",
      brand: "Nike",
      image: "assets/images/f1.jpg",
      details: "Stylish grey and pink sporty sneakers designed for comfort, daily wear, and lightweight running performance..",
      price: 5500,
      category: "Footwear",
    ),
    ProductModel(
      id: "f2",
      title: "Blossom Bow Heels",
      brand: "Zara",
      image: "assets/images/f2.jpg",
      details: "Elegant cream bow heels with a soft feminine look, perfect for parties, weddings, and classy casual outfits.",
      price: 5000,
      category: "Footwear",
    ),
    ProductModel(
      id: "f3",
      title: "Pearl Shine Flats",
      brand: "Dior",
      image: "assets/images/f3.jpg",
      details: "Luxury white glitter flats with premium finishing and cushioned comfort for elegant everyday fashion.",
      price: 6500,
      category: "Footwear",
    ),
    ProductModel(
      id: "f4",
      title: "Midnight Comfort Slides",
      brand: "Adidas",
      image: "assets/images/f4.jpg",
      details: "Modern black slip-on slides with soft ergonomic sole, ideal for casual indoor and outdoor wear.",
      price: 4800,
      category: "Footwear",
    ),
    ProductModel(
      id: "f5",
      title: "Silver Wave Slippers",
      brand: "Puma",
      image: "assets/images/f5.jpg",
      details: "Trendy silver textured slippers with anti-slip comfort and sporty modern styling.",
      price: 3200,
      category: "Footwear",
    ),
    ProductModel(
      id: "f6",
      title: "Royal Velvet Loafers",
      brand: "Gucci",
      image: "assets/images/f6.jpg",
      details: "Premium black velvet loafers with golden buckle detail, crafted for luxury formal fashion.",
      price: 8000,
      category: "Footwear",
    ),
    ProductModel(
      id: "f7",
      title: "Snowy Baby Walkers",
      brand: "MiniSteps",
      image: "assets/images/f7.jpg",
      details: "Cute white baby shoes with bow design, made for soft comfort and adorable kids fashion.",
      price: 4200,
      category: "Footwear",
    ),
    ProductModel(
      id: "f8",
      title: "Cozy Bunny Slippers",
      brand: "CozyFeet",
      image: "assets/images/f8.jpg",
      details: "Ultra-soft pink bunny slippers designed for warmth, relaxation, and cozy indoor comfort.",
      price: 2500,
      category: "Footwear",
    ),
    ProductModel(
      id: "f9",
      title: "Noir Elegance Heels",
      brand: "Chanel",
      image: "assets/images/f9.jpg",
      details: "Sophisticated black ankle heels with gold buckle accents for bold and classy fashion looks.",
      price: 5200,
      category: "Footwear",
    ),
    ProductModel(
      id: "f10",
      title: "Motion Air Sneakers",
      brand: "Skechers",
      image: "assets/images/f10.jpg",
      details: "Lightweight black running sneakers with breathable mesh and cushioned sole for all-day comfort.",
      price: 6000,
      category: "Footwear",
    ),
  ];
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);

    final allProducts = getProducts(selectedCategory);
    final products = filterSearch(allProducts);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4F7),

      body: SafeArea(
        child: Column(
          children: [

            /// ================= HEADER =================
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  /// TOP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),

                      const Column(
                        children: [
                          Text(
                            "LuxaCart",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Luxury Collection",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FavoriteItems(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.favorite, color: Colors.pink),
                          ),

                          if (productVM.favoriteProducts.isNotEmpty)
                            Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  productVM.favoriteProducts.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// SEARCH BAR
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search products...",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// CATEGORY BAR
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = selectedCategory == cat;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = cat;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.pink : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.pink),
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.pink,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// ================= PRODUCTS GRID =================
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),

                itemBuilder: (context, index) {
                  final product = products[index];

                  final isFav = productVM.favoriteProducts
                      .any((p) => p.id == product.id);

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [

                        /// IMAGE + FAVORITE
                        Expanded(
                          child: Stack(
                            children: [

                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  product.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    productVM.toggleFavorite(product);
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// DETAILS
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(product.brand),

                              const SizedBox(height: 5),

                              Text(
                                "Rs. ${product.price}",
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
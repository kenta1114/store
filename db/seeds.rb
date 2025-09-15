# Create sample products
products_data = [
  {
    name: "MacBook Air M2",
    category: "エレクトロニクス",
    price: 148800,
    inventory_count: 10,
    description: "Apple M2チップ搭載の軽量ノートパソコン。13.6インチの美しいRetinaディスプレイと最大18時間のバッテリー駆動時間。"
  },
  {
    name: "iPhone 15 Pro",
    category: "エレクトロニクス",
    price: 159800,
    inventory_count: 5,
    description: "A17 Proチップ搭載のプロ仕様スマートフォン。チタニウムデザインと ProRAWカメラ機能。"
  },
  {
    name: "Nike Air Max 270",
    category: "ファッション",
    price: 16500,
    inventory_count: 20,
    description: "快適なクッション性とスタイリッシュなデザインを兼ね備えたランニングシューズ。"
  },
  {
    name: "コーヒーメーカー DeLonghi",
    category: "ホーム＆キッチン",
    price: 25000,
    inventory_count: 8,
    description: "本格的なエスプレッソが楽しめる全自動コーヒーメーカー。ミルク泡立て機能付き。"
  },
  {
    name: "ワイヤレスヘッドフォン Sony WH-1000XM5",
    category: "エレクトロニクス",
    price: 45000,
    inventory_count: 15,
    description: "業界最高クラスのノイズキャンセリング機能搭載。最大30時間の音楽再生が可能。"
  },
  {
    name: "レザージャケット",
    category: "ファッション",
    price: 38000,
    inventory_count: 3,
    description: "本革を使用した高品質なレザージャケット。シンプルで洗練されたデザイン。"
  },
  {
    name: "ヨガマット",
    category: "スポーツ＆アウトドア",
    price: 5800,
    inventory_count: 25,
    description: "滑り止め加工されたプレミアムヨガマット。厚さ6mmで膝に優しい。"
  },
  {
    name: "プログラミング学習本「JavaScript入門」",
    category: "本・雑誌",
    price: 2800,
    inventory_count: 12,
    description: "初心者から中級者まで対応したJavaScriptプログラミングの実践的な学習書。"
  }
]

puts "Creating sample products..."

products_data.each do |product_data|
  product = Product.find_or_create_by(name: product_data[:name]) do |p|
    p.category = product_data[:category]
    p.price = product_data[:price]
    p.inventory_count = product_data[:inventory_count]
    p.description = product_data[:description]
  end
  puts "Created: #{product.name}"
end

puts "Sample products created successfully!"

# Create a test user
test_user = User.find_or_create_by(email_address: "test@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end

puts "Created test user: #{test_user.email_address}"
puts "Password: password123"

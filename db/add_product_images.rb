require 'net/http'
require 'uri'

# 商品画像を追加するスクリプト
puts "Adding product images..."

# 各商品に適切な画像を設定
product_images = {
  "MacBook Air M2" => "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800&h=600&fit=crop",
  "iPhone 15 Pro" => "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800&h=600&fit=crop", 
  "Nike Air Max 270" => "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=600&fit=crop",
  "コーヒーメーカー DeLonghi" => "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&h=600&fit=crop",
  "ワイヤレスヘッドフォン Sony WH-1000XM5" => "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&h=600&fit=crop",
  "レザージャケット" => "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800&h=600&fit=crop",
  "ヨガマット" => "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&h=600&fit=crop",
  "プログラミング学習本「JavaScript入門」" => "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=600&fit=crop"
}

product_images.each do |product_name, image_url|
  product = Product.find_by(name: product_name)
  next unless product
  
  begin
    # 画像をダウンロードして保存
    uri = URI(image_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    
    response = http.get(uri.path + (uri.query ? "?#{uri.query}" : ""))
    
    if response.code == '200'
      # 一時ファイルを作成
      filename = "#{product_name.gsub(/[^0-9A-Za-z.\-]/, '_')}.jpg"
      temp_file = Tempfile.new([filename, '.jpg'])
      temp_file.binmode
      temp_file.write(response.body)
      temp_file.rewind
      
      # Active Storageに画像を添付
      product.featured_image.attach(
        io: temp_file,
        filename: filename,
        content_type: 'image/jpeg'
      )
      
      temp_file.close
      temp_file.unlink
      
      puts "Added image for: #{product_name}"
    else
      puts "Failed to download image for: #{product_name} (#{response.code})"
    end
  rescue => e
    puts "Error adding image for #{product_name}: #{e.message}"
  end
end

puts "Product images added successfully!"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join("db/products.csv")
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |product|
  # Create categories and products here.
  category = Category.find_or_create_by(name: product["category"])
  if category.valid? && category
    product = category.products.create(
      title:          product["name"],
      description:    product["description"],
      price:          product["price"],
      stock_quantity: product["stock quantity"]
    )
    puts "Invalid product #{product['name']}" unless product&.valid?
  else
    puts "Invalid category #{product['category']} for products #{product['name']}."
  end
end
puts "Created #{Category.count} categories."
puts "Created #{Product.count} products."

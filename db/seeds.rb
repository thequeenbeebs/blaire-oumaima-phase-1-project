require_relative '../config/environment'

User.delete_all
List.delete_all 
Gift.delete_all
AddToList.delete_all 

oliviabas = User.create(username: "oliviabas")
shaylynn = User.create(username: "shaylynn")
jameslogan = User.create(username: "jameslogan")
sarahstone = User.create(username: "sarahstone")
user5 = User.create(username: "johnstewert")
user6 = User.create(username: "ronconnor")
user7 = User.create(username: "marysmith")


list1 = List.create(name: "my christmas", shopping_or_wish: "wishlist", user_id: user5.id)
list2 = List.create(name: "things to get", shopping_or_wish: "shopping list", user_id: user6.id)

gift1 = Gift.create(name: "Apple Watch", price: 399.99)
gift2 = Gift.create(name: "Cashmere Scarf", price: 124.89)
gift3 = Gift.create(name: "Nike Running Shoes", price: 189.99)
gift4 = Gift.create(name: "PS5", price: 500.00)
gift5 = Gift.create(name: "Ugg Slippers", price: 79.95)
gift6 = Gift.create(name: "Birthstone Necklace", price: 42.00)
gift7 = Gift.create(name: "Le Labo Eau de Parfum", price: 192)
gift8 = Gift.create(name: "L.L Bean Beanie", price: 16.96)
gift9 = Gift.create(name: "16 Piece Dinner Set", price: 256.00)
gift10 = Gift.create(name: "Bose Soundlink Speaker", price: 99.00)

puts "seed file ran"



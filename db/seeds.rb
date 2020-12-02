require_relative '../config/environment'

User.delete_all
List.delete_all 
Gift.delete_all
AddToList.delete_all 

oliviabas = User.create(username: "oliviabas")
shaylynn = User.create(username: "shaylynn")
jameslogan = User.create(username: "jameslogan")
sarahstone = User.create(username: "sarahstone")
johnstewert = User.create(username: "johnstewert")
ronconnor = User.create(username: "ronconnor")
marysmith = User.create(username: "marysmith")


list1 = List.create(name: "my christmas", shopping_or_wish: "wishlist", user_id: shaylynn.id)
list2 = List.create(name: "things to get", shopping_or_wish: "shopping list", user_id: sarahstone.id)

gift1 = Gift.create(name: "Apple Watch", price: 399.99, status: "Not Purchased")
gift2 = Gift.create(name: "Cashmere Scarf", price: 124.89, status: "Purchased")
gift3 = Gift.create(name: "Nike Running Shoes", price: 189.99, status: "Purchased")
gift4 = Gift.create(name: "PS5", price: 500.00), status: "Not Purchased"
gift5 = Gift.create(name: "Ugg Slippers", price: 79.95, status: "Not Purchased")
gift6 = Gift.create(name: "Birthstone Necklace", price: 42.00, status: "Not Purchased")
gift7 = Gift.create(name: "Le Labo Eau de Parfum", price: 192, status: "Not Purchased")
gift8 = Gift.create(name: "L.L Bean Beanie", price: 16.96, status: "Not Purchased")
gift9 = Gift.create(name: "16 Piece Dinner Set", price: 256.00, status: "Not Purchased")
gift10 = Gift.create(name: "Bose Soundlink Speaker", price: 99.00, status, "Not Purchased")

add_to_lists1 = AddToList.create(gift_id: gift1.id, list_id: list1.id)
add_to_lists2 = AddToList.create(gift_id: gift3.id, list_id: list2.id)
add_to_lists3 = AddToList.create(gift_id: gift2.id, list_id: list2.id)
add_to_lists4 = AddToList.create(gift_id: gift6.id, list_id: list1.id)
add_to_lists5 = AddToList.create(gift_id: gift4.id, list_id: list2.id)

puts "seed file ran"



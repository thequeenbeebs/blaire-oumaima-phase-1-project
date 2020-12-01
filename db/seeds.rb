require_relative ../config/environment 

User.delete_all
List.delete_all 
Gift.delete_all
AddLists.delete_all 

user1 = User.create(username: oliviabas)
user2 = User.create(username: shaylynn)
user3 = User.create(username: jameslogan)
user4 = User.create(username: sarahstone)
user5 = User.create(username: johnstewert)
user6 = User.create(username: ronconnor)
user7 = User.create(username: marysmith)


list1 = List.create(name: "my christmas", shopping_or_wish: "wishlist", user_id: user5.id)
list2 = List.create(name: "things to get", shopping_or_wish: "shopping list", user_id: user6.id)

gift1 = Gift.create(name: "Apple Watch", price: 399.99, inventory: 2000)
gift2 = Gift.create(name: "Cashmere Scarf", price: 124,89, inventory: 12)
gift3 = Gift.create(name: "Nike Running Shoes", price: 189.99, inventory: 400)
gift4 = Gift.create(name: "PS5", price: 500.00, inventory: 6 )
gift5 = Gift.create(name: "Ugg Slippers" price: 79.95, inventory: 834)
gift6 = Gift.create(name: "Birthstone Necklace", price: 42.00, inventory: 485)
gift7 = Gift.create(name: "Le Labo Eau de Parfum", price: 192, inventory: 336)
gift8 = Gift.create(name: "L.L Bean Beanie", price: 16.96, inventory: 2448)
gift9 = Gift.create(name: "16 Piece Dinner Set", price: 256.00, inventory: 33)
gift10 = Gift.create(name: "Bose Soundlink Speaker", price: 99.00, inventory: 3737)

add_to_lists1 = AddToList.create(gift_id: gift1.id, list_id: list1.id)
add_to_lists2 = AddToList.create(gift_id: gift3.id, list_id: list2.id)
add_to_lists3 = AddToList.create(gift_id: gift2.id, list_id: list2.id)
add_to_lists4 = AddToList.create(gift_id: gift6.id, list_id: list1.id)
add_to_lists5 = AddToList.create(gift_id: gift4.id, list_id: list2.id)

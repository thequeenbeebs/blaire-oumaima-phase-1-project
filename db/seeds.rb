require_relative '../config/environment'

User.delete_all
List.delete_all 
Gift.delete_all
AddToList.delete_all 
Follow.delete_all

# SEEDS FOR DEMO

santa = User.create(username: "santa")
mrs_claus = User.create(username: "mrs_claus")
nice = List.create(name: "The Nice List", user_id: santa.id, shopping_or_wish: "shopping")
naughty = List.create(name: "The Naughty List", user_id: santa.id, shopping_or_wish: "shopping")
baby = List.create(name: "Santa Baby", user_id: mrs_claus.id, shopping_or_wish: "wish")

elmo = Gift.create(name: "Tickle Me Elmo", price: 48.00, quantity: 1, status: "Purchased")
yoda = Gift.create(name: "Baby Yoda", price: 20.00, quantity: 25, status: "Not Purchased")
switch = Gift.create(name: "Nintendo Switch", price: 299.99, quantity: 2, status: "Not Purchased")
coal = Gift.create(name: "A Lump of Coal", price: 7.99, quantity: 200, status: "Purchased")
convertible = Gift.create(name: "BMW Convertible", price: 49700, quantity: 1, status: "Not Purchased")
ring = Gift.create(name: "Diamond Ring", price: 1000, quantity: 1, status: "Not Purchased")

AddToList.create(gift_id: elmo.id, list_id: nice.id)
AddToList.create(gift_id: yoda.id, list_id: nice.id)
AddToList.create(gift_id: switch.id, list_id: nice.id)
AddToList.create(gift_id: coal.id, list_id: naughty.id)
AddToList.create(gift_id: convertible.id, list_id: baby.id)
AddToList.create(gift_id: ring.id, list_id: baby.id)

Follow.create(follower_id: santa.id, followee_id: mrs_claus.id)



oliviabas = User.create(username: "oliviabas")
shaylynn = User.create(username: "shaylynn")
jameslogan = User.create(username: "jameslogan")
sarahstone = User.create(username: "sarahstone")
johnstewert = User.create(username: "johnstewert")
ronconnor = User.create(username: "ronconnor")
marysmith = User.create(username: "marysmith")

Follow.create(follower_id: oliviabas.id, followee_id: shaylynn.id)
Follow.create(follower_id: oliviabas.id, followee_id: jameslogan.id)
Follow.create(follower_id: oliviabas.id, followee_id: marysmith.id)


list1 = List.create(name: "my christmas", shopping_or_wish: "wishlist", user_id: shaylynn.id)
list2 = List.create(name: "things to get", shopping_or_wish: "shopping list", user_id: sarahstone.id)

gift1 = Gift.create(name: "Apple Watch", price: 399.99, quantity: 1,  status: "Not Purchased")
gift2 = Gift.create(name: "Cashmere Scarf", price: 124.89, quantity: 1, status: "Purchased")
gift3 = Gift.create(name: "Nike Running Shoes", price: 189.99, quantity: 1, status: "Purchased")
gift4 = Gift.create(name: "PS5", price: 500.00, quantity: 1, status: "Not Purchased")
gift5 = Gift.create(name: "Ugg Slippers", price: 79.95, quantity: 1, status: "Not Purchased")
gift6 = Gift.create(name: "Birthstone Necklace", price: 42.00, quantity: 1, status: "Not Purchased")
gift7 = Gift.create(name: "Le Labo Eau de Parfum", price: 192, quantity: 1, status: "Not Purchased")
gift8 = Gift.create(name: "L.L Bean Beanie", price: 16.96, quantity: 1, status: "Not Purchased")
gift9 = Gift.create(name: "16 Piece Dinner Set", price: 256.00, quantity: 1, status: "Not Purchased")
gift10 = Gift.create(name: "Bose Soundlink Speaker", price: 99.00, quantity: 1, status: "Not Purchased")

add_to_lists1 = AddToList.create(gift_id: gift1.id, list_id: list1.id)
add_to_lists2 = AddToList.create(gift_id: gift3.id, list_id: list2.id)
add_to_lists3 = AddToList.create(gift_id: gift2.id, list_id: list2.id)
add_to_lists4 = AddToList.create(gift_id: gift6.id, list_id: list1.id)
add_to_lists5 = AddToList.create(gift_id: gift4.id, list_id: list2.id)

puts "seed file ran"



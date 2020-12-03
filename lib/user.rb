class User < ActiveRecord::Base
    has_many :lists
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :users_i_follow, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :users_following_me, through: :following_users

    def profile_page
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("#{self.username}'s Profile Page") do |option|
            option.choice "View My Lists"
            option.choice "Create A List"
            option.choice "View A Friend's Lists"
            option.choice "Back to Home"
            option.choice "Exit"
        end
        if input == "View My Lists"
            self.view_lists
        elsif input == "Create A List"
            self.create_list
        elsif input == "View A Friend's Lists"
            self.friend_menu
        elsif input == "Back to Home"
            CLI.run
        elsif input == "Exit"
            exit 
        end
    end

    def view_lists
        prompt = TTY::Prompt.new
        if self.lists.length > 0
            puts
            input = prompt.select("#{self.username}'s Lists") do |option|
                self.lists.each do |list|
                    option.choice list.name
                end 
                option.choice "--- Create A List ---"
                option.choice "--- Back to Profile Page ---"
            end
            if input == "--- Create A List ---"
                self.create_list
            elsif input == "--- Back to Profile Page ---"
                self.profile_page
            else
                list = List.find_by(name: input, user_id: self.id)
                self.list_homepage(list)
            end
        else 
            puts
            puts "#{self.username}'s Lists"
            puts
            puts "You haven't created any lists!"
            response = prompt.select("Would you like to create one?") do |option|
                option.choice "Yes"
                option.choice "No"
            end
            if response == "Yes"
                self.create_list
            elsif response == "No"
                self.profile_page
            end
        end
    end

    def create_list
        puts "What would you like to name your list?"
        name = gets.chomp
        prompt = TTY::Prompt.new
        type = prompt.select("Is this a shopping list or a wish list?") do |option|
            option.choice "Shopping"
            option.choice "Wish"
        end
        new_list = List.create(name: name, shopping_or_wish: type, user_id: self.id)
        user = User.find(self.id)
        user.list_homepage(new_list)
    end

    def list_homepage(list)
        puts
        puts list.name.bold
        puts "#{list.shopping_or_wish} List".italic
        list.gifts.each do |gift|
            puts
            puts "Name: #{gift.name}"
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}"
            puts "Status: #{gift.status}"
        end
        total = list.gifts.sum {|gift| gift.price * gift.quantity }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}"
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "Add A Gift"
            option.choice "Edit Gift"
            option.choice "Delete List"
            option.choice "Back to Profile Page"
            #share list?
        end
        if input == "Add A Gift"
            list.add_gift
        elsif input == "Edit Gift"
            list.edit_gift_selector
        elsif input == "Delete List"
            list.delete_list
        elsif input == "Back to Profile Page"
            self.profile_page
        end
    end

    # FRIEND LIST METHODS

    def friend_menu
        prompt = TTY::Prompt.new
        if self.followed_users.length > 0
            input = prompt.select("Select a friend:") do |option|
                self.followed_users.each do |follow|
                    friend = User.find(follow.followee_id)
                    option.choice friend.username
                end
            end
            self.friend_list_menu(input)
        else
            puts "You don't have any friends yet!"
            puts "Add a friend?"
            #tty prompt yes/no
        end
    end

    def friend_list_menu(friend)
        prompt = TTY::Prompt.new
        input = prompt.select("#{friend.username}'s Lists") do |option|
                friend.lists.each do |list|
                    option.choice list.name
                end 
                option.choice "--- Back to My Profile Page ---"
            end
        if input == "--- Back to My Profile Page ---"
                self.profile_page
        else
            list = List.find_by(name: input, user_id: friend.id)
            self.view_friend_list(list)
        end
    end

    def view_friend_list(list)
        puts
        puts list.name.bold
        puts "#{list.shopping_or_wish} List".italic
        list.gifts.each do |gift|
            puts
            puts "Name: #{gift.name}"
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}"
            puts "Status: #{gift.status}"
        end
        total = list.gifts.sum {|gift| gift.price * gift.quantity }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}"
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "Back to Profile Page"
        end
        if input == "Back to Profile Page"
            self.profile_page
        end
    end

end

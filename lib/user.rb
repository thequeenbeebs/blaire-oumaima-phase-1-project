class User < ActiveRecord::Base
    has_many :lists
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :users_i_follow, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :users_following_me, through: :following_users



    def profile_page
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("#{self.username}'s profile".white.bold) do |option|
            option.choice "view my lists"
            option.choice "create a list"
            option.choice "view a friend's lists"
            option.choice "back to home"
            option.choice "exit".white.italic
        end
        if input == "view my lists"
            self.view_lists
        elsif input == "create a list"
            self.create_list
        elsif input == "view a friend's lists"
            self.friend_menu
        elsif input == "back to home"
            CLI.run
        elsif input == "exit".white.italic 
            exit 
        end
    end

    def view_lists
        prompt = TTY::Prompt.new
        if self.lists.length > 0
            puts
            input = prompt.select("#{self.username}'s lists".light_magenta) do |option|
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
            puts "#{self.username}'s lists".magenta
            puts
            puts "you haven't created any lists!"
            response = prompt.select("would you like to create one?") do |option|
                option.choice "yes".bold.italic
                option.choice "no".bold
            end
            if response == "yes"
                self.create_list
            elsif response == "no"
                self.profile_page
            end
        end
    end

    def create_list
        puts "what would you like to name your list?".magenta.bold
        name = gets.chomp
        prompt = TTY::Prompt.new
        type = prompt.select("is this a shopping list or a wish list?".bold.italic) do |option|
            option.choice "shopping"
            option.choice "wish"
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
            puts "Name: #{gift.name}".magenta 
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}".magenta 
            puts "Status: #{gift.status}"
        end
        total = list.gifts.sum {|gift| gift.price * gift.quantity }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}".magenta 
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "add a gift"
            option.choice "edit gift"
            option.choice "delete list"
            option.choice "back to profile page".italic
            #share list?
        end
        if input == "add a gift"
            list.add_gift
        elsif input == "edit gift"
            list.edit_gift_selector
        elsif input == "delete list"
            list.delete_list
        elsif input == "back to profile page".italic
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


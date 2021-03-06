class User < ActiveRecord::Base
    has_many :lists
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :users_i_follow, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :users_following_me, through: :following_users



    def profile_page
        prompt = TTY::Prompt.new
        puts
        input = prompt.select("             #{self.username}'s profile              ".bold.red.on_white) do |option|
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
            input = prompt.select("                  YOUR LISTS                          ".italic.light_magenta) do |option|
                self.lists.each do |list|
                    option.choice list.name
                end 
                option.choice "     create a list     ".italic
                option.choice "     back to profile page     ".italic
            end
            if input == "     create a list     ".italic
                self.create_list
            elsif input == "     back to profile page     ".italic
                self.profile_page
            else
                list = List.find_by(name: input, user_id: self.id)
                self.list_homepage(list)
            end
        else 
            puts
            puts ("                   YOUR LISTS                          ".italic.light_magenta)
            puts
            puts "you haven't created any lists!"
            response = prompt.select("would you like to create one?".light_magenta) do |option|
                option.choice "yes".bold.italic
                option.choice "no".bold
            end
            if response == "yes".bold.italic
                self.create_list
            elsif response == "no".bold
                self.profile_page
            end
        end
    end

    def create_list
        puts 
        puts "what would you like to name your list?".bold
        name = gets.chomp
        prompt = TTY::Prompt.new
        type = prompt.select("is this a shopping list or a wish list?".magenta.bold.italic) do |option|
            option.choice "shopping"
            option.choice "wish"
        end
        new_list = List.create(name: name, shopping_or_wish: type, user_id: self.id)
        user = User.find(self.id)
        user.list_homepage(new_list)
    end

    def list_homepage(list)
        puts list.name.bold
        puts 
        puts "#{list.shopping_or_wish} list".italic
        list.gifts.each do |gift|
            puts
            puts "Name: #{gift.name}".magenta 
            puts "Price: $#{sprintf "%.2f", gift.price}"
            puts "Quantity: #{gift.quantity}".magenta 
            puts "Status: #{gift.status}"
        end
        total = list.gifts.sum {|gift| gift.price * gift.quantity }
        puts
        puts "  Total Cost: $#{sprintf "%.2f", total}   ".magenta.on_white
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
            puts 
            puts
            input = prompt.select("       select a friend:       ".bold.italic.red.on_white) do |option|
                self.followed_users.each do |follow|
                    friend = User.find(follow.followee_id)
                    option.choice friend.username
                end
                option.choice "     add a friend       "
                option.choice "     remove a friend    "
                option.choice "     back to profile page    "
            end
            if input == "     add a friend       "
                self.add_friend
            elsif input == "     remove a friend    "
                self.remove_friend
            elsif input == "     back to profile page    "
                self.profile_page 
            else
                friend = User.find_by(username: input)
                self.friend_list_menu(friend)
            end
        else
            puts 
            puts "you don't have any friends yet!".light_magenta
            puts 
            input = prompt.select("     would you like to add a friend?     ".white.on_red) do |option|
                option.choice "yes".italic
                option.choice "no"
            end
            if input == "yes".italic
                self.add_friend
            elsif input == "no"
                self.profile_page
            end
        end
    end

    def add_friend
        prompt = TTY::Prompt.new
        puts
        puts "please enter your friend's username:".light_magenta
        puts 
        input = gets.chomp
        friend = User.find_by(username: input)
        if friend == nil 
            puts
            puts "that username does not exist.".bold.yellow
        elsif friend == self
            puts
            puts "you cannot be friends with yourself 🥺!"
        else
            Follow.create(follower_id: self.id, followee_id: friend.id)
            puts "          🎊 #{friend.username} is now your friend! 🎊            ".bold.red.on_white
        end
        input = prompt.select("") do |option|
            option.choice "add friend"
            option.choice "back to friend's lists"
            option.choice "back to profile page"
        end
        if input == "add friend"
            self.add_friend
        elsif input == "back to friend's lists"
            user = User.find(self.id)
            user.friend_menu
        elsif input == "back to profile page"
            user = User.find(self.id)
            user.profile_page
        end
    end

    def remove_friend
        prompt = TTY::Prompt.new
        input = prompt.select("which friend do you want to remove?") do |option|
            self.followed_users.each do |follow|
                friend = User.find(follow.followee_id)
                option.choice friend.username
            end
        end
        friend = User.find_by(username: input)
        joiner = Follow.find_by(followee_id: friend.id, follower_id: self.id)
        joiner.destroy
        puts "you have removed #{input}."
        input =prompt.select("") do |option|
            option.choice "back to friend's lists"
            option.choice "back to profile page"
        end
        if input == "back to profile page"
            self.profile_page
        elsif input == "back to friend's lists"
            user = User.find(self.id)
            user.friend_menu
        end
    end

    def friend_list_menu(friend)
        puts "#{friend.username}'s lists"
        if friend.lists.length == 0
            puts
            puts "your friend doesn't have any lists yet!".bold
        end
        prompt = TTY::Prompt.new
        input = prompt.select("") do |option|
            friend.lists.each do |list|
                option.choice list.name
            end 
            option.choice "back to my profile page"
        end
        if input == "back to my profile page"
                self.profile_page
        else
            list = List.find_by(name: input, user_id: friend.id)
            self.view_friend_list(list)
        end
    end

    def view_friend_list(list)
        puts
        puts list.name.bold
        puts "#{list.shopping_or_wish} list".italic
        list.gifts.each do |gift|
            puts
            puts "Name: #{gift.name}".magenta
            puts "Price: $#{sprintf "%.2f", gift.price}".white
            puts "Quantity: #{gift.quantity}".magenta
            puts "Status: #{gift.status}".white
        end
        total = list.gifts.sum {|gift| gift.price * gift.quantity }
        puts
        puts "Total Cost: $#{sprintf "%.2f", total}".bold.italic.light_magenta.on_white 
        prompt = TTY::Prompt.new
        input =prompt.select("") do |option|
            option.choice "back to friend's lists".magenta
            option.choice "back to profile page".italic.white
        end
        if input == "back to profile page".italic.light_magenta
            self.profile_page
        elsif input == "back to friend's lists".magenta
            self.friend_menu
        end
    end

end


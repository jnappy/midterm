require 'trello'
require 'pry'
require 'date'
require 'time'
require 'mailjet'

Trello.configure do |config|
  config.developer_public_key = "2cf4d880ae09b42530515779ed39e091"
  config.member_token =  "2a6f7c3b6148ee681473434a46dc2b9870da73643d7aa1ea14f8a8e8ee262b19" # The token from step 3.
end

Mailjet.configure do |config|
  config.api_key = '8df2e96e86134f42027537d7c76d6100'
  config.secret_key = '000576b46cc6a4a8cfe4fc27086083b2'
  config.default_from = 'jpnappy@gmail.com'
end

def what_is_due(trello_username)
  @me = Trello::Member.find(trello_username)
    @cards, @boards = {}, [] 
      @me.boards.each do |board|
          board.lists.each do |list| 
            #sets up task number so key/value can create unique cards using the same board
            task_number = 1
            list.cards.each do |card|
              #checks if there's a due date or if the card is on a "doing" list
                if (card.due != nil) && ((card.list.name == "Doing") || (card.member_ids.include? @me.id))
                  @cards[board.name + "~ Task #{task_number} "] = (card.name + "- Due on #{card.due.to_date}") 
                  @boards << board.name
                  task_number += 1
                  #conditional to add cards without a due date
                elsif (card.list.name == "Doing") || (card.member_ids.include? @me.id)
                  @cards[board.name + "~ Task #{task_number} "] = card.name
                  @boards << board.name
                  task_number += 1
                end
            end
          end
      end
    @boards.uniq!
end

def create_html
  #creates a hash of the @boards array with indices to be used on line 53  
  boards_with_index = Hash[@boards.map.with_index.to_a] 
    if @cards == {}
      html = "<p>You're working on nothing!</p><br>Enjoy!"
    else 
      @cards.each do |board, card|
        # inserts the board,card key/value into the array at particular index that will be used to generate HTML
        # also the regex was needed to cut off the "~ Task #{task_number}" piece
        @boards.insert((boards_with_index[board[/[^~]+/]] + 1), ["Task: ", card])
        #updates the indices of the @boards array with the new info inserted
        boards_with_index = Hash[@boards.map.with_index.to_a] 
      end
    end

    #adds html to the array that will be used in the mailjet email later
    html = @boards.each do |board|
      if board.class == String 
        board.prepend "<h2>Project: "
        board << "</h2>"
      elsif
        board.prepend "<p>"  
        board << "</p>"
      end
    end
    #makes a string from the array, removes commas
    html = html.flatten.join(",").gsub(",", '')
    return html

end

puts "Hi welcome to TrelloSnapShot © \n
With your Trello username we can give you a snapshot of the tasks you're working on. \n
What is your Trello Username?"

user_trello = gets.strip.downcase

puts "What is your email address?"

user_email = gets.strip.downcase

what_is_due(user_trello)
html = create_html

Mailjet::MessageDelivery.create(
      to: user_email,
      from: "jpnappy@gmail.com",
      subject:  "#{@me.full_name}, your TrelloSnapShot for #{Date.today}",
      html: "Find your current projects and tasks below:" + html
 )


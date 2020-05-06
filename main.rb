require "./lib/game"
require_relative './lib/core_extensions.rb'

class MainMenu
    
    def introduction
        puts "-----------------------"
        puts "WELCOME TO HANGMAN GAME"
        puts "-----------------------"
        puts "1. Start new game"
        puts "2. Load game"
        puts "3. How to play"
        puts "-----------------------"

        input = gets.chomp
        if input =~ /\b[1-3]{1,1}\b/m
            game_mode(input)
            
        else 
            introduction
        end
    end

    def game_mode(input)
        if input == '1'
            #start new game
            game = Game.new
            turn(game)
        
        elsif input == '2'
            puts "please enter game name that you want to load"
            File.open("saves/#{gets.chomp}") do |f|
                game = Marshal.load(f)
            end
            turn(game)
        else 
            puts "Game rules:
            The game gives you a random word from 5 to 12 characters to guess.
            You have 7 turns to guess the word letter by letter.
            Each turn you can type only 1 letter.
            In the start of each turn you can save your game typing: 'save game' without quotes
            Press to continue" 
            gets
            introduction
        end
    end

    def turn(game)
        game.formatted_grid
        if game.input_from_player == "save game"
            save_game(game)
        end
        game.check_input_from_player
        if game.game_over == :win
            puts 'You won'
            game.formatted_grid
        elsif game.game_over == :lose
            puts 'You lose'
        else
            turn(game)
        end
      
    end

    def save_game(game)
        puts 'please name your game'
        if File.directory?('saves') == false
            Dir.mkdir('saves')
        end
        File.open("saves/#{gets.chomp}", 'w+') do |f|
            Marshal.dump(game, f)
        end
        turn(game)
    end
end

start = MainMenu.new
start.introduction
    

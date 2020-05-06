
#adddd missed keys
#turns counter
#check for input
# make saves, serialization

require_relative "core_extensions.rb"

class Game 
    attr_reader :word, :grid, :turns, :guess
    @guess = ''
    
    def initialize
        @word = pick_random_line.split("")
        @grid = make_grid
        @turns = 7
        @guess = ''
        @missed = []
    end

    def pick_random_line
        chosen_word =  File.readlines("dict.txt").sample.chomp
        if chosen_word =~ /\b\w{5,12}\b/m
            chosen_word
        else
            pick_random_line
        end
    end

    def make_grid
        Array.new(word.length){Cell.new}
    end

    def formatted_grid 
            puts
            puts grid.map { |cell| cell.value.empty? ? " _ " : " #{cell.value} " }.join(" ")
            puts
            puts "missed keys: #{@missed.join(', ')}"
            puts "#{@turns} turns left"

    end

    def input_from_player
        @guess = gets.chomp
        
        if @guess =~ /\b[a-z]{1,1}\b/m
            @guess
        elsif @guess == 'save game'
            @guess
            p @guess
            
        else 
            puts "type 1 character a-z"
            input_from_player
        end

    end

    def check_input_from_player
        @word.each_with_index do |letter, index|
            if letter == @guess
                grid[index].value = @guess
            end
        end
        if !@word.include?(@guess)
            @missed.push(@guess)
            @turns -= 1
        end
    end

    def game_over
        if grid.map { |cell| cell.value }.none_empty?
            return :win
        elsif @turns < 1
            return :lose
        else 
            return false
        end
    end






end

class Cell
    attr_accessor :value
    def initialize(value = "")
        @value = value
    end
end


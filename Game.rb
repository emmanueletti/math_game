require './Player'
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

class Game
  def initialize
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @turns = [@player2, @player1]
    @current_player = nil
    @solution = nil
    @response = nil
  end

  # game loop
  def start_game
    loop do
      @current_player = @turns.first
      # player that is not current_player asks a question
      quizzer = @turns.reject { |player| player == @current_player }.first

      quizzer.prompt { generate_question }
      eval_response
      quizzer.prompt { generate_response(@solution == @response) }

      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
      return end_game(quizzer) if @current_player.lives.zero?

      puts '---- NEW TURN ----'
      @turns.reverse!
    end
  end

  private

  def eval_response
    print '> '
    @response = gets.chomp.to_i

    if @solution != @response
      @current_player.lives -= 1
      return false
    end
    true
  end

  def end_game(winner)
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts '---- GAME OVER ----'
    puts 'Goodbye'
  end

  def generate_question
    first_num = rand(1..20)
    second_num = rand(1..20)
    @solution = first_num + second_num
    "What does #{first_num} plus #{second_num} equal? "
  end

  def generate_response(bool)
    return 'YES! Your are correct' if bool

    'Wrong'
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

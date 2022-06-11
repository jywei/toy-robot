class Setup

  def initialize
    table = Table.new(5, 5)
    @simulator = Simulator.new(table)
  end

  def execute
    puts "Enter a command or type EXIT to quit:"

    command = gets.chomp
    while command.downcase !~ /exit/
      output = @simulator.execute(command)
      puts output if output

      # To stop looping
      command = gets.chomp
    end

    finish_game
  rescue Interrupt
    finish_game
  end

  private

    def finish_game
      system "clear" or system "cls"
      puts "Well, that's it!\n\n"
      exit
    end

end

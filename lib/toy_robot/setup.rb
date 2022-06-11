class Setup
  puts "Enter a command or type EXIT to quit:"

  command = gets.chomp
  while command !~ /EXIT/
    output = robot_simulator.execute(command)
    puts output if output
    command = gets.chomp
  end
end

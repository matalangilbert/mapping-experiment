class Target
  attr_accessor :x, :y, :z

  def initialize(x,y,z)
    @x = x
    @y = y
    @z = z
  end
end

NUMBER_OF_TARGETS = ARGV[0].to_i
OUTPUT_FILENAME = "target_locations.csv"
targets = Array.new

#populate targets array
200.step(800,100) do |x|
  200.step(800,100) do |y|
    200.step(800,100) do |z|
         target = Target.new(x, y, z)
         targets << target
    end
  end   
end 

targets.shuffle!
aim = (targets.length * targets.length * targets.length)

r = Random.new 
i=0
best_i = 0
non_improvements = 0

until i == NUMBER_OF_TARGETS
  if targets[i].x == targets[i+1].x || targets[i].y == targets[i+1].y || targets[i].z == targets[i+1].z #if there are 2 consecutive x, y or z values 
    random_place = r.rand(1..targets.length-1) #choose a random place to swap with
    targets[i], targets[random_place] = targets[random_place], targets[i] #swap
    i=0 #reset i, start checking the list again from the start
  end
  i += 1
end

number_of_targets = NUMBER_OF_TARGETS
File.open(OUTPUT_FILENAME,'w') do |f|
  (1..number_of_targets).each do |i|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    f.puts "#{targets[i].x},#{targets[i].y},#{targets[i].z}" 
  end
end

puts "Target file created in:\n'#{Dir.pwd}/#{OUTPUT_FILENAME}'"

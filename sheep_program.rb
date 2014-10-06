#this opens the file to be read
sheepWrite = File.open("Sheep.csv", "r")
data = sheepWrite.readlines
sheepLength = data.length

sheepWrite.rewind

totalSheep = []
#makes an array with all sheep population data points
i = 0
while i < sheepLength
	data[i] = data[i].split(",")
	totalSheep << data[i][1].to_f
	i+=1
end
#adds up all the sheep data points
total_sheep = 0
totalSheep.each do |s|
	total_sheep += s
end
#gets the average sheep population aka the mean
averageSheep = total_sheep / sheepLength
mean = averageSheep

#does subtraction of the average to each number, square the differences and add them all up
total_variance = 0
totalSheep.each do |s|
	total_variance += (mean - s)**2
end
#obtains the standard deviation and variance
length_minus1 = sheepLength - 1
variance = total_variance / length_minus1
standard_deviation = Math.sqrt(variance)

#this is for obtaining the z-scores and putting them into a new file.
outputs = File.open("outputs.txt", "a+")
totalSheep.each do |x|
	z = (x - mean) / standard_deviation
	outputs.write(z)
	outputs.write("\n")
end

#this is what the user will see in the end
puts "This is the total sheep population between 1867 and 1939."
puts total_sheep
puts "This is the average amount of sheep per year."
puts mean.to_i
puts "This is the standard deviation."
puts standard_deviation
puts "The z-scores of this data are in a separate file labeled outputs.txt. Would you like to view them?"

#this is defining the reading of the outputs.txt file for the user.
read_zscores = File.open("outputs.txt", "r")
data_zscores = read_zscores.readlines

#this asks the user if they want to see the z-scores
answer = gets.chomp
if answer == "yes"
	puts "These are the z-scores."
	puts data_zscores
elsif answer == "no"
	read_zscores.close
	puts "As you wish."
end

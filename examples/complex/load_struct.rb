require 'structures'

RodExample::Model.open_database("../tmp/abc.dat")
puts RodExample::MyStruct.count
puts RodExample::YourStruct.count
puts RodExample::HisStruct.count
index = 0
RodExample::MyStruct.each do |object|
  index += 1
  puts index if index % 1000 == 0
  object.to_s
end
RodExample::YourStruct.each do |object|
  object.to_s
end

puts RodExample::MyStruct.find_by_title("title_10")

RodExample::Model.close_database

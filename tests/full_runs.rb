require '../examples/complex/structures.rb'
require '../lib/rod.rb'
require 'test/unit'

module RodTest
	class FullRuns < Test::Unit::TestCase

		MAGNITUDE = 10000
		def setup
			@hs = []
			(MAGNITUDE).times do |i|
			  @hs[i] = RodExample::HisStruct.new
			  @hs[i].inde = i
			end

			@ys = []
			(MAGNITUDE).times do |i|
			  @ys[i] = RodExample::YourStruct.new
			  @ys[i].counter = 10
			  @ys[i].his_structs = @hs[i*10...(i+1)*10] 
			end

			@ms = []
			(MAGNITUDE * 10).times do |i|
			  @ms[i] = RodExample::MyStruct.new
			  @ms[i].count = 10 * i
			  @ms[i].precision = 0.1 * i
			  @ms[i].identifier = i
			  @ms[i].your_struct = @ys[i]
			  @ms[i].title = "title_#{i}"
			  @ms[i].body = "body_#{i}"
			end
		end


		def test_noncontinuous_pages
			test_filename = "tmp/noncontinuous_pages.dat"

			#creation
			RodExample::Model.create_database(test_filename)
			(0..2).each do |j|
				@ms.each_index do |i|
					@ms[i].store if i % 3 == j
				end
				@ys.each_index do |i|
					@ys[i].store if i % 3 == j
				end
				@hs.each_index do |i|
					@hs[i].store if i % 3 == j
				end
			end
			RodExample::Model.close_database

			# verification
			RodExample::Model.open_database(test_filename)
			assert RodExample::MyStruct.count == @ms.count, "MyStruct: should be #{@ms.count}, was #{RodExample::MyStruct.count}!"
			assert RodExample::YourStruct.count == @ys.count, "YourStruct: should be #{@ys.count}, was #{RodExample::YourStruct.count}!"
			assert RodExample::HisStruct.count == @hs.count, "HisStruct: should be #{@hs.count}, was #{RodExample::HisStruct.count}!"
			RodExample::Model.close_database	
		end
	end
end


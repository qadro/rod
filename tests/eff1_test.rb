require '../lib/rod.rb'

module RodTest
	class Exporter < Rod::Exporter
	  def self.create(path,classes)
	    `touch #{__FILE__}` 
	    super(path,classes)
	  end
	end

  class Loader < Rod::Loader
	  def self.open(path, classes)
	    super(path,classes)
    end
  end
 
  class Model < Rod::Model
		def self.exporter_class
			Exporter
		end

		def self.loader_class
			Loader 
	  end

  end

  class AStruct < Model
		field :a0, :ulong
		field :a1, :ulong
		field :a2, :ulong
		field :a3, :ulong
		field :a4, :ulong
		field :a5, :ulong
		field :a6, :ulong
		field :a7, :ulong
		field :a8, :ulong
		field :a9, :ulong
		
		build_structure
	end

  class BStruct < Model
		field :a0, :ulong
		field :a1, :ulong
		field :a2, :ulong
		field :a3, :ulong
		field :a4, :ulong
		field :a5, :ulong
		field :a6, :ulong
		field :a7, :ulong
		field :a8, :ulong
		field :a9, :ulong
		
		build_structure
	end
  
  class CStruct < Model
		field :a0, :ulong
		field :a1, :ulong
		field :a2, :ulong
		field :a3, :ulong
		field :a4, :ulong
		field :a5, :ulong
		field :a6, :ulong
		field :a7, :ulong
		field :a8, :ulong
		field :a9, :ulong
		
		build_structure
	end

  class DStruct < Model
		field :a0, :ulong
		field :a1, :ulong
		field :a2, :ulong
		field :a3, :ulong
		field :a4, :ulong
		field :a5, :ulong
		field :a6, :ulong
		field :a7, :ulong
		field :a8, :ulong
		field :a9, :ulong
		
		build_structure
	end

  class EStruct < Model
		field :a0, :ulong
		field :a1, :ulong
		field :a2, :ulong
		field :a3, :ulong
		field :a4, :ulong
		field :a5, :ulong
		field :a6, :ulong
		field :a7, :ulong
		field :a8, :ulong
		field :a9, :ulong
		
		build_structure
	end

  class EffectivenessTest

		MAGNITUDE = 100000
    FILENAME = "tmp/eff1.dat"

		def setup
			@as = []
			(MAGNITUDE).times do |i|
        @as[i] = AStruct.new
        @as[i].a0 = 0
        @as[i].a1 = 1
        @as[i].a2 = 2
        @as[i].a3 = 3
        @as[i].a4 = 4
        @as[i].a5 = 5
        @as[i].a6 = 6
        @as[i].a7 = 7
        @as[i].a8 = 8
        @as[i].a9 = 9
			end
			@bs = []
			(MAGNITUDE).times do |i|
        @bs[i] = BStruct.new
        @bs[i].a0 = 0
        @bs[i].a1 = 1
        @bs[i].a2 = 2
        @bs[i].a3 = 3
        @bs[i].a4 = 4
        @bs[i].a5 = 5
        @bs[i].a6 = 6
        @bs[i].a7 = 7
        @bs[i].a8 = 8
        @bs[i].a9 = 9
			end
			@cs = []
			(MAGNITUDE).times do |i|
        @cs[i] = CStruct.new
        @cs[i].a0 = 0
        @cs[i].a1 = 1
        @cs[i].a2 = 2
        @cs[i].a3 = 3
        @cs[i].a4 = 4
        @cs[i].a5 = 5
        @cs[i].a6 = 6
        @cs[i].a7 = 7
        @cs[i].a8 = 8
        @cs[i].a9 = 9
			end
			@ds = []
			(MAGNITUDE).times do |i|
        @ds[i] = DStruct.new
        @ds[i].a0 = 0
        @ds[i].a1 = 1
        @ds[i].a2 = 2
        @ds[i].a3 = 3
        @ds[i].a4 = 4
        @ds[i].a5 = 5
        @ds[i].a6 = 6
        @ds[i].a7 = 7
        @ds[i].a8 = 8
        @ds[i].a9 = 9
			end
			@es = []
			(MAGNITUDE).times do |i|
        @es[i] = EStruct.new
        @es[i].a0 = 0
        @es[i].a1 = 1
        @es[i].a2 = 2
        @es[i].a3 = 3
        @es[i].a4 = 4
        @es[i].a5 = 5
        @es[i].a6 = 6
        @es[i].a7 = 7
        @es[i].a8 = 8
        @es[i].a9 = 9
			end
		end

		def main
			Model.create_database(FILENAME)
      (MAGNITUDE / 2).times { |i|
        @as[i].store
      }
      (MAGNITUDE / 2).times { |i|
        @bs[i].store
      }
      (MAGNITUDE / 2).times { |i|
        @cs[i].store
      }
      (MAGNITUDE / 2).times { |i|
        @ds[i].store
      }
      (MAGNITUDE / 2).times { |i|
        @es[i].store
      }
      (MAGNITUDE / 2).times { |i|
        @as[MAGNITUDE/2 + i].store
      }
      (MAGNITUDE / 2).times { |i|
        @bs[MAGNITUDE/2 + i].store
      }
      (MAGNITUDE / 2).times { |i|
        @cs[MAGNITUDE/2 + i].store
      }
      (MAGNITUDE / 2).times { |i|
        @ds[MAGNITUDE/2 + i].store
      }
      (MAGNITUDE / 2).times { |i|
        @es[MAGNITUDE/2 + i].store
      }
      start_t = Time.now.to_f
			Model.close_database
      end_t = Time.now.to_f

      puts "Saving took #{end_t - start_t} seconds"
		end
	end

e = EffectivenessTest.new
e.setup
e.main
end

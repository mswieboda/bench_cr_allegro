require "./mouse"

module Bench
  class BenchObj
    Size = 16

    property x
    property y
    property color
    property speed : Int32

    def initialize
      @x = 0
      @y = 0
      @color = LibAllegro.map_rgb_f(rand, rand, rand)
      @speed = rand(100).to_i
    end

    def initialize(x, y)
      @x = x
      @y = y
      @color = LibAllegro.map_rgb_f(rand, rand, rand)
      @speed = rand(100).to_i
    end

    def update
    end

    def draw(x, y)
      draw(x, y, color)
    end

    def draw(x, y, color)
      x += @x
      y += @y

      LibAllegro.draw_filled_rectangle(x, y, x + Size, y + Size, color)
    end

    def destroy
    end

    def print
      puts "> BenchObj (#{row}, #{col})"
    end
  end
end

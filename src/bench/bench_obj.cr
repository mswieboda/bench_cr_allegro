require "./mouse"

module Bench
  class BenchObj
    SpeedMin = 1
    SpeedMax = 5
    Size = 16

    property x
    property y
    property dx
    property dy
    property color

    def initialize
      @x = 0
      @y = 0
      @dx = 0
      @dy = 0
      @color = LibAllegro.map_rgb_f(rand, rand, rand)

      @dx = rand_speed
      @dy = rand_speed
    end

    def initialize(x, y)
      @x = x
      @y = y
      @dx = 0
      @dy = 0
      @color = LibAllegro.map_rgb_f(rand, rand, rand)

      @dx = rand_speed
      @dy = rand_speed
    end

    def rand_speed
      ((SpeedMin + rand(SpeedMax - SpeedMin)) * (rand > 0.5 ? 1 : -1)).to_i
    end

    def update(screen_width, screen_height)
      @x += dx
      @y += dy

      @dx = -dx if x <= 0 || x + Size >= screen_width
      @dy = -dy if y <= 0 || y + Size >= screen_height
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

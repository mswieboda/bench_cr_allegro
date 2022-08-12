require "./ground"
require "./coal"
require "./tile"
require "./mouse"

module Bench
  class Map
    property x
    property y
    property width
    property height
    property tiles

    def initialize
      @x = 0
      @y = 0
      @width = 0
      @height = 0
      @tiles = [] of Tile
    end

    def update(mouse : Mouse)
      map_mouse = Mouse.new(mouse.x - x, mouse.y - y)

      tiles.each(&.update(map_mouse))
    end

    def draw
      tiles.each(&.draw(x, y))
    end

    def destroy
      tiles.each(&.destroy)
    end
  end
end

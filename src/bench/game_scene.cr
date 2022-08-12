require "./scene"
require "./map"

module Bench
  class GameScene < Scene
    property map

    def initialize
      super

      @name = :game_scene
      @map = Map.new
    end

    def initialize(screen_width, screen_height)
      super(screen_width, screen_height)

      @name = :game_scene
      @map = Map.new
    end

    def init
      init_map
    end

    def init_map
      # tiles
      (screen_width / Tile::Size).to_i.times do |col|
        (screen_height / Tile::Size).to_i.times do |row|
          map.tiles << Tile.new(row, col)
        end
      end
    end

    def update(keys : Keys, mouse : Mouse)
      if keys.just_pressed?(LibAllegro::KeyEscape)
        @exit = true
        return
      end

      map.update(mouse)
    end

    def draw
      map.draw
    end

    def destroy
      map.destroy
    end
  end
end

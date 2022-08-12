require "./scene"
require "./map"
require "./bench_obj"

module Bench
  class GameScene < Scene
    property fps
    property map
    property objs
    property frames

    ObjsPerFrame = 15
    QuitFPS = 30

    def initialize
      super

      @fps = FPSDisplay.new
      @map = Map.new
      @objs = [] of BenchObj
      @time_start = Time.local
      @frames = 0
      @current_fps = 0
    end

    def initialize(screen_width, screen_height)
      super(screen_width, screen_height)

      @fps = FPSDisplay.new
      @map = Map.new
      @objs = [] of BenchObj
      @time_start = Time.local
      @frames = 0
      @current_fps = 0
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
      if (frames > 300 && @current_fps <= QuitFPS) || keys.pressed?([LibAllegro::KeyEscape, LibAllegro::KeySpace, LibAllegro::KeyEnter, LibAllegro::KeyX])
        print_exit

        @exit = true

        return
      end

      objs.each(&.update)

      add_objs

      @frames += 1
    end

    def calc_fps
      @current_fps = @fps.calc
    end

    def add_objs
      ObjsPerFrame.times do
        obj = BenchObj.new(rand(screen_width - BenchObj::Size), rand(screen_height - BenchObj::Size))

        @objs << obj
      end
    end

    def draw
      map.draw

      objs.each(&.draw(0, 0))

      @fps.draw(objs.size, frames)
    end

    def destroy
      map.destroy
      objs.each(&.destroy)
    end

    def print_exit
      return if exit?

      now = Time.local
      time = now - @time_start

      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      puts ">\tobjs: #{objs.size}"
      puts ">\ttotal sec: #{time.total_seconds.round(1)}s"
      puts ">\tframes: #{frames}"
      puts ">\tlast avg fps: #{@current_fps}"
      puts ">\tended: #{now}"
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    end
  end
end

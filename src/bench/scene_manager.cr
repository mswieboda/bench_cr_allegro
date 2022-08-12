require "./scene"
require "./keys"
require "./mouse"
require "./fps_display"
require "./game_scene"

module Bench
  class SceneManager < Scene
    property? redraw
    property keys
    property mouse

    property scene : GameScene

    def initialize(screen_width, screen_height)
      super(screen_width, screen_height)

      @redraw = false

      @keys = Keys.new
      @mouse = Mouse.new

      @scene = GameScene.new(screen_width, screen_height)
    end

    def init
      scene.init
    end

    def update(event : LibAllegro::Event)
      case(event.type)
      when LibAllegro::EventTimer
        @exit = true if scene.exit?
        update(keys, mouse)
        keys.reset

        @redraw = true
      when LibAllegro::EventMouseAxes
        # TODO: make a mouse input holder, similar to Keys
        #       then put both Keys and Mouse inside Input ?
        mouse.x = event.mouse.x;
        mouse.y = event.mouse.y;
      when LibAllegro::EventKeyDown
        keys.pressed(event.keyboard.keycode)
      when LibAllegro::EventKeyUp
        keys.released(event.keyboard.keycode)
      when LibAllegro::EventDisplayClose
        @exit = true
      end
    end

    def update(keys : Keys, mouse : Mouse)
      scene.update(keys, mouse)
    end

    def draw
      scene.draw
    end

    def reset
      super

      @redraw = false
    end

    def destroy
      scene.destroy
    end

    def calc_fps
      scene.calc_fps
    end
  end
end

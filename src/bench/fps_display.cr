module Bench
  class FPSDisplay
    TimeSpan = 10

    Margin = 3
    Width = 100
    TextHeight = 10
    BarHeight = 3
    DarkShadow = LibAllegro.map_rgba_f(0, 0, 0, 0.69)
    Green = LibAllegro.map_rgba_f(0, 1, 0, 0.69)

    def initialize
      @time_start = Time.local
      @time_end = Time.local
      @frames = 0
      @str_fps = ""
      @str_time = ""
      @fps_percent = 0.0
      @font = LibAllegro.create_builtin_font
    end

    def calc
      @time_end = Time.local
      time = @time_end - @time_start
      fps = (@frames + 1) / time.total_seconds
      @str_fps = "#{fps.round(2)}"
      @str_time = "#{time.total_seconds.round(1)}s"
      @fps_percent = time.total_seconds / TimeSpan * 100
      @frames += 1

      if time.total_seconds >= TimeSpan
        @time_start = Time.local
        @frames = 0
      end

      return fps.to_i
    end

    def draw(obj_count, frames)
      height_total = Margin * 3 + TextHeight + BarHeight + Margin + TextHeight + Margin + TextHeight + Margin
      height = Margin

      LibAllegro.draw_filled_rectangle(Margin, height, Width + Margin * 3, height_total, DarkShadow)

      height += Margin

      LibAllegro.draw_text(@font, Green, Margin * 3, height, LibAllegro::AlignInteger, @str_fps)
      LibAllegro.draw_text(@font, Green, Width + Margin, height, LibAllegro::AlignRight, @str_time)

      height += TextHeight + Margin

      LibAllegro.draw_filled_rectangle(Margin * 2, height, Margin * 2 + @fps_percent, height + BarHeight, Green)

      height += BarHeight + Margin

      LibAllegro.draw_text(@font, Green, Margin * 3, height, 0, obj_count.to_s)
      LibAllegro.draw_text(@font, Green, Width + Margin, height, LibAllegro::AlignRight, "objs")

      height += TextHeight + Margin

      LibAllegro.draw_text(@font, Green, Margin * 3, height, 0, frames.to_s)
      LibAllegro.draw_text(@font, Green, Width + Margin, height, LibAllegro::AlignRight, "frames")
    end
  end
end

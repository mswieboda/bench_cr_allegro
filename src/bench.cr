require "crystal_allegro"

require "./bench/main"

module Bench
  VERSION = "0.1.0"

  Main.new.run
end

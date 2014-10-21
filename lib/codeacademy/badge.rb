module Codeacademy
  class Badge
    attr_reader :achievement_type, :title, :date

    def initialize(achievement_type, title, date)
      @achievement_type = achievement_type
      @title = title
      @date = date
    end
  end
end
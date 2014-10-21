require 'open-uri'
require 'nokogiri'
require_relative 'badge'

module Codeacademy
  class User
    class UnknownUserError < StandardError; end

    def initialize(username)
      @username = username
    end

    def exist?
      begin
        fetch achievements_url
        true
      rescue UnknownUserError
        false
      end
    end

    def badges(achievement_type = 'ruby')
      badges = []
      doc = Nokogiri::HTML(fetch achievements_url)
      doc.css(".achievement-card").each do |element|
        if element.css(".cc-achievement--#{achievement_type}-achievement").any?
          title = element.css('h5').first.text
          date = Date.parse(element.css('small small').first.text)
          badges << Badge.new(achievement_type, title, date)
        end
      end
      badges.sort_by &:date
    end

    private

    def achievements_url
      "http://www.codecademy.com/users/#{@username}/achievements"
    end

    def fetch(url)
      response = Net::HTTP.get_response(URI.parse(url))
      case response
      when Net::HTTPSuccess     then response.body
      when Net::HTTPNotFound then fail UnknownUserError
      else
        response.error!
      end
    end
  end
end
require 'json'
require 'webrick'

module Phase8

  class MyHash
    def initialize
      @hash = {}
    end
    
    def [](key)
      @hash[key.to_s]
    end

    def []=(key, value)
      @hash[key.to_s] = value
    end

    def to_json
      @hash.to_json
    end
  end

  class Flash

    def initialize(req)
      cookie = req.cookies.find { |c| c.name == 'rails_lite_app_flash' }

      @flash_now = MyHash.new
      @data = MyHash.new

      if cookie
        JSON.parse(cookie.value).each do |key, val|
          @flash_now[key] = value
        end
      end
    end

    def now
      @flash_now ||= MyHash.new
    end

    def [](key)
      @data[key] || now[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    def store_flash(res)
      cookie = WEBrick::Cookie.new("_rails_lite_app_flash", @data.to_json)
      
      cookie.path = "/"
      res.cookies << cook
    end
  end

end






end
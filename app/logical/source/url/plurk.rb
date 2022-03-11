# frozen_string_literal: true

class Source::URL::Plurk < Source::URL
  attr_reader :username, :work_id

  def self.match?(url)
    url.domain == "plurk.com"
  end

  def parse
    case [domain, *path_segments]

    # https://images.plurk.com/5wj6WD0r6y4rLN0DL3sqag.jpg
    # https://images.plurk.com/mx_5wj6WD0r6y4rLN0DL3sqag.jpg
    in "plurk.com", /^(mx_)?(\w{22})\.(\w+)$/
      @image_id = $2

    # https://www.plurk.com/p/om6zv4
    in "plurk.com", "p", work_id
      @work_id = work_id

    # https://www.plurk.com/m/p/okxzae
    in "plurk.com", "m", "p", work_id
      @work_id = work_id

    # https://www.plurk.com/redeyehare
    in "plurk.com", username
      @username = username

    # https://www.plurk.com/m/redeyehare
    in "plurk.com", "m", username
      @username = username

    else
    end
  end

  def image_url?
    host == "images.plurk.com"
  end
end
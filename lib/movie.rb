require 'json'

class Movie
  include HTTParty

  attr_accessor :name, :year, :poster, :file_path, :description, :runtime, :rated, :director, :actors

  def initialize(response, original_file)
    response = JSON.parse(response)
    self.name=(response['Title'])
    self.year=(response['Year'])
    self.poster=(response['Poster'])
    self.description=(response['Plot'])
    self.runtime=(runtime_to_minutes(response['Runtime']))
    self.rated=(response['Rated'])
    self.director=(response['Director'])
    self.actors=(response['Actors'])
    self.file_path=(original_file)
    # p "File path: " + self.file_path
  end

  def file_path=(val)
    # Convert to server path
    @file_path = val.gsub(VIDEOS_PATH, ROKSBOX_PATH)
  end

  protected
  def runtime_to_minutes(val)
    # Expects a format of "1 hr 50 mins"
    val = val.split(/hr/)
    (val[0].to_i * 60) + val[1].to_i
  end

end

# <movie>
#   <origtitle>Avatar</origtitle>
#   <year>2009</year>
#   <genre>Action, Adventure, Sci-Fi</genre>
#   <mpaa>Rated PG-13</mpaa>
#   <director>James Cameron</director>
#   <actors>Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang</actors>
#   <description>A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.</description>
#   <path>Z:\WWW\WWW-pub\Media\Videos\Avatar.mp4</path>
#   <length>120</length>
#   <videocodec>mp4</videocodec>
#   <poster>images/Avatar.jpg</poster>
# </movie>
require 'json'

class Movie
  include HTTParty

  attr_accessor :name, :year, :poster, :file_path

  def initialize(response, original_file)
    response = JSON.parse(response)
    self.name=(response['Title'])
    self.year=(response['Year'])
    self.poster=(response['Poster'])
    self.file_path=(original_file)
    # assign_attributes_from_hash(response)
  end

  def assign_attributes_from_hash(response)
    response.keys.each do |key|
      p response[key]
    end
  end

end

# <movie>
#   <origtitle>The Assassination of Jesse James by the Coward Robert Ford</origtitle>
#   <year> nothing</year>
#   <length> dunno </length>
#   <description>Everyone in 1880's America knows Jesse James. He's the nation's most notorious criminal, hunted by the law in 10 states. He's also the land's greatest hero, lauded as a Robin Hood by the public. Robert Ford? No one knows him. Not Yet. But the ambitious 19-year-old aims to change that. He'll befriend Jesse, ride with his gang. And if that doesn't bring Ford fame, he'll find a deadlier way.</description>
#   <mpaa>Rated R</mpaa>
#   <path>\Volumes\MAXTOR (F)\Video\Movies\The Assassination of Jesse James.mp4</path>
#   <poster>http://cf2.imgobject.com/t/p/w342/lSFYLoaL4eW7Q5VQ7SZQP4EHRCt.jpg</poster>
#   <videocodec>mp4</videocodec>
# </movie>
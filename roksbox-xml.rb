#!/usr/bin/env ruby

# The media drive needs to be mounted on your local machine with a local
# path to work!!!

# SET THESE VALUES
# Path to video folder on your local machine
VIDEO_PATH = "/Volumes/MAXTOR (F)/Video"
# The root path Roksbox is looking for
SERVER_PATH = "F:\\\\"

# Global values
sub_directories = []
s_sub_directories = []
video_files = []

Dir.chdir(VIDEO_PATH) #TODO move to setup()

def movie_node_template(movie)
    "<movie>
      <origtitle>#{movie_title(movie)}</origtitle>
      <year></year>
      <genre>#{genres(movie)}</genre>
      <mpaa></mpaa>
      <director></director>
      <actors></actors>
      <description></description>
      <path>#{web_server_path(movie)}</path>
      <length></length>
      <videocodec>#{video_codec(movie)}</videocodec>
      <poster>#{poster_path(movie)}</poster>
    </movie>
    "
end

def web_server_path(file_path)
  # FIXME get that gsub to use VIDEO_PATH and SERVER_PATH
  file_path.gsub('/', '\\')
    .gsub('\Volumes\MAXTOR (F)', 'F:\\\\')
    .gsub('&', '&amp;')
end

def movie_title(file_path)
  File.basename(file_path)
    .gsub('&', '&amp;')
    .gsub(File.extname(file_path), '')
    .gsub('.', ' ')
end

def genres(file_path)
  # TODO Get sub genres
  file_path.split('/')[-2]
end

def valid_video_format(file_path)
  # TODO Determine definite list for supported file formats
  valid_formats = [".mp4", ".m4v", ".wmv"]
  valid_formats.include?(File.extname(file_path))
end

def valid_video_title(file_path)
  # FIXME
  r = Regexp.new('^._') # skip hidden files
  return true unless file_path.match(r)
end

def poster_path(file_path)
  # Assumes images are in 'images/' in the root dir
  file = movie_title(file_path).gsub(' ', '-').downcase
  "images/#{genres(file_path)}/#{file}.jpg"
end

def video_codec(file_path)
  # TODO Get actual codecs and map
  File.extname(file_path).gsub('.', '')
end

Dir['*/'].each do | dir|
  unless dir == "images/"
    sub_directories << "#{VIDEO_PATH}/#{dir}"
  end
end

def setup
  
end

def parse_directory(dir)
  
end

def generate_xml_file
  
end

def generate_xml_node(movie)
  
end


# TODO break into a function
sub_directories.each do |s|
  Dir.chdir(s)
  Dir.entries(Dir.pwd).each do |i|
    s_sub_directories = []
    f_path = Dir.pwd() + "/" + i
    f = File.absolute_path(f_path)
    if !File.directory?(f)
      if valid_video_format(f)
        video_files << f
      else
        # p "Check on video" + f_path
      end
    else
      s_sub_directories << "#{f_path}"
    end
    # loop through sub_directories?
    # they will have genre subdirectories
    s_sub_directories.each do |d|
      Dir.chdir(d)
      Dir.entries(Dir.pwd).each do |h|
        f_path = Dir.pwd() + "/" + h
        p f_path
        f = File.absolute_path(f_path)
        if !File.directory?(f)
          if valid_video_format(f)
            # FIXME This is just duplicating shit right now
            video_files << f
          end
        end

      end
    end

  end


  # TODO Move to generate_xml_file
  File.open("#{VIDEO_PATH}/video.xml", 'w') { |f| 
    f.write('<xml>
    <viddb>
    ')
    video_files.each do |v|
      # TODO Move to generate_xml_node
      f.write(movie_node_template(v)) 
    end
    f.write('</viddb>
  </xml>')
  }

end




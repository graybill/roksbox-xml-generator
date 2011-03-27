#!/usr/bin/env ruby

# The media drive needs to be mounted on your local machine with a local
# path to work!!!

# SET THESE VALUES
# Path to video folder on your local machine
VIDEO_PATH = "/Volumes/MAXTOR (F)/Video"
# The root path Roksbox is looking for
SERVER_PATH = "F:\\\\"

# Global values
@sub_directories = []
@s_sub_directories = []
@video_files = []



def movie_node_template(file)
  "<movie>
    <origtitle>#{movie_title(file)}</origtitle>
    <year></year>
    <genre>#{genres(file)}</genre>
    <mpaa></mpaa>
    <director></director>
    <actors></actors>
    <description></description>
    <path>#{web_server_path(file)}</path>
    <length></length>
    <videocodec>#{video_codec(file)}</videocodec>
    <poster>#{poster_path(file)}</poster>
  </movie>
  "
end

def web_server_path(file_path)
  # FIXME get that gsub to use VIDEO_PATH and SERVER_PATH
  file_path.gsub('/', '\\')
    .gsub('\Volumes\MAXTOR (F)', 'F:\\\\')
    .gsub('&', '&amp;')
end

def file_path(file)
  Dir.pwd() + "/" + file
end

def movie_title(file_path)
  File.basename(file_path)
    .gsub(File.extname(file_path), '')
    .gsub('.', ' ')
    .gsub('&', '&amp;')
end

def genres(file_path)
  # TODO Get sub genres, anything after Video and before extname
  file_path.split('/')[-2]
end

def valid_video_format(file_path)
  # TODO Determine definite list for supported file formats
  valid_formats = [".mp4", ".m4v", ".wmv"]
  valid_formats.include?(File.extname(file_path))
end

def valid_video_title(file_path)
  r = Regexp.new('^.') # skip hidden files
  file_path.match(r)
end

def poster_path(file_path)
  # Assumes images are in 'images/' in the SERVER_PATH root dir
  file = movie_title(file_path).gsub(' ', '-').downcase
  "images/#{genres(file_path)}/#{file}.jpg"
end

def video_codec(file_path)
  # TODO Get actual codecs and map
  File.extname(file_path).gsub('.', '')
end

def generate_xml_file
  # TODO Move to generate_xml_file
  File.open("#{VIDEO_PATH}/video.xml", 'w') { |f| 
    f.write('<xml>
    <viddb>
    ')
    @video_files.each do |v|
      f.write(generate_xml_node(v)) 
    end
    f.write('</viddb>
  </xml>')
  }
end

def generate_xml_node(movie)
  movie_node_template(movie)
end

def parse_directories
  @sub_directories.each do |s|
    Dir.chdir(s)
    Dir.entries(Dir.pwd).each do |entry|
      parse_directory(entry)
    end #end Dir.entries
  end
end

def parse_directory(dir)
  # TODO Send sub directories here
  f_path = file_path(dir)
  f = File.absolute_path(f_path)
  if !File.directory?(f)
    if valid_video_format(f)
      @video_files << f
    else
      p "Check on video" + f_path
    end
  else
    @s_sub_directories << "#{f_path}"
  end
end

def init
  Dir.chdir(VIDEO_PATH) #TODO move to setup()
  Dir['*/'].each do | dir|
    unless dir == "images/"
      @sub_directories << "#{VIDEO_PATH}/#{dir}"
    end
  end
  parse_directories
  generate_xml_file
end

init # Kick it off
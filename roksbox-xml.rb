#!/usr/bin/env ruby

# The media drive needs to be mounted on your local machine with a local
# path to work!!!
# Local path to root video folder
VIDEO_PATH = "/Volumes/MAXTOR (F)/Video"
SERVER_PATH = "F:\\\\"

Dir.chdir(VIDEO_PATH)
sub_directories = []
video_files = []

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
  file_path.gsub('/', '\\').gsub(VIDEO_PATH, SERVER_PATH).gsub('&', '&amp;')
end

def movie_title(file_path)
  File.basename(file_path).gsub('&', '&amp;') 
end

def genres(file_path)
  file_path.split('/')[-2]
end

def valid_video_format(file_path)
  valid_formats = [".mp4", ".mov", ".m4v", ".wmv"]
  valid_formats.include?(File.extname(file_path))
end

def poster_path(file_path)
  "images/Movies/rear-window.jpg"
end

def video_codec(file_path)
  File.extname(file_path).gsub('.', '')
end

Dir['*/'].each do | dir|
  unless dir == "images/"
    sub_directories << "#{VIDEO_PATH}/#{dir}"
  end
end

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
        p "Check on video" + f_path
      end
    else
      s_sub_directories << "#{f_path}"
    end
    # loop through sub_directories?
  end

  File.open("#{VIDEO_PATH}/video.xml", 'w') { |f| 
    f.write('<xml><viddb>
    ')
    video_files.each do |v|
      f.write(movie_node_template(v)) 
    end
    f.write('</viddb></xml>')
  }

end




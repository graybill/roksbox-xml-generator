class RoksboxFile

  @files = []

  def get_directories(file_path)
    recurse(file_path)
  end

  Entry = Struct.new(:dir,:children) 
  def recurse(path) 
   entry = Entry.new(path,[]) 
   #no "." or ".." dirs 
   Dir["#{path}/*"].each do |e|
    p e
    if File.directory?(e)
      entry.children <<  recurse(e)
    end 
   end 
   @files << entry
  end 

  def build_xml_file
    File.open("video.xml", 'w') { |f| 
      f.write("<xml><viddb>")
      f.write("</viddb></xml>")
    }
  end

end
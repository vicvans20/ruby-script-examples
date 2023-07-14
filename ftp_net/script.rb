require 'net/ftp'
require 'pathname' # Dynamic current directory
require 'byebug'

puts "Start!"
ftp = Net::FTP.new('192.168.0.1') # Local server
ftp.login
begin
  puts "Current directory is #{ftp.pwd}"

  # Get directory list and move to first directory found
  directory_paths = ftp.nlst('/') # The nlst method retrieves a list of file names in the specified directory. kinda like `ls -p ./ | grep -v /`
  puts "Directories found: #{directory_paths}"
  ftp.chdir(directory_paths.first) # Move to first directory found

  # Display files found!
  puts "Files on #{ftp.pwd}: \n===================="
  file_names = ftp.nlst
  puts file_names
  puts "===================="
  # Search for a random image and download it
  random_image_name = file_names.detect { |file| file =~ /jpeg/ }
  puts "Found! #{random_image_name}" if random_image_name
  
  source_path = File.join(ftp.pwd, random_image_name) # File.join format the path correctly
  current_path = File.dirname(File.expand_path(__FILE__))
  destination_path = File.join(current_path, random_image_name)

  ftp.get(source_path, destination_path)
ensure
  ftp.close
  puts "End!"
end
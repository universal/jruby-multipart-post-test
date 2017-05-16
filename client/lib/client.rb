require 'net/http/post/multipart'

puts "Starting requests"

target = 'http://localhost:3000/upload'

puts "#"*80
puts "trying some normal requests first"
url = URI.parse(target)
Net::HTTP.start(url.host, url.port) do |http|
  puts "sending get request"
  response = http.request_get("/test")
  puts response.body
  puts "sending post request"
  response = http.request_post("/upload", "somedata")
  puts response.body
end

puts "#"*80
puts "trying multipart post now"

# 1. try
puts "#"*10
puts "1. try with opening in 'rb' mode"
puts "binary mode argument is necessary for JRuby!"
File.open("./image.jpg", 'rb') do |jpg|
   req = Net::HTTP::Post::Multipart.new url.path,
     "file" => UploadIO.new(jpg, "image/jpeg", "image.jpg")
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
  puts res.inspect
end

# 2. try
puts "#"*10
puts "2. try with just File.new -- and optional binary mode argument"
puts "binary mode argument is necessary for JRuby!"

def model_params file:
  {
    some: "test",
    image: UploadIO.new(File.new(file, "rb"), "application/octet-stream", File.basename(file))
  }
end

Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Post::Multipart.new(url, model_params(file: "./image.jpg"))
  http.request(req)
end


puts "#"*80
puts "Checks with text files"
path = 'test.txt'

tests = ["\r", "\n", "\0", "\r\n"]
contents = ["", "a"].map do |i|
  tests.map do |j|
    "#{i}#{j}"
  end
end.flatten + tests.map {|i| "#{i}a"}

["r", "rb"].each do |mode|
  puts "#"*20
  puts "Trying with mode: #{mode}"
  contents.each do |content|
    puts "Trying content: #{content.inspect}"
    File.open(path, 'w') do |f|
      f.print content
    end

    begin
      File.open(path, mode) do |f|
        req = Net::HTTP::Post::Multipart.new url.path,
          "file" => UploadIO.new(f, "text/plain", "test.txt")
        res = Net::HTTP.start(url.host, url.port, read_timeout: 2) do |http|
          http.request(req)
        end
        puts "success"
      end
    rescue => e
      puts ">>> Failed! <<<"
    end
  end
end

puts "finished"



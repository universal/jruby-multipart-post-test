require 'net/http/post/multipart'

puts "Starting requests"

target = 'http://localhost:3000/upload'

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

puts "trying multipart post now"
# 1. try
url = URI.parse(target)
File.open("./image.jpg") do |jpg|
   req = Net::HTTP::Post::Multipart.new url.path,
     "file" => UploadIO.new(jpg, "image/jpeg", "image.jpg")
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
  puts res.inspect
end


# 2. try
def model_params file:
  {
    some: "test",
    image: UploadIO.new(File.new(file), "application/octet-stream", File.basename(file))
  }
end

url = URI.parse(target)
Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Post::Multipart.new(url, model_params(file: "./image.jpg"))
  http.request(req)
end

puts "finished"



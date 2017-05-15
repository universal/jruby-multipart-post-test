# Testing multipart-post with Ruby/JRuby on Windows (and Ubuntu)

I've been using Ruby 2.3.3 as a starting point, since that is what I have on Windows 10 and Ubuntu. It works using Ruby/JRuby under Ubuntu. The endpoint is for now only a dummy rails app, which just responds with a text/plain answer.

The dummy endpoint doesn't work with either ruby or jruby, so it might be a problem in that code, not in jruby/multipart-post. Though using curl posting to it works just fine, so I'm not sure where the error actually is.

## Server Steps
 * cd to the rails_endpoint directory
 * run ```bundle```
 * run ```rails s```


## Working:
### Client using Ruby 2.3.3 (Windows and Ubuntu ) against Rails 5.1 endpoint

#### Steps to reproduce:
 * 'activate' Ruby 2.3.3
 * cd to the client directory
 * run ```bundle```
 * run ```ruby lib/client.rb```

## Not Working:
### Client using JRuby on Windows 10 against Rails 5.1 endpoint
#### Steps to reproduce:
 * 'activate' JRuby
 * cd to the client directory
 * run ```bundle```
 * run ```jruby lib/client.rb```

#### Alternative steps to reproduce:
 * 'activate' Ruby 2.3.3
 * cd to the client directory
 * run ```bundle```
 * run ```warble compiled jar```
 * run ```java -jar client.jar```




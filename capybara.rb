def basic_auth
  puts "yeahhhhh"
  encoded_login = ["hoge:fuga"].pack("m*").gsub(/\n/,"")
  page.header 'Authorization', "Basic #{encoded_login}"
end

def hello
  puts "hello   "
end
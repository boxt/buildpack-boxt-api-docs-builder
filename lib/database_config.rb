def create_database_yml
  return false unless File.directory?("config")
  puts("create_database_yml")
  File.open("config/database.yml", "w") do |file|
    file.puts <<-DATABASE_YML
<%
require 'cgi'
require 'uri'
begin
 uri = URI.parse(ENV["DATABASE_URL"])
rescue URI::InvalidURIError
 raise "Invalid DATABASE_URL"
end
raise "No RACK_ENV or RAILS_ENV found" unless ENV["RAILS_ENV"] || ENV["RACK_ENV"]
def attribute(name, value, force_string = false)
 if value
   value_string =
     if force_string
       '"' + value + '"'
     else
       value
     end
   "\#{name}: \#{value_string}"
 else
   ""
 end
end
adapter = uri.scheme
adapter = "postgresql" if adapter == "postgres"
database = (uri.path || "").split("/")[1]
username = uri.user
password = uri.password
host = uri.host
port = uri.port
params = CGI.parse(uri.query || "")
%>
<%= ENV["RAILS_ENV"] || ENV["RACK_ENV"] %>:
 <%= attribute "adapter",  adapter %>
 <%= attribute "database", database %>
 <%= attribute "username", username %>
 <%= attribute "password", password, true %>
 <%= attribute "host",     host %>
 <%= attribute "port",     port %>
<% params.each do |key, value| %>
 <%= key %>: <%= value.first %>
<% end %>
     DATABASE_YML
  end
end

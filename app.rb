require 'sinatra'
require 'securerandom'

get '/' do
  erb :index
end

get "/form" do
  erb :form
end

post '/criar' do
  id = "#{Time.now.strftime('%Y%m%d%H%M%S')}-#{SecureRandom.hex(4)}"
  titulo = params[:titulo]
  remetente = params[:remetente]
  conteudo = params[:conteudo]
  template = params[:template]

  carta_html = erb :carta, locals: { titulo: titulo, remetente: remetente, conteudo: conteudo, template: template }, layout: false
  
  File.write("./public/cartas/#{id}.html", carta_html)

  redirect "/carta/#{id}"
end

get '/carta/:id' do
  id = params[:id]
  send_file "./public/cartas/#{id}.html"
end

get '/sobre' do
  erb :sobre
end
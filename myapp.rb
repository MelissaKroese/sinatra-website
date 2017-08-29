require 'sinatra'
require 'csv'

get '/' do
  erb :home_page
end

post '/thank_you' do
  CSV.open("leads.csv", "a") do |csv|
    csv << [params[:firstname], params[:lastname], params[:email]]
  end

  erb :thank_you, locals: {
    firstname: params["firstname"],
    email: params["email"]
  }
end

get '/admin' do
  leads = CSV.read('leads.csv')
  erb :admin, locals: { leads: leads }
end
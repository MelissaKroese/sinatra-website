require 'sinatra'
require 'csv'

get '/' do
  erb :home_page
end

post '/thank_you' do
  CSV.open("leads.csv", "a") do |csv|
    csv << [params[:firstname], params[:lastname], params[:email], params[:created_at]]
  end

  erb :thank_you, locals: {
    firstname: params["firstname"],
    email: params["email"]
  }
end

get '/admin' do
  leads = CSV.read('leads.csv')

  leads.sort! { |x, y| x[0] <=> y[0] }

  erb :admin, locals: { leads: leads }

end


get '/leads.csv' do
  content_type 'application/csv'
  attachment "#{Time.now}-download-leads.csv"
  File.open('leads.csv').read.to_s
end

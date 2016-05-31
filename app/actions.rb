# Homepage (Root path)
get '/' do
  erb :index
end

get '/contact/show' do
  content_type :json
  @contact = Contact.find(params[:id].to_i)
  {contact: @contact}.to_json

end

post '/contact/new' do
  @contact = Contact.new
  @contact.first_name = params[:first]
  @contact.last_name = params[:last]
  @contact.numbers << Number.new(phone_number:params[:number])
  @contact.email = params[:email]
  @contact.save
end

post '/contact/update' do
  @contact = Contact.find(params[:contact_id])
  ##Update the contact with the passed in data
  binding.pry
end

get '/contacts/all' do
  @contacts = Contact.all
  {contacts: @contacts}.to_json
end

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
  content_type :json
  @contact = Contact.new
  @contact.first_name = params[:first]
  @contact.last_name = params[:last]
  @contact.numbers << Number.new(phone_number:params[:number])
  @contact.email = params[:email]
  @contact.save
  {contact: @contact}
end

post '/contact/update' do
  @contact = Contact.find(params[:contact_id])
  @contact.first_name = params[:first]
  @contact.last_name = params[:last]
  @contact.email = params[:email]
  @contact.save
end

get '/contacts/all' do
  content_type :json
  @contacts = Contact.all
  {contacts: @contacts}.to_json
end

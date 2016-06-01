# Homepage (Root path)
get '/' do
  erb :index
end

get '/contact/show' do
  content_type :json
  @contact = Contact.find(params[:contact_id].to_i)
  {contact: @contact}.to_json
end

post '/contact/new' do
  content_type :json
  binding.pry
  @contact = Contact.new
  @contact.first_name = params[:first]
  @contact.last_name = params[:last]
  @contact.numbers << Number.new(phone_number:params[:number])
  @contact.email = params[:email]
  if @contact.save
    {contact: @contact}.to_json
  else
    erb :index
  end
end

post '/contact/update' do
  content_type :json
  binding.pry
  @contact = Contact.find(params[:contact_id].to_i)
  @contact.first_name = params[:first]
  @contact.last_name = params[:last]
  @contact.email = params[:email]
  if !(@contact.save)
    erb :index
  end
  {contact: @contact}.to_json
end

post '/contact/destroy' do
  content_type :json
  Contact.destroy(params[:contact_id])
end

get '/contacts/all' do
  content_type :json
  @contacts = Contact.all
  {contacts: @contacts}.to_json
end

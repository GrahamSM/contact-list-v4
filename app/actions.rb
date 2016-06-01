# Homepage (Root path)
get '/' do
  erb :index
end

get '/contact/show' do
  content_type :json
  if Contact.find(params[:form_data].to_i)
    @contact = Contact.find(params[:form_data].to_i)
  end
  {contact: @contact}.to_json
end

post '/contact/new' do
  content_type :json
  @contact = Contact.new
  @contact.first_name = params[:form_data][0]
  @contact.last_name = params[:form_data][1]
  @contact.numbers << Number.new(phone_number: params[:form_data][2])
  @contact.email = params[:form_data][3]
  if @contact.save
    {contact: @contact}.to_json
  else
    erb :index
  end
end

post '/contact/update' do
  content_type :json
  @contact = Contact.find(params[:contact_id].to_i)
  @contact.first_name = params[:form_data][0]
  @contact.last_name = params[:form_data][1]
  @contact.email = params[:form_data][3]
  if !(@contact.save)
    erb :index
  end
  {contact: @contact}.to_json
end

get '/contact/destroy' do
  Contact.destroy(params[:contact_id])
  erb :index
end

get '/contacts/all' do
  content_type :json
  @contacts = Contact.all
  {contacts: @contacts}.to_json
end

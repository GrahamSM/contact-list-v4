# Homepage (Root path)
get '/' do
  erb :index
end

get '/contact/show' do
  content_type :json
  if Contact.find(params[:form_data].to_i)
    @contact = Contact.find(params[:form_data].to_i)
    @numbers = @contact.numbers
  end
  {contact: @contact, numbers: @numbers}.to_json
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
  if !(@contact.update(first_name: params[:form_data][0], last_name: params[:form_data][1], email: params[:form_data][3]))
    erb :index
  else
    {contact: @contact}.to_json
  end
end

get '/contact/destroy' do
  Contact.destroy(params[:contact_id])
  erb :index
end

get '/contacts/all' do
  content_type :json
  @contacts = Contact.all
  @numbers = []
  @contacts.each do |contact|
    @numbers << (contact.numbers.first || "")
  end
  {contacts: @contacts, numbers: @numbers}.to_json
end

post '/contact/add_number' do
  content_type :json
  binding.pry
  @contact = Contact.find(params[:contact_id].to_i)
  @number = Number.new(phone_number: params[:new_number])
  @contact.numbers << @number
  erb :index
end


# TODO: proper error handling. UI/UX.. i.e. No contacts, error here. JS, or just use erb?
# TODO: Multiple append on btn-show?
# TODO: refactor!

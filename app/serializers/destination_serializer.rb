class DestinationSerializer
  include JSONAPI::Serializer

  set_id :null_id do
    "null"
  end
  set_type "books"
  attributes :destination, :forecast, :total_books_found, :books
end
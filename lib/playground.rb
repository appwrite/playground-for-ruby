# frozen_string_literal: true

require "appwrite"
require "dotenv/load"
require "json"
require "colorize"

$client = Appwrite::Client.new

appwrite_endpoint = ENV["APPWRITE_ENDPOINT"]
appwrite_project = ENV["APPWRITE_PROJECT_ID"]
appwrite_api_key = ENV["APPWRITE_API_KEY"]

$client
  .set_endpoint(appwrite_endpoint) # Your API Endpoint
  .set_project(appwrite_project) # Your project ID
  .set_key(appwrite_api_key) # Your secret API key

def create_user
  users = Appwrite::Users.new($client)
  puts "Running Create User API".green

  response = users.create(
    user_id: "unique()",
    email: "email@example.com",
    password: "password",
    name: "Some User"
  )

  $user_id = response.id

  puts JSON.pretty_generate(response.to_map)
end
  
def list_users
  users = Appwrite::Users.new($client)
  puts "Running List User API".green

  response = users.list

  puts JSON.pretty_generate(response.to_map)
end

def delete_user
  users = Appwrite::Users.new($client)
  puts "Running Delete User API".green

  response = users.delete(user_id: $user_id)

  puts JSON.pretty_generate(response)
end

def create_collection
  database = Appwrite::Database.new($client)
  puts "Running Create Collection API".green

  responses = []

  responses << database.create_collection(
    collection_id: "movies",
    name: "Movies", 
    permission: "document",
    read: ["role:all"], 
    write: ["role:all"]
  )

  $collection_id = responses[0].id

  responses << database.create_string_attribute(
    collection_id: $collection_id,
    key: "name",
    size: 255,
    required: true,
    default: "",
    array: false
  )
  responses << database.create_integer_attribute(
    collection_id: $collection_id,
    key: "release_year",
    required: true,
    min: 0,
    max: 9999,
    array: false
  )
  responses << database.create_float_attribute(
    collection_id: $collection_id,
    key: "rating",
    required: true,
    min: 0.0,
    max: 99.99,
    array: false
  )
  responses << database.create_boolean_attribute(
    collection_id: $collection_id,
    key: "kids",
    required: true,
    array: false
  )
  # responses << database.create_index(
  #   collection_id: $collectionId,
  #   key: "name_kids_idx",
  #   type: "fulltext",
  #   attributes: ["name", "kids"]
  # )

  responses.each do |response|
    puts JSON.pretty_generate(response.to_map)
  end
end

def list_collections
  database = Appwrite::Database.new($client)
  puts "Running List Collection API".green

  response = database.list_collections

  puts JSON.pretty_generate(response.to_map)
end

def delete_collection
  database = Appwrite::Database.new($client)
  puts "Running Delete Collection API".green

  response = database.delete_collection(collection_id: $collection_id)

  puts JSON.pretty_generate(response)
end

def create_document
  database = Appwrite::Database.new($client)
  puts "Running Create Document API".green

  response = database.create_document(
    collection_id: $collection_id,
    document_id: "unique()",
    data: {
      name: "Spider Man",
      release_year: 1920,
      rating: 99.5,
      kids: false
    }
  )
  $document_id = response.id

  puts JSON.pretty_generate(response.to_map)
end

def list_documents
  database = Appwrite::Database.new($client)
  puts "Running List Document API".green

  response = database.list_documents(collection_id: $collection_id)

  puts JSON.pretty_generate(response.to_map)
end

def delete_document
  database = Appwrite::Database.new($client)
  puts "Running Delete Document API".green

  response = database.delete_document(
    collection_id: $collection_id, 
    document_id: $document_id
  )

  puts JSON.pretty_generate(response)
end

def upload_file
  storage = Appwrite::Storage.new($client)
  puts "Running Upload File API".green

  response = storage.create_file(
    file_id: "unique()",
    file: Appwrite::File.new("nature.jpg")
  )

  $file_id = response.id

  puts JSON.pretty_generate(response.to_map)
end

def list_files
  storage = Appwrite::Storage.new($client)
  puts "Running List Files API".green

  response = storage.list_files

  puts JSON.pretty_generate(response.to_map)
end

def delete_file
  storage = Appwrite::Storage.new($client)
  puts "Running Delete File API".green

  response = storage.delete_file(file_id: $file_id)

  puts JSON.pretty_generate(response)
end

create_user
list_users
delete_user

create_collection
list_collections

create_document
list_documents
delete_document

delete_collection

upload_file
list_files
delete_file

puts "Successfully Ran playground!".bold.green

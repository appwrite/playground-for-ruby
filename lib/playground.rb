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
  .set_self_signed

def create_user
  users = Appwrite::Users.new($client)
  puts "Running Create User API".green

  user = users.create(
    user_id: "unique()",
    email: "email#{Time.now.to_i}@example.com",
    password: "password",
    name: "Some User"
  )

  $user_id = user.id

  puts JSON.pretty_generate(user.to_map)
end
  
def list_users
  users = Appwrite::Users.new($client)
  puts "Running List User API".green

  users = users.list

  puts JSON.pretty_generate(users.to_map)
end

def delete_user
  users = Appwrite::Users.new($client)
  puts "Running Delete User API".green

  response = users.delete(user_id: $user_id)

  puts JSON.pretty_generate(response)
end

def create_database
  databases = Appwrite::Databases.new($client, database_id: "moviesDB_#{Time.now.to_i}")
  puts "Running Create Database API".green

  database = databases.create(name: "Movies")

  $database_id = database.id

  puts JSON.pretty_generate(database.to_map)
end

def delete_database
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running Delete Database API".green

  response = databases.delete()

  puts JSON.pretty_generate(response)
end

def create_collection
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running Create Collection API".green

  responses = []

  responses << databases.create_collection(
    collection_id: "movies",
    name: "Movies", 
    permission: "document",
    read: ["role:all"], 
    write: ["role:all"]
  )

  $collection_id = responses[0].id

  responses << databases.create_string_attribute(
    collection_id: $collection_id,
    key: "name",
    size: 255,
    required: true,
    default: "",
    array: false
  )
  responses << databases.create_integer_attribute(
    collection_id: $collection_id,
    key: "release_year",
    required: true,
    min: 0,
    max: 9999,
    array: false
  )
  responses << databases.create_float_attribute(
    collection_id: $collection_id,
    key: "rating",
    required: true,
    min: 0.0,
    max: 99.99,
    array: false
  )
  responses << databases.create_boolean_attribute(
    collection_id: $collection_id,
    key: "kids",
    required: true,
    array: false
  )
  responses << databases.create_email_attribute(
    collection_id: $collection_id,
    key: 'email',
    required: false,
    default: ''
  )
  sleep(3)
  responses << databases.create_index(
    collection_id: $collection_id,
    key: "name_kids_idx",
    type: "fulltext",
    attributes: ["name", "email"]
  )

  responses.each do |response|
    puts JSON.pretty_generate(response.to_map)
  end
end

def list_collections
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running List Collection API".green

  collections = databases.list_collections

  puts JSON.pretty_generate(collections.to_map)
end

def delete_collection
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running Delete Collection API".green

  response = databases.delete_collection(collection_id: $collection_id)

  puts JSON.pretty_generate(response)
end

def create_document
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running Create Document API".green

  document = databases.create_document(
    collection_id: $collection_id,
    document_id: "unique()",
    data: {
      name: "Spider Man",
      release_year: 1920,
      rating: 99.5,
      kids: false
    }
  )
  $document_id = document.id

  puts JSON.pretty_generate(document.to_map)
end

def list_documents
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running List Document API".green

  documents = databases.list_documents(collection_id: $collection_id)

  puts JSON.pretty_generate(documents.to_map)
end

def delete_document
  databases = Appwrite::Databases.new($client, database_id: $database_id)
  puts "Running Delete Document API".green

  response = databases.delete_document(
    collection_id: $collection_id, 
    document_id: $document_id
  )

  puts JSON.pretty_generate(response)
end

def create_bucket
  storage = Appwrite::Storage.new($client)
  puts "Running Create Bucket API".green

  bucket = storage.create_bucket(
    bucket_id: "unique()",
    name: "awesome-bucket",
    permission: "file"
  )

  $bucket_id = bucket.id
  puts JSON.pretty_generate(bucket.to_map)
end

def list_buckets
  storage = Appwrite::Storage.new($client)
  puts "Running List Buckets API".green

  buckets = storage.list_buckets
  
  puts JSON.pretty_generate(buckets.to_map)
end

def upload_file
  storage = Appwrite::Storage.new($client)
  puts "Running Upload File API".green

  file = storage.create_file(
    bucket_id: $bucket_id,
    file_id: "unique()",
    file: Appwrite::InputFile.from_path("./resources/nature.jpg")
  )

  $file_id = file.id

  puts JSON.pretty_generate(file.to_map)
end

def list_files
  storage = Appwrite::Storage.new($client)
  puts "Running List Files API".green

  files = storage.list_files(bucket_id: $bucket_id)

  puts JSON.pretty_generate(files.to_map)
end

def delete_file
  storage = Appwrite::Storage.new($client)
  puts "Running Delete File API".green

  response = storage.delete_file(
    bucket_id: $bucket_id, 
    file_id: $file_id
  )

  puts JSON.pretty_generate(response)
end

def delete_bucket
  storage = Appwrite::Storage.new($client)
  puts "Running Delete Bucket API".green

  response = storage.delete_bucket(bucket_id: $bucket_id)

  puts JSON.pretty_generate(response)
end

def create_function
  functions = Appwrite::Functions.new($client)
  puts "Running Create Function API".green

  function = functions.create(
    function_id: "unique()",
    name: "Test Function",
    runtime: "python-3.9",
    execute: ["role:all"]
  )

  $function_id = function.id

  puts JSON.pretty_generate(function.to_map)
end

def list_functions
  functions = Appwrite::Functions.new($client)
  puts "Running List Functions API".green

  functions = functions.list

  puts JSON.pretty_generate(functions.to_map)
end

def delete_function
  functions = Appwrite::Functions.new($client)
  puts "Running Delete Function API".green

  response = functions.delete(function_id: $function_id)

  puts JSON.pretty_generate(response)
end

# Users
create_user
list_users
delete_user

# Database
create_database
create_collection
list_collections
create_document
list_documents
delete_document
delete_collection
delete_database

# Storage
create_bucket
list_buckets
upload_file
list_files
delete_file
delete_bucket

# Functions
create_function
list_functions
delete_function

puts "Successfully Ran playground!".bold.green

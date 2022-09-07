# frozen_string_literal: true

require "appwrite"
require "dotenv/load"
require "json"
require "colorize"

include Appwrite

appwrite_endpoint = ENV["APPWRITE_ENDPOINT"] || 'https://appwrite.jakebarnby.com/v1'
appwrite_project = ENV["APPWRITE_PROJECT_ID"] || 'playground-for-android'
appwrite_api_key = ENV["APPWRITE_API_KEY"] || 'fd180448df4adf4c36d1e6e8e2febb3c63b67cfa61cbe75ea1f91767e8c803298e812abf72246d5e54b2866d9e677fd59c1cfa3e47594ec8bf48b43b900ed31320a6d018b1d29661f06eef4ff8535e8b0904ca002120339f10962a37998f5d6853d2ff8d6e89b42f24aafa650534cf0e616652bb1ffdb19fe8df15b9406ac2d9'

$client = Client.new
  .set_endpoint(appwrite_endpoint) # Your API Endpoint
  .set_project(appwrite_project) # Your project ID
  .set_key(appwrite_api_key) # Your secret API key

$users = Users.new($client)
$databases = Databases.new($client)
$storage = Storage.new($client)
$functions = Functions.new($client)

$database_id = ""
$collection_id = ""
$document_id = ""
$bucket_id = ""
$file_id = ""
$function_id = ""
$user_id = ""

def create_user
  puts "Running Create User API".green

  user = $users.create(
    user_id: ID.unique(),
    email: "email#{Time.now.to_i}@example.com",
    password: "password",
    name: "Some User"
  )

  $user_id = user.id

  puts JSON.pretty_generate(user.to_map)
end
  
def list_users
  puts "Running List User API".green

  users = $users.list

  puts JSON.pretty_generate(users.to_map)
end

def delete_user
  puts "Running Delete User API".green

  response = $users.delete(user_id: $user_id)

  puts JSON.pretty_generate(response)
end

def create_database
  puts "Running Create Database API".green

  database = $databases.create(
      database_id: ID.unique(),
      name: "Movies"
  )

  $database_id = database.id

  puts JSON.pretty_generate(database.to_map)
end

def delete_database
  puts "Running Delete Database API".green

  response = $databases.delete(database_id: $database_id)

  puts JSON.pretty_generate(response)
end

def create_collection
  puts "Running Create Collection API".green

  responses = []

  responses << $databases.create_collection(
    database_id: $database_id,
    collection_id: ID.unique(),
    name: "Movies", 
    document_security: true,
    permissions: [
        Permission.read(Role.users()),
        Permission.create(Role.users()),
        Permission.update(Role.users()),
        Permission.delete(Role.users()),
    ]
  )

  $collection_id = responses[0].id

  responses << $databases.create_string_attribute(
    database_id: $database_id,
    collection_id: $collection_id,
    key: "name",
    size: 255,
    required: true,
    default: "",
    array: false
  )
  responses << $databases.create_integer_attribute(
    database_id: $database_id,
    collection_id: $collection_id,
    key: "release_year",
    required: true,
    min: 0,
    max: 9999,
    array: false
  )
  responses << $databases.create_float_attribute(
    database_id: $database_id,
    collection_id: $collection_id,
    key: "rating",
    required: true,
    min: 0.0,
    max: 99.99,
    array: false
  )
  responses << $databases.create_boolean_attribute(
    database_id: $database_id,
    collection_id: $collection_id,
    key: "kids",
    required: true,
    array: false
  )
  responses << $databases.create_email_attribute(
    database_id: $database_id,
    collection_id: $collection_id,
    key: 'email',
    required: false,
    default: ''
  )
  sleep(3)
  responses << $databases.create_index(
    database_id: $database_id,
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
  puts "Running List Collection API".green

  collections = $databases.list_collections(database_id: $database_id)

  puts JSON.pretty_generate(collections.to_map)
end

def delete_collection
  puts "Running Delete Collection API".green

  response = $databases.delete_collection(
    database_id: $database_id,
    collection_id: $collection_id
  )

  puts JSON.pretty_generate(response)
end

def create_document
  puts "Running Create Document API".green

  document = $databases.create_document(
    database_id: $database_id,
    collection_id: $collection_id,
    document_id: ID.unique(),
    data: {
      name: "Spider Man",
      release_year: 1920,
      rating: 99.5,
      kids: false
    },
    permissions: [
      Permission.read(Role.users()),
      Permission.update(Role.users()),
      Permission.delete(Role.users()),
    ]
  )

  $document_id = document.id

  puts JSON.pretty_generate(document.to_map)
end

def list_documents
  puts "Running List Document API".green

  documents = $databases.list_documents(
    database_id: $database_id,
    collection_id: $collection_id
  )

  puts JSON.pretty_generate(documents.to_map)
end

def delete_document
  puts "Running Delete Document API".green

  response = $databases.delete_document(
    database_id: $database_id,
    collection_id: $collection_id,
    document_id: $document_id
  )

  puts JSON.pretty_generate(response)
end

def create_bucket
  puts "Running Create Bucket API".green

  bucket = $storage.create_bucket(
    bucket_id: ID.unique(),
    name: "awesome-bucket",
    file_security: true,
    permissions: [
      Permission.read(Role.any()),
      Permission.create(Role.users()),
      Permission.update(Role.users()),
      Permission.delete(Role.users())
    ]
  )

  $bucket_id = bucket.id

  puts JSON.pretty_generate(bucket.to_map)
end

def list_buckets
  puts "Running List Buckets API".green

  buckets = $storage.list_buckets
  
  puts JSON.pretty_generate(buckets.to_map)
end

def upload_file
  puts "Running Upload File API".green

  file = $storage.create_file(
    bucket_id: $bucket_id,
    file_id: ID.unique(),
    file: InputFile.from_path("./resources/nature.jpg"),
    permissions: [
        Permission.read(Role.any())
    ]
  )

  $file_id = file.id

  puts JSON.pretty_generate(file.to_map)
end

def list_files
  puts "Running List Files API".green

  files = $storage.list_files(bucket_id: $bucket_id)

  puts JSON.pretty_generate(files.to_map)
end

def delete_file
  puts "Running Delete File API".green

  response = $storage.delete_file(
    bucket_id: $bucket_id,
    file_id: $file_id
  )

  puts JSON.pretty_generate(response)
end

def delete_bucket
  puts "Running Delete Bucket API".green

  response = $storage.delete_bucket(bucket_id: $bucket_id)

  puts JSON.pretty_generate(response)
end

def create_function
  puts "Running Create Function API".green

  function = $functions.create(
    function_id: ID.unique(),
    name: "Test Function",
    runtime: "python-3.9",
    execute: [Role.any()]
  )

  $function_id = function.id

  puts JSON.pretty_generate(function.to_map)
end

def list_functions
  puts "Running List Functions API".green

  functions = $functions.list

  puts JSON.pretty_generate(functions.to_map)
end

def delete_function
  puts "Running Delete Function API".green

  response = $functions.delete(function_id: $function_id)

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

# frozen_string_literal: true

require "appwrite"
require "dotenv/load"
require "json"
require "colorize"

include Appwrite

appwrite_endpoint = 'https://v16.appwrite.org/v1'
appwrite_project = '66c466f6001a3c3e06ae'
appwrite_api_key = 'standard_2735ef3caa21929bc6940bdafe29ab9da0be16572a198be646998b7322c9422adaff18d519fc840d7e67f2d74b0dd1c0474aaa3e8521b62b0c11aca6aeee702f4a0aa4360a503df6b989c948ba678c5f236747602d4d673eda3775c3684da07fb5058b13414c9998f2aaf35c4448ee09f4dceb54f5f22694290b37d5b1796f9e'

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

def get_function
  puts "Running Get Function API".green

  function = $functions.get(function_id: $function_id)

  puts JSON.pretty_generate(function.to_map)
end

def delete_function
  puts "Running Delete Function API".green

  response = $functions.delete(function_id: $function_id)

  puts JSON.pretty_generate(response)
end

def create_deployment
  puts "Running Upload Deployment API"

  deployment = $functions.create_deployment(
    function_id: $function_id,
    code: InputFile.from_path("./resources/index.rb"),
    activate: true,
    entrypoint: "index.rb"
  )
  $deployment_id = deployment.id

  puts JSON.pretty_generate(deployment.to_map)

  puts 'Waiting a little to ensure deployment has built ...'
  sleep(5)
end

def list_deployments
  puts "Running List Deployments API"

  deployments = $functions.list_deployments(function_id: $function_id)

  puts JSON.pretty_generate(deployments.to_map)
end

def delete_deployments
  puts "Running Delete Deployment API"

  response = $functions.delete_deployment(
    function_id: $function_id,
    deployment_id: $deployment_id
  )

  puts JSON.pretty_generate(response)
end

def create_execution
  puts "Running Create Execution API"

  execution = $functions.create_execution(function_id: $function_id)

  puts JSON.pretty_generate(execution.to_map)
end

def list_executions
  puts "Running List Executions API"

  executions = $functions.list_executions(function_id: $function_id)

  puts JSON.pretty_generate(executions.to_map)
end

def get_execution
  puts "Running Get Execution API"

  execution = $functions.get_execution(
    function_id: $function_id,
    execution_id: $execution_id
  )

  puts JSON.pretty_generate(execution.to_map)
end

def delete_execution
  puts "Running Delete Execution API"

  response = $functions.delete_execution(
    function_id: $function_id,
    execution_id: $execution_id
  )

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
get_function
create_deployment
list_deployments
create_execution
list_executions
get_execution
delete_function
delete_execution
delete_deployments

puts "Successfully Ran playground!".bold.green

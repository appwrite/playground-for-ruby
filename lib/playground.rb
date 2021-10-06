# frozen_string_literal: true

require "appwrite"
require "dotenv/load"

$client = Appwrite::Client.new

appwrite_endpoint = ENV["APPWRITE_ENDPOINT"]
appwrite_project = ENV["APPWRITE_PROJECT_ID"]
appwrite_api_key = ENV["APPWRITE_API_KEY"]

$client
  .set_endpoint(appwrite_endpoint) # Your API Endpoint
  .set_project(appwrite_project) # Your project ID
  .set_key(appwrite_api_key) # Your secret API key

def create_collection
  database = Appwrite::Database.new($client)
  puts("Running Create Collection API")

  response = database.create_collection(
    name: "Movies", read: [], write: [], rules: [
      { label: "Name", key: "name", type: "text", default: "Empty Name", required: true, array: false },
      { label: "release_year", key: "release_year", type: "numeric", default: 1970, required: true, array: false }
    ]
  )
  $collection_id = response["$id"]
  puts response
end

def list_collection
  database = Appwrite::Database.new($client)
  puts("Running List Collection API")

  response = database.list_collections

  puts response
end

def add_doc
  database = Appwrite::Database.new($client)
  puts("Running Add Document API")

  response = database.create_document(
    collection_id: $collection_id, data: {
      name: "Spider Man",
      release_year: 1920
    }
  )

  puts response
end

def list_docs
  database = Appwrite::Database.new($client)
  puts("Running List Document API")

  response = database.list_documents(collection_id: $collection_id)

  puts response
end

def upload_file
  storage = Appwrite::Storage.new($client)
  puts("Running Upload File API")

  response = storage.create_file(file: Appwrite::File.new("nature.jpg"))

  puts(response)
end

def create_user(email, password, name)
  users = Appwrite::Users.new($client)
  puts("Running Create User API")

  response = users.create(email: email, password: password, name: name)

  puts response
end

def list_user
  users = Appwrite::Users.new($client)
  puts("Running List User API")

  response = users.list

  puts response
end

create_collection
list_collection
add_doc
list_docs
upload_file
create_user(Time.now.to_i.to_s + "@example.com", "password", "Some User")
list_user

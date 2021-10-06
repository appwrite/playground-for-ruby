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

create_collection
list_collection
add_doc

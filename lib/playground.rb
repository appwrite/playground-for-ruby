require "appwrite"
require "dotenv/load"

client = Appwrite::Client.new()

appwrite_endpoint = ENV["APPWRITE_ENDPOINT"]
appwrite_project = ENV["APPWRITE_PROJECT_ID"]
appwrite_api_key = ENV["APPWRITE_API_KEY"]

client
    .set_endpoint(appwrite_endpoint) # Your API Endpoint
    .set_project(appwrite_project) # Your project ID
    .set_key(appwrite_api_key) # Your secret API key
;

database = Appwrite::Database.new(client);

response = database.create_collection(
    name: "Movies", # Collection Name
    read: [], # Read permissions
    write: [], # Write permissions
    rules: [
        { label: 'Name', key: 'name', type: 'text', default: 'Empty Name', required: true, array: false },
        { label: 'release_year', key: 'release_year', type: 'numeric', default: 1970, required: true, array: false }
    ]);

puts ("Running Create Collection API")
puts response
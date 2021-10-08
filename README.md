# Appwrite's Ruby Playground 🎮

Appwrite playground is a simple way to explore the Appwrite API & Appwrite Ruby SDK. Use the source code of this repository to learn how to use the different Appwrite Ruby SDK features.

[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)

**Work in progress**

## Get Started

This playground doesn't include all of Ruby best practices but rather intended to show some of the most simple examples and use cases of using the Appwrite API in your Ruby application. Rubocop is enforced and the configuration can be found at [.rubocop.yml](.rubocop.yml)

## System Requirements 
* A system with Ruby installed.
* You have readily available AppWrite running instance (localhost in most cases).
* Create a project in AppWrite instance using console.
* Generate a secret key in the AppWrite instance using console.

### Installation
1. Clone this repository.
2. cd into to repository.
3. Copy the `.env.example` file as `.env` in the root of the repository. (You can run `cp .env.example .env`)
4. Copy the Project ID, Endpoint, API key from your Appwrite Console.
4. Update APPWRITE_PROJECT_ID, APPWRITE_ENDPOINT, APPWRITE_API_KEY using the copied values from the console in the `.env` file as appropriate. 
5. Install dependencies using bundle (`bundle install`)
5. Execute the command `ruby lib/playground.rb`
6. You will see the JSON response in the console.

### APIs Covered in Playground.
* Create Collection
* List Collection
* Add Document
* List Documents
* Upload File
* Create User
* List User

## Contributing

All code contributions - including those of people having commit access - must go through a pull request and approved by a core developer before being merged. This is to ensure proper review of all the code.

We truly ❤️ pull requests! If you wish to help, you can learn more about how you can contribute to this project in the [contribution guide](https://github.com/appwrite/appwrite/blob/master/CONTRIBUTING.md).

## Security

For security issues, kindly email us [security@appwrite.io](mailto:security@appwrite.io) instead of posting a public issue in GitHub.

## Follow Us

Join our growing community around the world! Follow us on [Twitter](https://twitter.com/appwrite_io), [Facebook Page](https://www.facebook.com/appwrite.io), [Facebook Group](https://www.facebook.com/groups/appwrite.developers/) or join our Discord Server [Discord community](https://discord.gg/GSeTUeA) for more help, ideas and discussions.  

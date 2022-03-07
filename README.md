# Appwrite's Ruby Playground 🎮

Appwrite playground is a simple way to explore the Appwrite API & Appwrite Ruby SDK. Use the source code of this repository to learn how to use the different Appwrite Ruby SDK features.

[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)

**Work in progress**

## Get Started

This playground does not adhere to Ruby best practices but rather is intended to show some of the most simple examples and use cases of using the Appwrite API in your Ruby application. Rubocop is enforced and the configuration can be found at [.rubocop.yml](.rubocop.yml)

## System Requirements
* A system with Python 3+ or Docker installed.
* An Appwrite instance.
* An Appwrite project created in the console.
* An Appwrite API key created in the console.

### Installation
1. Clone this repository.
2. `cd` into to the repository.
3. Open the playground.py file found in the root of the cloned repository.
4. Copy Project ID, endpoint and API key from Appwrite console into `lib/playground.rb`
5. Run the playground:
    Ruby:
        - Install dependencies using pip `bundle install`
        - Execute the command `bundle exec ruby lib/playground.rb`
    Docker:
        - Execute the command `docker compose up`
6. You will see the JSON response in the console.

### API's Covered:

- Databse
    * Create Collection
    * List Collection
    * Add Document
    * List Documents
    * Delete Document
    * Delete Collection

- Storage
    * Create Bucket
    * Upload File
    * List Files
    * Delete File

- Users
    * Create User
    * List User
    * Delete User

- Functions
    * Create Function
    * List Functions
    * Delete Function

## Contributing

All code contributions - including those of people having commit access - must go through a pull request and approved by a core developer before being merged. This is to ensure proper review of all the code.

We truly ❤️ pull requests! If you wish to help, you can learn more about how you can contribute to this project in the [contribution guide](https://github.com/appwrite/appwrite/blob/master/CONTRIBUTING.md).

## Security

For security issues, kindly email us [security@appwrite.io](mailto:security@appwrite.io) instead of posting a public issue in GitHub.

## Follow Us

Join our growing community around the world! Follow us on [Twitter](https://twitter.com/appwrite), [Facebook Page](https://www.facebook.com/appwrite.io), [Facebook Group](https://www.facebook.com/groups/appwrite.developers/) or join our [Discord Server](https://appwrite.io/discord) for more help, ideas and discussions.

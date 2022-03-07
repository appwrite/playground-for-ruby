# Appwrite's Ruby Playground 🎮

Appwrite playground is a simple way to explore the Appwrite API & Appwrite Ruby SDK. Use the source code of this repository to learn how to use the different Appwrite Ruby SDK features.

[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)

**Work in progress**

## Get Started

This playground does not adhere to Ruby best practices but rather is intended to show some of the most simple examples and use cases of using the Appwrite API in your Ruby application. Rubocop is enforced and the configuration can be found at [.rubocop.yml](.rubocop.yml)

## Requirements 
* A system with Ruby 2.7+ or Docker installed.
* An Appwrite instance (localhost in most cases).
* An Appwrite project created in the console.
* An Appwrite API Key created in the console.

### Installation
1. Clone this repository.
2. `cd` into the repository.
4. Open [playground.rb](./lib/playground.rb) and update YOUR_PROJECT_ID, YOUR_ENDPOINT, and YOUR_API_KEY using the copied values from the console.
5. Run the playground:
    Ruby:
        - Install dependencies using bundle (`bundle install`)
        - Execute the command `bundle exec ruby lib/playground.rb`
    Docker:
        - Execute the command `docker compose up`
6. You will see the JSON response in the console.

### APIs Covered in Playground:

- Databse
    * [Create Collection](./lib/playground.rb#L47)
    * [List Collection](./lib/playground.rb#L111)
    * [Add Document](./lib/playground.rb#L129)
    * [List Documents](./lib/playground.rb#L148)
    * [Delete Document](./lib/playground.rb#L157)
    * [Delete Collection](./lib/playground.rb#L120)

- Storage
    * [Create Bucket](./lib/playground.rb#L169)
    * [Upload File](./lib/playground.rb#L183)
    * [List Files](./lib/playground.rb#L198)
    * [Delete File](./lib/playground.rb#L207)

- Users
    * [Create User](./lib/playground.rb#L13)
    * [List User](./lib/playground.rb#L29)
    * [Delete User](./lib/playground.rb#L38)

## Contributing

All code contributions - including those of people having commit access - must go through a pull request and approved by a core developer before being merged. This is to ensure proper review of all the code.

We truly ❤️ pull requests! If you wish to help, you can learn more about how you can contribute to this project in the [contribution guide](https://github.com/appwrite/appwrite/blob/master/CONTRIBUTING.md).

## Security

For security issues, kindly email us [security@appwrite.io](mailto:security@appwrite.io) instead of posting a public issue in GitHub.

## Follow Us

Join our growing community around the world! Follow us on [Twitter](https://twitter.com/appwrite), [Facebook Page](https://www.facebook.com/appwrite.io), [Facebook Group](https://www.facebook.com/groups/appwrite.developers/) or join our [Discord Server](https://appwrite.io/discord) for more help, ideas and discussions.

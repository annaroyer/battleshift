# BattleShift

An API for multi-player battleship. This is a brownfield project built on top of a pre-existing battleship game for a single player and computer. Players can register for an account, and will receive an email with their API key and a link to activate their account. Once activated, they are able to send post requests using their API key to create a new game, place their ships and fire shots on the opposing player. 

See the project spec here: [Battleshift project spec](http://backend.turing.io/module3/projects/battleshift)

See the deployed project here: [BattleShift Game](https://lit-hollows-27475.herokuapp.com/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

*To get set up on our deployed heroku app, visit the application (link above), register for an account, check your email address for an API key and link to activate your acount, and follow the instructions in the application. This application requires postman or curl in the terminal to make post requests to the api.

1. clone down this project and change into the directory
```
git clone https://github.com/amj133/battleshift.git
bundle install
```
2. create and migrate the database
```
rake db:create
rake db:migrate
```
3. create an active user in the database
```
rails c
User.create(name: "give it a name", email: "give in an email", password: "give it a password", password_confirmation: "same password", status: 1)
exit
```
4. Run rails server and visit localhost:3000 in your browser
```
rails s
```
*visit http://localhost:3000 in your browser
*enjoy!

### Prerequisites

* Ruby 2.4+
* Rails 5

To play battleship you will need to use cURL in your terminal or download the postman application from chrome.

## Running the tests

To run the tests, follow the instructions in [Getting Started](#getting-started) above first.
Then, run rspec 
```
rspec
```
Our tests include: 
* feature tests for logging in, registering an account and visiting the user dashboard
* mailer tests for user receiving an API key and a link to activate their account 
* model tests of all ActiveRecord and PORO models
* service tests of all PORO services
* request tests of all API request endpoints

Tools and gems 


## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc


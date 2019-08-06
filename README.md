# Reception Scheduler
A scheduling system for that helps manage the rota for the Shoreditch House reception desk. The system allows employees to book shifts.

## Rules
- Shoreditch House is open from 7am until 3am, 7 days a week
- There is only one member of staff on shift at a time
- Shifts can be a maximum of 8 hours long
- An employee can work a maximum of 40 hours per week

## Requirements
- Ruby 2.53

## Installation
Go to terminal on your machine
```bash
bundle install
yarn install
rails db:create db:migrate db:seed
rails s
```
Go to http://localhost:3000

## How to use it
### As an employer (admin)
- As an admin you will have access to create and delete shifts, use the following login
```
email: test@test.com 
password: 123456
```
- To create a shift click the `new shift` button and it will take you to the page where you can submit the date and time of the shift you would like to create

### As an employee
- As an employee, you can select shifts that are 8 hours or less. But not more than 40 in one week.
- First sign up to the app with any email and password and click select `take shift` to select the shift you would like.
- There is a running total of how many hours you have worked for that week at the top of the page.
- Once your shift has been selected your email will now be against the shift. You cannot delete a shift once it has been taken.

## Testing
- Run ```rspec``` to test the tests that have been written for `Shift` and `User`.


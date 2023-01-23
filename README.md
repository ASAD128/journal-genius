# Visable Bank
## Overview and Features
- Restful API based double entry Accounting Application. 
- Can transfer funds from one account to another
- Can view last 10 transaction of any account
- System is build considering Journal Double Entry where against each transaction
  there's one journal entry and two postings. 

## Models
- *Account*:
  Store all the data related to accounts
- *Transaction*:
   All the transaction recorded here
- *Journal*:
   Against each transaction there's journal entry
- *Posting*:
   Each journal entry has two postings 
   
## APIs
- `POST http://0.0.0.0:3000/api/v1/accounts?name=Mikey&balance_cents=5000` 
- `GET http://0.0.0.0:3000/api/v1/accounts`
- `POST http://0.0.0.0:3000/api/v1/funds_transfer?source_account=26&destination_account=25&amount_cents=2000`
- `SHOW http://0.0.0.0:3000/api/v1/accounts/25`


## Ruby
ruby 3.1.3

## Rails
Rails 7.0.4.1 

## Docker
`docker compose build`
`docker compose up`

## Database
Postgresql 
`rake db:create`
`rake db:migrate`
`rake db:seed`


## Rspec 
`Rspec` & `FactoryBot` used to write the specs

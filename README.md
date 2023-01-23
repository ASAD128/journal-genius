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

## APIs
- `POST http://0.0.0.0:3000/api/v1/accounts?name=Mikey&balance_cents=5000` 
- `GET http://0.0.0.0:3000/api/v1/accounts`
- `POST http://0.0.0.0:3000/api/v1/funds_transfer?source_account=26&destination_account=25&amount_cents=2000`
- `SHOW http://0.0.0.0:3000/api/v1/accounts/25`

<img width="853" alt="Screenshot 2023-01-23 at 7 58 51 PM" src="https://user-images.githubusercontent.com/22412472/214036605-3f8cd9d3-cdbf-42cb-bd72-c114a8b63460.png">
<img width="867" alt="Screenshot 2023-01-23 at 7 59 12 PM" src="https://user-images.githubusercontent.com/22412472/214036779-8b8692aa-48c8-494f-806b-9ad6bff054dc.png">
<img width="864" alt="Screenshot 2023-01-23 at 7 59 30 PM" src="https://user-images.githubusercontent.com/22412472/214036879-2712ca12-c030-4151-94b6-0704e6447296.png">

## Questions??
`Contact me here at eamil: asadhnd@yahoo.com`


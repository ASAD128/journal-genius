
puts "Seeding..."

Account.find_or_create_by(name: 'CashBook', account_number: '00001111', currency: "USD")

# Only Cashbook account created via seed rest of the accounts should be created via post request
# POST http://0.0.0.0:3000/api/v1/accounts?name=Mikey&balance_cents=5000


puts "Seeding done."

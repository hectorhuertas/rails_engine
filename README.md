# Rails Engine

This project is a JSON API that exposes several kinds of sales data. The original specifications of the project can be found at [Original Project's Specifications](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md)

## Deployment & Testing

1. Clone the repo
```
$ git clone https://github.com/hectorhuertas/rails_engine.git
```
2. Create and migrate the database
```
$ rake db:setup
```
3. Import the csv files data
```
$ rake import
```
4. Run the test suite
```
$ rspec
```

## Cool features

#### Clean routes & controllers organization
* Very readable code thanks to following a strict RESTful organization of the multiple endpoints

#### Thorough Testing
* 100% Test coverage using SimpleCov
* Factory girl for easier testing

#### API built using Responders gem
* Used 'responders' gem to facilitate skinny controllers for the API

#### Complex ActiveRecord Queries
* Some of the business intelligence queries go through several tables and need several calculations.

## Available Endpoints

#### Index of Record

Each data category should include an `index` action which
renders a JSON representation of all the appropriate records:

`GET /api/v1/merchants.json`

#### Show Record

Each data category should include a `show` action which
renders a JSON representation of the appropriate record:

`GET /api/v1/merchants/1.json`

#### Single Finders

Each data category should offer `find` finders to return a single object representation like this:

```
GET /api/v1/merchants/find?id=12
```

Which would find the one merchant with ID `12`. The finder should work with any of the attributes defined on the data type and always be case insensitive.

For example:

```
GET /api/v1/merchants/find?name=Schroeder-Jerde
```

#### Multi-Finders

Each category should offer `find_all` finders like this:

```
GET /api/v1/merchants/find_all?name=Cummings-Thiel
```

Which would find all the merchants whose name matches this query.

The finder should work with any of the attributes defined on the data type and always be case insensitive.

#### Random

`api/v1/merchants/random.json` returns a random merchant.

### Relationship Endpoints

In addition to the direct queries against single resources, we would like to also be able to pull relationship data from the API.

We'll expose these relationships using nested URLs, as outlined in the sections below.

#### Merchants

* `GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant
* `GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices

* `GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions
* `GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/invoices/:id/items` returns a collection of associated items
* `GET /api/v1/invoices/:id/customer` returns the associated customer
* `GET /api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items

* `GET /api/v1/invoice_items/:id/invoice` returns the associated invoice
* `GET /api/v1/invoice_items/:id/item` returns the associated item

#### Items

* `GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items
* `GET /api/v1/items/:id/merchant` returns the associated merchant

#### Transactions

* `GET /api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers

* `GET /api/v1/customers/:id/invoices` returns a collection of associated invoices
* `GET /api/v1/customers/:id/transactions` returns a collection of associated transactions

### Business Intelligence Endpoints

#### All Merchants

* `GET /api/v1/merchants/most_revenue?quantity=x` returns the top `x` merchants ranked by total revenue
<!-- * `GET /api/v1/merchants/most_items?quantity=x` returns the top `x` merchants ranked by total number of items sold -->
<!-- * `GET /api/v1/merchants/revenue?date=x` returns the total revenue for date `x` across all merchants -->


#### Single Merchant

* `GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions
* `GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date `x`
* `GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.
* `GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices

<!-- #### Items

* `GET /api/v1/items/most_revenue?quantity=x` returns the top `x` items ranked by total revenue generated
* `GET /api/v1/items/most_items?quantity=x` returns the top `x` item instances ranked by total number sold
* `GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date -->

#### Customers

* `GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions

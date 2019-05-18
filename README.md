# Ruby on Rails 5 - Practice Code-along

## MVC Architecture

- Model
- View
- Controller

Browser interacts with the Controller, which will go to Model for data and return the results, which the Controller sends to the View prior to returning the results to the user and the browser

### Routes

Simple match route `get 'demo/index'` or `get 'demo/index', to: 'demo#index'`

Root Route `root 'demo#index'`

### Databases

**Database** - set of tables
example: simple_cms_development
Access permissions - granted at database level

**Table** - set of columns and rows
1 table = 1 model
represents a single concept (a noun)
example: products, customers, orders

**Column** - set of data of a single, simple type
example: first_name, last_name, email, etc.

**Row** - single record of data
example: "Bob", "bob@mail.com"

**Field** - intersection of row and column

**Index** - Data structure on a table to increase the lookup speed

**Foreign Keys** - table column whose values reference rows in another table
example: pages table -> subject_id
Always put indexes on foreign keys

**Schema** - structural definition of a database

**CRUD** - Create, Read, Update, Delete -> essential database interactions

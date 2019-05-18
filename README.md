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

### Migrations

migrations describe database changes from one state to another

- can move "up" and "back down" using instructions

- keeps database schema with application code

- executable and repeatable

- allows sharing schema changes

- written in ruby instead of SQL

Can be generated with `rails g migration DoSomethingNow`

Created with generating models too

`t.column "first_name", :string` or `t.string :last_name`

Table Column Types:

- binary
- boolean
- date
- datetime
- decimal
- float
- integer
- string
- text
- time

and options

- limit: size
- default: value
- null: true/false
- precision: number
- scale: number

rows managed automatically

- t.datetime :created_at
- t.datetime :updated_at
  same as:
- t.timestamps

primary key is automatically added by rails - id column

commands:

- `rails db:migrate`
- `rails db:migrate VERSION=0`
- `rails db:migrate VERSION=20190518154431`
- `rails db:migrate:status`
- `rails db:migrate:up VERSION=20190518154431`
- `rails db:migrate:down VERSION=20190518154431`
- `rails db:migrate:redo VERSION=20190518154431`

### Migration Methods

**table**
create_table(table)
drop_table(table)
rename_table(table, new_name)

**column**
add_column(table, column, type, options)
remove_column(table, column)
rename_column(table, column, new_name)
change_column(table, column, type, options)

**index migration methods**
add_index(table, column, options)
remove_index(table, column)
options:
unique: true/false
name: "custom_name"

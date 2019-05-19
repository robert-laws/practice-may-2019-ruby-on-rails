# Ruby on Rails 5 - Practice Code-along

## MVC Architecture

- Model
- View
- Controller

Browser interacts with the Controller, which will go to Model for data and return the results, which the Controller sends to the View prior to returning the results to the user and the browser

## Routes

Simple match route `get 'demo/index'` or `get 'demo/index', to: 'demo#index'`

Root Route `root 'demo#index'`

## Databases

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

## ActiveRecord

Rails implementation of the active record design pattern - retrieve data as objects that can be manipulated - read, created, updated, and deleted from database.

```ruby
user = User.new
user.first_name = "Bob"
user.save # SQL INSERT

user.last_name = "Cobb"
user.save # SQL UPDATE

user.delete # SQL DELETE
```

ActiveRelation (ARel) - simplifies generation of complete database queries (joins, aggregations, etc.) and their execution.

```ruby
users = User.where(first_name: "Bob")
users = users.order("last_name ASC").limit(5)

# SELECT users.* FROM users
# WHERE users.first_name = "Bob"
# ORDER BY users.last_name ASC
# LIMIT 5
```

`rails g model StoreItem`

Will create a migration and an entry in the models folder called store_item (and class StoreItem) and a table in the database called store_items.

ActiveRecord handles creating setter and getter methods for columns in the database. However, can still define attributes not included in database.

### Using Rails Console

`rails c`

### Creating Records

- New/save -> instantiate object, set values, then save to database
- Create -> instantiate object, set values and save in one step

```ruby
subject = Subject.new({name: "First Subject", position: 1, visible: true})
subject.save # saves record to database

subject = Subject.create({name: "First Subject", position: 1, visible: true})
# creates and saves in one step
```

### Updating Records

- Find/save -> find record, set values, save
- Find/update_attributes -> find record, set values and save at one time

```ruby
subject = Subject.find(1)
subject.name = "Initial Subject"
subject.save

subject_two = Subject.find(2)
subject_two.update_attributes({name: "Next Subject", visible: false})
```

### Deleting Records

- Find/destroy -> Find record, destroy
- using Delete -> will bypass steps and could be problematic

```ruby
problem_subject = Subject.create({name: "Bad Subject"})
# ...
subject = Subject.find(3)
subject.destroy # removes from database, ruby object still remains as a frozen hash
```
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

### Searching Records

- Subject.find(2) -> returns object or returns a "RecordNotFound" error
- Subject.find_by_id(5) -> returns object or nil
- Subject.find_by_name("item name") -> returns object or nil
- Subject.all -> return an array of objects
- Subject.first -> return object or nil
- Subject.last -> return object or nil

### Query Methods: Conditions

- where(conditions) -> `Subject.where(visible: true)`
- can use a string, array, hash

**Array**
example: `["name=? AND visible=true", "Test"] -> Rails will insert value in for ?`

**Hash**
example: `(name: "Test", visible: true)`

Can chain together queries: `Subject.where(visible: true).where(position: 2)`

### More Complex Queries - Order, Limit, Offset

- order(string) -> order(:name) = ascending order
- example order(name: :asc) or (name: :desc)
- limit(integer)
- offset(integer)

Disambiguation
`order("subjects.created_at ASC")`

### Named Scopes

- Queries defined in a model
- Defined using ActiveRelation query methods
- Can be called like ActiveRelation methods
- can accept Parameters
- Rails 5 requires lambda syntax - evaluated when called, not when defined

```ruby
scope :active, lambda { where(active: true)}
scope :active, -> { where(active: true)}
def self.active
  where(active: true)
end
ClassName.active

scope :with_content_type, lambda{|ctype|
  where(content_type: ctype)
}
ClassName.with_content_type('html')
```

## Relationship Types

- One-to-one -> 1:1 - has one, belongs to (has a foreign key)
- One-to-many -> 1:\* - has many, belongs to (has a foreign key)
- Many-to-many -> \*:\* - has many and belongs to many (join tables have foreign keys)

### ActiveRecord Associations

- One-to-one (unique items a person or thing can only have one of. ex. Employee has_one :office, break up a single table)
  Classroom has_one :teacher
  Teacher belongs_to :classroom

- One-to-many (more commonly used than one-to-one, plural relationship names, return an array of objects)
  Teacher has_many :courses
  Course belongs_to :teacher
  methods: subject.pages, subject.pages << page, subject.pages = [page, page, page], subject.pages.delete(page), subject.pages.destroy(page), subject.pages.clear, subject.pages.empty?, subject.pages.size

- Many-to-many
  Course has_and_belongs_to_many :students
  Student has_and_belongs_to_many :courses

### belongs_to validation

Models that have a belongs_to relationship must have a parent to be successfully saved. It can be disabled using `{ optional: true }`

### Many-to-many associations: simple

Objects have many object that belong to it, but not exclusively. `BlogPost has_many_and_belongs_to :categories`

Requires a join table with two foreign keys (with an index for quick lookup)

No primary key column `(id: false)`

Add same instances to class

Join table naming convention: `first_table + _*_ + second_table -> table names` are plural and in alphabetical order ex. BlogPost & Category = `blog_post_categories`

### Many-to-many associations: rich

Allows more complexity - join table with more columns

Requires a primary key on the join table

Can use custom name for table - usually ends in -ment or -ships

## CRUD Actions

- create (new - display new record form - /subjects/new, create - process new record form - /subjects/create)
- read (index - list records - /subjects, show - display single record - /subjects/show/:id)
- update - (edit - display edit record form - /subjects/edit/:id, update - process edit record form - /subjects/update/:id)
- delete - (delete - display delete record form - /subjects/delete/:id, destroy - process delete record form - /subjects/destroy/:id)

Use controllers to handle CRUD actions on model - one per model

Allows for clear URLs

`rails g controller Subjects index show new edit delete`

### REST and resourceful routes

- Representational State Transform
- do not perform procedures
- perform state transformation upon resources

1. Organize code into resources - ex. one controller per model
2. Learn HTTP verbs
3. Map a new URL syntax to controller actions
4. Modify existing links and forms to use new URL syntax

### REST HTTP Verbs

- GET - retrieve item from resource - used in links, allow multiple request, and cached
- POST - create new item in resource
- PATCH - update existing item in resource
- DELETE - delete existing item in resource

REST Verb Usage

- index = GET
- show = GET
- new = GET
- create = POST
- edit = GET
- update = PATCH
- delete = GET
- destroy = DELETE

### Routes and URL Syntax

- Rails default
- Optimized for REST
- simple and consistent

`resources :subjects`

- index - GET - /subjects
- show - GET - /subjects/:id
- new - GET - /subjects/new
- create - POST - /subjects
- edit - GET - /subjects/:id/edit
- update - PATCH - /subjects/:id
- delete - GET - /subjects/:id/delete
- destroy - DELETE - /subjects/:id

### Limiting Resourceful Routes

`resources :admin_users, except: [:show]`

`resources :products, only: [:index, :show]`

Adding Resourceful Routes

```ruby
resources :subjects do
  member do
    get :delete
  end

  collection do
    get :export
  end
end
```

example - adding delete verb to routes and including all other resources too.

```ruby
resources :authors do
  member do
    get :delete
  end
end
```

### Resourceful URL Helpers

Helps to create shorthand versions of URLs

`{controller: 'subjects', action: 'show', id: 5}` can be rewritten as `subject_path(5)`

- index - GET - /subjects - subjects_path
- show - GET - /subjects/:id - subject_path(:id)
- new - GET - /subjects/new - new_subject_path
- create - POST - /subjects - subjects_path
- edit - GET - /subjects/:id/edit - edit_subject_path(:id)
- update - PATCH - /subjects/:id - subject_path(:id)
- delete - GET - /subjects/:id/delete - delete_subject_path(:id)
- destroy - DELETE - /subjects/:id - subject_path(:id)

`<%= link_to('All Subjects', subjects_path) %>`

`<%= link_to('All Subjects', subjects_path(page: 3)) %>`

`<%= link_to('Show Subject', subject_path(@subject.id)) %>`

`<%= link_to('Show Subject', subject_path(@subject.id, format: 'verbose')) %>`

`<%= link_to('Edit Subject', edit_subject_path(@subject.id)) %>`

## Forms

Rails allows parameters to be used as a hash for post actions

```ruby
<%= form_for(@subject) do |f| %>
  <%= f.text_field(:name) %>
  <%= f.text_field(:position) %>
  <%= f.text_field(:visible) %>

  <%= f.submit("Create Subject")
<% end %>
```

### New

Uses new and create actions

`<%= form_for(@author, url: authors_path, method: "post") do |f| %>`

In the controller, the new method need an object to use for form creation. Can also add default values passing a hash to the new method on Author

```ruby
def new
  @author = Author.new({age: 20})
end
```

### Create

Processes the form given from the new path - often with 4 steps

1. instantiate a new object using form parameters
2. save the object
3. if save succeeds, redirect to the index page
4. if save fails, re-display the form so the user can correct errors

### Mass Assignment and Strong Parameters

Mass Assignment - pass a hash of values to an object - used by new, create, and update actions

Whitelisting = disallowing attributes to protect web sites - managed in the controller

Strong Parameters = turned on by default

```ruby
def author_params

end
```

### Edit/Update

Need to retrieve an existing record first

Update uses find and update_attributes to process its form, but applies the `update_attributes(@author)` method to update the database entry data

### Delete and Destroy

`<%= form_for(@author, url: author_path(@author), method: 'delete') do |f| %>`

But can be written as: `<%= form_for(@author, method: 'delete') do |f| %>`

### Flash Hash

Display a message to the user would be helpful upon completing an action such as destroying a database record

In HTML it's possible to keep track of things using cookies and sessions

The Flash hash stores a message and clears old messages after every request (one redirect)

Example: `flash[:notice] = "The subject was created successfully."`

Example: `flash[:error] = "Not enough access privileges."`

A good way to access the flash message is the following:

```ruby
<% if !flash[:notice].blank? %>
  <div class="notice">
    <%= flash[:notice] %>
  </div>
<% end %>
```

## Layouts

Template content appears within a layout including the `<%= yield %>` keyword.

Additional layouts can be defined in the `views/layouts` directory.

Can place repeatable code in a layout.

Instance variables can be defined in a template and are available to the layouts: `<% @page_title = "All Subjects Available" %>`

## Partials

For code that is repeated, a partial can hold the common code and make it available to a template

Partials are indicated with an underscore `_form.html.erb`

Referencing a partial that needs to have access to a parameter uses the locals field `<%= render partial: "form", locals: {f: f} %>`

## Text Helpers

- word_wrap - used with long text `<%= word_wrap(text, line_width: 30) %>` - will only work in HTML in the `pre` tag.

- simple_format - will respect line breaks using the `\n` new line and wrap text in paragraph tags `<%= simple_format(text) %>`

- truncate - breaks text at a specified length `<% truncate(text, length: 28) %>`

- pluralize - will apply plurals to text dynamically

```ruby
<% [0, 1, 2].each do |n| %>
  <%= pluralize(n, 'product') %>
<% end %>
```

Other useful text helpers include:

- truncate_words
- highlight
- excerpt

## Number Helpers

- number_to_currency
- number_to_percentage
- number_with_precision / number_to_rounded (alias for number_with_precision)
- number_with_delimited / number_to_delimited (alias for number_with_delimited)
- number_to_human
- number_to_human_size
- number_to_phone

Pattern used

- :delimited - delimits thousands (default ',')
- :separator - decimal separator (default '.')
- :precision - decimal places to show (default varies 2-3)

```ruby
number_to_currency(34.5, precision: 0, unit: "kr", format: "%n %u") # 35 kr
```

```ruby
number_to_percentage(34.5, precision: 1, separator: ',') # 34,5%
```

```ruby
number_with_precision(34.56789, precision: 6) # 34.567890
number_to_rounded(34.56789, precision: 6) # 34.567890
```

```ruby
number_with_delimiter(3456789, delimiter: ' ') # 3 456 789
number_to_delimited(3456789, delimiter: ' ') # 3 456 789
```

```ruby
number_to_human(123456789, precision: 5) # 123.46 Million
```

```ruby
number_to_human_size(1234567, precision: 2) # 1.2 MB
```

```ruby
number_to_phone(1234567890, area_code: true, delimiter: ' ', country_code: 1, extension: '321')
# +1 (123) 456 7890 x 321
```

## Date & Time Helpers

Available throughout Rails

Can use keywords in intuitive ways to indicate time concepts. Available keywords are: second, minute, hour, day, week, month, year.

```ruby
Time.now + 30.days - 23.minutes

Time.now - 30.days
# same as
30.days.ago

Time.now + 30.days
# same as
30.days.from_now
```

### Relative DateTime Calculations

beginning_of_day
beginning_of_week
beginning_of_month
beginning_of_year
yesterday
last_week
last_month
last_year
end_of_day
end_of_week
end_of_month
end_of_year
tomorrow
next_week
next_month
next_year

### Formatting

datetime.strftime(format_string)

```ruby
Time.now.strftime("%B %d, %Y %H:%M")
# "May 23, 2019 14:05"
```

Ruby DateTime formatting

Day
%a - abbreviated weekday name - Sun
%A - full weekday name - Sunday

Date
%d - day of the month (01..31)

Month
%b - abbreviated month name - Jan
%B - full month name - January
%m - month of the year (01..12)

Year
%y - year without century - (00..99)
%Y - year with century - ex. 2019

Time
%H - hour of the day; 24-hour clock (00..23)
%I - hour of the day; 12-hour clock (01..12)
%M - minute of the hour - (00..59)
%S - second of the minute - (00..60)
%p - meridian indicator (AM or PM)
%Z - time zone name

In Rails - DateTime formatting

`datetime.to_s(format_symbol)`

`Time.now.to_s(:long)`

DateTime Default Formats

:db - 2019-05-23 14:13:00
:number - 20190523141310
:time - 14:13
:short - 23 May 14:13
:long - May 23, 2019 14:13
:long_ordinal - May 23rd, 2019 14:13

## Custom Helpers

Best used for

- code that will be used repeatedly
- storing complex code so it doesn't occupy large parts of the controller
- writing Ruby code - without adding any html, etc.

Once defined, they can be called in the views.

## Sanitization Helpers

Prevent things like cross-site scripting (XSS)

Data could be potentially unsafe that comes from

- URL parameters
- form parameters
- cookie data
- database data

### Default Behavior

Corrected by escaping HTML using html entities for the opening and closing brackets `< >` which makes them text instead of code.

To use the string as html, use `raw()` to render it as code or `.html_safe`

```ruby
<% good_string = "<strong>Welcome to the website!</strong>" %>

<%= raw good_string %>

<%= good_string.html_safe %>
```

Other useful methods include `.strip_links(text)` to remove hyperlink code and `strip_tags(text)` to remove all html tags.

Sanitize function - defines tags and attributes that are allowed and removes all others.

```ruby
sanitize(html, options)

# permitted tags are p, br, strong, and em
# permitted attributes are id, class, and style
sanitize(@subject.content,
  tags: ["p", "br", "strong", "em"],
  attributes: ["id", "class", "style"]
)
```

## Asset Pipline

- concatenates CSS and JS files into single files
- compresses and minifies CSS and JS
- precompiles CSS and JS
- allows writing in other languages - ex. Sass
- adds asset fingerprint (forces browser to get a fresh copy of files)
- manifest files - contain directives for including asset files

Location

```ruby
app/assets/images
app/assets/javascripts
app/assets/stylesheets
```

Development vs Production

- in development skips concatenation, compression, fingerprinting
- in development - processing is done
- in production - does not do any processing, assumes assets have been precompiled
- this is done with the steps 1) `export RAILS_ENV=production`, and `bundle exec rails assets:precompile`

### Stylesheets Steps

1. write stylesheets
2. list stylesheets in manifest
3. add manifest to asset precompile list
4. include a stylesheet link tag in HTML

location: `/app/assets/stylesheets` or without asset pipeline `/public/stylesheets`

### Manifest file

located in application.css, or admin.css (shown below)

```css
/*
 * require_tree .
 *= require primary
 *= require admin_additions
 *= require_self
 */
 ```

`*= require_tree .` means to include all files within current directory

`*= require_self` means that styles within manifest file gets processed, not recommended place to put styles

`*= require primary` means that the file named primary should be included as part of the manifest

To add a separate CSS file, create a new manifest ex. `admin.css` and define the manifest - add `require admin_additions` to include this file as well.

Next, verify rails will precompile the files. In `config/initializers/assets.rb`.

Then add `Rails.application.config.assets.precompile += %w( admin.css )` with the admin.css defined and restart the server.
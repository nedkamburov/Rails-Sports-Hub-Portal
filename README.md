# Rails Sports Hub Portal

### A full-stack Sport Portal Hub built with Ruby on Rails

Access live demo at [https://sportshub.onrender.com](https://sportshub.onrender.com) <br>
* it might take up to 30 seconds to fully load<br>

[Link to the Sports Hub Requirements and Architecture](https://github.com/dark-side/lanthanum/tree/master/sports_hub_portal)

### Technologies:

- Ruby on Rails
- JavaScript (Stimulus)
- PostgreSQL

### Main features:

1. Home page with sports articles
   - Various categories, subcategories and teams
   - Articles with rich content
   - Comments on the articles with sorting and filtering options, likes and dislikes
   - Newsletter
   - Admin Dashboard to manage all content
2. Different types of users
3. Admin panel
4. Mailing service

### Installation instructions

Requirements: <br>
`ruby, rails, postgres, gem`

Initialise Postgres Database: <br>

```console
rails db:create
rails db:setup
```

Install the gems and fire up the server: <br>

```console
bundle install
rails server
```

### Other CLI functionalities
Send an email newsletter: <br>
`rake weekly_newsletter_email`

Run tests: <br>

```console 
rspec
bundle exec cucumber
```

### Extras
Generate a PDF (admins only) with all categories hierarchy by visiting localhost/admin.pdf

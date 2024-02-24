# Rails Sports Hub Portal

### A full-stack Sport Portal Hub built with Ruby on Rails

Access live demo at [https://sportshub-6m4y.onrender.com](https://sportshub-6m4y.onrender.com) <br>
* it might take up to 30 seconds to fully load<br>

[Link to the Sports Hub Requirements and Architecture](https://github.com/dark-side/sports-hub)

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

### Local Installation instructions

Requirements: <br>
`ruby, rails, postgres, gem, image-magick`

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

### Render Deployment instructions

1. Load the blueprint on Render and wait for it initialise the database and the web app.
2. You will have to provide the rails master key in the environment variables.
3. Use this guide to reset the secret and the public master key [https://discuss.rubyonrails.org/t/rails-master-key-and-per-environment-init/82615/2](https://discuss.rubyonrails.org/t/rails-master-key-and-per-environment-init/82615/2) 
4. The public one is commited to the repo but the secret one needs to match it and be set in `RAILS_MASTER_KEY` environment variable in the render web app.
5. The build should proceed, executing all the commands from ./bin/render-build.sh

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

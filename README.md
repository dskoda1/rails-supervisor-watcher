# Devise Authentication system with Rails 5

Almost every web application require user authentication. This is a boilerplate for user authentication with devise, Rails 5 and Postgresql.

I am using Cloud9 Development platform to create this project. If you are using local server, you may need to change the configuration for host.

Feel free to use this for your own project.

## Getting Started

### Step 1: Create a new username and password for postgresql

**Note:** You need to have postgresql installed in your system if you are not using Cloud9

First, you have to start the postgresql server and log into the psql server console.

```
$ sudo service postgresql start
$ sudo sudo -u postgres psql
```

Then, create a user in the server with default `username` and `password`. Exit the server.

```
postgres=# CREATE USER username SUPERUSER PASSWORD 'password';
postgres=# \q
```

### Step 2: Create the Environment variables in your local system

In your terminal / console, type the following command:

```
$ echo "export USERNAME=username" >> ~/.profile
$ echo "export PASSWORD=password" >> ~/.profile
$ source ~/.profile
```

If the username and password must match the user record created in Postgresql. Amend the above command if necessary.

### Step 3: Change the default configuration I have created

For this project, I have defined `\index` to be the page only login users can access. This is also the page that I have redirected to after user sign-up.

To change the redirect path (as per Devise's [documentation on sign up redirect](https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-up-%28registration%29)), change the `registrations_controller` file:

```ruby
  def after_sign_up_path_for(resource)
    \redirect\path\
  end
```

Note that `registrations_controller` extends the `Devise::RegistrationsController` class. Therefore, there is no need for you to write other registrations actions in the controller. Those actions will be inherited.

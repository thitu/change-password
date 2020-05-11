[![Build Status](https://travis-ci.com/thitu/change-password.svg?branch=master)](https://travis-ci.com/thitu/change-password)

# Change Passwords with Trusona

This is a pet project that makes password changes secure for certain people that I know.

## To get going...

This is a rails project: I will assume familiarity with the framework and underlying tooling.

```bash
bundle install
```

## Environment Variables

Add correct variables to `.env`. See `.env.example` for the template.


## Trusona Credentials

You can obtain your unique-to-you Trusona credentials at [dashboard.trusona.com](https://dashboard.trusona.com)


## Authorized Users

Configure your authorized users via `ENV['AUTHORIZED_USERS']`

This set of users can be dynamically obtained from a database or a remote service. Your choice.


## Change Password Command

Configure a change password command that would be executed once authorization and authentication is verified.

This is done expected via `ENV['PASSWD_SH']`

It will receive two arguments in order: the `username` and the `new password`

As is standard, it should exit with zero to indicate success and non-zero to indicate failure.

On success, a "your password was changed" email will be sent for confirmation, otherwise not.

Of course, there is an implied assumption that the "username" is an email address. Doh!


## Run the specs & features

```bash
bundle exec rake
```

## Take it for a spin

```bash
bundle exec rails s
```

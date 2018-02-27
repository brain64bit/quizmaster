# README

### Introduction

**QuizMaster** is web app that you will get random question, and what you need is answer the question with number (e.g 15, 7) or english numbering words (e.g fifty, seven).

### Setup

Here are the steps required to run the web application:

- Clone the repo, then install run `bundle install`
- Please run following commands:

```
PG_USERNAME=<yourpgusername> PG_PASSWORD=<yourpgpassword> rails db:create
PG_USERNAME=<yourpgusername> PG_PASSWORD=<yourpgpassword> rails db:migrate
PG_USERNAME=<yourpgusername> PG_PASSWORD=<yourpgpassword> rails db:seed
```

- After successfully execute that commands then run 


```
PG_USERNAME=<yourpgusername> PG_PASSWORD=<yourpgpassword> foreman start -f Procfile.dev
```

### Test

This application contains several tests:

- Rspec used by some tests like unit, controller and feature tests. To run you just need to execute `rspec` inside working directory
- Jest via yarn used to run javascript tests, in this application is used to test react components, to execute run `yarn test`.

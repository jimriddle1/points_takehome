---

# Overview

- Take Home challenge in which the task was to expose three endpoints of a transaction database
- Utilizes a mix of Active Record and Ruby to satisfy requirements

---

# Learning Goals

- Sad path and edge cases testing and functionality
- Expose an API for CRUD functionality

---

# Schema - 

![Screen Shot 2022-10-20 at 4 19 44 PM](https://user-images.githubusercontent.com/99755958/197061503-33b20267-849c-494b-a17f-fd89e185f4eb.png)

---

# API Usage

- Available Endpoints:
  - [Create transaction](#CREATE)
  - [Spend points](#UPDATE)
  - [View all transactions](#INDEX)

---

# CREATE


**Create Transaction**

- This endpoint creates a transaction 
	

``` ruby
[GET] /api/v1/transactions

```

 Example:

``` ruby 
[POST] /api/v1/transactions

- Body:
	  {
      "payer": "DANNON",
      "points": 1000,
      "timestamp": "2020-11-02T14:00:00Z"
    }

```

RESPONSE:

```json
{
	"data": {
		"id": "1",
		"type": "transaction",
		"attributes": {
			"payer": "DANNON",
			"points": 1000,
			"timestamp": "2020-11-02T14:00:00Z"
		}
	}
}
```

POSTMAN EXAMPLE: 
![Screen Shot 2022-10-20 at 4 59 30 PM](https://user-images.githubusercontent.com/99755958/197067161-f510312e-d643-4c1b-a470-e6b0b115b151.png)
---

# UPDATE


**Update Transactions**

- This endpoint spends points given a value
	

``` ruby
[PATCH] /api/v1/transactions/spend

```

 Example:

``` ruby 
[PATCH] /api/v1/transactions/spend

- Body:
	  {
      "points": 3000
    }

```

RESPONSE:

```json
{
	"data": [
		{
			"payer": "MILLER COORS",
			"points": -2000
		},
		{
			"payer": "DANNON",
			"points": -1000
		}
	]
}
```


# INDEX


**Transaction Index**

- This endpoint shows all transactions
	

``` ruby
[GET]  /api/v1/transactions

```

 Example:

``` ruby 
[GET]  /api/v1/transactions

```

RESPONSE:

```json
{
	"data": {
		"MILLER COORS": 10000,
		"DANNON": 1000
	}
}
```
---


# Feel like messing around?


## Installation

1. Clone this directory to your local repository using the SSH key:

```

$ git clone git@github.com:jimriddle1/transactions_takehome.git

```

  

2. Install gems for development using [Bundler](https://bundler.io/guides/using_bundler_in_applications.html#getting-started---installing-bundler-and-bundle-init):

```

$ bundle install

```

  

3. Set up your database with:

```

$ rails db:{drop,create,migrate}

```

  

4. Run the test suite with:

```

$ bundle exec rspec

```

  

5. Run your development server with:

```

$ rails s

```

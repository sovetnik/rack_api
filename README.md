Реализация JSON API, используя для роутинга только rack.
Хранилище данных постгрес.
Приложение должно отвечает на 3 запроса:

* POST /users
Принимает json вида:
```
{
  "email": "john@example.com"
}
```
email обязателен, проверяется на формат и уникальность. Ошибка возвращается с соответствующим кодом (email_missing, email_already_exists, wrong_email_format)

Возвращает:
```
{
  "data": {
    "id": "2ea550bc-705c-4702-b6d0-831919a33e5c",
    "email": "john@example.com"
  }
}
```

* GET /users
Возвращает список созданных пользователей:
```
{
  "data": [
    {
      "id": "2ea550bc-705c-4702-b6d0-831919a33e5c",
      "email": "john@example.com"
    }
  ]
}
```

* GET /users/:id
Возвращает пользователя по id:
```
{
  "data": {
    "id": "2ea550bc-705c-4702-b6d0-831919a33e5c",
    "email": "john@example.com"
  }
}
```

* На все остальные запросы возвращается 404 с кодом not_found


## Setup

```
createdb rack_api
ruby ./setup/db.rb

```

## Server

```
rackup
```

## Run test
```
rake
```

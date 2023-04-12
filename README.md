# wyga/http

Minimal http server which returns only status code.

```
docker run --rm -p 80:8000 wyga/http:204
```

## Why

I'm using this as default (catch all) backend for traefik deployments. Same as nginx config:

```
server {
  listen 8000 default_server;
  return 204;
}
```

but a lot smaller ...

## Images
```
wyga/http:200
wyga/http:204
wyga/http:403
wyga/http:404
wyga/http:500
wyga/http:503
```

# Nginx configurations

``` shell
$ cp * /etc/nginx/sites-available
$ ls -1 | while read p; do ln -s /etc/nginx/sites-available/$p /etc/nginx/sites-enabled/$p; done
$ systemctl reload nginx.service
```

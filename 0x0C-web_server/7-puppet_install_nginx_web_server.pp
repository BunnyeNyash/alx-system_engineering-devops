# Installs and configures Nginx using Puppet to serve "Hello World!" and redirect /redirect_me

package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
  ensure  => file,
}

file { '/etc/nginx/sites-enabled/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

file { '/etc/nginx/templates/default.erb':
  ensure  => file,
  content => @("END")
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html;
    server_name _;
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    location / {
        try_files \$uri \$uri/ =404;
    }
}
| END
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

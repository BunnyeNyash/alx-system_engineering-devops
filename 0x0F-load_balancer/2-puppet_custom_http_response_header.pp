# 2-puppet_custom_http_response_header.pp
# Configures a new Ubuntu machine to add a custom Nginx response header X-Served-By with the server hostname

# Ensure Nginx package is installed
package { 'nginx':
  ensure => installed,
}

# Get the hostname
$hostname = $::hostname

# Configure Nginx default site to include custom header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Template for Nginx configuration
file { '/etc/puppetlabs/code/environments/production/templates/nginx/default.erb':
  ensure  => file,
  content => @("END")
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    add_header X-Served-By <%= @hostname %>;
    root /var/www/html;
    index index.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
END
}

# Create a basic index.html
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure     => running,
  enable     => true,
  require    => Package['nginx'],
}

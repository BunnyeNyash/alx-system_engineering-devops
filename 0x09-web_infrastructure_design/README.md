# 0x09. Web Infrastructure Design

This project designs web infrastructures for `www.foobar.com`, meeting DevOps/SysAdmin requirements.

## Task 0: Simple Web Stack
- **Description:** Single server with LAMP stack (Nginx, PHP, MySQL, codebase) at IP `8.8.8.8`.
- **Components:** DNS (A record), Nginx (web server), PHP (app server), MySQL (database).
- **Issues:** SPOF (single server), downtime during maintenance, no scalability.
- **Diagram:** [https://imgur.com/a/S9GwaGP]

## Task 1: Distributed Web Infrastructure
- **Description:** Three servers with HAproxy, Nginx, PHP, MySQL (Primary + Replica).
- **Components:** HAproxy (round-robin), two servers split web/app and database.
- **Issues:** SPOF (HAproxy, MySQL Primary), no HTTPS, no monitoring.
- **Diagram:** [https://imgur.com/a/HKCMbMK]

## Task 2: Secured and Monitored Web Infrastructure
- **Description:** Adds firewalls, HTTPS, monitoring clients to Task 1.
- **Components:** Firewalls (filter traffic), SSL (encrypts traffic), Sumologic clients (monitor QPS, errors).
- **Issues:** SSL termination at HAproxy, single MySQL write node, mixed components.
- **Diagram:** [Imgur URL for Task 2 to insert later]

## Task 3: Scale Up
- **Description:** Adds server, HAproxy cluster, splits web/app/database.
- **Components:** Two HAproxy (active-active), four servers (Nginx, PHP, MySQL, extra server).
- **Why split:** Optimizes performance, eliminates SPOF.
- **Diagram:** [Imgur URL for Task 3 to insert later]

## Repository
- GitHub: `alx-system_engineering-devops`
- Directory: `0x09-web_infrastructure_design`

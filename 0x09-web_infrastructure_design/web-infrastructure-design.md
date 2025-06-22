# Web Infrastructure Design
## Task 0: Simple Web Stack
**Objective:** Design a one-server web infrastructure for www.foobar.com using a LAMP stack, reachable via IP 8.8.8.8.

**Diagram Description:**

- **Client (User):** A browser accessing www.foobar.com.
- **DNS:** Resolves www.foobar.com to 8.8.8.8 (A record).
- **Server (IP: 8.8.8.8):**
  - Runs Nginx (web server) to serve static content.
  - Runs PHP application server (e.g., PHP-FPM) to process dynamic content.
  - Runs MySQL (database) to store data.
  - Hosts application files (codebase).
- **Flow:** Client → DNS → Server (Nginx → PHP → MySQL) → Response to client.

**Components and Their Roles:**

- **Server:** A physical or virtual machine hosting all components (Nginx, PHP, MySQL, codebase). It’s a computer without direct input devices, accessible via the network.
- **Domain Name (foobar.com):** Maps human-readable name to IP 8.8.8.8, making the website accessible.
- **DNS Record (www):** An A record mapping www.foobar.com to 8.8.8.8.
- **Web Server (Nginx):** Handles HTTP requests, serves static files (e.g., HTML, CSS), and forwards dynamic requests to the application server.
- **Application Server (PHP):** Processes dynamic content (e.g., executes PHP scripts to generate HTML).
- **Database (MySQL):** Stores and manages data (e.g., user info, posts).
- **Communication:** The server uses HTTP over TCP/IP to communicate with the user’s browser.

**Issues with This Infrastructure:**

- **SPOF (Single Point of Failure):** The single server is a SPOF; if it fails (hardware, software, or network issue), the website is down.
- **Downtime During Maintenance:** Restarting Nginx or MySQL for updates or deploying new code causes downtime, as there’s no backup server.
- **Scalability Limitation:** A single server cannot handle high traffic (e.g., thousands of QPS), leading to slow performance or crashes.

---


## Task 1: Distributed Web Infrastructure
**Objective:** Design a three-server web infrastructure for www.foobar.com with a load balancer, addressing additional components and issues.

### Diagram Description:

- **Client (User):** Accesses www.foobar.com.
- **DNS:** Resolves to the load balancer’s IP (e.g., 8.8.8.8, A record).
- **Load Balancer (HAproxy):** Distributes traffic to two servers.
- **Server 1:**
  - Runs Nginx (web server).
  - Runs PHP application server.
  - Hosts application files.
- **Server 2:**
  - Runs MySQL (Primary node for writes).
  - Replica node (read-only) for redundancy.
- **Flow:** Client → DNS → HAproxy → Server 1 (Nginx → PHP) → Server 2 (MySQL) → Response.

### Components and Why They’re Added:

- **Load Balancer (HAproxy):** Distributes traffic across servers to improve scalability and reliability. Configured with round-robin algorithm, which cycles requests to each server evenly.
- **Two Servers:** Splitting web/app and database reduces load on a single server and mitigates SPOF.
- **Application Files:** Stored on Server 1 to serve dynamic content via PHP.
- **MySQL Primary-Replica Cluster:**
  - *Primary Node (Server 2):* Handles write operations (e.g., updating user data).
  - *Replica Node (Server 2 or another server):* Syncs with Primary for read operations, providing redundancy and read scalability.
- **Primary vs. Replica:** Primary accepts writes and syncs data to Replica; Replica handles reads, reducing Primary’s load.

### Load Balancer Setup:

- **Algorithm:** Round-robin, distributing requests sequentially to each server.
- **Active-Active vs. Active-Passive:**
  - *Active-Active:* Both servers handle traffic simultaneously (used here for load balancing).
  - *Active-Passive:* One server is active, the other is a standby (not used here).
- **Why Active-Active:** Increases capacity and redundancy; both servers process requests, reducing the risk of overload.

### Issues with This Infrastructure:

- **SPOF:**
  - Load balancer is a SPOF; if it fails, traffic cannot reach servers.
  - Primary MySQL node is a SPOF for writes; if it fails, writes stop.
- **Security Issues:**
  - No firewalls, leaving servers vulnerable to attacks (e.g., DDoS).
  - No HTTPS, so traffic is unencrypted, risking data interception.
- **No Monitoring:** No tools to track performance, errors, or uptime, making issue detection difficult.

---


## Task 2: Secured and Monitored Web Infrastructure
**Objective:** Enhance the three-server infrastructure with security (firewalls, HTTPS) and monitoring.

### Diagram Description:

- **Client (User):** Accesses www.foobar.com via HTTPS.
- **DNS:** Resolves to load balancer’s IP (A record).
- **Load Balancer (HAproxy):** Distributes traffic, terminates SSL.
- **Server 1:** Nginx, PHP, codebase, monitoring client.
- **Server 2:** MySQL (Primary + Replica), monitoring client.
- **Firewalls:** One per server (including load balancer) to filter traffic.
- **SSL Certificate:** Installed on HAproxy for HTTPS.
- **Monitoring Clients:** Collect data for a tool like Sumologic.
- **Flow:** Client → DNS → HAproxy (HTTPS) → Server 1 (Nginx → PHP) → Server 2 (MySQL) → Response.

### Components and Why They’re Added:

- **Firewalls:** Protect servers by filtering traffic, allowing only specific ports (e.g., 80, 443) and blocking malicious requests.
- **SSL Certificate:** Enables HTTPS, encrypting traffic between user and load balancer for security.
- **Monitoring Clients:** Collect metrics (e.g., CPU, memory, QPS) for tools like Sumologic to track performance and detect issues.

### Specifics:

- **Firewalls:** Block unauthorized access (e.g., only allow HTTP/443, MySQL/3306 between servers).
- **HTTPS:** Ensures data privacy and integrity; users trust secure sites.
- **Monitoring Purpose:** Tracks system health, alerts on issues (e.g., high QPS, errors).
- **Monitoring Data Collection:** Clients (e.g., Sumologic agents) gather logs, metrics (CPU, memory, QPS), and send them to a central dashboard.
- **Monitoring QPS:** Configure monitoring tool to track HTTP requests per second on Nginx (e.g., via access logs or NewRelic).

### Issues with This Infrastructure:

- **SSL Termination at Load Balancer:** Terminating SSL at HAproxy means traffic between HAproxy and servers is unencrypted, risking internal data exposure.
- **Single MySQL Write Node:** Only the Primary node accepts writes, a SPOF for write operations.
- **Same Components on Servers:** Having web server, app server, and database on similar servers (if not fully split) can lead to resource contention or complexity.

---



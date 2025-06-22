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



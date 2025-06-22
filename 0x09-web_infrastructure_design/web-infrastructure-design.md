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



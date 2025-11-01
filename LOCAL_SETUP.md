# Local Setup Guide (Without Docker)

This guide will help you run the ShopSquare microservices project locally without Docker.

## Prerequisites

1. **Java JDK 11 or higher** - Check with `java -version`
2. **Maven 3.6+** - Check with `mvn -version`
3. **MySQL 8.0+** - Check with `mysql --version`
4. **Node.js 16+ and npm** - Check with `node -v` and `npm -v`

## Step 1: Set Up MySQL Database

1. Start your MySQL server locally:
   ```bash
   # On macOS with Homebrew:
   brew services start mysql
   
   # Or start it manually:
   mysql.server start
   ```

2. Create the required databases by running the init script:
   ```bash
   mysql -u root -p < init-db.sql
   ```
   
   If your MySQL root user doesn't have a password, you can use:
   ```bash
   mysql -u root < init-db.sql
   ```

3. Verify databases are created:
   ```bash
   mysql -u root -p -e "SHOW DATABASES;"
   ```
   
   You should see:
   - `user_service_db`
   - `shop_service_db`
   - `products_db`
   - `cart_service_db`
   - `order_service_db`
   - `profile_service_db`
   - `cartitem_service_db`
   - `orderitem_service_db`

## Step 2: Start Services

### Option A: Use the Start Script (Recommended)

Simply run the provided script:
```bash
chmod +x start-all.sh
./start-all.sh
```

This will start all services in the background.

### Option B: Start Services Manually

Start services in this order (wait for each to start before starting the next):

1. **Eureka Server** (Service Discovery):
   ```bash
   cd eurekaserver
   mvn spring-boot:run
   ```
   Wait until it's running at http://localhost:8761

2. **API Gateway**:
   ```bash
   cd apigateway
   mvn spring-boot:run
   ```
   Runs on http://localhost:9100

3. **All Other Services** (in separate terminal windows):
   ```bash
   # User Service (port 9101)
   cd user-service && mvn spring-boot:run
   
   # Shop Service (port 9102)
   cd shopservice && mvn spring-boot:run
   
   # Product Service (port 9103)
   cd productservice && mvn spring-boot:run
   
   # Cart Service (port 9104)
   cd cartservice && mvn spring-boot:run
   
   # Order Service (port 9105)
   cd orderservice && mvn spring-boot:run
   
   # Profile Service (port 9106)
   cd profileservice && mvn spring-boot:run
   
   # Cart Item Service (port 9107)
   cd cartitem && mvn spring-boot:run
   
   # Order Item Service (port 9108)
   cd orderitem && mvn spring-boot:run
   ```

## Step 3: Start Frontend

1. Navigate to the UI directory:
   ```bash
   cd ui
   ```

2. Install dependencies (if not already done):
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

   The frontend will be available at http://localhost:5173

## Service Ports Summary

| Service | Port | URL |
|---------|------|-----|
| Eureka Server | 8761 | http://localhost:8761 |
| API Gateway | 9100 | http://localhost:9100 |
| User Service | 9101 | http://localhost:9101 |
| Shop Service | 9102 | http://localhost:9102 |
| Product Service | 9103 | http://localhost:9103 |
| Cart Service | 9104 | http://localhost:9104 |
| Order Service | 9105 | http://localhost:9105 |
| Profile Service | 9106 | http://localhost:9106 |
| Cart Item Service | 9107 | http://localhost:9107 |
| Order Item Service | 9108 | http://localhost:9108 |
| Frontend | 5173 | http://localhost:5173 |

## Verification

1. **Check Eureka Dashboard**: Visit http://localhost:8761
   - You should see all services registered except Eureka itself

2. **Check API Gateway**: Visit http://localhost:9100
   - Should be accessible and routing requests

3. **Check Individual Services**: Each service has Swagger UI available at:
   - http://localhost:PORT/swagger-ui.html
   - Example: http://localhost:9101/swagger-ui.html

4. **Check Frontend**: Visit http://localhost:5173
   - Should load the application

## Troubleshooting

### Services won't start
- Make sure MySQL is running: `mysql.server status`
- Check if ports are already in use: `lsof -i :PORT`
- Verify Java version: `java -version` (should be 11+)

### Services not registering with Eureka
- Wait for Eureka Server to fully start before starting other services
- Check Eureka URL in application.properties is `http://localhost:8761/eureka/`
- Check service logs for connection errors

### Database connection errors
- Verify MySQL is running: `mysql -u root -p -e "SELECT 1;"`
- Check database exists: `mysql -u root -p -e "SHOW DATABASES;"`
- Verify credentials in application.properties match your MySQL setup

### Frontend can't connect to API
- Ensure API Gateway is running on port 9100
- Check browser console for CORS errors
- Verify the proxy configuration in vite.config.ts

## Stopping Services

If you used the `start-all.sh` script:
```bash
# Find and kill all Java processes
pkill -f spring-boot:run

# Or find specific process IDs
ps aux | grep spring-boot
kill <PID>
```

For manually started services, use `Ctrl+C` in each terminal window.


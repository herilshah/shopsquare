#!/bin/bash

# Create logs directory if it doesn't exist
mkdir -p logs

# Start Eureka Server
echo "Starting Eureka Server..."
cd eurekaserver
mvn spring-boot:run > ../logs/eureka.log 2>&1 &
EUREKA_PID=$!
cd ..
echo "Eureka Server starting (PID: $EUREKA_PID), waiting 30 seconds..."
sleep 30

# Start API Gateway
echo "Starting API Gateway..."
cd apigateway
mvn spring-boot:run > ../logs/apigateway.log 2>&1 &
cd ..
echo "API Gateway starting, waiting 10 seconds..."
sleep 10

# Start User Service
echo "Starting User Service..."
cd user-service
mvn spring-boot:run > ../logs/user-service.log 2>&1 &
cd ..
sleep 5

# Start Shop Service
echo "Starting Shop Service..."
cd shopservice
mvn spring-boot:run > ../logs/shop-service.log 2>&1 &
cd ..
sleep 5

# Start Product Service
echo "Starting Product Service..."
cd productservice
mvn spring-boot:run > ../logs/product-service.log 2>&1 &
cd ..
sleep 5

# Start Cart Service
echo "Starting Cart Service..."
cd cartservice
mvn spring-boot:run > ../logs/cart-service.log 2>&1 &
cd ..
sleep 5

# Start Order Service
echo "Starting Order Service..."
cd orderservice
mvn spring-boot:run > ../logs/order-service.log 2>&1 &
cd ..
sleep 5

# Start Profile Service
echo "Starting Profile Service..."
cd profileservice
mvn spring-boot:run > ../logs/profile-service.log 2>&1 &
cd ..
sleep 5

# Start Cart Item Service
echo "Starting Cart Item Service..."
cd cartitem
mvn spring-boot:run > ../logs/cart-item-service.log 2>&1 &
cd ..
sleep 5

# Start Order Item Service
echo "Starting Order Item Service..."
cd orderitem
mvn spring-boot:run > ../logs/order-item-service.log 2>&1 &
cd ..

echo ""
echo "All services started!"
echo ""
echo "Service URLs:"
echo "  Eureka Server: http://localhost:8761"
echo "  API Gateway: http://localhost:9100"
echo "  Frontend: http://localhost:5173 (run 'cd ui && npm run dev')"
echo ""
echo "Logs are available in the ./logs directory"
echo "To stop all services, run: pkill -f spring-boot:run"

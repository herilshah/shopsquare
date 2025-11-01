# Docker Images Built Successfully! 🐳

All microservices have been containerized and Docker images have been created.

## Built Images

All images are tagged with `shopsquare/<service-name>:latest`:

1. ✅ **shopsquare/eureka-server:latest** (536MB) - Service Discovery
2. ✅ **shopsquare/apigateway:latest** (524MB) - API Gateway
3. ✅ **shopsquare/user-service:latest** (593MB) - User Service
4. ✅ **shopsquare/shop-service:latest** (586MB) - Shop Service
5. ✅ **shopsquare/product-service:latest** (586MB) - Product Service
6. ✅ **shopsquare/cart-service:latest** (586MB) - Cart Service
7. ✅ **shopsquare/order-service:latest** (586MB) - Order Service
8. ✅ **shopsquare/profile-service:latest** (586MB) - Profile Service
9. ✅ **shopsquare/cart-item-service:latest** (586MB) - Cart Item Service
10. ✅ **shopsquare/order-item-service:latest** (586MB) - Order Item Service
11. ✅ **shopsquare/frontend:latest** (81.4MB) - Frontend UI

**Total: 11 Docker images**

## View Images

```bash
docker images shopsquare/*
```

## Run with Docker Compose

The existing `docker-compose.yml` is configured to build images automatically. You can also use the pre-built images by updating the compose file to reference them.

To run everything:
```bash
docker-compose up -d
```

## Manual Image Commands

### List all images
```bash
docker images | grep shopsquare
```

### Run a single service
```bash
# Example: Run Eureka Server
docker run -d -p 8761:8761 --name eureka shopsquare/eureka-server:latest

# Example: Run User Service
docker run -d -p 9101:9101 --name user-service \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://host.docker.internal:3306/user_service_db \
  -e EUREKA_CLIENT_SERVICE_URL_DEFAULTZONE=http://host.docker.internal:8761/eureka/ \
  shopsquare/user-service:latest
```

### Tag with version
```bash
docker tag shopsquare/eureka-server:latest shopsquare/eureka-server:v1.0
```

### Push to registry (if needed)
```bash
# Tag for your registry
docker tag shopsquare/eureka-server:latest your-registry/shopsquare/eureka-server:latest

# Push
docker push your-registry/shopsquare/eureka-server:latest
```

## Rebuild Images

To rebuild all images:
```bash
./build-docker-images.sh
```

To rebuild a specific service:
```bash
cd <service-directory>
docker build -t shopsquare/<service-name>:latest .
```

## Image Sizes

- **Frontend**: 81.4MB (lightweight nginx)
- **API Gateway**: 524MB
- **Eureka Server**: 536MB
- **Microservices**: ~586MB each
- **User Service**: 593MB (slightly larger)

## Notes

- All images use multi-stage builds for optimal size
- Images are based on `eclipse-temurin:21-jre` for Java services
- Frontend uses `nginx:alpine` for serving static files
- Images include compiled JAR files from Maven builds


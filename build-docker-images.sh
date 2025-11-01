#!/bin/bash

# Script to build all Docker images for the ShopSquare microservices project

set -e  # Exit on error

echo "🐳 Building Docker images for all services..."
echo ""

# Define image name prefix
IMAGE_PREFIX="shopsquare"

# Services to build
services=(
    "eurekaserver:eureka-server:8761"
    "apigateway:apigateway:9100"
    "user-service:user-service:9101"
    "shopservice:shop-service:9102"
    "productservice:product-service:9103"
    "cartservice:cart-service:9104"
    "orderservice:order-service:9105"
    "profileservice:profile-service:9106"
    "cartitem:cart-item-service:9107"
    "orderitem:order-item-service:9108"
    "ui:frontend:5173"
)

# Build each service
for service_info in "${services[@]}"; do
    IFS=':' read -r directory image_name port <<< "$service_info"
    
    echo "📦 Building $image_name..."
    echo "   Directory: $directory"
    
    cd "$directory"
    
    # Build the Docker image
    docker build -t "${IMAGE_PREFIX}/${image_name}:latest" .
    
    echo "   ✓ $image_name built successfully!"
    echo ""
    
    cd ..
done

echo ""
echo "✅ All Docker images built successfully!"
echo ""
echo "📋 Built images:"
docker images | grep "$IMAGE_PREFIX" || echo "No images found with prefix $IMAGE_PREFIX"
echo ""
echo "🚀 To run with Docker Compose:"
echo "   docker-compose up -d"
echo ""
echo "💡 To tag images with a version:"
echo "   docker tag ${IMAGE_PREFIX}/<service>:latest ${IMAGE_PREFIX}/<service>:v1.0"


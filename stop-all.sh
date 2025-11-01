#!/bin/bash

echo "Stopping all Spring Boot services..."

# Kill all spring-boot processes
pkill -f spring-boot:run

echo "All services stopped."
echo ""
echo "Note: If some services are still running, you can manually stop them:"
echo "  ps aux | grep spring-boot"
echo "  kill <PID>"


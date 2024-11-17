# Variables
WEB_IMAGE=nginx:latest
WEB_CONTAINER=web
MAILER_IMAGE=mailer-image
MAILER_CONTAINER=mailer
WATCHER_IMAGE=watcher-image
WATCHER_CONTAINER=agent

# Default target
all: start_web build_mailer start_mailer build_watcher start_watcher

# Step 1: Start NGINX Container
start_web:
    docker run -d --name $(WEB_CONTAINER) $(WEB_IMAGE)

# Step 2: Create and Start Mailer Container
build_mailer:
    docker build -t $(MAILER_IMAGE) -f Dockerfile .

start_mailer:
    docker run -d --name $(MAILER_CONTAINER) $(MAILER_IMAGE)

# Step 4: Start the Agent Container
build_watcher:
    docker build -t $(WATCHER_IMAGE) -f Dockerfile.watcher .

start_watcher:
    docker run -d --name $(WATCHER_CONTAINER) --link $(WEB_CONTAINER):insideweb --link $(MAILER_CONTAINER):insidemailer $(WATCHER_IMAGE)

# Step 5: List Running Containers
list_containers:
    docker ps

# Step 6: Restart Containers
restart_containers:
    docker restart $(WEB_CONTAINER)
    docker restart $(MAILER_CONTAINER)
    docker restart $(WATCHER_CONTAINER)

# Step 7: View Container Logs
logs_web:
    docker logs $(WEB_CONTAINER)

logs_mailer:
    docker logs $(MAILER_CONTAINER)

logs_watcher:
    docker logs $(WATCHER_CONTAINER)

# Step 8: Follow Logs
follow_logs_watcher:
    docker logs -f $(WATCHER_CONTAINER)

# Step 9: Test the System
stop_web:
    docker stop $(WEB_CONTAINER)

# Clean up
clean:
    docker rm -f $(WEB_CONTAINER) $(MAILER_CONTAINER) $(WATCHER_CONTAINER)
    docker rmi $(MAILER_IMAGE) $(WATCHER_IMAGE)

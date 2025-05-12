# 🛠️  Makefile for Docker Management 🐳

# 🌈 Colors and Emojis
GREEN  := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
BLUE   := $(shell tput setaf 4)
NC     := $(shell tput sgr0)
ROCKET := 🚀
TRASH  := 🗑️
CHECK  := ✅
INFO   := ℹ️
PROTO  := 📦

# 📜 Help Command
.PHONY: help
help:
	@echo "${BLUE}Usage: make [command]${NC}"
	@echo ""
	@echo "${YELLOW}🐳  Docker Commands:${NC}"
	@echo "${GREEN}  docker-start${NC}              - ${ROCKET}	Start Docker containers in detached mode"
	@echo "${GREEN}  docker-build${NC}              - ${ROCKET}	Build and start Docker containers in detached mode"
	@echo "${GREEN}  docker-clean${NC}              - ${TRASH}	Clean up Docker resources (images, containers, volumes, caches)"
	@echo ""
	@echo "${YELLOW}📦 Proto Commands:${NC}"
	@echo "${GREEN}  compile-auth-proto${NC}        - ${PROTO}	Compile auth.proto file"
	@echo "${GREEN}  compile-product-proto${NC}     - ${PROTO}	Compile product.proto file"
	@echo "${GREEN}  compile-inventory-proto${NC}   - ${PROTO}	Compile inventory.proto file"
	@echo "${GREEN}  compile-order-proto${NC}       - ${PROTO}	Compile order.proto file"
	@echo ""
	@echo "${YELLOW}🛠️   Utility Commands:${NC}"
	@echo "${GREEN}  help${NC}                      - ${INFO}	Show this help message"

# 🚀 Start Docker Container
.PHONY: docker-start
docker-start:
	@echo "${GREEN}${ROCKET} Starting Docker containers...${NC}"
	docker compose up -d
	@echo "${GREEN}${CHECK} Docker containers are up and running!${NC}"

# 🚀 Build and Start Docker Containers
.PHONY: docker-build
docker-build:
	@echo "${GREEN}${ROCKET} Building and starting Docker containers...${NC}"
	docker compose up -d --build
	@echo "${GREEN}${CHECK} Docker containers are up and running!${NC}"

# 🗑️ Clean Docker Resources
.PHONY: docker-clean
docker-clean:
	@echo "${YELLOW}${TRASH} Cleaning up Docker resources...${NC}"
	@echo "${YELLOW}  - Stopping and removing containers...${NC}"
	docker compose down --remove-orphans
	@echo "${YELLOW}  - Removing unused images...${NC}"
	docker image prune -af
	@echo "${YELLOW}  - Removing unused volumes...${NC}"
	docker volume prune -f
	@echo "${YELLOW}  - Removing build cache...${NC}"
	docker builder prune -af
	@echo "${GREEN}${CHECK} Docker resources cleaned up!${NC}"

# 📦 Proto Compilation Commands
.PHONY: compile-auth-proto
compile-auth-proto:
	@echo "${BLUE}${PROTO} Compiling auth.proto...${NC}"
	@protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		common/proto/auth/auth.proto
	@echo "${GREEN}${CHECK} Auth proto compilation completed!${NC}"

.PHONY: compile-product-proto
compile-product-proto:
	@echo "${BLUE}${PROTO} Compiling product.proto...${NC}"
	@protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		common/proto/product/product.proto
	@echo "${GREEN}${CHECK} Product proto compilation completed!${NC}"

.PHONY: compile-inventory-proto
compile-inventory-proto:
	@echo "${BLUE}${PROTO} Compiling inventory.proto...${NC}"
	@protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		common/proto/inventory/inventory.proto
	@echo "${GREEN}${CHECK} Inventory proto compilation completed!${NC}"

.PHONY: compile-order-proto
compile-order-proto:
	@echo "${BLUE}${PROTO} Compiling order.proto...${NC}"
	@protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		common/proto/order/order.proto
	@echo "${GREEN}${CHECK} Order proto compilation completed!${NC}"
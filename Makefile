WAILS_VERSION ?= v2.11.0

.PHONY: build wails

wails:
	@command -v wails >/dev/null 2>&1 || (echo "Installing Wails $(WAILS_VERSION)..." && go install github.com/wailsapp/wails/v2/cmd/wails@$(WAILS_VERSION))

build: wails
	wails build -clean

BINARY ?= osci-workflow-validation

.PHONY: build test fmt vet clean run

build:
	go build -o $(BINARY) .

test:
	go test ./... -v

fmt:
	gofmt -w .

vet:
	go vet ./...

run: build
	./$(BINARY)

clean:
	rm -f $(BINARY)

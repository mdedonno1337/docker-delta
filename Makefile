DIR := ${CURDIR}
CURRENT_UID := $$(id -u)
CURRENT_GID := $$(id -g)

all: build copy

build:
	docker build -t delta .

copy:
	docker run --rm -v $(DIR):/out -u $(CURRENT_UID):$(CURRENT_GID) delta cp target/release/delta /out
	ls -la delta
	./delta --version

clean:
	docker rmi -f delta
	docker rmi -f rust

install: build copy
	sudo cp ./delta $$(which delta)


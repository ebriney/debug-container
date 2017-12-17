#https://docs.docker.com/engine/reference/run/#example-run-htop-inside-a-container
IT ?= 0
ifeq ($(IT),0)
  PARAMS=
else
  PARAMS=-it
endif

all: stop tests contExt run

.PHONY: tests

contExt:
	cd src && docker build -t cont_ext .

tests:
	cd tests && docker build -t cont_ext_sleep_test .

run:
	docker run --rm -d --name cont_ext_sleep_test cont_ext_sleep_test
	./debug-container.sh cont_ext_sleep_test cont_ext $(PARAMS)

stop:
	@docker kill cont_ext_sleep_test 1>/dev/null 2>/dev/null || true
	@docker kill cont_ext 1>/dev/null 2>/dev/null || true
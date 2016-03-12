###Docker targets
dbuild: docker/Dockerfile.template
	cd docker; ./build $(if $(nocache),"--no-cache")

dcibuild: dbuild
	"./script/cibuild"

dtest: dbuild
	cd docker; ./run_test "make test"

dclean: dbuild
	cd docker; ./run "make clean"

drun: dbuild
	cd docker; ./run "make run"

dbash: dbuild
	cd docker; ./run "/bin/bash"

###Erlang targets
REBAR := ./rebar

all: get-deps compile compile-app

get-deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile

compile-app:
	$(REBAR) boss c=compile

test:
	$(REBAR) boss c=test_functional

help:
	@echo 'Makefile for your chicagoboss app                                      '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make help                        displays this help text            '
	@echo '   make get-deps                    updates all dependencies           '
	@echo '   make compile                     compiles dependencies              '
	@echo '   make compile-app                 compiles only your app             '
	@echo '                                    (so you can reload via init.sh)    '
	@echo '   make test                        runs functional tests              '
	@echo '   make all                         get-deps compile compile-app       '
	@echo '                                                                       '
	@echo 'DEFAULT:                                                               '
	@echo '   make all                                                            '
	@echo '                                                                       '

.PHONY: all get-deps compile compile-app help test


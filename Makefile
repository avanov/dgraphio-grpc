# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
PROJECT_MKFILE_PATH := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_MKFILE_DIR  := $(shell cd $(shell dirname $(PROJECT_MKFILE_PATH)); pwd)

PROJECT_NAME      := dgraphio-grpc
PROJECT_ROOT      := $(PROJECT_MKFILE_DIR)

PROTO_DIR         := $(PROJECT_ROOT)/dgo/protos
PROTO_FILE        := api.proto
PROTO_BINDINGS    := $(PROJECT_ROOT)/src/lib

.PHONY: buildall codegen

codegen:
	cabal v2-exec -- compile-proto-file --includeDir $(PROTO_DIR) --proto $(PROTO_FILE) --out $(PROTO_BINDINGS)

all:
	cabal v2-build all

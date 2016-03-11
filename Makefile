# This makefile is only used for the Continues Integration

.PHONY: all test clean

ci:
	ci/test.sh

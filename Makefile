default: help

mutant ?= .
fuzzer ?= .

help:
	@echo "usage:"
	@echo "	make setup 					set up the env with required dependencies"
	@echo "	make test					fuzz against default codebase"
	@echo "	make mutate					create patch files using mutation tools"
	@echo "	make evaluate <seed> [<mutant> <fuzzer>]	evaluate fuzzers for a particular seed and optionally a mutant and a fuzzer"
	@echo "	make run					run all fuzzers in alternating sequence using a default seed value"


setup:
	./setup.sh

test:
	./test.sh

mutate:
	./mutate.sh

evaluate:
	./evaluate.sh $(seed) $(mutant) $(fuzzer)

run:
	./run.sh
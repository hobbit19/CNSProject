#Author: Polonio Davide <poloniodavide@gmail.com>
#License: GPLv3

OUTPUT_NAME= cnsproject
LIST_NAME= listOfSections.tex
PATH_OF_CONTENTS= res/sections
COMPILER_OPTIONS= pdflatex -interaction=nonstopmode

SHELL := /bin/bash #Need bash not shell

all: generate quiet

debug: generate notquiet

generate:
	set -e; \
	if [[ -a "res/$(LIST_NAME)" ]]; then echo "Removing res/$(LIST_NAME)"; \
		rm res/$(LIST_NAME); fi; \
	for i in $(sort $(wildcard $(PATH_OF_CONTENTS)/*.tex)); do \
		echo $i; \
		if [[ $$i != "$(PATH_OF_CONTENTS)/Abstract.tex" ]]; then \
			echo "Adding $$i into $(LIST_NAME)"; \
			echo "\input{$$i}" >> res/$(LIST_NAME); \
		fi \
	done; \

quiet:
	latexmk -jobname=$(OUTPUT_NAME) -pdflatex='$(COMPILER_OPTIONS)' -quiet -pdf main.tex;

notquiet:
	latexmk -jobname=$(OUTPUT_NAME) -pdflatex='$(COMPILER_OPTIONS)' -pdf main.tex;

clean:
	git clean -Xfd
	if [[ -a "$(OUTPUT_NAME)" ]]; then rm -rv $(OUTPUT_NAME)/; fi;

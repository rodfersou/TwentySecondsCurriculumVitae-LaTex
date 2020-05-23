all: build
	@echo "Done!"
build: src/*.tex
	@echo "Building.... $^"
	(find src -name '*.tex' -exec sh -c 'pdflatex -interaction=nonstopmode "$$1" 1> /dev/null' _ {} \;)
	(find src -name '*.pdf' -exec sh -c 'convert -density 150 -trim -quality 100 -flatten -sharpen 0x1.0 "$$1" "$${1%.pdf}.jpg"' _ {}  \;)
clean:
	(cd src && rm -f *.aux *.dvi *.log *.out *.bak)
	@echo "Clean done.";

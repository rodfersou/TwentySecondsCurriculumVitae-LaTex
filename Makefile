DOCKER=docker-compose run --rm latex
PDFLATEX=$(DOCKER) pdflatex -interaction=nonstopmode -output-directory=out
CONVERT=$(DOCKER) convert -density 150 -trim -quality 100 -flatten -sharpen 0x1.0

all: build
	@echo "Done!"
build: src/*.tex
	@echo "Building.... $^"
	for i in $$(find src -name '*.tex'); do     \
		$(PDFLATEX) "$$i" 1> /dev/null || true; \
	done
	make clean
	for i in $$(find out -name '*.pdf'); do \
		$(CONVERT) "$$i" "$${i%.pdf}.jpg";  \
	done
clean:
	cd out && rm -f *.aux *.dvi *.log *.out *.bak

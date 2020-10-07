DOCKER=docker-compose run --rm latex
PDFLATEX=$(DOCKER) pdflatex -interaction=nonstopmode
FIX_CONVERT=sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
CONVERT=$(DOCKER) $(FIX_CONVERT) && convert -density 150 -trim -quality 100 -flatten -sharpen 0x1.0

all: build
	@echo "Done!"
build: src/*.tex
	@echo "Building.... $^"
	find src -name '*.tex' -exec sh -c '$(PDFLATEX) "$$1" 1> /dev/null' _ {} \;
	find src -name '*.pdf' -exec sh -c '$(CONVERT) "$$1" "$${1%.pdf}.jpg"' _ {}  \;
clean:
	rm *.log
	cd src && rm -f *.aux *.dvi *.out *.bak
	@echo "Clean done.";

# Makefile twentyseconds cv

DOCKER=docker run --rm -it -v $$PWD:/data laurenss/texlive-full:2019
PDFLATEX=$(DOCKER) pdflatex -interaction=nonstopmode
FIX_CONVERT=sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
CONVERT=$(DOCKER) $(FIX_CONVERT) && convert -density 150 -trim -quality 100 -flatten -sharpen 0x1.0

files_tex = $(wildcard *.tex)
all: pdf
	@echo "Done!"
pdf: *.tex
	@echo "Building.... $^"
	@$(foreach var,$(files_tex),$(PDFLATEX) '$(var)' 1>/dev/null;)
	@$(foreach var,$(files_tex),$(CONVERT) '$(var:.tex=.pdf)' '$(var:.tex=.jpg)';)
clean:
	@rm -f *.aux *.dvi *.log *.out *.bak
	@echo "Clean done.";

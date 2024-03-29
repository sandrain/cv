#
# Makefile
#

.SUFFIXES: .tex .dvi .ps .fig .eps .gnu .c
PDF = ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true \
      -dSubsetFonts=true -dMaxSubsetPct=100

TARGET=cv

SPELL := aspell -a
UNAME := $(shell uname)
VIEWER := atril
ifeq ($(UNAME), Darwin)
	VIEWER := open
endif

TODAY = $(shell date +%Y%m)

all: pdflatex pub

display: $(TARGET)
	dvips -Ppdf -Pcmz -Pamz -t letter -D600 -G0 -o $(TARGET).ps $(TARGET).dvi
	$(PDF) $(TARGET).ps
	$(VIEWER) $(TARGET).pdf

hyogisim-publications.pdf: hyogisim-publications.tex head.tex publications.tex presentations.tex
	pdflatex hyogisim-publications
	pdflatex hyogisim-publications
	pdflatex hyogisim-publications
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' hyogisim-publications.log) \
	do pdflatex $(TARGET); done
	cp hyogisim-publications.pdf pub/hyogisim-publications-$(TODAY).pdf

pub: hyogisim-publications.pdf

pdflatex: $(TARGET).tex
	pdflatex $(TARGET)
	pdflatex $(TARGET)
	pdflatex $(TARGET)
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $(TARGET).log) \
	do pdflatex $(TARGET); done
	cp cv.pdf cv/hyogisim-cv-$(TODAY).pdf
	cp -f cv.pdf docs/hyogisim-cv.pdf

clean:
	$(RM) $(TARGET).ps $(TARGET).pdf $(TARGET).log $(TARGET).aux \
	      $(TARGET).dvi $(TARGET).tex.flc
	$(RM) $(TARGET).bbl $(TARGET).blg
	$(RM) *.kill kill* *.aux

purge:  clean
	$(RM) *~

#spell:
#	cat $(TF) | awk '{ if (index($$0,"%")!=1) print $$0}' |  $(SPELL)
#	#       detex $(TF) |  spell

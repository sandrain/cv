#
# Makefile
#

.SUFFIXES: .tex .dvi .ps .fig .eps .gnu .c
#PDF = ps2pdf -dPDFSETTINGS=/printer -dMaxSubsetPct=100 \
#      -dCompatibilityLevel=1.4 -dSubsetFonts=true -dEmbedAllFonts=true
PDF = ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true \
      -dSubsetFonts=true -dMaxSubsetPct=100

TARGET=cv

SPELL := aspell -a
UNAME := $(shell uname)
VIEWER := evince
ifeq ($(UNAME), Darwin)
	#VIEWER := open -a Skim
	VIEWER := open
endif

all:    pdf

display: $(TARGET)
	dvips -Ppdf -Pcmz -Pamz -t letter -D600 -G0 -o $(TARGET).ps $(TARGET).dvi
	$(PDF) $(TARGET).ps
	$(VIEWER) $(TARGET).pdf

pdf: $(TARGET)
	dvips -Ppdf -Pcmz -Pamz -t letter -D600 -G0 -o $(TARGET).ps $(TARGET).dvi
	$(PDF) $(TARGET).ps
	cp cv.pdf hyogisim-cv-201701.pdf

$(TARGET): $(TARGET).tex
	latex $(TARGET)
	latex $(TARGET)
	latex $(TARGET)

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

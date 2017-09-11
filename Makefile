BUILD = build
BOOKNAME = category-theory-for-programmers
TITLE = title.txt
METADATA = metadata.xml
STYLE = base.css
LATEX = base.latex
CHAPTERS = preface.md ch01.md ch02.md ch03.md ch04.md ch05.md ch06.md ch07.md ch08.md ch09.md
TOC = --toc --toc-depth=2
COVER_IMAGE = images/beauvais_interior_supports.jpg
LATEX_CLASS = report

all: book

book: epub html pdf

clean:
	rm -r $(BUILD)

epub: $(BUILD)/epub/$(BOOKNAME).epub

html: $(BUILD)/html/$(BOOKNAME).html

pdf: $(BUILD)/pdf/$(BOOKNAME).pdf

$(BUILD)/epub/$(BOOKNAME).epub: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/epub
	pandoc $(TOC) -S --epub-metadata=$(METADATA) --epub-stylesheet=$(STYLE) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
	cp -r base.css images/ $(BUILD)/html
	pandoc $(TOC) --standalone --css=$(STYLE) --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	pandoc $(TOC) --template=$(LATEX) --latex-engine=xelatex -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf

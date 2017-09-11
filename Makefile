BUILD = build
BOOKNAME = category-theory-for-programmers
TITLE = title.txt
METADATA = metadata.xml
STYLE = base.css
LATEX = base.latex
CHAPTERS = preface.md part_one/ch01.md part_one/ch02.md part_one/ch03.md part_one/ch04.md part_one/ch05.md part_one/ch06.md part_one/ch07.md part_one/ch08.md part_one/ch09.md part_one/ch10.md part_two/ch01.md
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

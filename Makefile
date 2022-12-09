.PHONY: create, clean, info

LANG := en
TARGET := slide.pdf
OBJDIR := .obj
OBJECT := $(OBJDIR)
SOURCE := .
TARGET_TEX := $(patsubst %.pdf,$(SOURCE)/%.tex,$(TARGET))
TARGET_DVI := $(patsubst %.pdf,$(OBJECT)/%.dvi,$(TARGET))
TARGET_BIB := $(patsubst $(SOURCE)/%.tex,$(OBJECT)/%,$(TARGET_TEX))
FIG := $(shell find ./fig -type f -not -name "*.gitkeep")
STY := $(shell find ./sty -type f -name *.sty)
TEX := $(shell find $(SOURCE) -type f -name *.tex)
BIB := .bib

FLAGS := -halt-on-error\
	-interaction=nonstopmode\
	-shell-escape\
	-file-line-error\
	-synctex=1\
	-kanji=utf8\
	-output-directory=$(OBJECT)

create: $(OBJECT) $(TARGET)

$(OBJECT):
	mkdir -p $(OBJECT)

$(TARGET): $(TARGET_DVI) $(FIG)
	@ dvipdfmx $< -o $(TARGET)

$(TARGET_DVI): $(TARGET_TEX) $(TEX) $(STY) $(BIB)
	@ platex $(FLAGS) $<
	@ if [ -s $(BIB) ]; then pbibtex $(TARGET_BIB); platex $(FLAGS) $<; fi
	@ platex $(FLAGS) $<

info:
	@ echo TARGETS: $(TARGET) $(TARGET_TEX) $(TARGET_DVI) $(TARGET_BIB)
	@ echo DIRECTORIES: $(SOURCE) $(OBJECT)
	@ echo TEX: $(TEX)
	@ echo STY: $(STY)
	@ if [ -s $(BIB) ]; then echo BIB; fi

clean: 
	rm -rf *.pdf $(OBJDIR)

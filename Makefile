# Variables
SOURCE_DIR = src
BUILD_DIR = build
SOURCES = $(wildcard $(SOURCE_DIR)/*.md)
HTML_OUT = $(patsubst $(SOURCE_DIR)/%.md, $(BUILD_DIR)/html/%.html, $(SOURCES))
PDF_OUT  = $(patsubst $(SOURCE_DIR)/%.md, $(BUILD_DIR)/pdf/%.pdf, $(SOURCES))

# Flags
PANDOC_FLAGS = --standalone --toc --mathjax --syntax-highlighting=tango --data-dir=./

# Default action: Build everything
all: html

# Rule for HTML
html: $(HTML_OUT)

$(BUILD_DIR)/html/%.html: $(SOURCE_DIR)/%.md
	@mkdir -p $(BUILD_DIR)/html
	pandoc $< $(PANDOC_FLAGS) --css=../../assets/styles.css -o $@

# Clean up build files
clean:
	rm -rf $(BUILD_DIR)

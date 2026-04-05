# Variables
SOURCE_DIR = src
BUILD_DIR = build
SOURCES = $(shell find $(SOURCE_DIR) -name '*.md')
HTML_OUT = $(patsubst $(SOURCE_DIR)/%.md, $(BUILD_DIR)/%.html, $(SOURCES))

# Flags
PANDOC_FLAGS = --standalone --toc --mathjax --syntax-highlighting=tango --data-dir=./ -H ./assets/parhead.html -H ./assets/chstyle.html -B ./assets/header.html -A ./assets/footer.html

.PHONY: all html assets clean

# Default action: Build everything
all: html

# Rule for HTML
html: $(HTML_OUT) assets

$(BUILD_DIR)/%.html: $(SOURCE_DIR)/%.md
	@mkdir -p $(dir $@)
	@if [ -f $@ ]; then \
		EXISTING_DATE=$$(grep -oP '(?<=Posted: )\d{2} [A-Za-z]{3} \d{4}' $@ | head -1); \
		pandoc $(PANDOC_FLAGS) --css=../assets/styles.css --css=../assets/tempstyle.css -M date="$$EXISTING_DATE" -M last_updated="$(shell date -u +"%d %b %Y")" $< -o $@; \
	else \
		pandoc $(PANDOC_FLAGS) --css=../assets/styles.css --css=../assets/tempstyle.css -M date="$(shell date -u +"%d %b %Y")" -M last_updated="$(shell date -u +"%d %b %Y")" $< -o $@; \
	fi

assets:
	mkdir -p $(BUILD_DIR)/
	cp -R assets $(BUILD_DIR)/

# Clean up build files
clean:
	rm -rf $(BUILD_DIR)

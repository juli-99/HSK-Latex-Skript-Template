# Variables
LATEX=pdflatex
BIBER=biber
INPUT_DOC=dokument.tex
INPUT_PRESENTATION=presentation.tex
OUTPUT_DOC=$(BUILD_DIR)/dokument.pdf
OUTPUT_PRESENTATION=$(BUILD_DIR)/presentation.pdf
BUILD_DIR=build

# Targets
all: both

dokument: $(OUTPUT_DOC)

presentation: $(OUTPUT_PRESENTATION)

both: document presentation

clean:
	rm -rf $(BUILD_DIR)/*

# Create PDF for document
$(OUTPUT_DOC): $(INPUT_DOC)
	@mkdir -p $(BUILD_DIR)
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_DOC)
	$(BIBER) $(BUILD_DIR)/dokument
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_DOC)  # Run pdflatex again

# Create PDF for presentation
$(OUTPUT_PRESENTATION): $(INPUT_PRESENTATION)
	@mkdir -p $(BUILD_DIR)
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_PRESENTATION)
	$(BIBER) $(BUILD_DIR)/presentation
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_PRESENTATION)  # Run pdflatex again

.PHONY: all dokument presentation both clean

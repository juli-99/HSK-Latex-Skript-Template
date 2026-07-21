# ------------------------------------------------------------------------------
# Variablen
# ------------------------------------------------------------------------------

# Programme
LATEX      = pdflatex
BIBER      = biber

# Input-Dateien (Pfad korrigiert basierend auf deiner Struktur)
INPUT_DOC          = Document/document.tex
INPUT_PRESENTATION = Presentation/presentation.tex

# Output-Dateien (Hier landen die PDFs im build-Ordner)
OUTPUT_DOC          = $(BUILD_DIR)/document.pdf
OUTPUT_PRESENTATION = $(BUILD_DIR)/presentation.pdf

# Verzeichnis für Hilfsdateien (Vermeidet Chaos im Hauptordner)
BUILD_DIR = build

# ------------------------------------------------------------------------------
# Targets
# ------------------------------------------------------------------------------

# Standard-Ziel: Kompiliert beides
all: document presentation

# Kompilierung des Hauptdokuments
# Wir müssen pdflatex -> biber -> pdflatex ausführen
document: $(OUTPUT_DOC)

# Kompilierung der Präsentation
presentation: $(OUTPUT_PRESENTATION)

# Erstellung des PDFs für das Hauptdokument
$(OUTPUT_DOC): $(INPUT_DOC)
	@mkdir -p $(BUILD_DIR)
	@echo "--- Kompilierung Dokument: $(INPUT_DOC) ---"
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_DOC)
	@echo "--- Biber (Literatur): $(INPUT_DOC) ---"
	$(BIBER) $(BUILD_DIR)/document
	@echo "--- Finaler Durchgang (Dokument) ---"
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_DOC)

# Erstellung des PDFs für die Präsentation
$(OUTPUT_PRESENTATION): $(INPUT_PRESENTATION)
	@mkdir -p $(BUILD_DIR)
	@echo "--- Kompilierung Präsentation: $(INPUT_PRESENTATION) ---"
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_PRESENTATION)
	@echo "--- Biber (Präsentation) ---"
	$(BIBER) $(BUILD_DIR)/presentation
	@echo "--- Finaler Durchgang (Präsentation) ---"
	$(LATEX) -output-directory=$(BUILD_DIR) $(INPUT_PRESENTATION)

# Aufräumen: Löscht den gesamten Build-Ordner
clean:
	@echo "--- Aufräumen: Lösche $(BUILD_DIR) ---"
	rm -rf $(BUILD_DIR)

# Markiert die Targets als "nicht als Datei vorhanden"
.PHONY: all document presentation clean

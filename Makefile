# Variables
TEX_FILE = resume.tex
PDF_FILE = resume.pdf
LATEX_ENGINE = pdflatex

.PHONY: all
all: $(PDF_FILE) ## Build resume PDF

.PHONY: help
help: ## Show this help message
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# LaTeX requires multiple passes for references, hyperlinks, etc.
$(PDF_FILE): $(TEX_FILE) ## Build PDF from LaTeX
	$(LATEX_ENGINE) -interaction=nonstopmode $(TEX_FILE)
	$(LATEX_ENGINE) -interaction=nonstopmode $(TEX_FILE)

.PHONY: clean
clean: ## Remove auxiliary LaTeX files
	rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk

.PHONY: distclean
distclean: clean ## Remove auxiliary files and PDF
	rm -f $(PDF_FILE)

.PHONY: rebuild
rebuild: distclean all ## Clean and rebuild from scratch

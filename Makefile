NPM := npm
VENDOR_DIR := assets/vendor/
JEKYLL := jekyll
BUNDLE := bundle exec

install:
	$(NPM) install

include-npm-deps:
	mkdir -p $(VENDOR_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(VENDOR_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.js $(VENDOR_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js $(VENDOR_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.js.map $(VENDOR_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js.map $(VENDOR_DIR)

build: install include-npm-deps
	$(BUNDLE) $(JEKYLL) build

serve: install include-npm-deps
	$(BUNDLE) $(JEKYLL) serve --host 0.0.0.0

s: install include-npm-deps
	$(BUNDLE) $(JEKYLL) serve --livereload --host 0.0.0.0


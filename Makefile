
build:
	tools/mdbuild.py
	cp -R media _build
serve:
	python -m SimpleHTTPServer

sysdeps:
	sudo apt-get install python-html2text python-markdown python-pip git
	sudo pip install mdx-anchors-away mdx-callouts mdx-foldouts

multi:
	tools/make_versions.sh

.PHONY: build serve sysdeps multi 

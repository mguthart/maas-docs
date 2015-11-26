
build:
	tools/mdbuild.py
	cp -R resources _build/
	cp -R media _build/
serve:
	python -m SimpleHTTPServer

publish:
	tools/mdbuild.py --plain
	cp -R resources _build/
	cp -R media _build/
	cp src/navigation.tpl _build/nav.html

sysdeps:
	sudo apt-get install python-html2text python-markdown python-pip git
	sudo pip install mdx-anchors-away mdx-callouts mdx-foldouts

multi:
	tools/make_versions.sh

clean:
	if [ -d "_build" ];then rm -rf _build; fi

.PHONY: build serve sysdeps multi clean

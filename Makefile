
build:
	tools/mdbuild.py

serve:
	python -m SimpleHTTPServer

sysdeps:
	sudo apt-get install python-html2text python-markdown python-pip git
	sudo pip install mdx-anchors-away mdx-callouts mdx-foldouts

multi:
	tools/make_versions.sh

clean:
	if [ -d "_build" ];then rm -rf _build; fi

.PHONY: build serve sysdeps multi clean

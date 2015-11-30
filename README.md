# maas-docs

** I will add a better readme with instructions at some point**

Basic use: 

 - The source files are in src/en/*.md
 - graphics are in /media
 - other bits in /resources (at the moment, these are largely css etc soley to help render a local version of docs, to aid editing)

The makefile has several useful targets depending on what you are doing.

 - *make build* will create a local version of templated docs (using the template included in src) in _build
 - *make serve* runs a simple HTTP server so you can check docs locally for style errors etc
 - *make publish* performs a scary step which builds plain, untemplated versions of the docs and then uploads them to a www- branch on the github repo
 

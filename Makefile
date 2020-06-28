build:
	cd exampleSite/ && hugo

format:
#	prettier --write "layouts/**/*.html"
	prettier --write "static/**/*.css"
	prettier --write "exampleSite/**/*.json"

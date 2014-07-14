all: js css

js:
	@echo "Compiling JavaScript"
	node public/scripts/_compile.js

css:
	@echo "Compiling LESS to CSS"
	lessc -x --source-map=public/site.css.map --source-map-url=/site.css.map --source-map-rootpath=/styles public/styles/site.less public/site.css

bin:
	@echo "Compiling WebApp"
	dub build --config=development

clean:
	rm -f public/*.map public/*.css public/*.js
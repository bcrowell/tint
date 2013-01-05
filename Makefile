test:
	ruby test.rb

clean:
	rm -f *~ 
	rm -f tests/*~ tests/*.json
	rm -f README.html

doc:
	markdown README.md >README.html

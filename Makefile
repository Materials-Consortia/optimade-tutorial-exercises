all: README.md

README.md: notebooks/exercises.ipynb
	./build.sh

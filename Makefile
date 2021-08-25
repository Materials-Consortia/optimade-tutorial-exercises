all: README.md

README.md: notebooks/exercises.ipynb
	pandoc notebooks/exercises.ipynb -t gfm -o README.md

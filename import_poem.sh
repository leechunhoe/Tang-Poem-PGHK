#!/bin/bash

python ~/hitlconverter/run.py -i ~/tangpoem/sample_poem.txt -o ~/tangpoem/hongim.txt --safe --hongim
python ~/hitlconverter/run.py -i ~/tangpoem/sample_poem.txt -o ~/tangpoem/hanji.txt --safe --hanji
python ~/hitlconverter/run.py -i ~/tangpoem/sample_poem.txt -o ~/tangpoem/tailo.txt --safe --tailo

rails runner "Poem.import_from_file"
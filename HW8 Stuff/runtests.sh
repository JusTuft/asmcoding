
#! /bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'


umasm urt0.ums calc40.ums printd.ums callmain.ums > calc40.um

files=(*.txt)
for f in "${files[@]}"; do
        echo -e "${NC}Running $f"
        input="$f"
        output1="${f%.txt}.out1"
        output2="${f%.txt}.out2"
        um calc40.um < "$input" > "$output1"
        /comp/40/bin/calc40 < "$input" > "$output2"
        diff "$output1" "$output2" > diff.txt
        if [[ -s diff.txt ]]; then
                cp diff.txt "${f%.txt}.diff"
                echo -e "${RED}Test $f failed. See ${f%.txt}.diff for details.${NC}"
        else
                echo -e "${GREEN}Test $f passed.${NC}"
        fi
        rm diff.txt
        rm "$output1" "$output2"



done


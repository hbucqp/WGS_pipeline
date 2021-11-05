# We have put the corresponding filenames in txt file named names.txt

# check the contents in names.txt
# cat names.txt
# oldname1 newname1
# oldname2 newname2
# oldname3 newname3
# oldname4 newname4


while read a b
do
    mv ${a} ${b}
done < names.txt

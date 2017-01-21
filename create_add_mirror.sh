IFS='
'

rm add_mirror.sh
touch add_mirror.sh
chmod +x add_mirror.sh
for i in `cat repolist`
do
	./create_mirror_name.sh $i >> add_mirror.sh
done

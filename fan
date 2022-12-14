#!/bin/bash

if ! [ -d ~/.local/share/fwikis ];
then echo you need to download something first; exit 1; fi
if [ "$1" == "ls" ]; then ls ~/.local/share/fwikis/; exit 1; fi

file="$(fzf <<< "$(ls -1 ~/.local/share/fwikis/)")";
[ -z $file ] && exit 1
file=~/.local/share/fwikis/$file
pages=$(xml sel -t -m "/mediawiki/page" -v "title" -n $file | nl)

while :; do
page=$(fzf --bind 'change:first' -s -e --tac -i --with-nth 2.. <<< $pages | awk '{print $1}')
[ -z $page ] && exit 1

redir=$(xml sel -t -m "/mediawiki/page[$page]/redirect" -v "@title" -n $file)
[ -z "$redir" ] || page=$(grep "	${redir}$" <<< "$pages" | awk '{print $1}')

html=fantemp_.html
[ -f $html ] && rm $html

cd /tmp
xml sel -t -m "/mediawiki/page[$page]/revision" -v "text" -n $file |\
pandoc -f mediawiki -o $html -t plain

#cp $html raw -f
sed -i 's/<ref>.*;//g;s/<\/\?div[^>]*.//g;' $html
sed -i 's/          */\n/g;s/-----*//g' $html
sed -zi 's/<gallery[^>]*>[^<]*<\/gallery>//g;s/<\/\?ref[^>]*>//g;s/<\/\?[^>]*>//g' $html
sed -zi 's/\n\n\n[\n\ ]*/\n\n/g;' $html

less -N $html;
rm $html
done

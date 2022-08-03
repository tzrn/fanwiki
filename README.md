# fanwiki

Download fandom wikis and browse them offline

**Dependencies**
+ `pip install xmlmerge`
+ pandoc
+ xmlstarlet
+ fzf

**Usage:**
- Download wiki with gett script. You need the url of AllPages of the wiki for that.
- Use fan to browse wikis.
- If some error comes up, thats probably 'cause there was too much content in single request. To fix specify limit as second argument (defaut limit is 3000) for examle `gett url 1000`

**Examples**
+ `gett wiki.fan.wiki/Special:AllPages` downloads dump
+ `fan` 

The xml dumps are located in ~/.local/share/fwikis

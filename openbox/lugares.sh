#!/bin/bash

echo '<openbox_pipe_menu>'

filemanager="pcmanfm"

for bookmark in `sed 's/[ ][^ ]*$//' .config/gtk-3.0/bookmarks
` ; do
  echo '<item label="'`basename ${bookmark}`'">'
  echo '<action name="Execute"><execute>'
  echo "$filemanager ${bookmark}"
  echo '</execute></action>'
  echo '</item>'
done

echo '</openbox_pipe_menu>'

@echo off
youtube-dl https://www.youtube.com/playlist?list=PLe30vg_FG4OSUlFitzqTnazH69eGwjuNI "%%(autonumber)s-%%(title)s-%%(id)s.%(ext)s" --restrict-filenames --ignore-errors
ECHO Download completed
PAUSE
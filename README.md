# SnowFlakes!

At the end of 2021 I started playing with this app and then didn't touch it again until the end of 2022. It may very well be another seasonal project for me to hack on.

## Description

SnowFlakes is a Menu Bar app that puts snow or flakes on the screen while you're using your Mac.

## Demo

https://user-images.githubusercontent.com/2092798/209457432-2546a72f-65aa-4f3d-a186-84de0e531dc7.mov

## Technical overview

For each display, a non-interactive overlay window is added. Inside that window is a fullscreen [SKView](https://developer.apple.com/documentation/spritekit/skview) that runs a scene that contains emitters. These emitters spit out snow and flakes and can be tweaked by the user interface. Settings are saved automatically across restarts of the app via a JSON encoded settings file.

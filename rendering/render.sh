#!/bin/bash -xe

povray \
    -W2000 -H1500 \
    +P \
    +A +AM3 +A0.05 +R7 \
    +Q11 \
    rendering.pov

xdg-open rendering.png

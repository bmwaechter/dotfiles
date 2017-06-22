#!/bin/sh

blank='#00000000'
clear='#ffffff22'
blackish='#3a3a3cff'
blue='#00afecff'

i3lock \
    --blur=2                                \
    --screen=0                              \
    --image ~/.config/i3/lock/tina_lock.png \
    --radius=109                            \
    --insidecolor=$blank                    \
    --ringcolor=$clear                      \
    --keyhlcolor="#feca4fff"                \
    --bshlcolor=$blackish
;

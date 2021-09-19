#!/bin/sh

dpi=$1

if [[ $dpi = 96 ]]; then

    # set .profile
    echo export QT_QPA_PLATFORMTHEME="qt5ct" > ~/.profile
    echo export EDITOR=/usr/bin/nvim >> ~/.profile
    echo export GTK2_RC_FILES="$HOME/.gtkrc-2.0" >> ~/.profile
    echo export BROWSER=/usr/bin/firefox >> ~/.profile

    # set dpi in .Xresources
    sed -i '/Xft.dpi: 136/cXft.dpi: 96' ~/.Xresources
    sed -i '/rofi.dpi: 136/crofi.dpi: 96' ~/.Xresources


elif [[ $dpi = 163 ]]; then

    # set .profile
    echo export QT_QPA_PLATFORMTHEME="qt5ct" > ~/.profile
    echo export EDITOR=/usr/bin/nvim >> ~/.profile
    echo export GTK2_RC_FILES="$HOME/.gtkrc-2.0" >> ~/.profile
    echo export BROWSER=/usr/bin/firefox >> ~/.profile

    echo export GDK_SCALE=1 >> ~/.profile
    echo export GDK_DPI_SCALE=1 >> ~/.profile
    echo export QT_AUTO_SCREEN_SCALE_FACTOR=0 >> ~/.profile
    echo export QT_SCREEN_SCALE_FACTORS=1 >> ~/.profile

    # set dpi in .Xresources
    sed -i '/Xft.dpi: 96/cXft.dpi: 163' ~/.Xresources
    sed -i '/rofi.dpi: 96/crofi.dpi: 163' ~/.Xresources

fi

i3exit logout






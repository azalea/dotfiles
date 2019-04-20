alias reload!='. ~/.zshrc'
alias python='python3'

zz () {
    if (( $#==0 ))
        then sleep 1200; 
    else
        sleep $(($* * 60)); 
    fi
    osascript -e 'display notification "赶快走开" with title "休息时间"'
}


#### BEGIN: Touch To-Do Aliases ####

TTDDIR=~/Dropbox/Apps/Touch\ To-Do

# Add a single Touch To-Do item. Spaces are welcome in item descriptions.
# If the item description has a leading \!, it is an important item.
td () {
    if (( $#==0 ))
        then echo usage: td description
    else
        touch $TTDDIR/"$*"
    fi
}

# Add multiple Touch To-Do items, separated by space.
# Thus, if you want spaces in an item, add quotes to its description, like "Say hello world"
# Also, you need to add quotes to the description of important items. 
ttd () {
    if (( $#==0 ))
        then echo usage: ttd description1 description2 ...
    else
        cd $TTDDIR
        touch $*
        cd - >& /dev/null
    fi
}

# Add multiple Touch To-Do important! items. 
ttd! () {
    if (( $#==0 ))
        then echo usage: ttd! description1 description2 ...
    else
        cd $TTDDIR
        for file in $*
        do
            touch "!"$file
        done
        cd - >& /dev/null
   fi
}

# View Touch To-Do item list
alias ttdv='ls -tc1 $TTDDIR | grep -v "Icon*"'

# Go to Touch To-Do folder
alias ttdg='cd $TTDDIR'

#### END: Touch To-Do Aliases #### 

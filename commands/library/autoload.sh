for i in $(find ${FAB_OS_LIBRARY_FOLDER} -name \*.sh); do # Not recommended, will break on whitespace
    if [ $i != "${FAB_OS_LIBRARY_FOLDER}/autoload.sh" ]; then
      source $i;
    fi
done
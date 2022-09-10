function install {
    local -n pkg_array=$1

    for pkg in "${pkg_array[@]}"; do
        # Install packages with local scripts
        if [[ -f $CWD/packages/$pkg.sh ]]; then
            print g "Installing $pkg..."
            source $CWD/packages/$pkg.sh
        else
        # Install using repository
            sudo apt-get install $pkg -y -q
        fi
    done
    return 0
}

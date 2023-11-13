# Add custom configuration to import all *.bashrc files from ~/.bashrc.d
if ! grep -q "# Custom bashrc configuration." $HOME/.bashrc; then
    echo "Adding custom configuration to $HOME/.bashrc"
    cat >>$HOME/.bashrc <<-EOM
#
# Custom bashrc configuration.
if [ -d \$HOME/.bashrc.d ]; then
    if [ -f \$HOME/.bashrc.d/*.bashrc ]; then
        for CUSTOM_BASHRC in \$HOME/.bashrc.d/*.bashrc; do
            chmod +x \$CUSTOM_BASHRC
            source \$CUSTOM_BASHRC
        done
    fi
fi
EOM
fi

# Create or overwrite ~/.bashrc.d
setup_bashrcd() {
    if [ -d $HOME/.bashrc.d ]; then
        read -p "Overwrite existing directory? [y/n]" yn

        case $yn in
        [Yy]*)
            cp -r bashrc.d $HOME/.bashrc.d
            echo "Updating: $HOME/.bashrc.d"
            ;;
        [Nn]*)
            echo "Keep: $HOME/.bashrc.d" && exit
            ;;
        *)
            echo "Answer [y/n]"
            setup_bashrcd
            ;;
        esac
    else
        cp -r bashrc.d $HOME/.bashrc.d
    fi
}

setup_bashrcd

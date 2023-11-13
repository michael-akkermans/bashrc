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

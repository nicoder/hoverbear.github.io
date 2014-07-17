#!/bin/bash
# The URL of the Rust nightlies.
URL="http://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
# The option that needs to be added to .bashrc or .zshrc
RC_OPTION='export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"'

function finish {
	rm -rf $DIR
}
trap finish EXIT


echo
echo "Got options? Just pass them like you would the ./install.sh script."
echo "It's at https://raw.githubusercontent.com/rust-lang/rust/master/src/etc/install.sh"
echo "For example, --uninstall"
echo

DIR=$(mktemp -d -t)

echo "Downloading Rust from $URL and unpacking it to the temporary directory."
curl $URL | tar xzf - -C $DIR --strip-components=1
sudo bash $DIR/install.sh $@
echo

echo
if [ -a ~/.zshrc ]; then
	echo "zsh user! You should run something like this:"
	echo echo "\"$RC_OPTION\" >> ~/.zshrc"
fi
if [ -a ~/.bashrc ]; then
	echo "bash user! You should run something like this:"
	echo echo "\"$RC_OPTION\" >> ~/.bashrc"
fi

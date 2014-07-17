#!/bin/bash
# Rust nightlies.
RUST_URL="http://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
# The option that needs to be added to .bashrc or .zshrc
RUST_RC_OPTION='export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"'

# Cargo Nightlies
CARGO_URL="http://static.rust-lang.org/cargo-dist/cargo-nightly-linux.tar.gz"

# When we exit, remove the $DIR.
function finish {
	rm -rf $DIR
}
trap finish EXIT

COMPONENT=$1
shift
URL=""
if [ "$COMPONENT" == "rustc" ]; then
	URL="http://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
fi
if  [ "$COMPONENT" == "cargo" ]; then
	URL="http://static.rust-lang.org/cargo-dist/cargo-nightly-linux.tar.gz"
fi
if [ "$COMPONENT" == "" ]; then
	echo "Please pass either 'cargo' or 'rustc' to this application."
	exit 1
fi

echo
echo "Got options? Just pass them like you would the ./install.sh script."
echo "For example, --help or --uninstall"
echo

DIR=$(mktemp -d -t)

echo "Downloading $COMPONENT from $URL and unpacking it to the temporary directory."
curl $URL | tar xzf - -C $DIR --strip-components=1
sudo bash $DIR/install.sh $@
echo

if [ "$COMPONENT" = "rustc" ]; then
	if [ -a ~/.zshrc ]; then
		echo "zsh user! You should run something like this:"
		echo echo "\"$RC_OPTION\" >> ~/.zshrc"
	fi
	if [ -a ~/.bashrc ]; then
		echo "bash user! You should run something like this:"
		echo echo "\"$RC_OPTION\" >> ~/.bashrc"
		echo "Then, you'll need to open a new term."
	fi
fi

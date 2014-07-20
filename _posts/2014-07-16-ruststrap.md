---
layout: post
title: Rustup.sh
---


Using Rust can be a bit frustrating if you're trying to track `master`. The language is currently moving fast and you generally want to work on the latest nightly.

You might want to add this script to your `$PATH`. If you haven't already, create a `~/bin/` folder and add it to your path in your `~/.zshrc` or `~/.bashrc` as below. Then you'll want to open a new terminal or source the environment again.

```bash
echo 'export PATH=$PATH:/home/your-username/bin' > ~/.bashrc
```

Then download the script, make it executable.

```bash
curl http://rust-lang.org/rustup.sh > ~/bin/rustup
chmod +x ~/bin/rustup
```

By default, it will install `rust` and `cargo`, the package manager. Just run it whenever you want to update and it will get you to the new version.

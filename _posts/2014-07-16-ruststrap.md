---
layout: post
title: ruststrap
---

This script downloads the latest Rust and/or Cargo nightly and installs (or uninstalls) it as needed.

The steps it takes are:

* Download an extract Rust into a temporary directory.
* Run the `install.sh` script with the options provided. (Like `--uninstall`)
* Output necessary config options for the user.

To use:

* Put the script code into any file. (Easiest way is `curl http://www.hoverbear.org/public/codefrags/ruststrap.sh > ruststrap.sh`)
* `chmod +x ruststrap.sh`
* Use `./ruststrap.sh rustc` to install `rust`.
* Use `./ruststrap cargo` to install `cargo`.

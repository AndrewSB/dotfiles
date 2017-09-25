#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -e a.out ]]; then
	$THIS_DIR/a.out
else
	cat $THIS_DIR/swift-helper.swift $THIS_DIR/git-info-or-cwd.swift $THIS_DIR/main.swift | swiftc - -o $THIS_DIR/a.out
	$THIS_DIR/a.out
fi

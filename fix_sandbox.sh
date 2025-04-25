#!/bin/bash

# Remove existing Pods
rm -rf Pods
rm -rf Podfile.lock

# Clean CocoaPods cache
pod cache clean --all

# Fix permissions
chmod -R 755 .
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

# Reinstall pods
pod install 
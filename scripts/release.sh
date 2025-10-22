#!/bin/bash
set -e

# Get version from pyproject.toml
VERSION=$(grep '^version = ' pyproject.toml | sed 's/version = "\(.*\)"/\1/')

if [ -z "$VERSION" ]; then
    echo "Error: Could not extract version from pyproject.toml"
    exit 1
fi

echo "Creating release for version $VERSION"

# Tag the release
git tag "v$VERSION"
git push origin "v$VERSION"

# Create GitHub release
gh release create "v$VERSION" \
    --title "mcpower-shared v$VERSION" \
    --generate-notes

echo "Release v$VERSION created successfully!"
echo "GitHub Actions will automatically publish to PyPI."


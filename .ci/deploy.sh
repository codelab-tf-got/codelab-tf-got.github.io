#!/bin/sh

cp codelab-logo.png build/unbundled

if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ];
then
    echo "Skipping deploy; doing just a build."
    exit 0
fi

git clone $REPO out

cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..

rm -rfv out/**/* || exit 0

cp -rv build/unbundled/* out/

cd out

git config user.name "$COMMIT_AUTHOR_NAME"
git config user.email "$COMMIT_AUTHOR_EMAIL"

git add -A .
git commit -m "Deploy to GitHub Pages: $SHA"

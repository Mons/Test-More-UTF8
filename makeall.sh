#!/usr/bin/env bash

MODULE=`perl -ne 'print $1 if m{all_from.+?([\w/.]+)}' Makefile.PL`;
perl=perl
$perl -v

rm -rf MANIFEST MANIFEST.bak Makefile.old META.yml MYMETA.yml MYMETA.json *.tar.gz && \
pod2text $MODULE > README && \
$perl -i -lpne 's{^\s+$}{};s{^    ((?: {8})+)}{" "x(4+length($1)/2)}se;' README && \
$perl Makefile.PL && \
mv MYMETA.yml META.yml && \
mv MYMETA.json META.json && \
make manifest && \
make && \
TEST_AUTHOR=1 make test && \
make dist && \
make disttest && \
cp -f *.tar.gz dist/ && \
make clean && \
rm -rf MANIFEST.bak Makefile.old && \
echo "All is OK"

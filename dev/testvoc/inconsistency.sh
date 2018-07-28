TMPDIR=/tmp

if [[ $1 = "ron-cat" ]]; then

lt-expand $2 | grep -v REGEX | grep -v '<prn><enc>' | grep -v ':<:' | sed 's/:>:/\'$'\t/g' | sed 's/:/\'$'\t/g' | cut -f2 -d$'\t' | sed 's/^/^/g' | sed 's/$/$/g' | tee $TMPDIR/tmp_testvoc1-$1.txt |\
        apertium-pretransfer|\
        lt-proc -b ../../ron-cat.autobil.bin | sed 's/$ ^/$\n ~^/g' | awk -F '>/' '{lemma=">$ "$1">/"; OFS=lemma; $1=""; print;}' | sed "s|^>$ ||" | sed 's/>\$ \^/>\$ \^.<sent>\/.<sent>\$ \^/g' | awk 'BEGIN{ RS="\n ~"; ORS=" " }{print }' | sed 's/>\$$/>\$ \^.<sent>\/.<sent>\$/g' |\
        apertium-transfer -b ../../apertium-ron-cat.ron-cat.t1x  ../../ron-cat.t1x.bin | apertium-interchunk ../../apertium-ron-cat.ron-cat.t2x  ../../ron-cat.t2x.bin | apertium-postchunk ../../apertium-ron-cat.ron-cat.t3x  ../../ron-cat.t3x.bin | tee $TMPDIR/tmp_testvoc2-$1.txt |\
        lt-proc -d ../../ron-cat.autogen.bin > $TMPDIR/tmp_testvoc3-$1.txt
paste -d _ $TMPDIR/tmp_testvoc1-$1.txt $TMPDIR/tmp_testvoc2-$1.txt $TMPDIR/tmp_testvoc3-$1.txt | sed 's/ \^.<sent>\$//g' | sed 's/ \.//g' | sed 's/_/   --------->   /g'  | grep -v '@'
rm $TMPDIR/tmp_testvoc1-$1.txt
rm $TMPDIR/tmp_testvoc2-$1.txt
rm $TMPDIR/tmp_testvoc3-$1.txt

elif [[ $1 = "cat-ron" ]]; then

lt-expand $2 | grep -v REGEX | grep -v '<prn><enc>' | grep -v ':<:' | sed 's/:>:/\'$'\t/g' | sed 's/:/\'$'\t/g' | cut -f2 -d$'\t' | sed 's/^/^/g' | sed 's/$/$/g' | tee $TMPDIR/tmp_testvoc1-$1.txt |\
        apertium-pretransfer|\
        lt-proc -b ../../cat-ron.autobil.bin | sed 's/$ ^/$\n ~^/g' | awk -F '>/' '{lemma=">$ "$1">/"; OFS=lemma; $1=""; print;}' | sed "s|^>$ ||" | sed 's/>\$ \^/>\$ \^.<sent>\/.<sent>\$ \^/g' | awk 'BEGIN{ RS="\n ~"; ORS=" " }{print }' | sed 's/>\$$/>\$ \^.<sent>\/.<sent>\$/g' |\
        apertium-transfer -b ../../apertium-ron-cat.cat-ron.t1x  ../../cat-ron.t1x.bin | apertium-interchunk ../../apertium-ron-cat.cat-ron.t2x  ../../cat-ron.t2x.bin | apertium-postchunk ../../apertium-ron-cat.cat-ron.t3x  ../../cat-ron.t3x.bin | apertium-transfer -n ../../apertium-ron-cat.cat-ron.t4x  ../../cat-ron.t4x.bin | tee $TMPDIR/tmp_testvoc2-$1.txt |\
        lt-proc -d ../../cat-ron.autogen.bin > $TMPDIR/tmp_testvoc3-$1.txt
paste -d _ $TMPDIR/tmp_testvoc1-$1.txt $TMPDIR/tmp_testvoc2-$1.txt $TMPDIR/tmp_testvoc3-$1.txt | sed 's/ \^.<sent>\$//g' | sed 's/ \.//g' | sed 's/_/   --------->   /g'  | grep -v '@'
rm $TMPDIR/tmp_testvoc1-$1.txt
rm $TMPDIR/tmp_testvoc2-$1.txt
rm $TMPDIR/tmp_testvoc3-$1.txt

else
        echo "sh inconsistency.sh <direction>";
fi

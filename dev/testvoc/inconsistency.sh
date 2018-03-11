TMPDIR=/tmp

if [[ $1 = "cat-ron" ]]; then

lt-expand $2 | grep -v REGEX | grep -v '<prn><enc>' | sed 's/:>:/%/g' | grep -v ':<:' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |\
        apertium-pretransfer|\
        lt-proc -b ../../cat-ron.autobil.bin |\
        apertium-transfer -b ../../apertium-ron-cat.cat-ron.t1x  ../../cat-ron.t1x.bin | apertium-interchunk ../../apertium-ron-cat.cat-ron.t2x  ../../cat-ron.t2x.bin | apertium-postchunk ../../apertium-ron-cat.cat-ron.t3x  ../../cat-ron.t3x.bin | tee $TMPDIR/tmp_testvoc2.txt |\
        lt-proc -d ../../cat-ron.autogen.bin > $TMPDIR/tmp_testvoc3.txt
paste -d _ $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g' | grep -v '\^@'

elif [[ $1 = "ron-cat" ]]; then

lt-expand $2 | grep -v REGEX | grep -v '<prn><enc>' | sed 's/:>:/%/g' | grep -v ':<:' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |\
        apertium-pretransfer|\
        lt-proc -b ../../ron-cat.autobil.bin |\
        apertium-transfer -b ../../apertium-ron-cat.ron-cat.t1x  ../../ron-cat.t1x.bin | apertium-interchunk ../../apertium-ron-cat.ron-cat.t2x  ../../ron-cat.t2x.bin | apertium-postchunk ../../apertium-ron-cat.ron-cat.t3x  ../../ron-cat.t3x.bin | tee $TMPDIR/tmp_testvoc2.txt |\
        lt-proc -d ../../ron-cat.autogen.bin > $TMPDIR/tmp_testvoc3.txt
paste -d _ $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g' | grep -v '\^@'

else
	echo "sh inconsistency.sh <direction>";
fi

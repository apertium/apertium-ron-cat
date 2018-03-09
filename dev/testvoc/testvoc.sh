echo "==Romanian->Catalan==========================";
bash inconsistency.sh ron-cat ../../../apertium-ron/apertium-ron.ron.dix > /tmp/ron-cat.testvoc; bash inconsistency-summary.sh /tmp/ron-cat.testvoc ron-cat; grep '  #' /tmp/ron-cat.testvoc > ./ron-cat.testvoc 
echo ""
echo "==Catalan->Romanian==========================";
bash inconsistency.sh cat-ron ../../../apertium-cat/apertium-cat.cat.dix > /tmp/cat-ron.testvoc; bash inconsistency-summary.sh /tmp/cat-ron.testvoc cat-ron; grep '  #' /tmp/cat-ron.testvoc > ./cat-ron.testvoc 

# This program expands polysemic entries into multiple lines
# so each possibility is tested during testvoc. Each time
# it is executed, an entry per line is modified if necessary.

BEGIN { FS="\\$ "; OFS = "$ " }
{
    if ($2 !="")
    {
        first = $1;
        $1 = "";
        j=split(first, a, "//");
        for (i = 2; i <= j; ++i) print a[1] "/~/" a[i] "$+" substr($0,3,length($0));
    }
    else print $0;
}

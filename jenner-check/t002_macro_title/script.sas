/* Adapted from beginner-SAS-examples.sas (krblackwell/SAS)
   Source: the macro-variable / title walkthrough ("now I'm going to show
   some simple macros. ANYONE can do this."), using &name and &sysdate in
   titles, then PROC PRINT with a WHERE clause. */

data example;
label rucool="rucool: is the person cool?";*notice I add the variable name in the label;
input id name $ score year rucool;
cards;
1 Nelson 100 1998 2
2 Bach 97 1995 2
3 Ludwig 50 2000 1
4 Yo-yo 100 2011 1
;
run;

%let name=Sam;
title1 "&name &sysdate some SAS code created 2013";
title2 "isn't that great?";
title3 'but you do not always have to use double quotes';
title3;*title3 here by itself erases only title3;
proc print data=example;
var id name;
where score=100;
*titles can go before a run statement, within a PROC;
title4 'where score=100';
run;
title4;

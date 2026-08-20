/* Adapted from beginner-SAS-examples.sas (krblackwell/SAS)
   Source: the merging walkthrough ("let's assume the two datasets we've
   created, example and one, refer to the same cases..."), showing
   proc sort + a one-to-one merge by a shared key, including the
   full-join-style behavior when a key is missing from one side. */

data one;
input nums cat;
label cat = "cat: do they like cats?";
cards;
1 1
2 2
4 1
6 2
3 .
;
run;

data example;
label rucool="rucool: is the person cool?";
input id name $ score year rucool;
cards;
1 Nelson 100 1998 2
2 Bach 97 1995 2
3 Ludwig 50 2000 1
4 Yo-yo 100 2011 1
;
run;

data example2;
set example;
if year<1999 then theyear=1;
else theyear=2;
run;

data example2;*overwrite this table;
set example2;*using this name;
rename id=nums;*you lose the id column. it's renamed;
run;

***************merging;
*let's assume the two datasets we've created, example and one, refer to the same cases. what that means is
the ID columns refer to the same people, visits, physicians, claims, whatever the unit of analysis is;
*if we want to merge these two things, here's some example code:;
proc sort data=one;*you have to sort before a merge;
by nums;
run;
proc sort data=example2;*you have to sort both. I'm using the ID variable that's been renamed so they match. They have to be the same name;
by nums;
run;
data merged;
merge example2 one;
by nums;
run;
proc print data=merged;
title2 "notice what happens when one dataset doesn't have data for a case";
title3 "nums=6 is not on the example dataset, so those are blank, but included. This is a FULL JOIN if you're familiar with SQL at all";
run;
proc print data=merged (obs=2) noobs;
title2 "only the first two rows are printed because of the (obs=2) code";
title3 "noobs has to go after if you want the two together";
title4 "noobs takes away that obs column you saw before for proc print";
run;
title2;title3;title4;
run;

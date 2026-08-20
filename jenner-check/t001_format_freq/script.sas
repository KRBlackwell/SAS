/* Adapted from beginner-SAS-examples.sas (krblackwell/SAS)
   Source: the PROC FORMAT + PROC FREQ walkthrough, showing custom formats
   with the value baked into the label so output is self-explanatory. */

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

*Formats with the number in the label. It makes it easier when looking at output or printed output.;
proc format;
value animal
1="1: cat"
2="2: dog"
3="3: bird"
4="4: dinosaur"
other="other animal"
;
run;

proc freq data=one;
tables nums;
format nums animal.;
run;
*The format is applied. SAS doesn't know what it means. You have to know what it means.;

proc format;
value yesno 1='1: yes' 2='2: no';
value years
low-1989="pre-90s"
1990-1999="nineties"
2000-high="2k and later"
.="missing data"
;
run;

data years;
input year;
cards;
1980
1979
1990
1992
1994
.
1999
2000
2030
;
run;

proc freq data=years;
tables year/missing;*missing will show missing data in the frequency;
format year years.;
run;

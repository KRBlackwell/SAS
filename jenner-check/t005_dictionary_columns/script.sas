/* Adapted from proc-sql.sas (krblackwell/SAS)
   Source: the dictionary.columns walkthrough ("dictionary.columns can be
   accessed with a data step or a common way I use it is with proc sql...
   it will find all libnames that are active"). The original points
   libname edit at a Windows-only path via '$EDIT'/%%EDIT%% env-var syntax;
   substituted here for a WORK-library dataset so the same dictionary.columns
   query technique runs unmodified. */

data sumgroup;
input groups $ name $ count;
cards;
dev katie 1
dev usagi 3
dev guy 2
;
run;

*see for yourself, you can either select where desired libname or where not in (undesired libnames);
proc sql;
select distinct libname from dictionary.columns;
quit;

proc sql;
select libname, memname, name, type, length from dictionary.columns
where libname = 'WORK' and memname = 'SUMGROUP';
quit;

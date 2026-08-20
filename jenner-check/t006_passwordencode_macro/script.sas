/* Adapted from databaseConnection.sas (krblackwell/SAS)
   Source: the %passwordencode macro ("You don't want to hard code things,
   especially login credentials. This is a quick-and-dirty way..."). The
   macro itself (PROC PWENCODE -> read the encoded fileref back into a
   macro variable via CALL SYMPUT) is unmodified; only the caller below is
   new, since the original file calls it with a real network path
   ("MY SECURE FOLDER PATH WHERE MACROS GO") that doesn't exist here -
   substituted for a relative path so the same macro logic runs unmodified. */

%global myencryptedpassword;
%macro passwordencode(myPassword,myfilepath);
filename mypass "&myfilepath.";
proc pwencode in="&myPassword." out=mypass;run;
data getpwd;
infile mypass;
length pwd $50.;
input pwd $;
call symput('myencryptedpassword',pwd);
run;
%mend;

*passwordencode makes a macro variable called &myencryptedpassword;
*(declared %global above so it's visible after this parameterized macro
returns - CALL SYMPUT inside a macro with parameters defaults to that
macro's LOCAL symbol table per SAS 9.4 macro-scoping rules);
%passwordencode(password1234,./mypass.txt);

%put NOTE: encoded value is &myencryptedpassword;

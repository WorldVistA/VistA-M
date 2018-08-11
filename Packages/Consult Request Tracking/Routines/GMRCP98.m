GMRCP98 ;ALB/WTC - Database repair for scheduling events ;12/19/17  09:56
 ;;3.0;CONSULT/REQUEST TRACKING;**98**;;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
REQACT ;  
 ;
 ;  Correct date/time stored as string in "B" cross-reference.
 ;
 N D0,D1,DATETIME,NEWDT,FIXED,I,TOTAL,PROGRESS,COMPLETE ;
 ;
 S (D0,FIXED)=0 ;
 S TOTAL=$P(^GMR(123,0),"^",4) ;
 F I=10:10:100 S COMPLETE(I)=0 ;
 ;
 ;  Scan Consult file
 ;
 F I=1:1 S D0=$O(^GMR(123,D0)) Q:'D0  D  ;
 . ;
 . ;  Report progress to user
 . ;
 . I I#1000=0 W "." ;
 . S PROGRESS=I/TOTAL*100\1 I PROGRESS>0,PROGRESS#10=0,COMPLETE(PROGRESS)=0 W !,PROGRESS,"% complete." S COMPLETE(PROGRESS)=1 ;
 . ;
 . ;  Start scan of date/time cross-reference at end of numeric entries
 . ;
 . S DATETIME=9999999.999999 ;
 . F  S DATETIME=$O(^GMR(123,D0,40,"B",DATETIME)) Q:DATETIME=""  D  ;
 .. ;
 .. ;  Scan activity multiple's date/time cross reference for string entries.
 .. ;
 .. S D1=0 F  S D1=$O(^GMR(123,D0,40,"B",DATETIME,D1)) Q:'D1  D  ;
 ... ;
 ... ; Strip off trailing zeroes so date/time is numeric
 ... ;
 ... S NEWDT=+DATETIME ;
 ... ;
 ... ;  Update multiple and cross-reference.  Delete string cross-reference entry.
 ... ;
 ... S $P(^GMR(123,D0,40,D1,0),"^",1)=NEWDT,^GMR(123,D0,40,"B",NEWDT,D1)=""
 ... K ^GMR(123,D0,40,"B",DATETIME,D1) ;
 ... S FIXED=FIXED+1 ;
 ... W !,FIXED,". ",DATETIME," ==> ",NEWDT ;
 ;
 Q  ;
 ;

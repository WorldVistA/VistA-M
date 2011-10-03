PXRMFF0 ;SLC/PKR - Clinical Reminders function finding routines. ;08/28/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ;============================================
COUNT(LIST,FIEVAL,COUNT) ;
 N IND,JND,KND
 S COUNT=0
 F IND=1:1:LIST(0) D
 . S JND=LIST(IND),KND=0
 . F  S KND=+$O(FIEVAL(JND,KND)) Q:KND=0  D
 .. I FIEVAL(JND,KND) S COUNT=COUNT+1
 Q
 ;
 ;===========================================
DIFFDATE(LIST,FIEVAL,DIFF) ;Return the difference in days between the
 ;first two findings in the list.
 I LIST(0)<2 S DIFF=2 Q
 N DATE1,DATE2,DAYS,IND,JND
 S DATE1=+$G(FIEVAL(LIST(1),"DATE"))
 S DATE2=+$G(FIEVAL(LIST(2),"DATE"))
 S DAYS=$$FMDIFF^XLFDT(DATE1,DATE2)
 S DIFF=$S(DAYS<0:-DAYS,1:DAYS)
 Q
 ;
 ;===========================================
DUR(LIST,FIEVAL,DUR) ;
 N EDT,IND,JND,KND,SDT
 F IND=1:1:LIST(0) D
 . S JND=LIST(IND)
 . I FIEVAL(JND)=0 S (EDT,SDT)=0 Q
 .;Check for finding with start and stop date.
 . I $D(FIEVAL(JND,"START DATE")) D
 .. S SDT=+$G(FIEVAL(JND,"START DATE"))
 .. S EDT=+$G(FIEVAL(JND,"STOP DATE"))
 .. I EDT=0 S EDT=+$G(FIEVAL(JND,"DATE"))
 . E  D
 ..;Get start and stop for multiple occurrences.
 .. S KND=$O(FIEVAL(JND,"A"),-1)
 .. S EDT=$S(KND="":0,1:$G(FIEVAL(JND,KND,"DATE")))
 .. S KND=+$O(FIEVAL(JND,""))
 .. S SDT=$S(KND=0:0,1:$G(FIEVAL(JND,KND,"DATE")))
 ;Return the duration in days.
 S DUR=$$FMDIFF^XLFDT(EDT,SDT)
 I DUR<0 S DUR=-DUR
 Q
 ;
 ;============================================
FI(LIST,FIEVAL,LV) ;Given a regular finding return its true/false value.
 S LV=FIEVAL(LIST(1))
 Q
 ;
 ;============================================
MAXDATE(LIST,FIEVAL,MAXDATE) ;Given a list of findings return the maximum
 ;date. This will be the newest date.
 N DATE,IND
 S MAXDATE=0
 F IND=1:1:LIST(0) D
 . S DATE=$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE>MAXDATE S MAXDATE=DATE
 Q
 ;
 ;============================================
MINDATE(LIST,FIEVAL,MINDATE) ;Given a list of findings return the minimum
 ;date. This will be the oldest non-null or zero date.
 N IND,ODL
 F IND=1:1:LIST(0) S ODL(+$G(FIEVAL(LIST(IND),"DATE")))=""
 S MINDATE=+$O(ODL(0))
 Q
 ;
 ;============================================
MRD(LIST,FIEVAL,MRD) ;Given a list of findings return the most recent
 ;finding date from the list.
 N DATE,IND
 S MRD=0
 F IND=1:1:LIST(0) D
 . S DATE=$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE>MRD S MRD=DATE
 Q
 ;
 ;============================================
NUMERIC(LIST,FIEVAL,VALUE) ;Given a finding, return the first numeric
 ;portion of one of the "CSUB" values. Based on original work
 ;by R. Silverman.
 S VALUE=$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 S VALUE=$$FIRSTNUM(VALUE)
 Q
 ;
FIRSTNUM(STRING) ;return the first numeric portion of a string.
 N CHAR,DONE,IND,NUMBER,NUMERIC
 S NUMERIC="+-.1234567890"
 S STRING=$TR(STRING," ")
 S DONE=0,IND=0,NUMBER=""
 F  Q:DONE  D
 . S IND=IND+1,CHAR=$E(STRING,IND)
 . I CHAR="" S DONE=1 Q
 . I NUMERIC[CHAR S NUMBER=NUMBER_CHAR
 . I NUMBER'="",NUMERIC'[CHAR S DONE=1
 Q +NUMBER
 ;
 ;============================================
VALUE(LIST,FIEVAL,VALUE) ;Given a finding return one of its "CSUB"
 ;values.
 S VALUE=$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 Q
 ;

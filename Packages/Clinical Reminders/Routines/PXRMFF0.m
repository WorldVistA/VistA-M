PXRMFF0 ;SLC/PKR - Clinical Reminders function finding routines. ;11/30/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,12,18**;Feb 04, 2005;Build 152
 ;
 ;============================================
COUNT(LIST,FIEVAL,COUNT) ;
 N IND,JND,KND
 S COUNT=0
 F IND=1:1:LIST(0) D
 . S JND=LIST(IND),KND=0
 . F  S KND=+$O(FIEVAL(JND,KND)) Q:KND=0  I FIEVAL(JND,KND) S COUNT=COUNT+1
 Q
 ;
 ;===========================================
DIFFDATE(LIST,FIEVAL,DIFF) ;Return the difference in days between the
 ;first two findings in the list.
 N DATE1,DATE2,DAYS
 S DATE1=+$G(FIEVAL(LIST(1),"DATE"))
 S DATE2=+$G(FIEVAL(LIST(2),"DATE"))
 S DAYS=$$FMDIFF^XLFDT(DATE1,DATE2)
 ;If LIST(3) is defined then return actual value.
 S DIFF=$S($D(LIST(3)):DAYS,DAYS<0:-DAYS,1:DAYS)
 Q
 ;
 ;===========================================
DTIMDIFF(LIST,FIEVAL,DIFF) ;General date difference function.
 N CALCUNIT,DATE1,DATE2,SF
 S DATE1=+$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 S DATE2=+$G(FIEVAL(LIST(4),LIST(5),LIST(6)))
 ;If the passed unit is D get it directly, otherwise use seconds.
 S CALCUNIT=$S(LIST(7)="D":1,1:2)
 S DIFF=$$FMDIFF^XLFDT(DATE1,DATE2,CALCUNIT)
 ;If the passed unit is not seconds scale appropriately. 
 I (CALCUNIT=2),(LIST(7)'="S") S SF=$S(LIST(7)="M":60,LIST(7)="H":3600,1:1),DIFF=DIFF/SF
 ;If LIST(8) is "A" return absolute value.
 I $G(LIST(8))="A" S DIFF=$S(DIFF<0:-DIFF,1:DIFF)
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
 S MAXDATE=$S(FIEVAL(LIST(1)):FIEVAL(LIST(1),"DATE"),1:0)
 I LIST(0)=1 Q
 N DATE,IND
 F IND=2:1:LIST(0) D
 . I 'FIEVAL(LIST(IND)) Q
 . S DATE=+$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE>MAXDATE S MAXDATE=DATE
 Q
 ;
 ;============================================
MAXVALUE(LIST,FIEVAL,MAXVALUE) ;Given a list of findings and associated
 ;CSUBs return the maximum from all the occurrences.
 N IND,OCC,TEMP
 S MAXVALUE=+$G(FIEVAL(LIST(1),1,LIST(2)))
 F IND=1:2:LIST(0) D
 . I 'FIEVAL(LIST(IND)) Q
 . S OCC=""
 . F  S OCC=+$O(FIEVAL(LIST(IND),OCC)) Q:OCC=0  D
 .. S TEMP=+$G(FIEVAL(LIST(IND),OCC,LIST(IND+1)))
 .. I TEMP>MAXVALUE S MAXVALUE=TEMP
 Q
 ;
 ;============================================
MINDATE(LIST,FIEVAL,MINDATE) ;Given a list of findings return the minimum
 ;date.
 N DLIST,IND
 F IND=1:1:LIST(0) S DLIST(+$G(FIEVAL(LIST(IND),"DATE")))=""
 S MINDATE=+$O(DLIST(0))
 Q
 ;
 ;============================================
MINVALUE(LIST,FIEVAL,MINVALUE) ;Given a list of findings return the minimum
 ;from all the occurrences.
 N IND,OCC,TEMP
 S MINVALUE=+$G(FIEVAL(LIST(1),1,LIST(2)))
 F IND=1:2:LIST(0) D
 . I 'FIEVAL(LIST(IND)) Q
 . S OCC=""
 . F  S OCC=+$O(FIEVAL(LIST(IND),OCC)) Q:OCC=0  D
 .. S TEMP=+$G(FIEVAL(LIST(IND),OCC,LIST(IND+1)))
 .. I TEMP<MINVALUE S MINVALUE=TEMP
 Q
 ;
 ;============================================
MRD(LIST,FIEVAL,MRD) ;Given a list of findings return the most recent
 ;finding date from the list.
 S MRD=$S(FIEVAL(LIST(1)):FIEVAL(LIST(1),"DATE"),1:0)
 I LIST(0)=1 Q
 N DATE,IND
 F IND=2:1:LIST(0) D
 . I 'FIEVAL(LIST(IND)) Q
 . S DATE=+$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE>MRD S MRD=DATE
 Q
 ;
 ;============================================
NUMERIC(LIST,FIEVAL,NUMBER) ;Given a finding, return the first numeric
 ;portion of one of the "CSUB" values. Based on original work
 ;by R. Silverman.
 S NUMBER=$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 S NUMBER=$$FIRSTNUM(NUMBER)
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

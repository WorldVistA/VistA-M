PXRMFF0 ;SLC/PKR - Clinical Reminders function finding routines. ;02/22/2022
 ;;2.0;CLINICAL REMINDERS;**4,6,12,18,47,42,65**;Feb 04, 2005;Build 438
 ;
 ;============================================
COUNT(LIST,FIEVAL,COUNT) ;
 N C1,IND,JND,KND
 S COUNT=0
 F IND=1:1:LIST(0) D
 . S C1=$E(LIST(IND),1)
 . I (C1="C")!(C1="R") D  Q
 .. N CRSUB,SUB
 .. S SUB=$E(LIST(IND),2,15)
 .. S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 .. S KND=0
 .. F  S KND=+$O(FIEVAL(CRSUB,SUB,KND)) Q:KND=0  I $D(FIEVAL(CRSUB,SUB,KND)) S COUNT=COUNT+1
 .;
 . S JND=LIST(IND),KND=0
 . F  S KND=+$O(FIEVAL(JND,KND)) Q:KND=0  I FIEVAL(JND,KND) S COUNT=COUNT+1
 Q
 ;
 ;===========================================
DIFFDATE(LIST,FIEVAL,DIFF) ;Return the difference in days between the
 ;first two findings in the list.
 N C1,CRSUB,DATE1,DATE2,DAYS,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S DATE1=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 E  S DATE1=+$G(FIEVAL(LIST(1),"DATE"))
 S C1=$E(LIST(2),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(2),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S DATE2=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 E  S DATE2=+$G(FIEVAL(LIST(2),"DATE"))
 S DAYS=$$FMDIFF^XLFDT(DATE1,DATE2)
 ;If LIST(3) is defined then return actual value.
 S DIFF=$S($D(LIST(3)):DAYS,DAYS<0:-DAYS,1:DAYS)
 Q
 ;
 ;===========================================
DTIMDIFF(LIST,FIEVAL,DIFF) ;General date difference function.
 N C1,CALCUNIT,CRSUB,DATE1,DATE2,SF,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S DATE1=+$G(FIEVAL(CRSUB,SUB,LIST(2),LIST(3)))
 E  S DATE1=+$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 S C1=$E(LIST(4),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(4),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S DATE2=+$G(FIEVAL(CRSUB,SUB,LIST(5),LIST(6)))
 E  S DATE2=+$G(FIEVAL(LIST(4),LIST(5),LIST(6)))
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
 N C1,CRSUB,EDT,IND,JND,KND,SDT,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . I +$G(FIEVAL(CRSUB,SUB))=0 S (EDT,SDT)=0 Q
 .;Get start and stop for multiple occurrences.
 . S KND=$O(FIEVAL(CRSUB,SUB,"A"),-1)
 . S EDT=$S(KND="":0,1:$G(FIEVAL(CRSUB,SUB,KND,"DATE")))
 . S KND=+$O(FIEVAL(CRSUB,SUB,""))
 . S SDT=$S(KND=0:0,1:$G(FIEVAL(CRSUB,SUB,KND,"DATE")))
 E  D
 . S JND=LIST(1)
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
 N C1,CRSUB,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S LV=+$G(FIEVAL(CRSUB,SUB))
 E  S LV=FIEVAL(LIST(1))
 Q
 ;
 ;============================================
MAXDATE(LIST,FIEVAL,MAXDATE) ;Given a list of findings return the maximum
 ;date. This will be the newest date.
 N C1,CRSUB,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S MAXDATE=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 E  S MAXDATE=+$G(FIEVAL(LIST(1),"DATE"))
 I LIST(0)=1 Q
 N DATE,IND
 F IND=2:1:LIST(0) D
 . S C1=$E(LIST(IND),1)
 . I (C1="C")!(C1="R") D
 .. S SUB=$E(LIST(IND),2,15)
 .. S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 .. S DATE=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 . E  S DATE=+$G(FIEVAL(LIST(IND),"DATE"))
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
 N C1,CRSUB,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S MINDATE=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 E  S MINDATE=+$G(FIEVAL(LIST(1),"DATE"))
 I LIST(0)=1 Q
 N DATE,IND
 F IND=2:1:LIST(0) D
 . S C1=$E(LIST(IND),1)
 . I (C1="C")!(C1="R") D
 .. S SUB=$E(LIST(IND),2,15)
 .. S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 .. S DATE=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 . E  S DATE=+$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE<MINDATE S MINDATE=DATE
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
 N C1,CRSUB,SUB
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . S MRD=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 E  S MRD=+$G(FIEVAL(LIST(1),"DATE"))
 I LIST(0)=1 Q
 N DATE,IND
 F IND=2:1:LIST(0) D
 . S C1=$E(LIST(IND),1)
 . I (C1="C")!(C1="R") D
 .. S SUB=$E(LIST(IND),2,15)
 .. S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 .. S DATE=+$G(FIEVAL(CRSUB,SUB,"DATE"))
 . E  S DATE=+$G(FIEVAL(LIST(IND),"DATE"))
 . I DATE>MRD S MRD=DATE
 Q
 ;
 ;============================================
NUMERIC(LIST,FIEVAL,NUMBER) ;Given a finding, return the first numeric
 ;portion of one of the "CSUB" values. Based on original work
 ;by R. Silverman.
 I LIST(0)=2 S NUMBER=$G(FIEVAL(LIST(1),LIST(2)))
 I LIST(0)=3 S NUMBER=$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
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
 N C1
 S C1=$E(LIST(1),1)
 I (C1="C")!(C1="R") D  Q
 . N CRSUB,SUB
 . S SUB=$E(LIST(1),2,15)
 . S CRSUB=$S(C1="C":"CONTRA",C1="R":"REFUSED",1:"")
 . ;I LIST(0)=2 S VALUE=$G(FIEVAL(CRSUB,SUB,LIST(2))) Q
 . I LIST(0)=3 S VALUE=$G(FIEVAL(CRSUB,SUB,LIST(2),LIST(3)))
 . I LIST(0)=2 S VALUE=$G(FIEVAL(CRSUB,SUB,LIST(2)))
 ;
 ;I LIST(0)=2 S VALUE=$G(FIEVAL(LIST(1),LIST(2))) Q
 I LIST(0)=3 S VALUE=$G(FIEVAL(LIST(1),LIST(2),LIST(3)))
 I LIST(0)=2 S VALUE=$G(FIEVAL(LIST(1),LIST(2)))
 Q
 ; 

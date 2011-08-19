PXRMMSER ; SLC/PKR - Computed findings for military service information. ;04/24/2009
 ;;2.0;CLINICAL REMINDERS;**11,12**;Feb 04, 2005;Build 73
 ;
 ;======================================================
AORANGE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will be true if the agent orange exposure registration
 ;date is in the date range specified by Beginning Date/Time
 ;and Ending Date/Time.
 N RDATE
 S NFOUND=0
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,2)
 I 'TEST Q
 S RDATE=+$P(^TMP($J,"SVC",DFN,2,1),U,1)
 I (RDATE=0)!(RDATE<BDT)!(RDATE>EDT) S TEST=0 Q
 S NFOUND=1
 S TEST(NFOUND)=1,DATE(NFOUND)=RDATE
 S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=$P(^TMP($J,"SVC",DFN,2,5),U,2)
 S TEXT(NFOUND)="Agent orange exposure registration date: "_$$FMTE^XLFDT(RDATE,"5Z")_"; location: "_DATA(NFOUND,"LOCATION")
 Q
 ;
 ;======================================================
COMBAT(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will be true if combat service is found in the
 ;date range the date range specified by Beginning Date/Time
 ;and Ending Date/Time.
 N FDATE,TDATE
 S NFOUND=0
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,5)
 I 'TEST Q
 S FDATE=$P(^TMP($J,"SVC",DFN,5,1),U,1)
 S TDATE=$P(^TMP($J,"SVC",DFN,5,2),U,1)
 I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" S TEST=0 Q
 S NFOUND=1
 S TEST(NFOUND)=1,DATE(NFOUND)=FDATE
 S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=$P(^TMP($J,"SVC",DFN,5,3),U,2)
 S TEXT(NFOUND)="Combat service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_"; location: "_DATA(NFOUND,"LOCATION")
 Q
 ;
 ;======================================================
CVELIG(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Computed finding for
 ;combat vet eligiblity data.
 N CV,EDATE,ELIG,RESULT
 ;DBIA #4156
 S RESULT=$$CVEDT^DGCV(DFN,$$NOW^PXRMDATE)
 ;RESULT=(1,0,-1)^End Date (if populated, otherwise null)^CV
 ;      (piece 1)  1 - qualifies as a CV
 ;                 0 - does not qualify as a CV
 ;                -1 - bad DFN or date
 ;      (piece 3)  1 - vet was eligible on date specified (or DT)      
 ;                 0 - vet was not eligible on date specified (or DT)
 S CV=$P(RESULT,U,1),EDATE=$P(RESULT,U,2),ELIG=$P(RESULT,U,3)
 I 'CV S NFOUND=0 Q
 S NFOUND=1
 S TEST(NFOUND)=CV,DATE(NFOUND)=$$NOW^PXRMDATE
 S TEXT(NFOUND)="End date is "_$$FMTE^XLFDT(EDATE,"5Z")
 S DATA(NFOUND,"END DATE")=EDATE
 S DATA(NFOUND,"VALUE")=$S(ELIG:"ELIGIBLE",1:"EXPIRED")
 S DATA(NFOUND,"STATUS")=DATA(NFOUND,"VALUE")
 Q
 ;
 ;======================================================
DISCHDT(DFN,TEST,DATE,VALUE,TEXT) ;This computed finding will return
 ;the most recent service separation date.
 N BRANCH,TEMP
 ;DBIA #5264
 S TEMP=$G(^DPT(DFN,.32))
 S VALUE=$P(TEMP,U,7)
 I VALUE="" S TEST=0 Q
 S DATE=VALUE,TEST=1
 S BRANCH=$P(TEMP,U,5)
 S TEXT="Last Service Separation date: "_$$FMTE^XLFDT(VALUE,"5Z")
 I BRANCH'="" S TEXT=TEXT_"; Branch of Service: "_$$EXTERNAL^DILFD(2,.325,"",BRANCH)
 Q
 ;
 ;======================================================
GETSVCD(DFN) ;Get the SVC^VADPT service data.
 I $D(^TMP($J,"SVC",DFN)) Q
 N VAERR,VAROOT
 S VAROOT="^TMP($J,""SVC"",DFN)"
 D SVC^VADPT
 Q
 ;
 ;======================================================
OEF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return OEF service information in the date range
 ;specified by Beginning Date/Time and Ending Date/Time.
 N FDATE,IND,SDIR,TDATE,TEMP
 S NFOUND=0
 S SDIR=$S(NGET<0:1,1:-1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 D GETSVCD(DFN)
 I ^TMP($J,"SVC",DFN,12)=0 Q
 S IND=""
 F  S IND=$O(^TMP($J,"SVC",DFN,12,IND)) Q:IND=""  D
 . S FDATE=$P(^TMP($J,"SVC",DFN,12,IND,2),U,1)
 . I FDATE="" Q
 . S TDATE=$P(^TMP($J,"SVC",DFN,12,IND,3),U,1)
 . I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" Q
 . S TEMP(FDATE,"TEST")=1
 . S TEMP(FDATE,"DATA","LOCATION")=$P(^TMP($J,"SVC",DFN,12,IND,1),U,2)
 . S TEMP(FDATE,"TEXT")="OEF service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_"; location: "_TEMP(FDATE,"DATA","LOCATION")
 S FDATE=""
 F  S FDATE=$O(TEMP(FDATE),SDIR) Q:(FDATE="")!(NFOUND=NGET)  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=TEMP(FDATE,"TEST"),DATE(NFOUND)=FDATE
 . S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=TEMP(FDATE,"DATA","LOCATION")
 . S TEXT(NFOUND)=TEMP(FDATE,"TEXT")
 Q
 ;
 ;======================================================
OIF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return OIF service information in the date range
 ;specified by Beginning Date/Time and Ending Date/Time.
 N FDATE,IND,SDIR,TDATE,TEMP
 S NFOUND=0
 S SDIR=$S(NGET<0:1,1:-1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 D GETSVCD(DFN)
 I ^TMP($J,"SVC",DFN,11)=0 Q
 S IND=""
 F  S IND=$O(^TMP($J,"SVC",DFN,11,IND)) Q:IND=""  D
 . S FDATE=$P(^TMP($J,"SVC",DFN,11,IND,2),U,1)
 . I FDATE="" Q
 . S TDATE=$P(^TMP($J,"SVC",DFN,11,IND,3),U,1)
 . I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" Q
 . S TEMP(FDATE,"TEST")=1
 . S TEMP(FDATE,"DATA","LOCATION")=$P(^TMP($J,"SVC",DFN,11,IND,1),U,2)
 . S TEMP(FDATE,"TEXT")="OIFF service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_"; location: "_TEMP(FDATE,"DATA","LOCATION")
 S FDATE=""
 F  S FDATE=$O(TEMP(FDATE),SDIR) Q:(FDATE="")!(NFOUND=NGET)  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=TEMP(FDATE,"TEST"),DATE(NFOUND)=FDATE
 . S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=TEMP(FDATE,"DATA","LOCATION")
 . S TEXT(NFOUND)=TEMP(FDATE,"TEXT")
 Q
 ;
 ;======================================================
PHEART(DFN,TEST,DATE,VALUE,TEXT) ;Single value computed finding for
 ;purple heart data.
 N CV,EDATE,ELIG,RESULT
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,9)
 I 'TEST Q
 S DATE=$$NOW^PXRMDATE
 S VALUE=""
 S TEXT="Patient is a Purple Heart recipient."
 Q
 ;
 ;======================================================
POW(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will be true if the patient was a POW in the date range
 ;specified by Beginning Date/Time and Ending Date/Time.
 N FDATE,TDATE
 S NFOUND=0
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,4)
 I 'TEST Q
 S FDATE=$P(^TMP($J,"SVC",DFN,4,1),U,1)
 S TDATE=$P(^TMP($J,"SVC",DFN,4,2),U,1)
 I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" S TEST=0 Q
 S NFOUND=1
 S TEST(NFOUND)=1,DATE(NFOUND)=FDATE
 S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=$P(^TMP($J,"SVC",DFN,4,3),U,2)
 S TEXT(NFOUND)="Patient was a POW from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_"; location: "_DATA(NFOUND,"LOCATION")
 Q
 ;
 ;======================================================
RADEXP(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;;This computed
 ;finding will be true if the radiation exposure registration
 ;date is in the date range specified by Beginning Date/Time
 ;and Ending Date/Time.
 N RDATE
 S NFOUND=0
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,3)
 I 'TEST Q
 S RDATE=$P(^TMP($J,"SVC",DFN,3,1),U,1)
 I (RDATE<BDT)!(RDATE>EDT) S TEST=0 Q
 S NFOUND=1
 S TEST(NFOUND)=1,DATE(NFOUND)=RDATE
 S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"EXPOSURE METHOD"))=$P(^TMP($J,"SVC",DFN,3,2),U,2)
 S TEXT(NFOUND)="Radiation exposure registration date: "_$$FMTE^XLFDT(RDATE,"5Z")_"; exposure method: "_DATA(NFOUND,"EXPOSURE METHOD")
 Q
 ;
 ;======================================================
SBRANCH(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return service branch information for a maximum of
 ;three service periods in the date range specified by BDT and EDT.
 N FDATE,IND,LE,SDIR,SVC,TDATE,TEMP
 ;DBIA #5264
 S TEMP=$G(^DPT(DFN,.32))
 ;Save the data in the same nodes as SVC^VADPT
 S SVC(6,1)=$P(TEMP,U,5)
 S SVC(6,2)=$P(TEMP,U,8)
 S SVC(6,3)=$P(TEMP,U,4)
 S SVC(6,4)=$P(TEMP,U,6)
 S SVC(6,5)=$P(TEMP,U,7)
 S SVC(6)=$S(SVC(6,4)&SVC(6,5):1,1:0)
 S SVC(7,1)=$P(TEMP,U,10)
 S SVC(7,2)=$P(TEMP,U,13)
 S SVC(7,3)=$P(TEMP,U,14)
 S SVC(7,4)=$P(TEMP,U,11)
 S SVC(7,5)=$P(TEMP,U,12)
 S SVC(7)=$S(SVC(7,4)&SVC(7,5):1,1:0)
 S SVC(8,1)=$P(TEMP,U,15)
 S SVC(8,2)=$P(TEMP,U,18)
 S SVC(8,3)=$P(TEMP,U,14)
 S SVC(8,4)=$P(TEMP,U,16)
 S SVC(8,5)=$P(TEMP,U,17)
 S SVC(8)=$S(SVC(8,4)&SVC(8,5):1,1:0)
 S TEMP=$G(^DPT(DFN,.3291))
 S SVC(6,6)=$P(TEMP,U,1)
 S SVC(7,6)=$P(TEMP,U,2)
 S SVC(8,6)=$P(TEMP,U,3)
 S NFOUND=0
 S IND=$S(NGET<0:9,1:5)
 S SDIR=$S(NGET>0:1,1:-1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 I NGET>3 S NGET=3
 F  S IND=$O(SVC(IND),SDIR) Q:(IND="")!(NFOUND=NGET)  D
 . S TEST=SVC(IND)
 . I 'TEST Q
 . S FDATE=SVC(IND,4)
 . S TDATE=SVC(IND,5)
 . I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" Q
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=1,DATE(NFOUND)=FDATE
 . S DATA(NFOUND,"BRANCH")=$$EXTERNAL^DILFD(2,.325,"",SVC(IND,1))
 . S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"DISCHARGE TYPE"))=$$EXTERNAL^DILFD(2,.324,"",SVC(IND,3))
 . S DATA(NFOUND,"ENTRY DATE")=FDATE
 . S DATA(NFOUND,"SEPARATION DATE")=TDATE
 . S DATA(NFOUND,"SERVICE COMPONENT")=$$EXTERNAL^DILFD(2,.32911,"",SVC(IND,6))
 . S TEXT(NFOUND)="Service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_" in "_DATA(NFOUND,"BRANCH")_"; discharge "_DATA(NFOUND,"DISCHARGE TYPE")
 Q
 ;
 ;======================================================
UNKOEIF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return unknown OEF/OIF service information in the date
 ;range specified by Beginning Date/Time and Ending Date/Time.
 N FDATE,IND,SDIR,TDATE,TEMP
 S NFOUND=0
 S SDIR=$S(NGET<0:1,1:-1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 D GETSVCD(DFN)
 I ^TMP($J,"SVC",DFN,13)=0 Q
 S IND=""
 F  S IND=$O(^TMP($J,"SVC",DFN,13,IND)) Q:IND=""  D
 . S FDATE=$P(^TMP($J,"SVC",DFN,13,IND,2),U,1)
 . I FDATE="" Q
 . S TDATE=$P(^TMP($J,"SVC",DFN,13,IND,3),U,1)
 . I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" Q
 . S TEMP(FDATE,"TEST")=1
 . S TEMP(FDATE,"DATA","LOCATION")=$P(^TMP($J,"SVC",DFN,13,IND,1),U,2)
 . S TEMP(FDATE,"TEXT")="OEF/OIF service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")_"; location: "_TEMP(FDATE,"DATA","LOCATION")
 S FDATE=""
 F  S FDATE=$O(TEMP(FDATE),SDIR) Q:(FDATE="")!(NFOUND=NGET)  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=TEMP(FDATE,"TEST"),DATE(NFOUND)=FDATE
 . S (DATA(NFOUND,"VALUE"),DATA(NFOUND,"LOCATION"))=TEMP(FDATE,"DATA","LOCATION")
 . S TEXT(NFOUND)=TEMP(FDATE,"TEXT")
 Q
 ;
 ;======================================================
VIET(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed will be
 ;true if Vietnam service in the date range specified by BDT and EDT
 ;is found. Note even though it is a multi structure it can only
 ;return one occurrence.
 N FDATE,TDATE
 S NFOUND=0
 D GETSVCD(DFN)
 S TEST=^TMP($J,"SVC",DFN,1)
 I 'TEST Q
 S FDATE=$P(^TMP($J,"SVC",DFN,1,1),U,1)
 S TDATE=$P(^TMP($J,"SVC",DFN,1,2),U,1)
 I $$OVERLAP^PXRMINDX(FDATE,TDATE,BDT,EDT)'="O" S TEST=0 Q
 S NFOUND=1
 S TEST(NFOUND)=1,DATE(NFOUND)=FDATE
 S TEXT(NFOUND)="Vietnam service from "_$$FMTE^XLFDT(FDATE,"5Z")_" to "_$$FMTE^XLFDT(TDATE,"5Z")
 Q
 ;
 ;======================================================
VETERAN(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for checking if a
 ;patient is a veteran.
 N VAEL
 S DATE=$$NOW^PXRMDATE
 D ELIG^VADPT
 S TEST=VAEL(4)
 S VALUE=""
 D KVA^VADPT
 Q
 ;

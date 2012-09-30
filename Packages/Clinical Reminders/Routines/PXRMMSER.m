PXRMMSER ;SLC/PKR,AJB - Computed findings for military service information. ;02/01/2012
 ;;2.0;CLINICAL REMINDERS;**11,12,21**;Feb 04, 2005;Build 152
 ;
 ;======================================================
AORANGE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will be true if the agent orange exposure registration
 ;date is in the date range specified by Beginning Date/Time
 ;and Ending Date/Time. VA-AGENT ORANGE EXPOSURE.
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
 ;and Ending Date/Time. VA-COMBAT SERVICE.
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
 ;combat vet eligiblity data. VA-COMBAT VET ELIGIBILITY.
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
DISCHDT(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;
 ; This computed finding returns the service separation date.
 ; CF.VA-SERVICE SEPARATION DATES
 N IND
 D MSDATA(DFN,NGET,BDT,EDT,.NFOUND,.TEST,.DATE,.DATA,.TEXT,1)
 F IND=1:1:NFOUND S DATA(IND,"VALUE")=DATE(IND)
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
MSDATA(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT,SEPDTR) ;This computed
 ;finding will return service branch information.
 ;CF.VA-SERVICE BRANCH.
 ;DBIA #5354
 N ENTRYDTA,MSDATA,NEPS
 D MSDATA^DGMSE(DFN,.NEPS,.ENTRYDTA,.MSDATA)
 I NEPS=0 S NFOUND=0 Q
 N BRANCH,DISTYPE,ENTRYDT,ENTRYDTO,IND,NOW
 N SCOMP,SDIR,SEPDT,SEPDTC,SEPDTCO
 S NOW=$$NOW^PXRMDATE
 S SDIR=$S(NGET>0:-1,1:1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 S NFOUND=0,ENTRYDT=""
 F  S ENTRYDT=$O(ENTRYDTA(ENTRYDT),SDIR) Q:(ENTRYDT="")!(NFOUND=NGET)  D
 . S IND=ENTRYDTA(ENTRYDT)
 . S SEPDT=MSDATA(IND,"SEPARATION DATE")
 .;Check for separation date required.
 . I SEPDTR,SEPDT="" Q
 .;If there is no Separation Date use the evaluation date and time.
 . S SEPDTC=$S(SEPDT'="":SEPDT,1:NOW)
 . I $$OVERLAP^PXRMINDX(ENTRYDT,SEPDTC,BDT,EDT)'="O" Q
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=1
 . S DATE(NFOUND)=MSDATA(IND,"DATE")
 . S BRANCH=MSDATA(IND,"BRANCH")
 . I BRANCH="" S BRANCH="<NO DATA>"
 . S DATA(NFOUND,"BRANCH")=BRANCH
 . S SCOMP=MSDATA(IND,"SERVICE COMPONENT")
 . S SCOMP=$S(SCOMP="":"<NO DATA>",1:SCOMP)
 . S DATA(NFOUND,"SERVICE COMPONENT")=SCOMP
 . S DISTYPE=MSDATA(IND,"DISCHARGE TYPE")
 . S DISTYPE=$S(DISTYPE="":"<NO DATA>",1:DISTYPE)
 . S DATA(NFOUND,"DISCHARGE TYPE")=DISTYPE
 . S ENTRYDTO=$$FMTE^XLFDT(ENTRYDT,"5Z")
 . S SEPDTO=$S(SEPDT="":"<NO DATA>",1:$$FMTE^XLFDT(SEPDT,"5Z"))
 . S TEXT(NFOUND)="Service from "_ENTRYDTO_" to "_SEPDTO_" in "_BRANCH_"; service component "_SCOMP_"; discharge "_DISTYPE_"."
 Q
 ;
 ;======================================================
OEF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return OEF service information in the date range
 ;specified by Beginning Date/Time and Ending Date/Time.
 ;VA-OEF SERVICE.
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
OEIF(NGET,BDT,EDT,TGLIST,PARAM) ;List computed finding to build patient
 ;list based on OEF/OIF/UNK data.
 ;VA-OEF/OIF
 N DA,DATE,DFN,FDATE,LOC,LOCATION,NFOUND,TDATE
 K ^TMP($J,TGLIST)
 ;DBIA #5354
 D OEIF^DGMSE(BDT,EDT,"OEIF")
 S DATE=$$NOW^PXRMDATE
 S NGET=$S(NGET<0:-NGET,1:NGET)
 S LOCATION=$G(PARAM)
 I LOCATION="" S LOCATION="ANY"
 S DFN=""
 F  S DFN=$O(^TMP($J,"OEIF",DFN)) Q:DFN=""  D
 . S FDATE=""
 . F  S FDATE=$O(^TMP($J,"OEIF",DFN,FDATE)) Q:FDATE=""  D
 .. S TDATE=""
 .. F  S TDATE=$O(^TMP($J,"OEIF",DFN,FDATE,TDATE)) Q:TDATE=""  D
 ... S LOC=""
 ... F  S LOC=$O(^TMP($J,"OEIF",DFN,FDATE,TDATE,LOC)) Q:LOC=""  D
 .... S NFOUND=+$O(^TMP($J,TGLIST,DFN,""))
 .... I NFOUND=NGET Q
 .... I (LOCATION["ANY")!(LOCATION[LOC) D
 ..... S DA=""
 ..... F  S DA=$O(^TMP($J,"OEIF",DFN,FDATE,TDATE,LOC,DA)) Q:DA=""  D
 ...... S NFOUND=NFOUND+1
 ...... S ^TMP($J,TGLIST,DFN,NFOUND)=DFN_";"_DA_U_DATE_U_2_U_LOC_U_TDATE_";"_FDATE
 K ^TMP($J,"OEIF")
 Q
 ;
 ;======================================================
OIF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return OIF service information in the date range
 ;specified by Beginning Date/Time and Ending Date/Time.
 ;VA-OIF SERVICE.
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
 ;purple heart data. VA-PURPLE HEART.
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
 ;VA-POW.
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
 ;and Ending Date/Time. DVA-RADIATION EXPOSURE.
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
 ;finding will return service branch information.
 ;CF.VA-SERVICE BRANCH.
 N IND
 D MSDATA(DFN,NGET,BDT,EDT,.NFOUND,.TEST,.DATE,.DATA,.TEXT,0)
 F IND=1:1:NFOUND S DATA(IND,"VALUE")=DATA(IND,"BRANCH")
 Q
 ;
 ;======================================================
UNKOEIF(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed
 ;finding will return unknown OEF/OIF service information in the date
 ;range specified by Beginning Date/Time and Ending Date/Time.
 ;VA-UNKNOWN OEF/OIF SERVICE.
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
VETERAN(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for checking if a
 ;patient is a veteran. VA-VETERAN.
 N VAEL
 S DATE=$$NOW^PXRMDATE
 D ELIG^VADPT
 S TEST=VAEL(4)
 S VALUE=""
 D KVA^VADPT
 Q
 ;
 ;======================================================
VIET(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;This computed will be
 ;true if Vietnam service in the date range specified by BDT and EDT
 ;is found. Note even though it is a multi structure it can only
 ;return one occurrence. VA-VIETNAM SERVICE.
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

DGPHSTAT ;ALB/RPM - PURPLE HEART STATUS REPORT ; 02/01/01 8:00am
 ;;5.3;Registration;**343**;Aug 13, 1993
 ;
 ;This report lists all patients with Current PH Status of either
 ;In Process or Pending.  The report can be tasked using TaskMan
 ;and the EN^DGPHSTAT entry point.  The Purple Heart Sort field (#1202)
 ;of the MAS PARAMETERS file (#43) contains the sort order used
 ;when queuing from TaskMan.  The option allows manual
 ;generation of the report using a user selected sort order and
 ;output device.
 ;
 Q   ;No direct entry
 ;
EN ;Entry point
 I '$D(ZTQUEUED) D MAN Q
 ;
QEN ;Start point for TaskMan queuing
 N DGORD
 ;
 ;Retrieve the sort order in numeric: 1-"A"scending or 0-"D"escending
 S DGORD=$$GETSORT("N")
 D START
 Q
 ;
MAN ;Start point for manual report allows sort order and device selection
 N DGORD
 S DGORD=$$ASKSORT()
 Q:DGORD=-1
 I $$DEVICE() D START
 Q
 ;
ASKSORT() ;Requests sort order from user when MAN entry point
 ; Input: none
 ;
 ; Output: Function value   Interpretation
 ;               0            Descending
 ;               1            Ascending
 ;              -1            "^" or timeout
 ;
 N DGSORT,DIR,DIRUT,DTOUT
 S DIR(0)="SA^D:DESCENDING;A:ASCENDING"
 S DIR("A")="Select 'A'scending or 'D'escending format: "
 S DIR("A",1)="The Purple Heart Status report will be sorted by number of days"
 S DIR("A",2)="since the last Status change in ascending or descending order."
 S DIR("A",3)=""
 S DIR("B")=$$GETSORT("E")
 S DIR("?")="Report will be sorted by number of days since last update."
 S DIR("??")="Enter 'A' if you want most recent first, 'D' if oldest first."
 W !!
 D ^DIR
 S DGSORT=$S(Y="A":1,1:0)
 I $D(DIRUT)!$D(DTOUT) S DGSORT=-1
 Q DGSORT
 ;
DEVICE() ;Allow user selection of output device
 ; Input: none
 ;
 ; Output: Function value    Interpretation
 ;               0           User decides to queue or not print report. 
 ;               1           Device selected to generate report NOW. 
 ;
 N OK,IOP,POP,%ZIS
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 I OK,$D(IO("Q")) D
 . N ZTRTN,ZTDESC,ZTSAVE,ZTSK
 . S ZTRTN="START^DGPHSTAT"
 . S ZTDESC="Current PH Status Pending/In Process report."
 . S ZTSAVE("DGORD")=""
 . F DG1=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 . W !,$S($D(ZTSK):"Request "_ZTSK_" Queued!",1:"Request Cancelled!"),!
 . D HOME^%ZIS
 . S OK=0
 Q OK
 ;
START ;
 D LOOP
 D PRINT
 D EXIT
 Q
 ;
LOOP ;Locate all PENDING and IN-PROCESS status Purple Heart requests
 ;and build ^TMP("DGPH",$J, with data
 N DGSTAT  ;Purple Heart Status
 N DGDFN   ;Patient DFN
 K ^TMP("DGPH",$J)
 F DGSTAT=1,2 D
 . S DGDFN=0
 . F  S DGDFN=$O(^DPT("C",DGSTAT,DGDFN)) Q:'DGDFN  D
 . . D BLDTMP(DGSTAT,DGDFN,DGORD)
 Q
 ;
BLDTMP(DGST,DFN,DGOR) ;^TMP("DGPH",$J global builder
 ; Build TMP file based on sort selection
 ;
 ; Division name retrieved from pointer to the INSTITUTION file (#4)
 ; in PH DIVISION field (#.535) in PATIENT file (#2)
 ; DBIA: #10090 - Supported read to the INSTITUTION file with FileMan
 ;
 ; Input:
 ;    DGST - PH Status
 ;    DFN  - Patient
 ;    DGOR - Sort Order [default=0 (Descending)]
 ;
 N DGDAYS,DGDIV,DGDT,DGNAME,DGNUM,DGSSN,VADM,X,X1,X2,Y
 ;validate input parameters
 I $G(DGST)'=1,$G(DGST)'=2 Q
 Q:'$G(DFN)
 S DGOR=$G(DGOR,0)
 ;
 D ^VADPT
 S DGNAME=VADM(1)
 S DGSSN=$P(VADM(2),U,2)
 S DGNUM=$O(^DPT(DFN,"PH"," "),-1)
 Q:DGNUM=""
 S DGDT=$P(^DPT(DFN,"PH",DGNUM,0),U)
 S X1=DT,X2=DGDT D ^%DTC S DGDAYS=X
 S Y=DGDT D DD^%DT S DGDT=Y
 S DGDIV=$$GET1^DIQ(2,DFN,.535)
 I $G(DGDIV)']"" S DGDIV="UNKNOWN"
 S ^TMP("DGPH",$J,"REQ",DGDIV,DGST,$S(DGOR:DGDAYS,1:(999-DGDAYS)),DFN)=DGDAYS_"^"_DGDT_"^"_DGNAME_"^"_DGSSN
 S ^TMP("DGPH",$J,"TOT")=$G(^TMP("DGPH",$J,"TOT"))+1
 S ^TMP("DGPH",$J,"STAT",DGST)=$G(^TMP("DGPH",$J,"STAT",DGST))+1
 S ^TMP("DGPH",$J,"DIV",DGDIV)=$G(^TMP("DGPH",$J,"DIV",DGDIV))+1
 Q
 ;
PRINT ;
 U IO
 N DG1,DG2,DG3,DG4,DGFIRST,DGLINE
 N DGSITE,DGSTNUM,DGSTTN,DGSTN
 N DGQUIT,DGPAGE
 S DGSITE=$$SITE^VASITE
 S DGSTNUM=$P(DGSITE,U,3),DGSTN=$P(DGSITE,U,2)
 S DGSTTN=$$NAME^VASITE(DT)
 S DGSTN=$S($G(DGSTTN)]"":DGSTTN,1:$G(DGSTN))
 S DGQUIT=0
 S DGPAGE=0
 I '$D(^TMP("DGPH",$J)) D  Q
 . D HEAD
 . W !!!?20,"**** No records to report. ****"
 S DG1=""
 F  S DG1=$O(^TMP("DGPH",$J,"REQ",DG1)) Q:DG1']""  D  Q:DGQUIT
 . D HEAD
 . Q:DGQUIT
 . W !,"Division: "_DG1
 . S DG2=0
 . F  S DG2=$O(^TMP("DGPH",$J,"REQ",DG1,DG2)) Q:'DG2  D  Q:DGQUIT
 . . W !!,"DAYS",?13,"DATE"
 . . W !,$S(DG2="1":"PENDING",1:"IN PROCESS"),?13,$S(DG2="1":"PENDING",1:"IN PROCESS"),?36,"PATIENT NAME",?67,"PATIENT SSN"
 . . W !,"----------",?13,"----------",?36,"------------",?67,"-----------"
 . . S DG3=""
 . . F  S DG3=$O(^TMP("DGPH",$J,"REQ",DG1,DG2,DG3)) Q:DG3=""  D  Q:DGQUIT
 . . . S DG4=0
 . . . F  S DG4=$O(^TMP("DGPH",$J,"REQ",DG1,DG2,DG3,DG4)) Q:'DG4  D  Q:DGQUIT
 . . . . D:$Y>(IOSL-4) HEAD Q:DGQUIT
 . . . . S DGLINE=^TMP("DGPH",$J,"REQ",DG1,DG2,DG3,DG4)
 . . . . W !,$P($G(DGLINE),U),?13,$P($G(DGLINE),U,2),?36,$P($G(DGLINE),U,3),?67,$P($G(DGLINE),U,4)
 . Q:DGQUIT
 . W !!?5,"Requests from Division "_DG1_": "_^TMP("DGPH",$J,"DIV",DG1)
 ;Shutdown if stop task requested
 I DGQUIT W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 ;
 W !!?7,"Total Number of Pending: "_$S($G(^TMP("DGPH",$J,"STAT","1"))>0:^TMP("DGPH",$J,"STAT","1"),1:0)
 W !?5,"Total Number of In Process Requests: "_$S($G(^TMP("DGPH",$J,"STAT","2"))>0:^TMP("DGPH",$J,"STAT","2"),1:0)
 W !?5,"Total Number of Outstanding Requests: "_$G(^TMP("DGPH",$J,"TOT"))
 Q
 ;
HEAD ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPAGE)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 W @IOF
 S Y=DT X ^DD("DD") S DGDT=Y
 S DGPAGE=$G(DGPAGE)+1
 W !,"PURPLE HEART REQUEST STATUS REPORT",?48,DGDT,?70,"Page: ",$G(DGPAGE)
 W !,"STATION: "_$G(DGSTN)
 Q
 ;
GETSORT(DGFMT) ;Retrieve the sort order from field 1202 of MAS PARAMETERS file
 ; Input:   DGFMT - selects output format
 ;                  Valid values: "N" - numeric [default]
 ;                                "I" - internal FM
 ;                                "E" - external FM  
 ;
 ; Output:  Function value   Interpretation
 ;                 0          Descending order [default] when "N" input
 ;                 1          Ascending order when "N" input
 ;                "D"         Descending order when "I" input
 ;                "A"         Ascending order when "I" input
 ;           "DESCENDING"     Descending order when "E" input
 ;           "ASCENDING"      Ascending order when "E" input
 ;
 N DGSORT,DGFLG
 S DGFMT=$G(DGFMT,"N")
 I DGFMT'="N",DGFMT'="I",DGFMT'="E" S DGFMT="N"
 S DGFLG=$S(DGFMT="I":"I",DGFMT="E":"E",1:"I")
 S DGSORT=$$GET1^DIQ(43,"1,",1202,DGFLG)
 I DGFMT="N" S DGSORT=$S(DGSORT="A":1,1:0)
 I DGFMT="I" S DGSORT=$S(DGSORT'="":DGSORT,1:"D")
 I DGFMT="E" S DGSORT=$S(DGSORT'="":DGSORT,1:"DESCENDING")
 Q DGSORT
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("DGPH",$J)
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q

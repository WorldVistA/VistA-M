DGOTHRP6 ;SLC/RED(LIB) - OTHD (OTHER THAN HONORABLE DISCHARGE) Reports ;May 9,2018@05:08
 ;;5.3;Registration;**952**;May 9, 2018;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RED - June 14, 2019 09:00
 ;
 ;  IA:  10103    ^XLFDT (sup)  - [$$FMADD^XLFDT, $$FMTE^XLFDT , $$NOW^XLFDT]
 ;       10112    $$SITE^VASITE
 ;       10015    ^DIQ    (sup)
 ;       10026    ^DIR   (sup)
 ;       10061    PID^VADPT (sup)
 ;       10063    ^%ZTLOAD (sup)
 ;       10089    ^%ZISC  (sup)
 ;
 Q  ;Cannot be ran directly
 ;
 ;Prepares a list of patients registered in VistA since Executive Order 13822 was released (Jan. 9, 2018) who 
 ; have an "other than honorable" discharge type and are not enrolled in VA healthcare. "
 ;
 ; Special Note: This report excludes patients with Patient Enrollment status of 'VERIFIED', I'm not completely sure this is a valid screen.
 ;
EN ; VistA option:  DG OTH POTENTIAL OTH PTS
 N DGSTDT,MINDTE,MAXDTE,MINDTE,MAXDTE
 W @IOF
 S MINDT=3100701,MAXDT=DT
 S DGSTDT=$$STARTDT(MINDT,MAXDT)
 I DGSTDT=0 Q
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D  Q                                        ;Queued report settings
 .S ZTDESC="Potential OTH Patients Report",ZTRTN="ENQUE^DGOTHRP6"
 .S ZTSAVE("DGSTDT")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",!
 I $E(IOST)="C" D WAIT^DICD
 ;
ENQUE ;  Queued entry 
 N DFN,DGENR,DGENR,DGSTAT,DGENDT,DGELIG,DGARRAY,PAGE,COUNT,DGDOD,DASH,DESCR,DGDISC,DGLAST,DGNAME,DGQ,PID,EXIT
 S DGARRAY=$NA(^TMP("DGOTHRP6",$J)) K @DGARRAY
 S PAGE=1,COUNT=0
 I $G(DGSTDT)="" S DGSTDT=3170701                           ;Default start date
 S DFN="+" F  S DFN=$O(^DPT(DFN),-1) Q:DFN<1  D
 . S DGENDT=$P($G(^DPT(DFN,0)),U,16)                        ;Date entry added to VistA
 . I DGENDT<DGSTDT Q                                        ;Vista Entry was made before the start date, not need to keep looking
 . S DGLAST=$O(^DPT(DFN,.3216,99999),-1)                    ;Get the latest period of service
 . S DGDISC=$$GET1^DIQ(2.3216,DGLAST_","_DFN_",",".06","I")
 . Q:DGDISC'=4                                              ;Character of discharge is not OTH
 . Q:$D(^DGOTH(33,"B",DFN))                                 ;Exists as an OTH patient in file #33
 . S DGENR=$O(^DGEN(27.11,"C",DFN,99999999),-1)
 . I DGENR S DGSTAT=$$GET1^DIQ(27.11,DGENR_",",".04")
 . Q:$G(DGSTAT)="VERIFIED"
 . S DGDOD=$P($$GET1^DIQ(2,DFN_",",".351","I"),".")
 . D DEM^VADPT                                              ;get patient demographics
 . S DGNAME=VADM(1),PID=$E(DGNAME,1)_$P($P(VADM(2),U,2),"-",3) D KVA^VADPT
 . S DGELIG=$$GET1^DIQ(2,DFN_",",".361")                    ;Current Primary Eligibility
 . S @DGARRAY@(DGNAME)=PID_U_DGENDT_U_DGDOD_U_DGELIG,COUNT=COUNT+1
 I $D(@DGARRAY) D PRTHDR,PRNTREP,QUIT
 Q
 ;
PRTHDR ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 W @IOF
 I PAGE=1 D
 . W "This report will list patients registered in VistA since Executive"
 . W !,"Order #13822 (dated Jan. 9, 2018) who have an 'Other Than Honorable'"
 . W !,"discharge type and are not currently enrolled in VA healthcare."
 . W !!,"The default start date is 7/1/17, you may select a different start date"
 . W !?3,"REPORT RUN DATE: ",$$FMTE^XLFDT(DT,10),?40,"STARTING DATE RANGE: ",$$FMTE^XLFDT(DGSTDT,10),!
 F DASH=1:1:75 W "="
 W !,"PATIENTS WITH 'OTH' DISCHARGE TYPE",?37,"FACILITY: ",$E($P($$SITE^VASITE,U,2),1,19),?68,"PAGE: ",PAGE,!
 F DASH=1:1:75 W "="
 W !,"PATIENT",?22,"PID",?30,"REG. DATE",?41,"CURRENT PRIMARY ELIG.",?65,"DATE OF",!,?65,"DEATH",!
 F DASH=1:1:75 W "-"
 Q
 ;
PRNTREP ;Print the report
 N NAM S NAM="",EXIT=0
 F  S NAM=$O(@DGARRAY@(NAM)) Q:NAM=""  D  Q:EXIT
 .I ($E(IOST,1,2)="C-"),$Y+3>IOSL S DIR(0)="E" D ^DIR K DIR D
 . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G QUIT
 . . S PAGE=PAGE+1 D PRTHDR
 . Q:EXIT
 . W !,$E(NAM,1,20),?22,$P(@DGARRAY@(NAM),U),?30,$$FMTE^XLFDT($P(@DGARRAY@(NAM),U,2),5),?41,$E($P(@DGARRAY@(NAM),U,4),1,23),?65,$$FMTE^XLFDT($P(@DGARRAY@(NAM),U,3),5)
 W:'EXIT !!,"Total number of Patients: ",COUNT
 I $E(IOST,1,2)="C-",'EXIT R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 D QUIT
 Q
 ;
STARTDT(MINDT,MAXDT) ;
 S DESCR=""
 ; MINDT = earliest allowed date (required)
 ; returns date in internal FM format or 0 on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 ; get min and max dates in external format
 S MINDTE=$$FMTE^XLFDT(3170701),MAXDTE=$$FMTE^XLFDT(MAXDT)
 S DIR(0)="DA^"_MINDT_":"_MAXDT_":EX"
 S DIR("A")="Search start date: "
 S DIR("B")=$$FMTE^XLFDT(3170701)
 S DIR("?")="Latest allowed date is TODAY"
 S DIR("?",1)="Earliest allowed date is "_MINDTE_"."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
QUIT ;
 K @DGARRAY
 Q
 ;
 ;END DGOTHRP6

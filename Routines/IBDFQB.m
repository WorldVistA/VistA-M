IBDFQB ;ALB/MAF - MAIN QUEUE JOB FOR ENCOUNTER FORM PRINTING - FEB 2 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
 ;
EN ;
 ; -- Goes through the "SEQ" cross reference to print the 
 ;    highest priority jobs first (lowest sequence number).
 N IBDFQUE,IBDFQDT,IBDFQD,IBDFQT,IBDFTSTP
 S IBDFQUE=1,IBDFTSTP=1
 S (IBDFNUM,IBDFNAME,IBDFIFN,IBDFSEQ,QUIT)=0
 D NOW^%DTC S IBDFQDT=%,IBDFQD=$P(%,"."),IBDFQT=$E($P(%,".",2),1,4)
 ;
 F  S IBDFSEQ=$O(^IBD(357.09,"SEQ",IBDFSEQ)) Q:IBDFSEQ']""  F  S IBDFNUM=$O(^IBD(357.09,"SEQ",IBDFSEQ,IBDFNUM)) Q:IBDFNUM']""  F  S IBDFIFN=$O(^IBD(357.09,"SEQ",IBDFSEQ,IBDFNUM,IBDFIFN)) Q:IBDFIFN']""  N IBDFARY D UP($$QUEUE(IBDFIFN))
 ;
 ; -- send forms pending pages to PCE automatically
 D BCKGRND^IBDFFRFT
 ;
 G EXIT
 ;
 ;
UP(IBTASK) ; -- store results of tasking
 Q:'$G(IBTASK)
 D TASK
 Q
 ;
 ;
QUEUE(IBDFIFN) ; -- Set up Queue variables
 N ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTSAVE,ZTION,X,Y
 K ^TMP("IBDF",$J,"C"),^TMP("IBDF",$J,"D")
 D SET
 G:('$D(^TMP("IBDF",$J)))!QUIT CLEAR
 ;
 ; -- check if already tasked and running?
 ;I $P(IBDFNODE,"^",11)]"" S ZTSK=$P(IBDFNODE,"^",11) D STAT^%ZTLOAD I "^1^2^"[ZTSK(1) S QUIT=1 G CLEAR
 ;I $P(IBDFNODE,"^",11)]"" S ZTSK=$P(IBDFNODE,"^",11) W !,ZTSK,! B  
 S $P(^IBD(357.09,IBDFNUM,"Q",IBDFIFN,0),"^",14)=$P(IBDFNODE,"^",11)
 ;
 F IBDT=0:0 S IBDT=$O(IBDFARY(IBDT)) Q:'IBDT  D
 .S ZTDTH=$S('$D(ZTDTH):$H,$D(ZTDTH)&(ZTDTH]""):ZTDTH,1:$H)
 .S ZTRTN="DQ^IBDFQB",ZTDESC="IBD - Encounter Forms for"_IBDFNAME,ZTSAVE("^TMP(""IBDF"",$J,")="",ZTSAVE("IB*")="",ZTIO=$S($P(IBDFNODE,"^",9)]"":$P(IBDFNODE,"^",9),1:"") D ^%ZTLOAD D HOME^%ZIS
 ;
 ; -- after queing, delete start and stop times and add task
 ; -- once started add start time
 ; -- once finished add stop time, delete task no.
 ;
 S IBZTSK=ZTSK
 I '$D(ZTQUEUED) D ^%ZISC S QUIT=1
 ;
 ;
CLEAR ; -- Clean up variables if task is not queued
 K ^TMP("IBDF",$J),^TMP("IB",$J)
 ;
 I QUIT D
 .I $D(ZTSK),$D(ZTSK(1)) I "^1^2^"[ZTSK(1) K ZTSK
 .S IBZTSK=$S($D(ZTSK):ZTSK,1:"")
 ;
 S QUIT=0
 Q $G(IBZTSK)
 ;
DQ ; -- Generic entry points to edit
 ; -- only called by jobs tasked by this routine
 S IBDFFLD=".02" D UPDT
 D ^IBDF1B1
 S IBDFFLD=".03" D UPDT
 S IBTASK="@" D TASK
 Q
 ;
UPDT ; -- Update start and finish times
 N DIE,DA,DR
 D NOW^%DTC S IBDFX=$E(%,1,12),DA=IBDFIFN,DA(1)=IBDFNUM,DIE="^IBD(357.09,"_DA(1)_","_"""Q"""_",",DR=IBDFFLD_"///"_"^S X=IBDFX" D ^DIE Q
 ;
 ;
TASK ; -- Update Task number and last date printed
 N DA,DR,DIE
 S DA=IBDFIFN,DA(1)=IBDFNUM,DIE="^IBD(357.09,"_DA(1)_","_"""Q"""_",",DR=".11///"_IBTASK_";.12///"_IBDT D ^DIE
 I $D(IB1FLAG) S IB1TASK=IBTASK
 Q
 ;
 ;
EXIT K IBADDONS,IBCLN,IBDFDAY,IBDFIFN,IBDFINST,IBDFNAME,IBDFNODE,IBDFNOW,IBDFNUM,IBDFSEQ,IBDIV,IBDT,IBREPRNT,IBSRT,IBSTRTDV,IBDFDAY1,IBDFLAST,IBDFONE,IBDFQ,IBDFXX,IBZTSK,QUIT
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
 ;
SET ; -- Set up variables needed for priniting of forms
 S IBDFNODE=$G(^IBD(357.09,IBDFNUM,"Q",IBDFIFN,0))
 I $P(IBDFNODE,"^",4)=""!($P(IBDFNODE,"^",5)="")!($P(IBDFNODE,"^",6)="")!($P(IBDFNODE,"^",7)="")!($P(IBDFNODE,"^",8)="")!($P(IBDFNODE,"^",9)="")!($P(IBDFNODE,"^",10)="") D  I QUIT Q
 .I '$D(IBDFQUE) W !!,"PRINT QUEUE ABORTED.... missing required parameters!!!!" D PAUSE^VALM1
 .S QUIT=1
 .Q
 I $P(IBDFNODE,"^",8)="N" D  I QUIT Q
 .I '$D(IBDFQUE)  W !!,"PRINT QUEUE ABORTED.....not an active print job... check Special Instructions" D PAUSE^VALM1
 .S QUIT=1
 .Q
 S IBSRT=$P(IBDFNODE,"^",4),SELECTBY="C",IBADDONS=$P(IBDFNODE,"^",5),IBREPRNT="",IBSTRTDV=""
 D ENTRY Q:QUIT  D
 .N GROUPS,IEN
 .; -- GET PRINT MANAGER GROUPS
 .S GROUPS=""
 .S GROUPS($P(IBDFNODE,"^",6))="" D
 ..S GROUPS=0 F  S GROUPS=$O(GROUPS(GROUPS)) Q:'GROUPS  D
 ...S IEN=0 F  S IEN=$O(^IBD(357.99,GROUPS,10,IEN)) Q:'IEN  S IBCLN=+$G(^IBD(357.99,GROUPS,10,IEN,0)) S:IBCLN ^TMP("IBDF",$J,"C",IBCLN)=""
 ...S IEN=0 F  S IEN=$O(^IBD(357.99,GROUPS,11,IEN)) Q:'IEN  S IBDIV=+$G(^IBD(357.99,GROUPS,11,IEN,0)) S:IBDIV ^TMP("IBDF",$J,"D",IBDIV)=""
 Q
 ;
 ;
ENTRY ; -- Calc date and do checks on special instructions
 K IBDFARY
 N IBDFNOW,IBDFINST,IBDFDATE,IBDFDAYS,IBDFCTR,IBDFQTIM
 ;S IBDFNOW=$P($$NOW^XLFDT(),"."),IBDFINST=$P(IBDFNODE,"^",8),IBDFQTIM=$S($P(IBDFNODE,"^",13)]"":$P(IBDFNODE,"^",13),1:$E($P($$NOW^XLFDT(),".",2),1,4))
 S IBDFNOW=$P($$NOW^XLFDT(),"."),IBDFINST=$P(IBDFNODE,"^",8),IBDFQTIM=$S($P(IBDFNODE,"^",13)]"":$P(IBDFNODE,"^",13),1:IBDFQT)
 D:'$D(IBDFSING) ZTDTH
 ;
 ; -- if ignoring weekends and/or holidays, check current date
 I IBDFINST["W" I $$WEEKEND(IBDFNOW) S QUIT=1 Q
 I IBDFINST["H" I $$HOLIDAY(IBDFNOW) S QUIT=1 Q
 I IBDFINST["I" I $$WEEKEND(IBDFNOW)!($$HOLIDAY(IBDFNOW)) S QUIT=1 Q
 ;
 ; -- find date to return - returned in IBDFARY(date) array
 ; -- loop adds 1 day and checks if day is restricted
 ; --     if not, it adds it as a printable day and compares it
 ; --     with the number of printable days ahead the user wants to prn
 S IBDFDATE=IBDFNOW,IBDFCTR=0,IBDFDAYS=+$P(IBDFNODE,"^",7)
 F  Q:IBDFCTR=IBDFDAYS  D
 .S IBDFDATE=$$FMADD^XLFDT(IBDFDATE,1)
 .I IBDFINST["W" Q:$$WEEKEND(IBDFDATE) 
 .I IBDFINST["H" Q:$$HOLIDAY(IBDFDATE)
 .I IBDFINST["I" Q:$$WEEKEND(IBDFDATE)!($$HOLIDAY(IBDFDATE))
 .S IBDFCTR=IBDFCTR+1
 S IBDFARY(IBDFDATE)=""
 Q
 ;
WEEKEND(DATE) ;
 ; -- DATE (defaulted to current date if not passed)
 ; -- output = 1 if date is a weekend
 I '$G(DATE) S DATE=$P($$NOW^XLFDT(),".")
 I 60[$$DOW^XLFDT(DATE,1) Q 1
 Q 0
 ;
HOLIDAY(DATE) ;
 ; -- DATE (defaulted to current date if not passed)
 ; -- output = 1 if date is a holiday
 I '$G(DATE) S DATE=$P($$NOW^XLFDT(),".")
 N X,Y,DIC
 S DIC="^HOLIDAY(",DIC(0)="",X=+$P(DATE,".")
 D ^DIC I +Y>0 Q 1
 Q 0
ZTDTH ;  -- Set up the variable ZTDTH to pass the queue date time of the
 ;     queued job.
 N IBDFJQ
 I IBDFQT=2400!(IBDFQT=0000) D  G DTIME
 .I IBDFQTIM=2400 S IBDFQTIM="0000"
 .I IBDFQTIM=IBDFQT S IBDFJQ=IBDFQDT Q
 .S IBDFJQ=IBDFQD_"."_IBDFQTIM
 I IBDFQTIM>IBDFQT S IBDFJQ=IBDFQD_"."_IBDFQTIM
 I IBDFQTIM<IBDFQT S X1=IBDFQDT,X2=1 D C^%DTC S IBDFJQ=$P(X,".")_"."_IBDFQTIM
 I IBDFQTIM=IBDFQT S IBDFJQ=IBDFQDT
DTIME I IBDFJQ]"" S ZTDTH=$$FMTH^XLFDT(IBDFJQ)
 Q

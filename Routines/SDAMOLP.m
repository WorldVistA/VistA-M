SDAMOLP ;ALB/CAW - Retroactive Encounter List (Print); 4/15/92 ; 03 Feb 99  4:20 PM
 ;;5.3;Scheduling;**132,176**;Aug 13, 1993
 ;
BLD ; Build info from ^TMP global
 ;
 ; -- check if user has asked to stop job
 IF $$S^%ZTLOAD("Printing Retroactive Report...") S (SDSTOP,ZTSTOP)=1 G BLDQ
 ;
 S (SDDV,SDSC,SDAD,SDDFN)="",(SDPAGE,SDSTOP)=0,SDFST=21,SDSEC=50,SDFLEN=14,SDSLEN=30,SDCNT=0,SDMORE=1
 S $P(SDASH,"-",IOM+1)=""
 U IO
 I '$D(^TMP("SDRAL",$J)) D HDR W !,SDASH,!!,"No Encounters found for selected date range." G BLDQ
 ;
 D DV
 ;
 IF SDSTOP G BLDQ
 ;
 IF $G(SDCNT) D TOTAL
 ;
BLDQ ; -- send message that job finished or stopped
 N X
 S X=$S('SDSTOP:"Retroactive Report Successfully Completed",1:"Retroactive Report Stopped By User")
 S X=$$S^%ZTLOAD(X)
 Q
 ;
 ; SDDV=Division, SDSC=Stop Code, SDAD=Encounter Date/Time, SDDFN=Patient
 ; 
DV F  S SDDV=$O(^TMP("SDRAL",$J,SDDV)) Q:SDDV=""  D SC Q:SDSTOP
 Q
SC F  S SDSC=$O(^TMP("SDRAL",$J,SDDV,SDSC)) Q:SDSC=""  D HDR,AD Q:SDSTOP
 Q
AD F  S SDAD=$O(^TMP("SDRAL",$J,SDDV,SDSC,SDAD)) Q:'SDAD  D DFN Q:SDSTOP
 Q
DFN F  S SDDFN=$O(^TMP("SDRAL",$J,SDDV,SDSC,SDAD,SDDFN)) Q:'SDDFN  S SDATA=^(SDDFN) S DFN=SDDFN D PID^VADPT6 D INFO Q:SDSTOP  S SDCNT=$G(SDCNT)+1
 Q
 ;
TOTAL ;
 W !!!,"Total Encounters: ",SDCNT
 Q
INFO ; Encounter Date/Time and Patient
 ;
 W !,SDASH
 W !,"Encounter Date/Time:",?SDFST,$$FDTTM^VALM1(SDAD),?41,"Patient:",?SDSEC,$P(^DPT(SDDFN,0),U)
 ;
 ; Date Encounter Entered and ID
 W !,?7,"Date Entered:",?SDFST,$$FDTTM^VALM1($P(SDATA,U,2)),?46,"ID:",?SDSEC,VA("PID")
 ;
 ; Date Transmitted and Type
 W !,?3,"Close-Out Date :",?SDFST,$$FDTTM^VALM1($P(SDATA,U,5)),?44,"Type:",?SDSEC,$P(SDATA,U,4)
 ;
 ; User
 W !,?13,"Clinic:",?SDFST,$S($P(SDATA,U,6)=0:"",1:$P(SDATA,U,6)),?44,"User:",?SDSEC,$P($G(^VA(200,+$P(SDATA,U,3),0),"UNKNOWN"),U)
 ;
 S SDMORE=$S('$O(^TMP("SDRAL",$J,SDDV,SDSC,SDAD)):0,1:1)
 D CHK
 ;
 ; -- check if user has asked to stop job
 IF $$S^%ZTLOAD() S (SDSTOP,ZTSTOP)=1
 Q
 ;
HDR ; Header
 ;
 S SDPAGE=SDPAGE+1
 I $E(IOST,1,2)="C-",'SDMORE S SDMORE=1 D PAUSE^VALM1 I 'Y S SDSTOP=1 Q
 W @IOF,"Retroactive Encounter List",?70,"Page: "_SDPAGE
 W !,?3,"Date Range: "_$$FDATE^VALM1(SDBD)_" to "_$$FDATE^VALM1(SDED) D NOW^%DTC W ?51,"Run Date: "_$E($$FTIME^VALM1(%),1,18) Q:'$D(^TMP("SDRAL",$J))
 W !,?5,"Division: "_$P($G(^DG(40.8,SDDV,0)),U),?44,"Close-Out Check: ",$S(SDNPDB=1:"DATABASE UPDATE ONLY",1:"WORKLOAD CREDIT")
 W !,?4,"Stop Code: "_SDSC,?44,"Visit Selection: "_$S(SDSEL=1:"STOP CODE",1:"CLINIC")
 Q
 ;
CHK ;Check to pause on screen
 I $E(IOST,1,2)="C-",($Y+7)>IOSL D
 . D PAUSE^VALM1 S SDY=Y
 . IF SDMORE,SDY D HDR
 . S:'SDMORE SDMORE=1
 . IF 'SDY S SDSTOP=1
 I $E(IOST,1,2)="P-",($Y+6)>IOSL,SDMORE D HDR Q
 Q

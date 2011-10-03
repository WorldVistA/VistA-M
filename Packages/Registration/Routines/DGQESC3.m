DGQESC3 ;ALB/JFP - VIC PREADMIT SCAN ROUTINE ; 01/09/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENS ; -- Entry point
 N DIR,Y
 ;
 S DIR(0)="YA"
 S DIR("A")="Download Scheduled Admissions to the VIC card station "
 S DIR("B")="NO"
 S DIR("?")="Enter yes to download data."
 D ^DIR
 I Y D  Q
 .; -- New Variables
 .N VAUTD
 .N DATE,DFNARR,CNT,Y,ERR,SDATE,EDATE,CLINIC,DFN,LDATE,IFN,ZTSTOP,RESULTS
 .N DGSNODE,DGSUB,DGJ,DGUTD,DGDV
 .N DIVFLAG,DIVISION,SELDIV
 .; -- Set variables
 .S VAUTD=1 ; -- All divisions selected
 .D NOW^%DTC S DATE=%
 .S DFNARR="^TMP(""DGQE-DFN"","_$J_")"
 .K @DFNARR
 .S CNT=0
 .; -- Check for multi divisional hospital
 .I $P(^DG(43,1,"GL"),"^",2)=1 D  Q:Y=-1
 ..D DIVISION^VAUTOMA
 .; -- Download for date range
 .S ERR=$$SDATE^DGQESC0()
 .I ERR=-1 Q
 .S SDATE=ERR
 .S ERR=$$EDATE^DGQESC0(ERR)
 .I ERR=-1 Q
 .S EDATE=ERR
 .; -- Task off job
 .S DIR(0)="YA"
 .S DIR("A")="Task job: "
 .S DIR("B")="YES"
 .S DIR("?")="Enter YES/NO to determine whether job is tasked"
 .D ^DIR
 .Q:$D(DIRUT)
 .I Y D  Q
 ..D BATCH
 ..I '$D(ZTSK) Q
 ..W !,"Card(s) queued, task number = "_ZTSK
 .D PRESCAN
 Q
 ;
EXIT ; -- Finish processing
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=0) W !!,CNT_" Scheduled admissions down loaded to VIC work station"
 K @DFNARR
 Q
 ;
PRESCAN ; -- Scans for scheduled admissions
 I '$D(ZTQUEUED) W !!,"Note: Each dot equals a day",!,"."
 ; -- scan scheduled admissions
 S (CLINIC,DFN)=""
 S LDATE=SDATE
 F  S LDATE=$O(^DGS(41.1,"C",LDATE)) Q:(LDATE="")!($P(LDATE,".",1)>EDATE)  D
 .I '$D(ZTQUEUED) W "."
 .S IFN=""
 .F  S IFN=$O(^DGS(41.1,"C",LDATE,IFN)) Q:IFN=""  D
 ..S DGSNODE=$G(^DGS(41.1,IFN,0))
 ..; -- Check cancelled flag
 ..I $P(DGSNODE,"^",13)'="" Q
 ..; -- Check batch cancelled flag
 ..I $$S^%ZTLOAD D  Q
 ...S ZTSTOP=1
 ..I VAUTD=0 D CHKDIV  Q:'DIVFLAG
 ..S DFN=$P(DGSNODE,"^",1)
 ..; -- Places card in hold file
 ..S @DFNARR@(DFN)=""
HL7 ; -- Builds HL7 batch message
 S DFN=""
 F  S DFN=$O(@DFNARR@(DFN)) Q:'DFN  S CNT=CNT+1
 S RESULTS=$$EVENT^DGQEHL72("A08",DFNARR)
 I $D(JPTEST) W !,"Results = ",RESULTS
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=-1) D
 .W !,"Scheduled admission data not downloaded. Error - ",$P(RESULTS,"^",2)
 ; -- Clean up variables
 D EXIT
 Q
 ;
CHKDIV ; -- Check to see if clinic is part of Division selected
 ; -- re-sequences array
 S DGSUB="" F DGJ=1:1 S DGSUB=$O(VAUTD(DGSUB)) Q:DGSUB=""  S DGUTD(DGJ)=$G(VAUTD(DGSUB))
 ;
 S DIVFLAG=0
 S DGDV=$P(DGSNODE,"^",12)
 I DGDV="" S DIVFLAG=0 Q
 S DIVISION=$P($G(^DG(40.8,DGDV,0)),U,1)
 I DIVISION="" S DIVFLAG=0 Q
 F DGJ=1:1 S SELDIV=DGUTD(DGJ) D  Q:'$D(DGUTD(DGJ+1))
 .I SELDIV=DIVISION S DIVFLAG=1 Q 
 Q
 ;
BATCH ; -- Batch entry point for placing cards on hold
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,G
 ;
 S ZTRTN="PRESCAN^DGQESC3"
 S ZTDESC="Scheduled admissions download to VIC work station via HL7"
 S ZTIO=""
 K ZTDTH
 ;D NOW^%DTC S ZTDTH=%
 F G="VAUTD","CNT","DFNARR","SDATE","EDATE" S:$D(@G) ZTSAVE(G)=""
 S ZTSAVE("VAUTD(")=""
 D ^%ZTLOAD
 Q
 ;
END ; -- End of Code
 Q
 ;

DGQESC2 ;ALB/JFP - VIC OUTPATIENT CLINIC SCAN ROUTINE ; 03/29/2004
 ;;5.3;Registration;**73,568,725**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENO ; -- Entry Point
 N DIR,Y
 ;
 S DIR(0)="YA"
 S DIR("A")="Download Clinics patients to the VIC card station: "
 S DIR("B")="NO"
 S DIR("?")="Enter yes to download data."
 D ^DIR
 I Y D  Q
 .; -- New Variables
 .N VAUTD,VAUTNI,VAUTC
 .N DATE,DFNARR,CNT,Y,ERR,SDATE,EDATE,DFN,RESULTS
 .N DIVFLAG,DIVISION,SELDIV
 .N DGSUB,DGJ,DGUTD,DGWD,DGDV,ZTSTOP
 .; -- Set Variables
 .S VAUTD=1  ; -- All divisions selected
 .D NOW^%DTC S DATE=%
 .S DFNARR="^TMP(""DGQE-DFN"","_$J_")"
 .K @DFNARR
 .S CNT=0
 .; -- Check for multi divisional hospital
 .I $P(^DG(43,1,"GL"),"^",2)=1 D  Q:Y=-1
 ..D DIVISION^VAUTOMA
 .; -- Check for Clinics within division or all
 .S VAUTNI=2
 .D CLINIC^VAUTOMA
 .I Y=-1 Q
 .; -- Download for date range
 .S ERR=$$SDATE^DGQESC0()
 .I ERR=-1 Q
 .S SDATE=ERR
 .S ERR=$$EDATE^DGQESC0(ERR)
 .I ERR=-1 Q
 .S EDATE=ERR
 .S DIR(0)="YA"
 .; -- Task off job
 .S DIR("A")="Task job: "
 .S DIR("B")="YES"
 .S DIR("?")="Enter YES/NO to determine whether job is tasked"
 .D ^DIR
 .Q:$D(DIRUT)
 .I Y D  Q
 ..D BATCH
 ..I '$D(ZTSK) Q
 ..W !,"Card(s) queued, task number = "_ZTSK
 .D OUTSCAN
 Q
 ;
EXIT ; -- Finish Process
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=0) W !!,CNT_" Outpatients down loaded to VIC work station"
 K @DFNARR
 Q
 ;
OUTSCAN ; Scan the clinics for appointments to create VIC cards
 ;
 N CLINIC,CLINDATE,DPTINFO,I,CLNARRAY,DGARRAY,DGDIV,SDCNT S I=1
 K ^TMP($J,"SDAMA"),^TMP($J,"SDAMA301")
 ;
 I '$D(ZTQUEUED) W !!,"Note: Each Dot equals a clinic",!
 I VAUTC,VAUTD D
 .S CLINIC=0 F  S CLINIC=$O(^SC(CLINIC)) Q:'CLINIC  D
 ..I $P(^SC(CLINIC,0),U,3)="C" D CBLD3(CLINIC)
 ;
 I VAUTC,'VAUTD S DGDIV="" D
 .S DGDIV="" F  S DGDIV=$O(VAUTD(DGDIV)) Q:'DGDIV  D
 ..S CLINIC=0 F  S CLINIC=$O(^SC(CLINIC)) Q:'CLINIC  D
 ...I $P(^SC(CLINIC,0),U,3)="C",$P(^SC(CLINIC,0),U,15)=DGDIV D CBLD3(CLINIC)
 ;
 I 'VAUTC S CLINIC=0 F  S CLINIC=$O(VAUTC(CLINIC)) Q:'CLINIC  D CBLD3(CLINIC)
 ;
 D SDAMA,BLDTMP,BLDHL7
 K DGARRAY,SDCNT,^TMP($J,"SDAMA301"),^TMP($J,"SDAMA")
 Q
CBLD3(CLINIC) ; Build array of specified Clinics for specified Divisions
 S CLNARRAY(I)=$G(CLNARRAY(I))_CLINIC_";"
 I $L(CLNARRAY(I))>120 S I=I+1
 I '$D(ZTQUEUED) W "."
 Q
 ;
SDAMA ; Build TMP Global with Appointment API Data for Report
 S DGARRAY(1)=SDATE_";"_EDATE
 S DGARRAY("FLDS")="2;3"
 F I=1:1 Q:'$D(CLNARRAY(I))  D
 .S DGARRAY(2)=CLNARRAY(I)
 .I $$SDAPI^SDAMA301(.DGARRAY)>0 M ^TMP($J,"SDAMA")=^TMP($J,"SDAMA301")
 .K ^TMP($J,"SDAMA301")
 Q
BLDHL7 ; -- Building HL7 batch message
 S DFN=""
 F  S DFN=$O(@DFNARR@(DFN)) Q:'DFN  S CNT=CNT+1
 S RESULTS=$$EVENT^DGQEHL72("A08",DFNARR)
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=-1) D
 .W !,"Clinic patients not downloaded.  Error - ",$P(RESULTS,"^",2)
 ; -- Clean up variables
 D EXIT
 Q
 ;
BLDTMP ;
 ; -- Building Temporary Storage Data
 S (ZTSTOP,CLINIC)=0 F  S CLINIC=$O(^TMP($J,"SDAMA",CLINIC)) Q:'CLINIC!(ZTSTOP)  D
 .I $$S^%ZTLOAD S ZTSTOP=1 Q
 .S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA",CLINIC,DFN)) Q:'DFN  D
 ..S CLINDATE=0 F  S CLINDATE=$O(^TMP($J,"SDAMA",CLINIC,DFN,CLINDATE)) Q:'CLINDATE  D
 ...I $P($P(^TMP($J,"SDAMA",CLINIC,DFN,CLINDATE),U,3),";")="R" S @DFNARR@(DFN)=""
 Q
 ;
CHKDIV ; -- Check to see if clinic is part of Division selected
 ; -- re-sequences array
 S DGSUB="" F DGJ=1:1 S DGSUB=$O(VAUTD(DGSUB)) Q:DGSUB=""  S DGUTD(DGJ)=$G(VAUTD(DGSUB))
 ;
 S DIVFLAG=0
 S DGWD=CLINIC
 I DGWD S DGDV=$S('$D(^SC(DGWD,0)):0,+$P(^(0),"^",15):$P(^(0),"^",15),1:$O(^DG(40.8,0)))
 I DGDV=0 S DIVFLAG=0 Q
 S DIVISION=$P($G(^DG(40.8,DGDV,0)),U,1)
 I DIVISION="" S DIVFLAG=0 Q
 ;W !,"DIVISION = ",DIVISION
 F DGJ=1:1 S SELDIV=DGUTD(DGJ) D  Q:'$D(DGUTD(DGJ+1))
 .;W !,"SELDIV = ",SELDIV
 .I SELDIV=DIVISION S DIVFLAG=1 Q 
 Q
 ;
BATCH ; -- Entry point for placing cards on hold
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,G
 ;
 S ZTRTN="OUTSCAN^DGQESC2"
 S ZTDESC="Download Outpatients to VIC work station via HL7"
 S ZTIO=""
 K ZTDTH
 ;D NOW^%DTC S ZTDTH=%
 F G="VAUTD","VAUTC","CNT","DFNARR","SDATE","EDATE" S:$D(@G) ZTSAVE(G)=""
 S ZTSAVE("VAUTD(")="",ZTSAVE("VAUTC(")=""
 D ^%ZTLOAD
 Q
 ;
END ; -- End of Code
 Q
 ;

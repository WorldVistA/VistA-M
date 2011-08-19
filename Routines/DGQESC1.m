DGQESC1 ;ALB/JFP - VIC INPATIENT SCAN ROUTINE ; 01/09/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENI ; -- Entry Point
 N DIR,Y
 S DIR(0)="YA"
 S DIR("A")="Download all current Inpatients to the VIC card station "
 S DIR("B")="NO"
 S DIR("?")="Enter yes to download data."
 D ^DIR
 I Y D  Q
 .; -- New varaibles
 .N DATE,DFNARR,CLINIC,DFN,ZTSTOP,CNT,RESULTS
 .N VAUTD,VAUTNI
 .N DGSUB,DGJ,DGUTP,DGWD,DGDV
 .N DIVFLAG,DIVISION,SELDIV
 .; -- Set variables
 .S VAUTD=1 ; -- All divisions selected
 .S CNT=0
 .D NOW^%DTC S DATE=%
 .S DFNARR="^TMP(""DGQE-DFN"","_$J_")"
 .K @DFNARR
 .; -- Check for multi divisional hospital
 .I $P(^DG(43,1,"GL"),"^",2)=1 D  Q:Y=-1
 ..D DIVISION^VAUTOMA
 .; -- Check for wards within division or all
 .S VAUTNI=2
 .D WARD^VAUTOMA
 .I Y=-1 Q
 .; -- Task off job
 .S DIR(0)="YA"
 .S DIR("A")="Queue job: "
 .S DIR("B")="YES"
 .S DIR("?")="Enter YES or NO to have job run in background"
 .D ^DIR
 .Q:$D(DIRUT)
 .I Y D  Q
 ..D BATCH
 ..I '$D(ZTSK) Q
 ..W !,"Card(s) queued, task number = "_ZTSK
 .; -- Builds an array of inpatients to download
 .D INSCAN
 Q
 ;
EXIT ; -- Finish processing
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=0) W !!,CNT_" Inpatients down loaded to VIC work station"
 K @DFNARR
 Q
 ;
INSCAN ; -- Scans all ward locations for inpatients
 I '$D(ZTQUEUED) W !!,"Note: Each dot equals a ward",!,"."
 ; -- scan INPATIENT clinics
 S (CLINIC,DFN)=""
 F  S CLINIC=$O(^DPT("CN",CLINIC)) Q:(CLINIC="")  D
 .; -- Check to see if users wants task to stop
 .I $$S^%ZTLOAD D  Q
 ..S ZTSTOP=1
 .I VAUTD=0 D CHKDIV  Q:'DIVFLAG
 .I '$D(ZTQUEUED) W "."
 .S DFN=""
 .F  S DFN=$O(^DPT("CN",CLINIC,DFN)) Q:(DFN="")  D
 ..;W !,"DFN = ",DFN
 ..S @DFNARR@(DFN)=""
HL7 ; -- Builds HL7 batch message
 S DFN=""
 F  S DFN=$O(@DFNARR@(DFN)) Q:'DFN  S CNT=CNT+1
 S RESULTS=$$EVENT^DGQEHL72("A08",DFNARR)
 I '$D(ZTQUEUED)&($P(RESULTS,"^",1)=-1) D
 .W !,"Inpatient data not downloaded.  Error - ",$P(RESULTS,"^",2)
 ; -- Clean up variables
 D EXIT
 Q
 ;
CHKDIV ; -- Check to see if clinic is part of Division selected
 ; -- re-sequences array
 S DGSUB="" F DGJ=1:1 S DGSUB=$O(VAUTD(DGSUB)) Q:DGSUB=""  S DGUTD(DGJ)=$G(VAUTD(DGSUB))
 ;
 S DIVFLAG=0
 S DGWD=$O(^DIC(42,"B",CLINIC,0))
 I DGWD S DGDV=$S('$D(^DIC(42,DGWD,0)):0,+$P(^(0),"^",11):$P(^(0),"^",11),1:$O(^DG(40.8,0)))
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
 N ZTRTN,ZTDESCO,ZTIO,ZTDTH,ZTSAVE,G
 ;
 S ZTRTN="INSCAN^DGQESC1"
 S ZTDESC="Download Inpatients to VIC work station via HL7"
 S ZTIO=""
 K ZTDTH
 ;D NOW^%DTC S ZTDTH=%
 F G="VAUTD","DFNARR","CNT" S:$D(@G) ZTSAVE(G)=""
 S ZTSAVE("VAUTD(")=""
 D ^%ZTLOAD
 Q
 ;
END ; -- End of Code
 Q
 ;

DGDEATH ;ALB/MRL/PJR-PROCESS DECEASED PATIENTS ; 10/27/04 9:45pm
 ;;5.3;Registration;**45,84,101,149,392,545,595,568,563,725,772**;Aug 13, 1993;Build 4
 ;
GET N DGMTI,DATA
 S DGDTHEN="" W !! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S (DA,DFN)=+Y
 S DGDOLD=$G(^DPT(DFN,.35))
 I $D(^DPT(DFN,.1)) W !?3,"Patient is currently in-house.  Discharge him with a discharge type of DEATH." G GET
 I $S($D(^DPT(DFN,.35)):^(.35),1:"") F DGY=0:0 S DGY=$O(^DGPM("ATID1",DFN,DGY)) Q:'DGY  S DGDA=$O(^(DGY,0)) I $D(^DGPM(+DGDA,0)),$P(^(0),"^",17)]"" S DGXX=$P(^(0),"^",17),DGXX=^DGPM(DGXX,0) I "^12^38^"[("^"_$P(DGXX,"^",18)_"^") G DIS
 D NOW^%DTC S DGNOW=%
 S ^TMP("DEATH",$J)=1
 K A W ! S DIE=DIC,DR=".351" D ^DIE
 I '$D(^DPT(DFN,.35)) K ^TMP("DEATH",$J) G GET
 S DGDNEW=^DPT(DFN,.35)
 I $P(DGDNEW,"^",1)="",$P(DGDNEW,"^",2)'="" S DR=".352////@" D ^DIE
 I $P(DGDNEW,"^",1)="" K ^TMP("DEATH",$J) G GET
SN I $P(DGDNEW,"^",1)'="" S DR=".353" D ^DIE I $P($G(^DPT(DFN,.35)),"^",3)']"" D SNDISP G SN
 I DGDOLD'=DGDNEW D DISCHRGE
 I $P(DGDOLD,"^",1)'=$P(DGDNEW,"^",1) D XFR
 K ^TMP("DEATH",$J) G GET
 ;
DIS W !,"Patient has a discharge type of Death",!,"Edit the discharge",!
Q K A,DA,DFN,DGDA,DIC,DIE,DR,DGXX,DGY,DGDTHEN,DGDOLD,DGDNEW,DGDONOT Q
XFR ; called from set x-ref of field .351 of file 2
 N DGPCMM,DGFAPT,DGFAPTI,DGFAPT1
 Q:'$D(DFN)
 K DGTEXT D ^DGPATV S DGDEATH=$$GET1^DIQ(2,DFN,.351,"I"),XMSUB="PATIENT HAS EXPIRED",DGCT=0
 D DEMOG
 S DGT=X-.0001,(Y,DGDDT)=X,DG1="" D:DGT]"" ^DGPMSTAT
 S Y=$$FMTE^XLFDT(Y),Y=$S(Y]"":Y,1:"UNKNOWN")
 S DGDONOT=0 D APTT3
 D LINE("")
 D LINE("      Date/Time of Death: "_DEATHVAL_$S(DGDONOT:"",'DG1:"",$D(DGDTHEN):"",1:"  (While an inpatient)"))
 D LINE("")
 I '$D(ADM),DG1,$D(^DGPM(+DGA1,0)) S ADM=+^DGPM($P(^(0),"^",14),0)
 S Y=$$FMTE^XLFDT($S($D(ADM):ADM,1:""))
 D LINE($S($D(DGDTHEN):"",DG1:"     Admission Date/Time: "_Y_$S((DGDDT-ADM)<1:"  (Within 24 hours of hospitalization)",1:""),1:""))
 D LINE("")
 S DGX=$P($G(^DGPM(+$G(DGA1),0)),"^",6),DGX=$P($G(^DIC(42,+DGX,0)),U,1)
 D LINE($S($D(DGDTHEN):"",('DG1):"",$D(DGA1):"             Admitted To: "_$S(DGX]"":DGX,1:"UNKNOWN"),1:"")) K DGX
 D LINE("")
 I DG1&'$D(DGDTHEN) D 
 . D LINE($S($D(DGXFR0):"           Last Transfer: "_$S($D(^DIC(42,+$P(DGXFR0,"^",6),0)):$P(^(0),"^"),1:"UNKNOWN"),1:""))
 . D LINE("")
F N DGARRAY,SDCNT S DGFAPT=DGDEATH,DGFAPTI=""
 S DGARRAY("FLDS")=3,DGARRAY(4)=DFN,DGARRAY("SORT")="P",DGARRAY(1)=DT,DGARRAY(3)="I;R"
 S SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 ;
 I SDCNT>0 F  S DGFAPT=$O(^TMP($J,"SDAMA301",DFN,DGFAPT)) Q:'DGFAPT  S DGFAPT1=$G(^TMP($J,"SDAMA301",DFN,DGFAPT)) Q:DGFAPT1']""  D  Q:DGFAPTI
 .I $P($P(DGFAPT1,U,3),";")'["C" D LINE("NOTE: Patient has future appointments scheduled!!") S DGFAPTI=1
 S DGSCHAD=0 D SA I DGSCHAD D LINE("NOTE: Patient had scheduled admissions which have been cancelled!!")
 I 'DGVETS D LINE("Patient is a NON-VETERAN."_$S($D(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)):"  ["_$P(^(0),"^",1)_"]",1:""))
 S DGPCMM=$$PCMMXMY^SCAPMC25(1,DFN,,,0) ;creates xmy array
 S DGCT=$$PCMAIL^SCMCMM(DFN,"DGTEXT",DT)
Q1 S DGB=1 D ^DGBUL S X=DGDEATH
 K DGDEATH,DGSCHAD,DGI,Y,DGDDT,^TMP($J,"SDAMA301") D KILL^DGPATV K ADM,DG1,DGA1,DGCT,DGT,DGXX,DGY,Z Q
SA F DGI=0:0 S DGI=$O(^DGS(41.1,"B",DFN,DGI)) Q:'DGI  I $D(^DGS(41.1,DGI,0)),($P(^(0),"^",13)']""),($P(^(0),"^",17)']"") S $P(^(0),"^",13)=DGDEATH,$P(^(0),"^",14)=+DUZ,$P(^(0),"^",15)=1,$P(^(0),"^",16)=2,DGSCHAD=1
 Q
 ;
DEL ; delete death bulletin
 N DGPCMM,DELBY,DELTM,DTHINFO
 S DFN=+$G(DA) I '$D(^DPT(DFN,0)) Q  ; no patient node
 I +$G(^DPT(DFN,.35)) Q  ; not deletion
 S DGDEATH=X,XMSUB="Patient Death has been Deleted",DGCT=0
 D ^DGPATV
 D LINE("The date of death for the following patient has been deleted.")
 D LINE("")
 D DEMOG
 D LINE("")
 S DGPCMM=$$PCMMXMY^SCAPMC25(1,DFN,,,0) ;creates xmy array
 S DGCT=$$PCMAIL^SCMCMM(DFN,"DGTEXT",DT)
 S DGB=1 D ^DGBUL S X=DGDEATH
 K DGCT,DGDEATH D KILL^DGPATV
 Q
 ;
DEMOG ; list main demographics
 D LINE("                    NAME: "_DGNAME)
 D LINE("                     SSN: "_$P(SSN,"^",2))
 D LINE("                     DOB: "_$P(DOB,"^",2))
 I DGVETS D
 . N DGX
 . S DGX=$G(^DPT(DFN,.31))
 . S DGLOCATN=$$FIND1^DIC(4,"","MX","`"_+$P(DGX,U,4)),DGLOCATN=$S(+DGLOCATN>0:$P($$NS^XUAF4(DGLOCATN),U),1:"NOT LISTED")
 . D LINE("   CLAIM FOLDER LOCATION: "_$S($D(DGLOCATN):DGLOCATN,1:"NOT LISTED"))
 . D LINE("            CLAIM NUMBER: "_$S($P(DGX,"^",3)]"":$P(DGX,"^",3),1:"NOT LISTED"))
 D LINE("   COORDINATING MASTER OF RECORD: "_DGCMOR)
 D GETS^DIQ(2,DFN_",",".351;.353;.354;.355","E","DTHINFO")
 S DEATHVAL=$G(DTHINFO(2,DFN_",",.351,"E"))
 S DEATHVAL=$$FMTE^XLFDT(DEATHVAL),DEATHVAL=$S(DEATHVAL]"":DEATHVAL,1:"UNKNOWN")
 S SOURCE=$G(DTHINFO(2,DFN_",",.353,"E"))
 S DELTM=$G(DTHINFO(2,DFN_",",.354,"E"))
 S DELBY=$G(DTHINFO(2,DFN_",",.355,"E"))
 D LINE("")
 D LINE("             LAST EDITED BY: "_DELBY)
 D LINE("    DATE/TIME LAST MODIFIED: "_DELTM)
 D LINE("     SOURCE OF NOTIFICATION: "_$S(SOURCE="":"UNDEFINED",1:SOURCE))
 ;K DEATHVAL,SOURCE,DELTM,DELBY
 Q
 ;
LINE(X) ; add line contained in X to array
 S DGCT=DGCT+1
 S DGTEXT(DGCT,0)=X
 Q
DSBULL ;
 ;
 I $G(IVMDODUP)=1 Q
 S DFN=DA
 I $D(DGPMDA) D  Q
 .S DISTYPE=$P($G(^DGPM(DGPMDA,0)),"^",18)
 .I $G(^DG(405.2,DISTYPE,0))["DEATH" D
 ..S FDA(2,DFN_",",.353)=1 D FILE^DIE(,"FDA","BWFERR")
 ..D DISCHRGE,XFR
 I $D(^TMP("DEATH",$J)) Q
 D DISCHRGE,XFR
 Q
DKBULL ;
 S DFN=DA
 S FDA(2,DFN_",",.353)="@"
 I $D(^TMP("DEATH",$J)) S FDA(2,DFN_",",.355)=DUZ
 D FILE^DIE(,"FDA",)
 D DEL
 Q
DISCHRGE ;
 ; If the patient is being discharged, determine values needed for 
 ; Source of Notification and Date/Time last entered.
 ;
 I '$D(DGNOW) S DGNOW=$$HTFM^XLFDT($H)
 I $G(DGDAUTO)'=1 S FDA(2,DFN_",",.354)=DGNOW
 S FDA(2,DFN_",",.355)=DUZ
 D FILE^DIE(,"FDA",)
 Q
APTT3 ;Check to exclude "While an Inpatient" from DOD Bulletin
 ; Input:  DFN  Output: DGDONOT
 N DATE,XIEN,TYPE,XDOD,YES
 S DGDONOT=0
 S XDOD=$P($G(^DPT(DFN,.35)),"^",1) I 'XDOD Q
 S XDOD=$P(XDOD,".",1),YES=0,TYPE=""
 I '$D(^DGPM("APTT3",DFN)) Q
 S DATE=$O(^DGPM("APTT3",DFN,XDOD)) I 'DATE Q
 I $P(DATE,".",1)=XDOD S YES=1
 I ($P(DATE,".",1)-1)=XDOD S YES=1
 S XIEN=$O(^DGPM("APTT3",DFN,DATE,"")) I 'XIEN Q
 S TYPE=$P($G(^DGPM(XIEN,0)),"^",4)
 I YES,'((TYPE=27)!(TYPE=32)) S DGDONOT=1
 Q
SNDISP ; Source of Notification display choices
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,DGLIST,DGLNAME,I,X,Y
 S DGLIST=$P($G(^DD(2,.353,0)),"^",3)
 S Y=6
 S DIR("?",1)=" "
 S DIR("?",2)=" This is a required response. Please select from the following:"
 S DIR("?",3)=" Entering '^' will take you back to the Source of Notification prompt"
 S DIR("?",4)=" "
 S DIR("?",5)=" "
 F X=1:1 S DGLNAME=$P(DGLIST,";",X) Q:DGLNAME']""  S DIR("?",Y)="      "_$P(DGLNAME,":",1)_"      "_$P(DGLNAME,":",2) S Y=Y+1
 S DIR("?",Y)=" "
 F I=1:1 Q:'$D(DIR("?",I))  W !,DIR("?",I)
 Q

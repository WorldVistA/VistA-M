SPNFAP1 ;SAN/WDE/Print routine for pts with future appt's
 ;;2.0;Spinal Cord Dysfunction;**13,24**;01/02/1997
 ; Prints patients with future appts
 ;
EN ;
 K ^UTILITY($J)
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
DATE ;
 K %DT
 S Y=DT X ^DD("DD") S SPNDEF=$P(Y,"@",1)
 S %DT("A")="Enter a START date: "
 S %DT("B")=SPNDEF
 S %DT="AE"
 D ^%DT I Y=-1 W !,"Option aborted!" D ZAP Q
 S SPNSTRT=Y
 ;ending date
 S %DT("A")="Enter a ENDING date: "
 S %DT(0)=SPNSTRT
 S X1=SPNSTRT,X2=15 D C^%DTC S Y=X X ^DD("DD") S %DT("B")=$P(Y,"@",1)
 S %DT="AE"
 D ^%DT I Y=-1 W !,"Option aborted!" D ZAP Q
 S SPNEND=Y_.2359
PROMPT ;
 ;ask if they want only pt in the reg..
 ;ask if they want only pts with a sci indicator in file 2..
 ;ask if they want both,  Pts in 154 and pts in 2 with an indicator
 K DIR S DIR(0)="SOM^1:Patients in the Registry only.;2:Patients marked as SCI but not in the Registry.;3:Both."
 D ^DIR
 I (Y="^")!('+Y) D ZAP Q
 S SPNSEL=Y
 S SPNCNT=0
 I SPNSEL'=1 W !!,"This report should be queued to run during off hours.",!
DEV S ZTSAVE("SPN*")=""
 D DEVICE^SPNPRTMT("JUMPIN^SPNFAP1","Patients with future Appointments",.ZTSAVE) Q:SPNLEXIT
TASK ;
 I SPNIO="Q" D ZAP Q  ;queued from spnprtmt
JUMPIN ;
 ;
 U IO
 S SPNCNT=0
 I SPNSEL=1 D SCDONLY
 I SPNSEL=1 D PRINT I $E(IOST,1)="P" W @IOF X ^%ZIS("C")
 I SPNSEL=1 I $E(IOST,1)="C" I SPNLEXIT'=1 N DIR S DIR(0)="E" D ^DIR W @IOF Q
 I SPNSEL=1 G ZAP Q:SPNLEXIT=1
 D BOTH D PRINT X ^%ZIS("C")
 I $E(IOST,1)="C" I SPNLEXIT'=1 N DIR S DIR(0)="E" D ^DIR W @IOF Q
 D ZAP
 K SPNLEXIT
 Q
ZAP ;****************************************************************
 K ^UTILITY($J),SPNEND,SPNSTRT,SPNSEL,Y,X,SPNDFN,SPNP2,SPNP3,SPNP4
 K SPNA,SPNQ,SPNIO,SPNCNT,SPNDFN,DATA,SPNCHK,SPNAPPT
 K SPNCL,SPNDT,SPNDATA,SPNTIM,SPNSSN,SPNPT
 K SDARRAY,SDCOUNT,SDDATE,SDCLIEN
 K %DT,SPNTAB
 Q
SCDONLY S SPNDFN=0,DATA="" F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:(SPNDFN="")!('+SPNDFN)  D
 .I '$$EN2^SPNPRTMT(SPNDFN) Q
 .D APPT
 Q
 ;--------------------------------------------------------------------
BOTH ;
 S SPNDFN=0 F  S SPNDFN=$O(^DPT(SPNDFN)) Q:(SPNDFN="")!('+SPNDFN)  D
 .I SPNSEL=3 I $D(^SPNL(154,SPNDFN,0)) Q:'$$EN2^SPNPRTMT(SPNDFN)  D APPT Q
 .S SPNCHK=$P($G(^DPT(SPNDFN,57)),U,4) I +SPNCHK D APPT
 .I $E(IOST,1)="C" I SPNDFN#100=62 W "."
 .Q
 Q
 ;---------------------------------------------------------------------
APPT ;
 I SPNSEL=2 Q:$D(^SPNL(154,SPNDFN,0))  ;pt file only pt is in 154
 S SPNCNT=SPNCNT+1 I $E(IOST,1)="C" I SPNCNT#10=0 W "."
 S SDARRAY(1)=SPNSTRT_";"_SPNEND
 S SDARRAY(3)="R"
 S SDARRAY(4)=SPNDFN
 S SDARRAY("FLDS")="1;2"
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT>0 D
 .S SDCLIEN=0 F  S SDCLIEN=$O(^TMP($J,"SDAMA301",SPNDFN,SDCLIEN)) Q:'+SDCLIEN  D
 ..S SDDATE=0 F  S SDDATE=$O(^TMP($J,"SDAMA301",SPNDFN,SDCLIEN,SDDATE)) Q:'+SDDATE  D
 ...S SDAPPT=$G(^TMP($J,"SDAMA301",SPNDFN,SDCLIEN,SDDATE))
 ...S SPNAPPT=$P($G(^TMP($J,"SDAMA301",SPNDFN,SDCLIEN,SDDATE)),U,1)
 ...S SPNCL=$P(SDAPPT,U,2) S SPNCL=$P(SPNCL,";",2)
 ...Q
 ..Q
 .I SPNSEL'=2 S SPNP2=$E($$GET1^DIQ(154,SPNDFN_",",.03),1,13),SPNP3=$E($$GET1^DIQ(154,SPNDFN_",",2.1),1,3),SPNP4=$E($$GET1^DIQ(154,SPNDFN_",",1.1),1,3)
 .I SPNSEL=2 S SPNP2="",SPNP3="",SPNP4=""
 .S ^UTILITY($J,$P(SPNAPPT,".",1),SPNAPPT,SPNCL,$P(^DPT(SPNDFN,0),U,1),$P(^DPT(SPNDFN,0),U,9))=SPNAPPT_"^"_SPNP2_"^"_SPNP3_"^"_SPNP4
 .S ^UTILITY($J,$P(SPNAPPT,".",1))=""
 I SDCOUNT<0 D
 .I $D(^TMP($J,"SDAMA301",101)) W !!,"Database unavailable. Try later."
 .I $D(^TMP($J,"SDAMA301",116)) W !!,"Pt doesn't exist in Vista system."
 .Q
 I SDCOUNT'=0 K ^TMP($J,"SDAMA301")
 Q
PRINT ;
 S SPNPA=1
 S Y=SPNSTRT X ^DD("DD") S SPNSTRT=Y S Y=SPNEND X ^DD("DD") S SPNEND=Y
 K Y
 D HDR
 I '$D(^UTILITY($J)) D
 .W !,"-----------------------------------------------------------------------------"
 .W !!?10,"**** No Data for this report. ****"  D  Q
 .I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR K Y
 .D CLOSE^SPNPRTMT
 .Q
 S SPNDT=0 F  S SPNDT=$O(^UTILITY($J,SPNDT)) Q:(SPNDT="")!('+SPNDT)  D P1 W !
 Q
 ;----------------------------------------------------------------------
P1 ;Get times of the appts for the given day
 S Y=SPNDT X ^DD("DD") W !,Y S Y="" W !,"-----------------------------------------------------------------------------"
 S SPNTIM=0 F  S SPNTIM=$O(^UTILITY($J,SPNDT,SPNTIM)) Q:(SPNTIM="")!('+SPNTIM)  D P2
 Q
P2 ;Get clinic
 S SPNCL="" F  S SPNCL=$O(^UTILITY($J,SPNDT,SPNTIM,SPNCL)) Q:SPNCL=""  D P3
 Q
 ;
P3 ;
 S SPNPT="" F  S SPNPT=$O(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT)) Q:SPNPT=""  S SPNSSN=0 F  S SPNSSN=$O(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT,SPNSSN)) Q:(SPNSSN="")!('+SPNSSN)  D PRT2
 Q
PRT2 ;
 S Y=$P(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT,SPNSSN),U,1) X ^DD("DD")
 W !,$P(Y,"@",2)
 W ?7,$E(SPNCL,1,20)
 W ?28,$E(SPNPT,1,17),?46,$E(SPNSSN,6,9)
 W ?53,$P(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT,SPNSSN),U,2)
 W ?67,$P(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT,SPNSSN),U,3)
 W ?73,$P(^UTILITY($J,SPNDT,SPNTIM,SPNCL,SPNPT,SPNSSN),U,4)
 I $Y>(IOSL-5) D HDR I SPNLEXIT S (SPNDT,SPNTIM,SPNCL,SPNCL,SPNSSN)="END" Q
 Q
HDR ;
 I $E(IOST,1)="P" I SPNPA'=1 W #
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPA=1 W @IOF Q
 .I SPNPA'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..K Y
 ..W @IOF
 ..Q
 .Q
 Q:SPNLEXIT
 S SPNTAB=$S(SPNSEL=1:18,SPNSEL=2:12,1:2)
 W !?SPNTAB,$S(SPNSEL=1:"Patients in the Registry only",SPNSEL=2:"Patients marked as SCI but not in the Registry",1:"Combined report -- Pts in Registry AND Pts marked as SCI but not in Registry")
 W !?18,"Listing appointments from ",?72,"Page: ",SPNPA
 W !?15,SPNSTRT," to ",SPNEND,!
 W !,"Appointment date"
 W !,"Time",?7,"Clinic",?28,"Patient",?46,"SSN",?53,"Reg",?67,"SCI",?73,"SCI"
 W !,?53,"Status",?67,"LVL",?71,"NETWRK"
 I SPNPA'=1 W !,"-----------------------------------------------------------------------------"
 S SPNPA=SPNPA+1

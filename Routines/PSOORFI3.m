PSOORFI3 ;BIR/RTR-finish CPRS orders by Clinic ;11/09/98
 ;;7.0;OUTPATIENT PHARMACY;**15,27,32,46,84,99,130,117,139,172,225,300**;DEC 1997;Build 4
 ;SC(-2675,40.8-728,51.2-2226,50.607-2221,55-2228,PSSLOCK-2789,DPT-10035,ORX2-867
 ;
 K ^TMP($J,"PSOCL"),^TMP($J,"PSOCLX"),PSOCLIN,PSOCLINF,PSOXINST
 N PSOCFLAG,PSONPTRX,PSOINPTR,PSCLP,PSOCLINS,PSOSTC,PSOLGD,PSODIEN,PSOCTMP
 K DIR S DIR(0)="SMB^C:CLINIC;S:SORT GROUP;E:EXIT",DIR("A")="Select By",DIR("B")="Clinic",DIR("?",1)="Enter 'C' to process orders for one individual Clinic,"
 S DIR("?",2)="      'S' to process orders for all Clinics associated with a Sort Group,",DIR("?",3)="      '^' or 'E' to exit" S DIR("?")=" "
 W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!(Y="E") W ! G EXIT
 I Y="S" G SORT
CLIN W ! K DIC S DIC="^SC(",DIC(0)="QEAMZ",DIC("A")="Select CLINIC: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G EXIT
 S PSOCLIN=+Y,PSOCLINF=1 D CHECK I $G(PSOCFLAG) D INSTNM^PSOORFI2 W !!,"You are signed in under the "_$G(PSODINST)_" CPRS Ordering",!,"Institution, which does not match the Institution for this Clinic!",! K PSODINST G CLIN
 S ^TMP($J,"PSOCL",PSOCLIN)=PSOCLIN K PSOCLIN G START
SORT W ! K DIC S DIC="^PS(59.8,",DIC(0)="QEAMZ",DIC("A")="Select CLINIC SORT GROUP: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G EXIT
 S PSOCLINS=+Y
 K ^TMP($J,"PSOCL"),^TMP($J,"PSOCLX") F PSCLP=0:0 S PSCLP=$O(^PS(59.8,PSOCLINS,1,PSCLP)) Q:'PSCLP  S PSOSTC=+$P($G(^PS(59.8,PSOCLINS,1,PSCLP,0)),"^") S:$G(PSOSTC)&($D(^SC(PSOSTC,0))) ^TMP($J,"PSOCL",PSOSTC)=PSOSTC
 I '$O(^TMP($J,"PSOCL",0)) W !!,"There are no Clinics associated with this Sort Group!",! K ^TMP($J,"PSOCL") G SORT
 F PSCLP=0:0 S PSCLP=$O(^TMP($J,"PSOCL",PSCLP)) Q:'PSCLP  S PSOCLIN=PSCLP D CHECK I $G(PSOCFLAG) S ^TMP($J,"PSOCLX",PSCLP)=PSCLP K ^TMP($J,"PSOCL",PSCLP)
 I $O(^TMP($J,"PSOCLX",0)) H 1 W @IOF W !,"Orders for these Clinics in the Sort Group will not be displayed for Finishing",!,"because the CPRS Ordering Institution does not match the Institution that is",!,"associated with the Clinic:",! D
 .F PSCLP=0:0 S PSCLP=$O(^TMP($J,"PSOCLX",PSCLP)) Q:'PSCLP  D:($Y+4)>IOSL  W !,$P($G(^SC(PSCLP,0)),"^")
 ..W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR W @IOF
 I $O(^TMP($J,"PSOCLX",0)) D EOP
 K ^TMP($J,"PSOCLX") I '$O(^TMP($J,"PSOCL",0)) W !!,"There are no Clinics that have a matching Institution!",! D EOP G SORT
 ;
 S PSOCLINF=2
START K MEDP,MEDA,PSOQUIT,POERR("QFLG"),POERR("DFLG"),DIR
 G:'$O(^TMP($J,"PSOCL",0)) EXIT
 S PATA=0 F PSOCLIN=0:0 S PSOCLIN=$O(^TMP($J,"PSOCL",PSOCLIN)) Q:'PSOCLIN!($G(POERR("QFLG")))  F PSOLGD=0:0 S PSOLGD=$O(^PS(52.41,"ACL",PSOCLIN,PSOLGD)) Q:'PSOLGD!($G(POERR("QFLG")))  D
 .F PSODIEN=0:0 S PSODIEN=$O(^PS(52.41,"ACL",PSOCLIN,PSOLGD,PSODIEN)) Q:'PSODIEN!($G(POERR("QFLG")))  D
 ..I $P($G(^PS(52.41,PSODIEN,0)),"^",3)'="NW",$P($G(^(0)),"^",3)'="RNW",$P($G(^(0)),"^",3)'="RF" Q
 ..I $G(PSOPINST)'=$P($G(^PS(52.41,PSODIEN,"INI")),"^") Q
 ..Q:$G(PAT($P(^PS(52.41,PSODIEN,0),"^",2)))=$P(^PS(52.41,PSODIEN,0),"^",2)  S PAT=$P(^PS(52.41,PSODIEN,0),"^",2)
 ..I PAT'=PATA,$O(PSORX("PSOL",0))!($D(RXRS)) D LBL^PSOORFIN
 ..D LK^PSOORFIN I $G(POERR("QFLG")) K POERR("QFLG") S PSOLK=1,PAT(PAT)=PAT Q
 ..I $$CHK^PSODPT(PAT_"^"_$P($G(^DPT(PAT,0)),"^"),1,1)<0 S PSOLK=1,PAT(PAT)=PAT S X=PAT D ULP^PSOORFIN Q
 ..S (PSODFN,Y)=PAT_"^"_$P($G(^DPT(+$G(PAT),0)),"^"),PATA=PAT
 ..D:'$G(MEDA) PROFILE^PSOORFI2 S Y=PSODFN I $G(MEDP) K PSOFIN S POERR("QFLG")=0 S PSONOLCK=1,PSOPTLOK=PAT D OERR^PSORX1 S PSOFIN=1 D QU^PSOORFIN S X=PSOPTLOK D KLLP^PSOORFIN,ULP^PSOORFIN,KLL^PSOORFIN Q
 ..D SDFN^PSOORFIN D POST^PSOORFI1 I $G(PSOQFLG)!($G(PSOQUIT)) S:$G(PSOQUIT) POERR("QFLG")=1 S:$G(PSOQFLG) PAT(PAT)=PAT S X=PAT D ULP^PSOORFIN K PSOQFLG Q
 ..S PAT(PAT)=PAT
 ..F ORD=0:0 S ORD=$O(^PS(52.41,"AOR",PAT,PSOPINST,ORD)) Q:'ORD!($G(POERR("QFLG")))  I '$P($G(^PS(52.41,ORD,0)),"^",23) D
 ...S PSODFN=PAT D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2)
 ...D LK1^PSOORFIN,ORD^PSOORFIN S X=PAT D ULP^PSOORFIN
 I $O(PSORX("PSOL",0))!($D(RXRS)) D LBL^PSOORFIN
 ;
EXIT K ^TMP($J,"PSOCL"),^TMP($J,"PSOCLX"),PSOCLIN,PSOCLINF,PSOXINST G EX^PSOORFIN
 Q
CHECK ; check Institution
 K PSOXINST,PSOCFLAG
 I $P($G(^SC(PSOCLIN,0)),"^",4),$P($G(^(0)),"^",4)'=$G(PSOPINST) S PSOCFLAG=1 Q
 I $P($G(^SC(PSOCLIN,0)),"^",4) Q
 S PSONPTRX=$P($G(^SC(PSOCLIN,0)),"^",15)
 I '$G(PSONPTRX) S PSONPTRX=$O(^DG(40.8,0))
 I '$G(DT) S DT=$$DT^XLFDT
 S PSOINPTR=+$$SITE^VASITE(DT,PSONPTRX) I PSOINPTR'=$G(PSOPINST) S PSOCFLAG=1
 Q
EOP W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 Q
L1 ;Lock single order
 I '$G(ORD) Q
 K PSOMSG D PSOL^PSSLOCK(+ORD_"S") I '$G(PSOMSG) W !!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"This Order is being edited by another person."),! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 Q
UL1 ;Unlock single order
 I '$G(ORD) Q
 I '$D(^PS(52.41,ORD,0)) D  Q
 . D UNLK1^ORX2(+$G(OR0))
 . Q
 D PSOUL^PSSLOCK(+ORD_"S")
 Q
DOSE ;pending orders
 K DOENT S DS=1
 F I=0:0 S I=$O(^PS(52.41,ORD,1,I)) Q:'I  S DOSE=$G(^PS(52.41,ORD,1,I,1)),DOSE1=$G(^(2)) D  D DOSE1
 .S PSONEW("DOSE",I)=$P(DOSE1,"^"),PSONEW("DOSE ORDERED",I)=$P(DOSE1,"^",2),PSONEW("UNITS",I)=$P(DOSE,"^",9),PSONEW("NOUN",I)=$P(DOSE,"^",5)
 .S:$P(DOSE,"^",9) UNITS=$P(^PS(50.607,$P(DOSE,"^",9),0),"^")
 .S PSONEW("VERB",I)=$P(DOSE,"^",10),PSONEW("ROUTE",I)=$P(DOSE,"^",8)
 .S:$P(DOSE,"^",8) ROUTE=$P(^PS(51.2,$P(DOSE,"^",8),0),"^")
 .S PSONEW("SCHEDULE",I)=$P(DOSE,"^"),PSONEW("DURATION",I)=$P(DOSE,"^",2)
 .S DOENT=$G(DOENT)+1 S PSONEW("CONJUNCTION",I)=$S($P(DOSE,"^",6)="A":"AND",$P(DOSE,"^",6)="S":"THEN",$P(DOSE,"^",6)="X":"EXCEPT",1:"")
 .I 'PSONEW("DOSE ORDERED",I),$G(PSONEW("VERB",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Verb: "_$G(PSONEW("VERB",I))
 .S:$G(DS) IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (3)"
 S PSONEW("ENT")=DOENT K DOSE,DOSE1,I,UNITS,ROUTE,DOENT
 Q
DOSE1 I $G(DS)=1 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"        *Dosage:" D FMD G DU
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="            *Dosage:" D FMD
DU I 'PSONEW("DOSE ORDERED",I),$P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Oth. Lang. Dosage: "_$G(PSONEW("ODOSE",I))
 I PSONEW("DOSE ORDERED",I),$G(PSONEW("VERB",I))]"" D
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Verb: "_$G(PSONEW("VERB",I))
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="     Dispense Units: "_$S($E(PSONEW("DOSE ORDERED",I),1)=".":"0",1:"")_PSONEW("DOSE ORDERED",I)
 I PSONEW("NOUN",I) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Noun: "_PSONEW("NOUN",I)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="             *Route: "_$G(ROUTE)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          *Schedule: "_PSONEW("SCHEDULE",I)
 I $P(DOSE,"^",2)]"" D
 .S DUR=$S($E($P(DOSE,"^",2),1)'?.N:$E($P(DOSE,"^",2),2,99)_$E($P(DOSE,"^",2),1),1:$P(DOSE,"^",2))
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          *Duration: "_DUR_" ("_$S($P(DOSE,"^",2)["M":"MINUTES",$P(DOSE,"^",2)["H":"HOURS",$P(DOSE,"^",2)["L":"MONTHS",$P(DOSE,"^",2)["W":"WEEKS",1:"DAYS")_")"
 I $P(DOSE,"^",6)]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       *Conjunction: "_$S($P(DOSE,"^",6)="A":"AND",$P(DOSE,"^",6)="S":"THEN",$P(DOSE,"^",6)="X":"EXCEPT",1:"")
 Q
DOSE2 ;displays pending order after edits
 S DS=1
 F I=1:1:PSONEW("ENT") Q:'I  D  D DOSE3 K COJ
 .S:$G(PSONEW("UNITS",I))]"" UNITS=$P(^PS(50.607,PSONEW("UNITS",I),0),"^") S:$G(PSONEW("ROUTE",I))]"" ROUTE=$P(^PS(51.2,PSONEW("ROUTE",I),0),"^")
 .S DUR=$G(PSONEW("DURATION",I)) S:$G(PSONEW("CONJUNCTION",I))]"" COJ=PSONEW("CONJUNCTION",I)
 .S NOUN=PSONEW("NOUN",I),VERB=$G(PSONEW("VERB",I))
 .I 'PSONEW("DOSE ORDERED",I),$P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Oth. Lang. Dosage: "_$G(PSONEW("ODOSE",I))
 .I '$G(PSONEW("DOSE ORDERED",I)),$G(PSONEW("VERB",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Verb: "_$G(PSONEW("VERB",I))
 .S:$G(DS) IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (3)"
 K I,UNITS,ROUTE,DUR,COJ,VERB,NOUN
 Q
DOSE3 I $G(DS)=1 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"        *Dosage:" D FMD G DO
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="            *Dosage:" D FMD
DO I 'PSONEW("DOSE ORDERED",I),$P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Oth. Lang. Dosage: "_$G(PSONEW("ODOSE",I))
 I $G(PSONEW("DOSE ORDERED",I)),$G(PSONEW("VERB",I))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               Verb: "_$G(PSONEW("VERB",I))
 I $G(PSONEW("DOSE ORDERED",I)) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="     Dispense Units: "_$S($E(PSONEW("DOSE ORDERED",I),1)=".":"0",1:"")_PSONEW("DOSE ORDERED",I)
 I $G(PSONEW("DOSE ORDERED",I)) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="               NOUN: "_PSONEW("NOUN",I)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="             *Route: "_$G(ROUTE)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          *Schedule: "_PSONEW("SCHEDULE",I)
 I $G(DUR)]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          *Duration: "_DUR_" ("_$S(DUR["M":"MINUTES",DUR["H":"HOURS",DUR["L":"MONTHS",DUR["W":"WEEKS",1:"DAYS")_")"
 I $G(COJ)]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       *Conjunction: "_$S(COJ="A":"AND",COJ="T":"THEN",COJ="X":"EXCEPT",1:"")
 Q
FMD Q:$G(PSONEW("DOSE",II))']""  S MIG=PSONEW("DOSE",II)
 I $E(MIG,1)=".",$G(PSONEW("DOSE ORDERED",II)) S MIG="0"_MIG
 F SG=1:1:$L(MIG," ") S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " S ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(MIG," ",SG)
 I $G(UNITS)]"" S:$L(^TMP("PSOPO",$J,IEN,0)_" ("_UNITS_")")>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " S ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" ("_UNITS_")"
 K DS,MIG,SG
 I '$G(PSONEW("DOSE ORDERED",II)),$P($G(^PS(55,PSODFN,"LAN")),"^") D LAN^PSOORED5
 Q
SQR ;
 D SQR^PSOORFIN
 Q
SQN ;
 K MAXRF,PSOSIG,MPSDY,PSOMAX,STA,PSORX0,ORCHK,ORDRG
 I $G(PSOQUIT) S PSOQQ=1 K PSOQUIT
 Q

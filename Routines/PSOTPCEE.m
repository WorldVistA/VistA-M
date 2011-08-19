PSOTPCEE ;BIR/MHA-transitional pharmacy benefit enter/edit ;07/01/03
 ;;7.0;OUTPATIENT PHARMACY;**145,153,227,268**;DEC 1997;Build 9
 ;;External reference to SDPHARM1 supported by DBIA 4196
 ;;External reference ^DIC(4 supported by DBIA 2251
 Q  ;placed out of order by PSO87*227
ST N PSODFN,FLG,PSODF,FI,INST,SNO,CDT,UL S FI=52.91,$P(UL,"=",79)="="
PT K DIC,DIE,PSODFN,FLG,PSODF,REC,INST,SNO,CDT
 W ! S (DIC,DIE)=52.91,DIC(0)="QEALM",DLAYGO=FI
 ;S DIC("W")="W ?15,$$GET1^DIQ(2,+Y,.01)"
 D ^DIC G:+Y'>0 PTX S FLG=$P(Y,"^",3)
 S (PSODFN,DA)=+Y,DR=.351,DIC=2,DIQ="PSODF" D EN^DIQ1 K DIC,DR,DIQ
 I $G(PSODF(2,DA,.351))]"",FLG D  G PT
 .W !!?10,$C(7),"Patient died on "_PSODF(2,PSODFN,.351)_" - Cannot be added to file!!",!
 .S DIK="^PS(52.91," D ^DIK K DIK
 L +^PS(FI,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W $C(7),!!,"Patient Data is Being Edited by Another User!",! G PT
 S (INST,SNO)="" D:FLG
 .S X=$$DEF^SDPHARM1(DA) S:X INST=$P(X,"^"),SNO=$P(X,"^",2)
 .S DR="1////"_DT_";5////M;6////"_SNO_";7////"_INST D ^DIE
INS S REC=$G(^PS(FI,DA,0))
 S DR="7" D ^DIE I $D(Y)!($D(DTOUT)) D:FLG RM L -^PS(FI,DA) G PT
 I X,X'=$P(REC,"^",8) S $P(REC,"^",7)=$P($G(^DIC(4,X,99)),"^"),DR="6////"_$P($G(^DIC(4,X,99)),"^") D ^DIE
 S DR="6" D ^DIE I $D(Y)!($D(DTOUT)) D:FLG RM L -^PS(52.91,DA) G PT
 I X,X'=$P(REC,"^",7),$$IEN^XUAF4(X) S DR="7////"_$$IEN^XUAF4(X) D ^DIE G INS
 S CDT=$P(REC,"^",3)
 S DR="2" D ^DIE I $D(Y)!($D(DTOUT)) L -^PS(FI,DA) G PT
 I CDT,X="" S DR="3////@" D ^DIE W !,"INACTIVATION REASON CODE: " G CONT
 I X S DR="3R",DIE("NO^")="" D ^DIE I $D(DTOUT) S DR="3////3" D ^DIE L -^PS(FI,DA) G PT
CONT L -^PS(FI,DA)
 S Y=$S(FLG:DT,1:$P(REC,"^",2)) X ^DD("DD")
 W !!,UL,!,"DATE PHARMACY BENEFIT BEGAN: "_Y
 S Y=$P(REC,"^",6),Y=$S(Y="E":"EWL",Y="S":"SCHEDULED APPOINTMENT",Y="X":"EWL & SCHEDULED APPOINTMENT",Y="M":"MANUAL",1:"")
 W ?42,"WAIT TYPE: "_Y
 S Y=$P(REC,"^",5) I Y X ^DD("DD")
 W !,"DESIRED APPOINTMENT DATE: "_Y
 W !,"EXCLUSION REASON: " S Y=$P(REC,"^",9)
 W:Y=1 "ACTIVE RX"
 W:Y=2 "ACTUAL APPT. < 30 DAYS FROM DATE APPT. MADE"
 W:Y=3 "ACTIVE RX & ACTUAL APPT. < 30 DAYS FROM DATE APPT. MADE"
 S Y=$P(REC,"^",10) I Y X ^DD("DD")
 W !,"PRIMARY CARE SCHEDULE APT DATE: "_Y_"   "_"RX #: "_$P(REC,"^",11)
 S Y=$P(REC,"^",12) I Y X ^DD("DD")
 W !,"DATE LETTER PRINTED: "_Y,!,UL
 G PT
PTX K DIC,DIE,%DT,DR,DA Q
RM ;
 ;W !?10,$C(7),"Required Data - Setting patient as Inactive"
 ;S DR="2////"_DT_";3////3" D ^DIE
 W !!,$C(7),"Required Data - deleting patient entry from TPB ELIGIBILITY (#52.91) File."
 K DIK S DIK="^PS(52.91,",DA=PSODFN D ^DIK K DIK,^PS(52.91,"AX",DT,DA)
 Q

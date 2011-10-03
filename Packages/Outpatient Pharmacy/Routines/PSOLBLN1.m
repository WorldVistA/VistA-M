PSOLBLN1 ;BIR/BHW - NEW LABEL CONTINUED ;03/14/94
 ;;7.0;OUTPATIENT PHARMACY;**5,30,71,107,110,162**;DEC 1997
 ;External reference to ^PS(54 supported by DBIA 2227
START W !,?54,$S($L($G(COPAYVAR)):$G(COPAYVAR)_"     ",1:""),"Days Supply: ",$G(DAYS),?102,"Mfg "_$G(MFG)_" Lot# "_$G(LOT)
 I 'PRTFL G NORENW
 ;NO REFILLS
 W !,$P(PS,"^",2),?102,"Tech__________RPh__________"
 W !,$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP)
 I $G(PSOBARS),$P(PSOPAR,"^",19)'=1 S X="S",X2=PSOINST_"-"_RX S X1=$X W ?54,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0
 E  W !!!!
 W "FORWARDING SERVICE REQUESTED",?54,"* NO REFILLS REMAINING ** PHYSICIAN USE ONLY *",! W:"C"[$E(MW) ?21,"CERTIFIED MAIL" W ?54,"*Signature:____________________________SC NSC*"
 W !,?54,"*Print Name:",ULN,"*",! W $S($G(PS55)=2:"***DO NOT MAIL***",1:"***CRITICAL MEDICAL SHIPMENT***") W ?54,"*DEA or VA#_________________Date_____________*",?102,"Routing: "_$S("W"[$E(MW):MW,1:MW_" MAIL")
 W !,?54,"*Refills: 0 1 2 3 4 5 6 7 8 9 10 11",?99,"*",?102,"Days Supply: ",$G(DAYS)," Cap: ",$S(PSCAP:"**NON-SFTY**",1:"SAFETY")
 W !,?54,"***** To be filled in VA Pharmacies only *****",?102,"Isd: ",ISD," Exp: ",EXPDT,!,PNM,?54,$G(VAPA(1)),?102,"Last Fill: ",$G(PSOLASTF)
 W !,$S($D(PSMP(1)):PSMP(1),1:VAPA(1)),?54,$G(ADDR(2)),?102,"Pat. Stat ",PATST," Clinic: ",PSCLN
 W !,$S($D(PSMP(2)):PSMP(2),$D(PSMP(1)):"",1:$G(ADDR(2))),?54,$G(ADDR(3)),?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$S($D(PSMP(3)):PSMP(3),$D(PSMP(1)):"",1:$G(ADDR(3))),?54,$G(ADDR(4))
 W !,$S($D(PSMP(4)):PSMP(4),$D(PSMP(1)):"",1:$G(ADDR(4))),?54,"*Indicate address change on back of this form",!,?54,"[ ] Permanent [ ] Temporary until ",$S($P($G(VAPA(10)),"^",2)]"":$P($G(VAPA(10)),"^",2),1:"__/__/__")
 I $G(PSOBARS) S X="S",X2=PSOINST_"-"_RX S X1=$X W ?102,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0
 Q
NORENW ;NO RENEW
 W !,$P(PS,"^",2),?102,"Tech__________RPH__________"
 W !,$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP)
 I $G(PSOBARS),$P(PSOPAR,"^",19)'=1 S X="S",X2=PSOINST_"-"_RX S X1=$X W ?54,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0
 E  W !!!!
 W "FORWARDING SERVICE REQUESTED",?54,"*** This prescription CANNOT be renewed ***",! W:"C"[$E(MW) ?21,"CERTIFIED MAIL" W ?54,"*",?96,"*",!,?54,"*     A NEW PRESCRIPTION IS REQUIRED      *"
 W !,$S($G(PS55)=2:"***DO NOT MAIL***",1:"***CRITICAL MEDICAL SHIPMENT***"),?54,"*",?96,"*",!,?54,"***** Please contact your physician *******"
 W !,?54,$G(VAPA(1)),?102,"Routing: "_$S("W"[$E(MW):MW,1:MW_" MAIL"),!,?54,$G(ADDR(2)),?102,"Days supply: ",$G(DAYS)," Cap: ",$S(PSCAP:"**NON-SFTY**",1:"SAFETY")
 W !,PNM,?54,$G(ADDR(3)),?102,"Isd: ",ISD," Exp: ",EXPDT
 W !,$S($D(PSMP(1)):PSMP(1),1:VAPA(1)),?54,$G(ADDR(4)),?102,"Last Fill: ",$G(PSOLASTF)
 W !,$S($D(PSMP(2)):PSMP(2),$D(PSMP(1)):"",1:$G(ADDR(2))),?54,"*Indicate address change on back of this form",?102,"Pat. Stat ",PATST," Clinic: ",PSCLN
 W !,$S($D(PSMP(3)):PSMP(3),$D(PSMP(1)):"",1:$G(ADDR(3))),?54,"[ ] Permanent [ ] Temporary until ",$S($P($G(VAPA(10)),"^",2)]"":$P($G(VAPA(10)),"^",2),1:"__/__/__"),?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$S($D(PSMP(4)):PSMP(4),$D(PSMP(1)):"",1:$G(ADDR(4))) I $G(PSOBARS) S X="S",X2=PSOINST_"-"_RX S X1=$X W ?102,@PSOBAR1,X2,@PSOBAR0,$C(13) S $X=0
 Q
ALLWARN ;ALLERGIES WITH DRUG WARNING
 I $G(PSOBLALL),$P(PPL,",",PI+1)'="" D WARN^PSOLBL2 Q
 K ^TMP($J,"PSOWARN"),^TMP($J,"PSOWPT"),^TMP($J,"PSOAPT"),PSONKA,PSONULL
 X "N X S X=""GMRADPT"" X ^%ZOSF(""TEST"") Q" I '$T D WARN^PSOLBL2 Q
 F WWW=1:1 Q:$P(WARN,",",WWW,99)=""  S PSOWARN=$P(WARN,",",WWW) D:$D(^PS(54,PSOWARN,0))
 . ;BHW;Modify Loop to use $O instead of 1:1
 . S JJJ=0
 . F  S JJJ=$O(^PS(54,PSOWARN,1,JJJ)) Q:('JJJ)  D
 . . I $D(^PS(54,PSOWARN,1,JJJ,0)) S ^TMP($J,"PSOWARN",PSOWARN,JJJ)=^PS(54,PSOWARN,1,JJJ,0)
 . . Q
 . Q
 S ^TMP($J,"PSOWPT",1)=PNM,^(2)="Rx# "_RXN,^(3)=DRUG,^(4)="DRUG WARNING:"
 S WCNT=4 F WWW=0:0 S WWW=$O(^TMP($J,"PSOWARN",WWW)) Q:'WWW  F RRR=0:0 S RRR=$O(^TMP($J,"PSOWARN",WWW,RRR)) Q:'RRR  S WCNT=WCNT+1 S ^TMP($J,"PSOWPT",WCNT)=^TMP($J,"PSOWARN",WWW,RRR)
 K ^TMP($J,"ALWA")
 S GMRA="0^0^111" D ^GMRADPT I $G(GMRAL) F PSORY=0:0 S PSORY=$O(GMRAL(PSORY)) Q:'PSORY  S ^TMP($J,"ALWA",$S($P(GMRAL(PSORY),"^",4):1,1:2),$S('$P(GMRAL(PSORY),"^",5):1,1:2),$P(GMRAL(PSORY),"^",7),$P(GMRAL(PSORY),"^",2))=""
 S ^TMP($J,"PSOAPT",1)=$G(PNM)_"  "_$G(SSNP),^(2)="",^(3)="Verified Allergies",^(4)="------------------"
 S ALCNT=4,EEE=0,(PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"ALWA",1,1,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"ALWA",1,1,PSOLG,PSOLGA)) Q:PSOLGA=""  S EEE=1,ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_PSOLGA
 I EEE S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 I 'EEE D
 .I $G(GMRAL)=0 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_"NKA",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 .E  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="Non-Verified Allergies",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="----------------------"
 S EEE=0,(PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"ALWA",2,1,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"ALWA",2,1,PSOLG,PSOLGA)) Q:PSOLGA=""  S EEE=EEE+1,ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_PSOLGA
 I EEE S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 I 'EEE D
 .I $G(GMRAL)=0 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_"NKA",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 .E  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)=""
 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="Verified Adverse Reactions",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="--------------------------"
 S (PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"ALWA",1,2,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"ALWA",1,2,PSOLG,PSOLGA)) Q:PSOLGA=""  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_PSOLGA
 S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="Non-Verified Adverse Reactions",ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="------------------------------"
 S (PSOLG,PSOLGA)="" F  S PSOLG=$O(^TMP($J,"ALWA",2,2,PSOLG)) Q:PSOLG=""  F  S PSOLGA=$O(^TMP($J,"ALWA",2,2,PSOLG,PSOLGA)) Q:PSOLGA=""  S ALCNT=ALCNT+1,^TMP($J,"PSOAPT",ALCNT)="  "_PSOLGA
PRT D PRINT^PSOLBL2
 Q

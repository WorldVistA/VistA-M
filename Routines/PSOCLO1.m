PSOCLO1 ;BHAM ISC/SAB - clozaril rx lockout routine ; 20 Apr 1999  10:50 AM
 ;;7.0;OUTPATIENT PHARMACY;**1,23,37,222**;DEC 1997;Build 12
 ;External reference YSCLTST2 supported by DBIA 4556
 ;External reference ^PS(55 supported by DBIA 2228
 ;MH package will authorize dispensing of the Clozapine drugs
 K ANQDATA,ANQX,ANQNO,PSONEW("SAND"),^TMP($J,"PSO")
 N X,Y,%,%DT,J,ANQ,ANQD,ANQJ,ANQRE,DTOUT,DUOUT,DIR,DIRUT,PSOYS
 I '$D(^PS(55,DFN,"SAND")) W !!,"*** This patient has not been registered in the clozapine program ***" G END
 I $P(^PS(55,DFN,"SAND"),"^")="" W !!,"*** This patient has no clozapine registration number ***" G END
 I $P(^PS(55,DFN,"SAND"),"^",2)="D" D  G END
 .W !!,"*** This patient has been discontinued from the clozapine treatment program ***"
 .W !,"*** and must have a new registration number assigned ***"
 S PSOYS=$$CL^YSCLTST2(DFN)
 G:+PSOYS<0 END
 S CLOZPAT=$P(PSOYS,"^",7),CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 G:$P(PSOYS,"^")=0 OV1
 D DSP  G:+PSOYS=1 GDOSE
 S X=$S(CLOZPAT=2:84,CLOZPAT=1:42,1:21)
 D CL1^YSCLTST2(DFN,X)
 I $D(^TMP($J,"PSO")) G CHECK
OV1 I $$OVERRIDE^YSCLTST2(DFN) S ANQRE=7 W !!,"Permission to dispense clozapine has been authorized by NCCC",! G OVRD
 D MSG4,MSG3,MH G QU
 Q
CHECK ;
 S ANQRE=$S($P(PSOYS,"^",2)<3500:3,1:5)
 S ANQD(1)=9999999-$P(PSOYS,"^",6),X1=$P(PSOYS,"^",6),X2="-6" D C^%DTC S ANQD=(9999999-$P(X,"."))
 S ANQ(1)=$P(PSOYS,"^",2)_"^"_$P(PSOYS,"^",4) D
 .F ANQJ=2:1:4 S ANQD=$O(^TMP($J,"PSO",ANQD)) Q:'ANQD  S ANQ(ANQJ)=^(ANQD),ANQD(ANQJ)=ANQD
 S ANQD=$O(ANQ(""),-1)
 I ANQD<2 W !,"*** No previous results to display ***",! G OVRD
 W !,"*** Last "_$S(ANQD=4:"Four ",ANQD=3:"Three ",1:"TWO ")_$P(PSOYS,"^",3)_" and ANC results were:"
 W !,?39,"WBC    ANC",!
 F ANQJ=ANQD:-1:1 S ANQD=9999999-ANQD(ANQJ)_"0000" W ?5,$E(ANQD,4,5)_"/"_$E(ANQD,6,7)_"/"_($E(ANQD,1,3)+1700) W:ANQD["." "@",$E(ANQD,9,10),":",$E(ANQD,11,12) W ?29,"Results: "_$P(ANQ(ANQJ),"^")_" - "_$P(ANQ(ANQJ),"^",2),!
OVRD ;
 I '$D(^XUSEC("PSOLOCKCLOZ",DUZ)) D  G EXIT
 .S ANQX=1 W !,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key."
 I ANQRE W !,"Override reason being: "_$P($T(@(ANQRE_"^PSOCLO1")),";;",2),!
 S DIR("A")="Do you want to override and issue this prescription",DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I 'Y!($D(DIRUT)) S ANQX=1 G EXIT
 S DIC=200,DIC(0)="AEQM",DIC("A")="Approving member of the Clozapine team: ",DIC("S")="I $D(^XUSEC(""PSOLOCKCLOZ"",+Y)),+Y'=DUZ" D ^DIC K DIC S ANQD=+Y I Y<0 S ANQX=1 G EXIT
 S DIR(0)="52.52,5",DIR("A")="Remarks"
 D ^DIR K DIR G EXIT:$D(DIRUT)
 S ANQX=0,ANQDATA=DUZ_"^"_ANQD_"^"_ANQRE_"^"_X
 ;
GDOSE ; set variable to ask daily dose
 N PSOCD
DOSE ;
 S DIR(0)="N^12.5:3000:1",DIR("A")="CLOZAPINE dosage (mg/day) ? " D ^DIR K DIR G EXIT:$D(DIRUT)
 S PSOCD=X
 I PSOCD#25=0,PSOCD'<12.5,PSOCD<900 G EXIT
 I PSOCD#12.5 S DIR(0)="Y",DIR("B")="NO",DIR("A")=PSOCD_" is an unusual dose.  Are you sure " D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
 I PSOCD>900 S DIR(0)="Y",DIR("A")="Recommended maximum daily dose is 900. Are you sure " D ^DIR K DIR G EXIT:$D(DIRUT) I 'Y G DOSE
EXIT ;
 K ^TMP($J,"PSO")
 S:$D(DIRUT) ANQX=1
 I $G(ANQX) W !!,"No Prescription entered!" K ANQDATA
 E  S PSONEW("SAND")=PSOCD_"^"_$P(PSOYS,"^",2)_"^"_($P($P(PSOYS,"^",6),"."))_"^"_$P(PSOYS,"^",4)
 D DIR
 Q
MSG3 ;
 W !!,"A CBC/Differential including WBC and ANC Must Be Ordered and Monitored on a",!
 W "Twice weekly basis until the WBC STABILIZES above 3500/mm3 and ANC above",!
 W "2000/mm3 with no signs of infection.",!
 Q
MSG4 ;
 W !!,"Permission to dispense clozapine has been denied. If the results of the latest"
 W !,"Lab Test drawn in the past 7 days show WBC>3000/mm3 and ANC>1500/mm3 and"
 W !,"you wish to dispense outside the FDA and VA protocol WBC/ANC limits, document"
 W !,"your request to Director of the VA National Clozapine Coordinating Center"
 W !,"(Phone: 214-857-0068 Fax: 214-857-0339) for a one-time override permission."
 Q
MSG5 ;
 W !!,"Permission to dispense clozapine has been denied. Please contact the"
 W !,"Director of the VA National Clozapine Coordinating Center"
 W !,"(Phone: 214-857-0068 Fax: 214-857-0339)."
 Q
MH       ;
 W !,"Also make sure that the LAB tests, WBC and ANC are set up correctly in the"
 W !,"Mental Health package using the CLOZAPINE MULTI TEST LINK option."
 Q
DSP ;
 W !,"*** Most recent "_$P(PSOYS,"^",3)_" and "_$P(PSOYS,"^",5)_" (ANC) results ***"
 W !,"     performed on "
 S Y=$P(PSOYS,"^",6) X ^DD("DD") W $P(Y,"@")_" are: "
 W !!,?5,$P(PSOYS,"^",3)_": "_$P(PSOYS,"^",2)
 W !,?5,"ANC: "_$P(PSOYS,"^",4),!
 Q
DIR ;
 W !! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 Q
END ;
 D MSG5
QU S ANQX=1 D DIR
 Q
1 ;;NO WBC IN LAST 7 DAYS
2 ;;NO VERIFIED WBC
3 ;;LAST WBC RESULT < 3500
4 ;;3 SEQ. WBC DECREASE
5 ;;LAST ANC RESULT < 2000
6 ;;3 SEQ. ANC DECREASE
7 ;;NCCC AUTHORIZED

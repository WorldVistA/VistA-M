PSGOE5 ;BIR/CML3-UTILITIES FOR ORDER ENTRY ;19 OCT 94 / 4:50 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
PROF ;
 F  W !!,"Do you want a profile for ",$P(PSGP(0),"^") S %=2 D YN^DICN Q:%  W !!,"Enter 'YES' to print a profile of this patient's orders, including any new",!,"orders or changes.  Enter 'NO' (or '^') to continue without a profile."
 Q:%'=1  D ENL^PSGOU Q:"^"[PSGOL  N PSGSS,PSGSSH S (PSGOEPRF,PSGPRWD,PSGPRWDN,PSGPRWG,PSGPRWGN)="",PSGSS="P0",PSGPRA="N",PSGPRP="P" D ENDEV^PSGPR
 K PSGOEPRF Q
 ;
ENMAR ;
 D NOW^%DTC I $O(^PS(55,PSGP,5,"AUS",%)) F Q=%:0 S Q=$O(^PS(55,PSGP,5,"AUS",Q)) Q:'Q  F QQ=0:0 S QQ=$O(^PS(55,PSGP,5,"AUS",Q,QQ)) Q:'QQ  I $D(^PS(55,PSGP,5,QQ,4)),$P(^(4),"^",10) Q
 Q:'$T  F  W !!,"Do you want to print an MAR for this patient" S %=2 D YN^DICN Q:%  W !!,"  Enter 'YES' to print an MAR for this patient.  Enter 'NO' (or '^') to",!,"continue without an MAR."
 Q:%'=1  S DIR(0)="SOBA^7:7 DAY MAR;1:14 DAY MAR;2:24 HOUR MAR",DIR("A")="Select MAR to print: ",DIR("?",1)="Select one of the following:",DIR("?",2)="   7 DAY MAR",DIR("?",3)="   14 DAY MAR",DIR("?",4)="   24 HOUR MAR",DIR("?",5)=""
 S DIR("?")="Press RETURN (or enter '^') to abort this MAR print." W ! D ^DIR Q:"^"[Y
 N PSGSS,PSGSSH,PSGOP S PSGPAT=PSGP,PSGPAT(PSGP)="",PSGMARB=0,PSGSS="P" I $E(Y)'=2 S PSGMARDF=$S(Y=1:14,1:7) D ENOE^PSGMMAR Q
 D ENDATE^PSGMAR Q

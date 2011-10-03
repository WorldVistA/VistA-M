ENLBL8 ;(WASH ISC)/DH-Help Processor for Location Labels ;10.10.97
 ;;7.0;ENGINEERING;**12,16,35,45**;Aug 17, 1993
WARN Q:$D(ZTQUEUED)
 U IO(0) W *7,!,"NOTE: Location ",ENEQB," not properly formatted.",!,"      NO BAR CODE LABEL PRINTED." W !,"      Press <RETURN> to continue...",! R X:DTIME
 Q
 ;
BHELP W !!,"You must enter a building number as it appears in the Space File. If you",!,"obtain unanticipated results, you should first check your entry against",!,"the Space File."
 W !,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;
WHELP1 W !!,"Select a WING as defined in the Space File (#6928).",!,"Would you like to see the entries" S %=2 D YN^DICN D:%=1 WHELP2
 S X="" Q
 ;
WHELP2 W !,"Choose from:" S ENY=0
WHELP21 S A=0 F B=0:0 S A=$O(^ENG("SP","C",A)) Q:A=""  W !?3,A S ENY=ENY+1 I (ENY>(IOSL-3)) D WHELP22 Q:A=""
 I X'="^" W !,"Press <RETURN> to continue..." R X:DTIME
 S X="" Q
WHELP22 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME S:X="^" A="" S ENY=0
 Q
 ;
FLOOR S DIC="^ENG(""SP"",",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=ENEQC",DIC("A")="Start with: " D ^DIC K DIC Q:Y'>0
 S ENEQC("FR")=$P(^ENG("SP",+Y,0),U,1)
 S DIC="^ENG(""SP"",",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=ENEQC",DIC("A")="Go to: " D ^DIC K DIC I +Y'>0 K ENEQC("FR") Q
 S ENEQC("TO")=$P(^ENG("SP",+Y,0),U,1) I ENEQC("FR")]ENEQC("TO") W !!,"Your starting point comes after your ending point. Can't process.",*7 K ENEQC("FR"),ENEQC("TO") G FLOOR
 Q
 ;
REQ ;Requeue the print job
 S ZTREQ="900S"
 Q
 ;
EXIT I $D(ENEQIO) U ENEQIO W @ENEQIOF S IO=ENEQIO,IOF=ENEQIOF,ION=ENEQION,IOST=ENEQIOST,IOST(0)=ENEQIOST(0) S:$D(ENEQIO("S")) IO("S")=ENEQIO("S") D ^%ZISC
EXIT1 K ENEQIO,ENEQIOF,ENEQION,ENEQIOST,ENEQIOSL
 I $D(ENBCIO) S IO=ENBCIO,IOF=ENBCIOF,ION=ENBCION,IOST=ENBCIOST,IOST(0)=ENBCIOST(0) S:$D(ENBCIO("S")) IO("S")=ENBCIO("S") D ^%ZISC
 K ENBCIO,ENBCIOF,ENBCION,ENBCIOST,ENBCIOSL,ENBCIOS
 K EN,ENA,ENB,ENERR,ENEQSTA,ENEQSTAN,ENEQBY,ENEQDA,ENEQLM,ENEQBC,ENHDMRGN,ENEQUSER,ENEQPG,ENEQX,ENEQY,ENDX
 K ENMOD,ENSN,ENPMN,ENCMR,ENID,ENMEN,ENMAN,ENCAT,ENUSE,ENSER,ENLOC,ENEQDATE,ENEQA,ENEQB,ENEQC,ENBLDG,ENDIV,ENX,ENY,ENWNG,ENFLG,ENFR,ENTO,ENROOM
 K ENSHKEY,ENPMDT,ENPMWO,ENDA,ENLOCSRT,ENPO,ENLBLHD,ENLBLBOT,ENPM,ENLID,ENIX,ENEQREP
 D HOME^%ZIS K ^TMP($J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENLBL8

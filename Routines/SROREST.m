SROREST ;B'HAM ISC/MAM - STUFF RESTRAINTS; [ 01/30/01  1:13 AM ]
 ;;3.0; Surgery ;**94,100**;24 Jun 93
 N SRLCK S SRSOUT=0 I '$D(SRTN) W !!,"A surgical case has not been entered.  " G END
 D ^SROLOCK I SROLOCK S SRSOUT=1 G END
ASK W @IOF,!,"Enter/Edit Irrigations or Restraints and Positioning Aids:",!!,"1. Irrigations",!,"2. Restraints and Positioning Aids",!!,"Select Number: " R X:DTIME I '$T!("^^"[X) S SRSOUT=1 G END
 I X'=1&(X'=2) S X="?"
 I X["?" W !!,"Type '1' to enter irrigation solutions, or '2' to enter restraints",!,"or positioning aids.",!!,"Press RETURN to continue  " R X:DTIME G ASK
 S SRLCK=$$LOCK^SROUTL(SRTN) I '$G(SRLCK) G ASK
 I X=1 G ^SROIRR
LIST ;
 K SREST S (CNT,SREST)=0 F  S SREST=$O(^SRO(132.05,SREST)) Q:'SREST  S INACT=$P(^SRO(132.05,SREST,0),"^",2) I 'INACT S CNT=CNT+1,SREST(CNT)=SREST_"^"_$P(^SRO(132.05,SREST,0),"^")
 N SRD,SRI,SRFIRST,SRJ,SRLAST,SRP,SRP1,SRQ,SRTOT S SRD=36,SRTOT=CNT,SRP1=CNT/SRD,SRP=$P(SRP1,".") I SRP1>SRP S SRP=SRP+1
 S (CNT,SRLAST)=0 F SRPAGE=1:1:SRP S SRNUM=$S(SRTOT>SRD:"Page "_SRPAGE_" of "_SRP,1:""),SRFIRST=SRLAST+1,SRLAST=$S(SRLAST+SRD<SRTOT:SRLAST+SRD,1:SRTOT) D PAGE Q:SRSOUT
END D ^SRSKILL D:$G(SRLCK) UNLOCK^SROUTL(SRTN) W @IOF
 Q
PAGE Q:SRSOUT  W @IOF,!,?20,"Restraints and Positioning Aids",?(79-$L(SRNUM)),SRNUM,! F I=1:1:80 W "="
 F CNT=SRFIRST:1:SRLAST S S=SREST(CNT) W:CNT#2 !,$J(CNT,2)_". "_$P(SREST(CNT),"^",2) W:'(CNT#2) ?40,$J(CNT,2)_". "_$P(SREST(CNT),"^",2)
 W ! F LINE=1:1:80 W "-"
SEL W ! K DIR S DIR("?",1)=" Enter the numbers corresponding to your choices, separated by a comma (,).",DIR("?")=" For example, if selecting items 1, 4 and 7, you would enter '1,4,7'."
 S DIR("A")="Select the number(s) corresponding to your choice: ",DIR(0)="FAO" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRX=Y I Y="" Q
 S:'$D(^SRF(SRTN,20,0)) ^SRF(SRTN,20,0)="^130.31PA^0^0"
 S SRQ=0 F SRCNT=1:1 S SRI=$P(SRX,",",SRCNT) Q:SRI=""!SRQ  I '$D(SREST(SRI)) W !!,SRI_" is an invalid entry.  Please try again." S SRQ=1
 I SRQ D RET S:$D(DTOUT)!$D(DUOUT) SRSOUT=1 G PAGE
 F SRCNT=1:1 S SRI=$P(SRX,",",SRCNT) Q:SRI=""  D STUFF
 D RET I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
STUFF ; stuff restraints in Surgery file
 I $D(SREST(SRI)) S SREST=+SREST(SRI),SREST1=$P(SREST(SRI),"^",2) W !!,"Entering "_SREST1_" ..." K DR S DIE=130,DA=SRTN,DR=".13///"_SREST1,DR(2,130.31)=.01 D ^DIE K DR
 Q
RET W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue  " D ^DIR
 Q

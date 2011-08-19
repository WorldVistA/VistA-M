SROIRR ;B'HAM ISC/MAM - ENTER IRRIGATIONS; [ 01/30/01  11:13 AM ]
 ;;3.0; Surgery ;**94,100**;24 Jun 93
 S (CNT,SRIRR)=0 F  S SRIRR=$O(^SRO(133.6,SRIRR)) Q:'SRIRR  S INACT=$P(^SRO(133.6,SRIRR,0),"^",3) I 'INACT S CNT=CNT+1,SRIRRG(CNT)=SRIRR_"^"_$P(^SRO(133.6,SRIRR,0),"^")
 N SRD,SRI,SRFIRST,SRJ,SRLAST,SRP,SRP1,SRQ,SRTOT S SRD=36,SRTOT=CNT,SRP1=CNT/SRD,SRP=$P(SRP1,".") I SRP1>SRP S SRP=SRP+1
 S (CNT,SRLAST)=0 F SRPAGE=1:1:SRP S SRNUM=$S(SRTOT>SRD:"Page "_SRPAGE_" of "_SRP,1:""),SRFIRST=SRLAST+1,SRLAST=$S(SRLAST+SRD<SRTOT:SRLAST+SRD,1:SRTOT) D PAGE Q:SRSOUT
END D ^SRSKILL,UNLOCK^SROUTL(SRTN) W @IOF
 Q
PAGE Q:SRSOUT  W @IOF,!,?25,"Irrigation Solutions",?(79-$L(SRNUM)),SRNUM,! F I=1:1:80 W "="
 F CNT=SRFIRST:1:SRLAST S S=SRIRRG(CNT) W:CNT#2 !,$J(CNT,2)_". "_$P(SRIRRG(CNT),"^",2) W:'(CNT#2) ?40,$J(CNT,2)_". "_$P(SRIRRG(CNT),"^",2)
 W ! F LINE=1:1:80 W "-"
SEL W ! K DIR S DIR("?",1)=" Enter the numbers corresponding to your choices, separated by a comma (,).",DIR("?")=" For example, if selecting items 1, 4 and 7, you would enter '1,4,7'."
 S DIR("A")="Select the number(s) corresponding to your choice: ",DIR(0)="FAO" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRX=Y I Y="" Q
 S:'$D(^SRF(SRTN,26,0)) ^SRF(SRTN,26,0)="^130.08PA^0^0"
 S SRQ=0 F SRCNT=1:1 S SRI=$P(SRX,",",SRCNT) Q:SRI=""!SRQ  I '$D(SRIRRG(SRI)) W !!,SRI_" is an invalid entry.  Please try again." S SRQ=1
 I SRQ D RET S:$D(DTOUT)!$D(DUOUT) SRSOUT=1 G PAGE
 F SRCNT=1:1 S SRI=$P(SRX,",",SRCNT) Q:SRI=""  D STUFF
 D RET I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
STUFF ; stuff restraints in Surgery file
 I $D(SRIRRG(SRI)) S SRIRR=+SRIRRG(SRI),SRIRR1=$P(SRIRRG(SRI),"^",2) W !!,"Entering "_SRIRR1_" ..." K DR S DIE=130,DA=SRTN,DR=".39///"_SRIRR1,DR(2,130.08)=.01 D ^DIE K DR
 Q
RET W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue  " D ^DIR
 Q

PRCHOV ;WISC/ERC-Overage Report  ;7/24/00  23:25
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N:'$G(PRCBUGS) L,DIC,BY,FLDS,PRC,DIS,PRCF,STFLG,Y,%
ASK ; Ask user if report should be for one station.
 S %=1,PRC("SST")="",STFLG=""
 W !!,"Would you like this report for a single STATION NUMBER?: " D YN^DICN Q:%<0  I %=0 W !!,"Enter 'Y' if you would like to limit the report to one station." G ASK
 G:%=2 PRINT
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  S STFLG=1
ASK2 ;Ask user if report should be for one substation.
 I '$D(^PRC(411,"UP",+PRC("SITE"))) G PRINT
 I $D(^PRC(411,"UP",+PRC("SITE"))) S %=1 W !!,"Would you like this report for a single sub-station?: " D YN^DICN Q:%<0  I %=0 W !!,"Enter 'Y' if you would like to limit the report to one sub-staion." G ASK2
 G:%=2 PRINT
 S DIC="^PRC(411,",DIC(0)="AEQZ",DIC("A")="Select SUBSTATION: ",DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")" D ^DIC I Y>0 S PRC("SST")=+Y,STFLG=2
PRINT ;
 S L=0,DIC="^PRC(442,",FLDS="[PRCH OVERAGE]",BY="[PRCH OVERAGE]"
 S DHD="OVERAGE REPORT FOR "_$S(STFLG=1:PRC("SITE"),STFLG=2:$S($D(^PRC(411,PRC("SST"),50)):$P(^PRC(411,PRC("SST"),50),U,1)_" "_$P(^PRC(411,PRC("SST"),50),U,2),1:PRC("SITE")),1:"ALL STATIONS")
 S:STFLG=1 DIS(0)="I $D(^PRC(442,D0,0))>0,PRC(""SITE"")=$P($P(^PRC(442,D0,0),U),""-"")"
 S:STFLG=2 DIS(0)="I $D(^PRC(442,D0,0))>0,$D(^PRC(442,D0,23))>0,PRC(""SITE"")=$P($P(^PRC(442,D0,0),U),""-"")&($S($P(^PRC(442,D0,23),U,7):PRC(""SST"")=$P(^PRC(442,D0,23),U,7),1:0))"
 D EN1^DIP
 Q

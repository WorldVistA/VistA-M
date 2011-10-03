PRCB0C ;WISC/PLT-utility for fiscal user's station, substation, fy, qtr, fcp, bbfy ;1/3/97  16:28
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
SITE ;station prompt
 N PRCMDIV,PRCRI
 N A,B,C,X,Y,Z,%
 D DUZ^PRCFSITE G:'% Q
 W ! I '$D(^PRC(411,0)) W "SITE PARAMETERS HAVE NOT YET BEEN ESTABLISHED, NO FURTHER PROCESSING CAN OCCUR",$C(7) G Q
 S U="^",B=^PRC(411,0) I +$P(B,U,4)<1 W !,"NO ENTRIES FOUND IN SITE PARAMETER FILE",$C(7) G Q
 S:$G(^VA(200,+PRC("PER"),400))]"" PRC("SP")=1
 I $P(B,U,4)>1 S PRCMDIV=""
 K PRC("FU") I '$G(PRC("SP")) D AFU^PRCFSI1 G:$G(PRC("FU")) EXT1
 S PRC("SITE")=$S($O(^PRC(411,"AC","Y",0)):$O(^PRC(411,"AC","Y",0)),1:$O(^PRC(411,0)))
 I '$D(PRCMDIV) S PRC("SITE")=$O(^PRC(411,0)),Y=+PRC("SITE")
 I $D(PRCMDIV) W ! S DIC("A")="Select STATION NUMBER ('^' TO EXIT): ",DIC("B")=PRC("SITE"),DIC=411,DIC(0)="AEQMZ",DIC("S")="I +Y<1000000" D ^DIC K DIC
 G:+Y<1 EXT1
 S PRC("SITE")=+Y
 K DIC,PRC("SP"),PRC("L"),PRC("I")
 QUIT
EXT1 K PRC QUIT
 ;
SUBSITE ;sub station prompt
 I $D(^PRC(411,"UP",+PRC("SITE"))) S DIC="^PRC(411,",DIC(0)="AEQZ",DIC("A")="Select SUBSTATION: ",DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")" D ^DIC I Y>0 S PRC("SST")=+Y
 QUIT
 ;
FY ;fiscal year prompt
 D FY^PRCSUT
 QUIT
 ;
QTR ;quarter prompt
 D QT^PRCSUT
 QUIT
 ;
FCP ;fund control point
 N PRCSC
 S PRCSC=4
 D CP^PRCSUT1
 QUIT
 ;
BBFY ;bbfy prompt
 N A
 S A=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"))
 QUIT
 ;
Q K PRC,PRCB QUIT

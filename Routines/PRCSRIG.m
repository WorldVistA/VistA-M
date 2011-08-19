PRCSRIG ;WISC/SAW-GENERATE REQUESTS FROM REPETITIVE ITEM LIST FILE ;1.29.98
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D DUZ^PRCFSITE Q:'$D(PRC("PER"))  D DISP^PRCOSS3
 W !!,"This option generates requests with permanent transaction numbers from",!,"entries in the repetitive item list file.",!,"Are you sure you are ready to proceed" S %=2 D YN^DICN G EXIT:%=2!(%<0),PRCSRIG:%=0
 W ! S DIC="^PRCS(410.3,",DIC(0)="AEMQ",DIC("S")="S PRC(""SITE"")=$P(^(0),""-""),PRC(""CP"")=$P(^(0),""-"",4),$P(^(0),U,5)="""" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))" D ^DIC K DIC("S") I Y'>0 G EXIT
 S PRCSRID0=+Y,PRC("SITE")=$P(^PRCS(410.3,PRCSRID0,0),"-"),PRC("CP")=$P(^(0),"-",4)
 S:'$D(PRC("SST")) PRC("SST")="" S DIC("B")=PRC("SST") I $D(^PRC(411,"UP",+PRC("SITE"))) S DIC="^PRC(411,",DIC(0)="AEQZ",DIC("A")="Select SUBSTATION: ",DIC("S")="I $E($G(^PRC(411,+Y,0)),1,3)=PRC(""SITE"")" D ^DIC I Y>0 S PRC("SST")=+Y
 S (A,PRCSAPP)=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^",3) I PRCSAPP["_/_" D FY2^PRCSUT2 G EXIT:X="^"
 D FY^PRCSUT Q:PRC("FY")'?2N
 S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"))
 I '$D(PRC("BBFY")) W !,"Please check the accounting elements for FY ",PRC("FY") G EXIT
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY")) S (A,PRCSAPP)=$P(PRC("ACC"),"^",11)
 I PRCSAPP["_/_" D FY2^PRCSUT2 G EXIT:X="^"
 L +^PRCS(410.3,PRCSRID0,0):15 S PRCSL=$T I PRCSL=0 W !!,$C(7),"This record is being accessed by another user.  Please try later." G EXIT
 S $P(^PRCS(410.3,PRCSRID0,0),U,5)=1 L -^PRCS(410.3,PRCSRID0,0) D CLOSE^PRCOSS3
 W !!,"You may use either the current quarter or the repetitive item",!,"list quarter to generate requests."
ASKQTR N PQTR S (%,PQTR)=1 W !,"Use repetitive item list quarter" D YN^DICN Q:%=-1  S:%=2 PQTR=0 G:%=0 ASKQTR
 S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS G EXIT:POP I $D(IO("Q")) S ZTRTN="^PRCSRIG1",ZTSAVE("PRC*")="",ZTSAVE("PQTR")="",ZTSAVE("C")="",ZTSAVE("PRCSRID0")="",ZTSAVE("PRC(""PER"")")="",ZTSAVE("PRCSAPP")="" D ^%ZTLOAD G EXIT
 D ^PRCSRIG1
EXIT K %,%ZIS,B,DIC,PRCSRID0,Y,ZTRTN,ZTSAVE Q

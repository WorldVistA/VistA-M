PRCBCPE ;WISC@ALTOONA/CTB-CONTROL POINT EDIT ; 01/03/94  9:53 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K C,D,D0,DA,DI,DIC,DIE,DINUM,DLAYGO,DQ,DR,DWLW,I,J,NEW,NEWNAME,OLD,OLDNAME,OLDNUM,PRCFA,X,Y Q
ADD ;ADD NEW FUND CONTROL POINT
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE Q:'%
 I '$D(^PRC(420,PRC("SITE"))) K DD,DO S (DINUM,X)=PRC("SITE"),DIC="^PRC(420,",DIC(0)="EMNQL",DLAYGO=420 D FILE^DICN G OUT:Y<0 S $P(^PRC(420,+Y,1,0),"^",2)="420.01s"
 K PRCFA("OUT") D CPEDIT I '$D(PRCFA("OUT")) S DIE="^PRC(420,",DA=PRC("SITE"),DR="2;3" D ^DIE
 K PRCFA("OUT") G OUT
CPEDIT K PRCFA S DIC("S")="I X'=9999",PRCFA("ALL")="",DA(1)=PRC("SITE"),DLAYGO=420.01,DIC="^PRC(420,"_DA(1)_",1,",DIC(0)="AEMNZLQ" D ^DIC I X["^" S PRCFA("OUT")="" Q
 Q:+Y<0  S DA=+Y,OLD=$P(Y(0),"^"),OLDNUM=$P(OLD," "),OLDNAME=$P(OLD," ",2,99)
 I $P(Y(0),"^",19)'=1 G C
 E  S %A="This Control Point has been marked as INACTIVE, do you wish to",%A(1)="reactivate it at this time",%B="",%=2 D ^PRCFYN
 I %<0 S PRCFA("OUT")="" Q
 I %=2 S %A="Are you sure you what to reactivate this Control Point",%B="" D ^PRCFYN I %<0 S PRCFA("OUT")="" Q
 I %=2 S X="  <No Action Taken>*" D MSG^PRCFQ
 I %=1 S $P(^PRC(420,DA(1),1,DA,0),"^",23,24)="^",$P(^(0),"^",19)=0,X="  --Fund Control Point has been reactivated*" D MSG^PRCFQ
C W ! S %A="Do you need to edit the Fund Control Point Name",%B="",%=2 D ^PRCFYN G AD1:%=2 I %<0 S PRCFA("OUT")="" Q
 W ! S %A="You may edit only the NAME of this Control Point, you may NOT change the number",%A(1)="Do you REALLY wish to change the NAME of this Fund Control Point",%B="",%=1 D ^PRCFYN G AD1:%=2 I %<0 S PRCFA("OUT")="" Q
AD2 S Y=OLDNAME W !!,"Fund Control Point NAME: ",Y W:$X>48 !?9 W "// "
 I $L(OLDNAME)>19 D RW^PRCBSA Q:$D(X)[0
 I $L(OLDNAME)<20 R X:DTIME I '$T!(X["^") S PRCFA("OUT")="" Q
 G:X="" AD1
 I X["?"!($L(X)>30)!(+X=+OLDNUM)!(X'?1.30ANP) W !,$C(7),"Enter FUND CONTROL POINT NAME, (up to ",30-$L(OLDNUM)," characters), do not include the NUMBER" G AD2
 S NEW=OLDNUM_" "_X,NEWNAME=X,%A=" ",%A(1)="The NEW Fund Control Point Number and Name will be:",%A(2)=NEW,%A(3)="IS THIS CORRECT",%B="",%=2 D ^PRCFYN G AD2:%=2 I %<0 S PRCFA("OUT")="" Q
 S %A="OK to update the file",%=1,%B="" D ^PRCFYN I %<0 S PRCFA("OUT")="" Q
 I %=2 S X="  <No Updating has Occurred>*" D MSG^PRCFQ G AD1
 K ^PRC(420,DA(1),1,"B",$E(OLD,1,30),DA),^PRC(420,DA(1),1,"C",$E(OLDNAME,1,30),DA)
 S $P(^PRC(420,DA(1),1,DA,0),"^")=NEW,^PRC(420,DA(1),1,"B",$E(NEW,1,30),DA)="",^PRC(420,DA(1),1,"C",$E(NEWNAME,1,30),DA)="",X="  <Fund Control Point name has been changed.>*" D MSG^PRCFQ
AD1 S DIE=DIC,DR=".5;1;4;12;6;13;7;8;14;22" D ^DIE W:$P(^PRC(420,DA(1),1,DA,0),"^",11)["N" "Notify users of this control point that the control point is non-automated!"
 W ! S DIC("A")="Select next FUND CONTROL POINT: "
 G CPEDIT
Q I X="^" K X
 Q
REA ;REACTIVATE AN INACTIVE FUND CONTROL POINT
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S $P(^PRC(420,PRC("SITE"),1,0),"^",2)="420.01s"
REA1 S PRCFA("REACTIVATE")="",DA(1)=PRC("SITE"),DIC="^PRC(420,"_DA(1)_",1,",DIC(0)="AEMQN" D ^DIC K DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to reactivate this Fund Control Point",%B="",%=1 D ^PRCFYN G OUT:%<0 I %=2 D NA G REA1
 S $P(^PRC(420,DA(1),1,DA,0),"^",23,24)="^",$P(^(0),"^",19)=0,X=" --Fund Control Point has been reactivated*" D MSG^PRCFQ S DIC("A")="Select Next Fund Control Point: " G REA1
DEA ;DEACTIVATE A CONTROL POINT
 K PRCFA S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S $P(^PRC(420,PRC("SITE"),1,0),"^",2)="420.01s"
DEA1 S DA(1)=PRC("SITE"),DIC="^PRC(420,"_DA(1)_",1,",DIC(0)="AEMQN" D ^DIC K DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to deactivate this Fund Control Point",%B="",%=1 D ^PRCFYN G OUT:%<0 I %=2 D NA G DEA1
 S $P(^PRC(420,DA(1),1,DA,0),"^",23,24)=DUZ_"^"_DT,$P(^(0),"^",19)=1,X=" --Fund Control Point has been deactivated*" D MSG^PRCFQ W ! S DIC("A")="Select Next FUND CONTROL POINT: " G DEA
 Q
NA S X="<No Action Taken>*" D MSG^PRCFQ Q
 ;

PRCBSA ;WISC@ALTOONA/CTB-BOC EDIT ;4/30/93  3:01 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K DQ,D0,DI,DLAYGO,DWLW,I,J,NEW,NEWNAME,OLD,OLDNAME,OLDNUM,PRCFA,Y,X,DIC,DIE,DR,DA Q
REA ;REACTIVATE AN INAACTIVE BOC
 K PRCFA S PRCFA("REACTIVATE")="",DIC=420.2,DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to reactivate this BOC",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,REA:%=2
 S $P(^PRCD(420.2,DA,0),"^",2,4)="0^^",X=" --BOC has been reactivated*" D MSG^PRCFQ S DIC("A")="Select Next BOC: " G REA
DEA ;DEACTIVATE AN A BOC
 K PRCFA S DIC=420.2,DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to deactivate this BOC",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,DEA:%=2
 S $P(^PRCD(420.2,DA,0),"^",2)="1^"_DUZ_"^"_DT,X=" --BOC has been deactivated*" D MSG^PRCFQ W ! S DIC("A")="Select Next BOC: " G DEA
ADD ;ADD NEW BOC
 K PRCFA S PRCFA("ALL")="" S (DLAYGO,DIC)=420.2,DIC(0)="AEMZNLQ" D ^DIC G:Y<0 OUT S DA=+Y
 S OLD=$P(Y(0),"^"),OLDNUM=$P(OLD," "),OLDNAME=$P(OLD," ",2,99)
 W ! S %A="Do you need to edit the BOC Name",%B="",%=2 D ^PRCFYN G OUT:%<0,AD1:%=2
 W ! S %A="You may edit only the NAME of this BOC, you may NOT change the number",%A(1)="Do you REALLY wish to change the NAME of this BOC",%B="",%=1 D ^PRCFYN G OUT:%<0,AD1:%=2
AD2 S Y=OLDNAME W !!,"BOC NAME: ",Y W:$X>48 !?9 W "// "
 I $L(OLDNAME)>19 D RW G OUT:$D(X)[0
 I $L(OLDNAME)<20 R X:$S($D(DTIME):DTIME,1:300) I '$T!(X["^") G OUT
 G:X="" AD1
 I X["?"!($L(X)>72)!(+X=+OLDNUM)!(X'?1.72ANP) W !,$C(7),"Enter BOC NAME, do not include the NUMBER" G AD2
 S NEW=OLDNUM_" "_X,NEWNAME=X,%A=" ",%A(1)="The NEW BOC Number and Name will be:",%A(2)=NEW,%A(3)="IS THIS CORRECT",%B="",%=2 D ^PRCFYN G OUT:%<0,AD2:%=2
 S %A="OK to update the file",%=1,%B="" D ^PRCFYN G OUT:%<0 I %=2 S X="  <No Updating has Occurred>*" D MSG^PRCFQ
 K ^PRCD(420.2,"B",$E(OLD,1,30),DA),^PRCD(420.2,"C",$E(OLDNAME,1,30),DA)
 S $P(^PRCD(420.2,DA,0),"^")=NEW,^PRCD(420.2,"B",$E(NEW,1,30),DA)="",^PRCD(420.2,"C",$E(NEWNAME,1,30),DA)="",X="  <BOC name has been changed.>*" D MSG^PRCFQ
AD1 S DIE=DIC,DR="1" D ^DIE W ! S DIC("A")="Select next BOC: "
 G ADD
Q I X="^" K X
 Q
RW ;
 S DG=Y ;I $D(DTIME)[0 S DTIME=999
L W:$X>50 ! R "  Replace ",X:$S($D(DTIME):DTIME,1:300) G D:X="",Q:X?1"^".E,D1:X?."?",E:X="END"!(X="end") I X["@" W "  Deletion is not authorized.",$C(7) G L
 I Y[X S D=X D H G D:'$T S Y=$P(Y,D,1)_X_$P(Y,D,2,999) G L
 S D=$P(X,"...",1),DH=$F(Y,D) I DH S X=$P(X,"...",2,99),X=$S(X="":999,1:$F(Y,X,DH)) I X S DH=DH-$L(D)-1,D=X D H I  S Y=$E(Y,1,DH)_X_$E(Y,D,999) G L
 W $C(7)," ??" G L
H R " With ",X:$S($D(DTIME):DTIME,1:300) Q:X?.ANP  W $C(7),"??" G H
E D H I  S Y=Y_X G L
D W:'$T $C(7) I DG'=Y S X=Y W !?3 W X I X="" S X="@"
 Q
D1 I $L(Y)>19 W !,"Use Standard Filemanager 'Replace With' Techniques to edit the data."
 Q
PRT1 ;PRINT BOCS LISTING
 S DIC="^PRCD(420.2,",L=0,BY="@NUMBER",FLDS="[PRCB SUBACCT LISTING]",PRCFA("ALL")=1
 D EN1^DIP K PRCFA("ALL"),DIC,L,FLDS,BY Q

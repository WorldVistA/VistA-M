PRCBCC ;WISC@ALTOONA/CTB-COST CENTER EDIT ;9-27-89/11:47 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K DQ,D0,DI,DLAYGO,DWLW,I,J,NEW,NEWNAME,OLD,OLDNAME,OLDNUM,PRCFA,Y,X,DIC,DIE,DR,DA Q
REA ;REACTIVATE AN INACTIVE COST CENTER
 K PRCFA S PRCFA("REACTIVATE")="",DIC=420.1,DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to reactivate this Cost Center",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,REA:%=2
 S $P(^PRCD(420.1,DA,0),"^",2,4)="0^^",X=" --Cost Center has been reactivated*" D MSG^PRCFQ S DIC("A")="Select Next COST CENTER: " G REA
DEA ;DEACTIVATE AN A COST CENTER
 K PRCFA S DIC=420.1,DIC(0)="AEMQN" D ^DIC G:Y<0 OUT S DA=+Y
 W !,$C(7) S %A="Are you sure that you wish to deactivate this Cost Center",%B="",%=1 D ^PRCFYN I %'=1 G OUT:%<0,DEA:%=2
 S $P(^PRCD(420.1,DA,0),"^",2)="1^"_DUZ_"^"_DT,X=" --Cost Center has been deactivated*" D MSG^PRCFQ W ! S DIC("A")="Select Next COST CENTER: " G DEA
ADD ;ADD NEW COST CENTER
 K PRCFA S PRCFA("ALL")="" S (DLAYGO,DIC)=420.1,DIC(0)="AEMNLQZ" D ^DIC G:Y<0 OUT S DA=+Y
 S OLD=$P(Y(0),"^"),OLDNUM=$P(OLD," "),OLDNAME=$P(OLD," ",2,99)
 W ! S %A="Do you need to edit the Cost Center Name",%B="",%=2 D ^PRCFYN G OUT:%<0,AD1:%=2
 W ! S %A="You may edit only the NAME of this Cost Center, you may NOT change the number",%A(1)="Do you REALLY wish to change the NAME of this Cost Center",%B="",%=1 D ^PRCFYN G OUT:%<0,AD1:%=2
AD2 S Y=OLDNAME W !,"Cost Center NAME: ",Y W:$X>48 !?9 W "// "
 I $L(OLDNAME)>19 D RW^PRCBSA G OUT:$D(X)[0
 I $L(OLDNAME)<20 R X:DTIME I '$T!(X["^") G OUT
 G:X="" AD1
 I X["?"!($L(X)>72)!(+X=+OLDNUM)!(X'?1.72ANP) W !,$C(7),"Enter COST CENTER NAME, do not include the NUMBER" G AD2
 S NEW=OLDNUM_" "_X,NEWNAME=X,%A=" ",%A(1)="The NEW cost center Number and Name will be:",%A(2)=NEW,%A(3)="IS THIS CORRECT",%B="",%=2 D ^PRCFYN G OUT:%<0,AD2:%=2
 S %A="OK to update the file",%=1,%B="" D ^PRCFYN G OUT:%<0 I %=2 S X="  <No Updating has Occurred>*" D MSG^PRCFQ
 K ^PRCD(420.1,"B",$E(OLD,1,30),DA),^PRCD(420.1,"C",$E(OLDNAME,1,30),DA)
 S $P(^PRCD(420.1,DA,0),"^")=NEW,^PRCD(420.1,"B",$E(NEW,1,30),DA)="",^PRCD(420.1,"C",$E(NEWNAME,1,30),DA)="",X="  <Cost Center name has been changed.>*" D MSG^PRCFQ
AD1 S DIE=DIC,DR="2" D ^DIE,A1 S DIC("A")="Select next COST CENTER: "
 G ADD
 ;
A1 W ! S %A="Do you wish to edit the BOC list for this Cost Center",%B="",%=1
 D ^PRCFYN G OUT:%<0 Q:%=2
 W ! S %A="Do you want me to add or delete ALL BOCs to this cost center before",%A(1)="you begin editing the BOC list",%B="",%=2 D ^PRCFYN G OUT:%<0 I %=1 D ALL Q:%<0
 K PRCFA("ALL") S DR=1 D ^DIE Q
 ;
ALL ;
 W ! S %A="You will now be permitted to add or delete ALL BOC from the list",%A(1)="ARE YOU SURE YOU WANT TO CONTINUE",%B="",%=2 D ^PRCFYN Q:%'=1
ALL1 R !!,"Add or Delete? ",X:DTIME I '$T!(X["^") S %=-1 Q
 I X=""!("AaDd"'[$E(X,1)) W !,"Select an 'A' to ADD or 'D' to DELETE all BOCs from the list. ",! G ALL1
 I "Dd"[$E(X,1) G D
A ;ADD ALL BOC TO A COST CENTER
 S %A="LAST CHANCE, Is it OK to ADD all BOCs to this list",%B="",%=1 D ^PRCFYN Q:%'=1
 D WAIT^PRCFYN S COUNT=0,N=0 F I=1:1 S N=$O(^PRCD(420.2,N)) Q:'N  I $D(^(N,0)),+$P(^(0),"^",2)=0 S LAST=N,COUNT=COUNT+1,^PRCD(420.1,DA,1,N,0)=N,^PRCD(420.1,DA,1,"B",N,N)=""
 S ^PRCD(420.1,DA,1,0)="^420.11P^"_LAST_"^"_COUNT S X=" --Done--" D MSG^PRCFQ S %=1
 Q
D ;DELETE ALL BOCS FROM A COST CENTER
 I $G(^PRCD(420.1,DA,1,0))="" W ! D EN^DDIOL("No BOCs for this Cost Center.") W ! QUIT
 S %A="LAST CHANCE, Is it OK to DELETE all BOCs from this list",%B="",%=1 D ^PRCFYN Q:%'=1
 D WAIT^PRCFYN S A=$P(^PRCD(420.1,DA,1,0),"^",1,2) K ^PRCD(420.1,DA,1) S ^PRCD(420.1,DA,1,0)=A K A S X=" --Done--" D MSG^PRCFQ S %=1 Q
PRT1 ;PRINT CC LISTING WITH DEACTIVATED
 S DIC="^PRCD(420.1,",L=0,FLDS="[PRCB CC LISTING]",BY="@COST CENTER NUMBER",PRCFA("ALL")=1
 D EN1^DIP K PRCFA("ALL"),DIC,L,FLDS,BY Q
PRT2 ;PRINT CC LISTING WITH BOCS--ACTIVE ONLY
 S DIC="^PRCD(420.1,",L=0,FLDS="[PRCB CC LISTING W/SUBACCT]",BY="@COST CENTER NUMBER" K PRCFA("ALL")
 D EN1^DIP K DIC,L,FLDS,BY Q

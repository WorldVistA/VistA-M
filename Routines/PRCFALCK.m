PRCFALCK ;WISC@ALTOONA/CTB-CHECK FISCAL LOCK FILE ; 03/21/94  10:30 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
LOCK N X0,X1,X2,X3,Y
 S %=0 G FAIL:'$D(X)#2,FAIL:X="",FAIL:'$D(^PRCF(421.4,"B",X)) S X1=$O(^PRCF(421.4,"B",X,0)) I X1="" G FAIL
 L +^PRCF(421.4,X1,0):1 I $T S X0=^PRCF(421.4,X1,0) I +$P(X0,"^",2)=0 D NOW^%DTC S ^PRCF(421.4,X1,0)=$P(X0,"^",1)_"^1^"_DUZ_"^"_% S %=1 L -^PRCF(421.4,X1,0) Q
 S X0=^PRCF(421.4,X1,0)
 S X3=$P(X0,"^",3) I +X3>0,$D(^VA(200,X3,0)) S X3=$P(^(0),"^",1)
 E  S %=0,X3="an unknown person"
 I $D(ZTIO),ZTIO=""!(ZTIO="@") G OUT
 W !!!,X," lock was set by ",X3 S Y=$P(X0,"^",4) D DD^%DT W:Y]"" " on ",Y,"."
 W !,"No further action taken.  Contact your supervisor to clear the lock."
OUT I $G(X1) L -^PRCF(421.4,X1,0) Q
FAIL W !!!,"Corruption exists in the FISCAL LOCK file.",!,"PLEASE CONTACT YOUR SITE MANAGER.",!!!!! S %=0 Q
 ;
CLEAR ;Clear a lock
 S DIC=421.4,DIC(0)="AEMZQ" D ^DIC K DIC Q:Y<0
 I +$P(Y(0),"^",2)=0 S $P(^PRCF(421.4,+Y,0),"^",3)="" W !!,$P(Y(0),"^")," Lock is not in use.  No action taken." K Y Q
 S DA=+Y F I=1:1:4 S X(I)=$P(Y(0),"^",I)
 S Y=X(4) D D^PRCFQ S X(3)=$S($D(^VA(200,X(3),0)):$P(^(0),"^"),1:"an unknown person")
 W ! S %A="It looks like the lock was set by "_X(3)_$S(Y]"":" on "_Y,1:"")
 S %A(1)="Have you checked with all your users to be sure that "_X(1),%A(2)="is not in progress on the system",%B="",%=2 D ^PRCFYN I %'=1 D NA Q
 S %A="Are you sure that you want to clear this lock",%B="",%=2 D ^PRCFYN I %'=1 D NA Q
 W !!,"OK, I will now clear the ",X(1)," lock." S ^PRCF(421.4,DA,0)=$P(^PRCF(421.4,DA,0),"^",1) K X,Y S X="  ---Done---" D MSG^PRCFQ Q
NA S X="   No action taken" D MSG^PRCFQ K Y,X Q
UNLOCK ;INTERNAL ENTRY TO CLEAR LOCK.  REQUIRES VARIABLE X EQUAL TO LOCK NAME
 S X1=$O(^PRCF(421.4,"B",X,0)) Q:X1=""  S ^(0)=$P(^PRCF(421.4,+X1,0),"^",1) K X,X1 Q

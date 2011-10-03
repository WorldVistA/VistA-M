LRBLDMV ;AVAMC/REG - MOVE BLOOD DONATION ;12/19/94  11:53 ;
 ;;5.2;LAB SERVICE;**26,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  W !!?17,"Move a donation from one donor to another",!
ASK D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END D REST G:Y=1 ASK
 ;
REST W ! S DIC=65.5,DIC(0)="AEQMZ",DIC("A")="MOVE FROM DONOR: " D ^DIC Q:Y<1  S LRF=+Y D A
 I '$O(^LRE(LRF,5,0)) W $C(7),!!,"No donation date." Q
 W ! S DIC="^LRE(LRF,5," S DIC("A")="  DONATION DATE: " D ^DIC K DIC Q:Y<1  S LRI=+Y,LRU=$P(Y(0),U,4),(Y,LRD)=$P($P(Y(0),U),".") D D^LRU S LRD(1)=Y
 I LRU="" W $C(7),!,"No unit ID entered. Do you want to continue" S %=2 D YN^LRU Q:%'=1  S LRU="NONE"
 W " UNIT ID: ",LRU S DIE="^LRE(LRF,5,",DA=LRF D CK^LRU I $D(LR("CK")) D FRE^LRU Q
 W ! S DIC=65.5,DIC(0)="AEQMZ",DIC("A")="MOVE TO DONOR: " D ^DIC K DIC Q:Y<1  S LRT=+Y,LRT(1)=$P(Y,U,2) D A I $D(^LRE(LRT,5,LRI,0)) W $C(7),!!,"Donation date ",LRD(1)," exists for ",LRT(1) Q
 W $C(7),!!?3,"OK TO MOVE" S %=2 D YN^LRU I %'=1 D FRE^LRU Q
 S:'$D(^LRE(LRT,5,0)) ^(0)="^65.54DA^^"
 S %X="^LRE(LRF,5,LRI,",%Y="^LRE(LRT,5,LRI," D %XY^%RCR S X=^LRE(LRT,5,0),^(0)=$P(X,"^",1,2)_"^"_LRI_"^"_($P(X,"^",4)+1)
 K ^LRE(LRF,5,LRI),^LRE("AD",LRD,LRF),^LRE("C",LRU,LRF,LRI),^LRE("AT",LRU) S X=^LRE(LRF,5,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 S ^LRE("AD",LRD,LRT)="",DA=LRI,DA(1)=LRT I LRU'="NONE" S ^LRE("C",LRU,LRT,LRI)="",X=LRU X ^DD(65.54,4,1,2,1)
 S Z="65.54,.01",X="",O=LRD,DA(1)=LRF D EN^LRUD S DA(1)=LRT,O="",X=LRD,Z="65.54,.01" D EN^LRUD
 D FRE^LRU S Y=1 Q
F D E S A=0 F LRZ=0:1 S A=$O(^LRE(LR,99,A)) Q:'A  S X=^LRE(LR,99,A,0) D ^DIWP
 D:LRZ ^DIWW Q
E K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W" Q
 ;
A S LRABO=$P(Y(0),U,5),LRRH=$P(Y(0),U,6) W !,"ABO GROUP: ",LRABO,"  Rh TYPE: ",LRRH
 S LR=+Y,X=$G(^LRE(LR,1)) W ?30,"File Number: ",LR,?50,"SSN: ",$P(Y(0),U,13),!,$P(X,U)," ",$P(X,U,2)," ",$P(X,U,3),!,$P(X,U,4)," ",$P($G(^DIC(5,+$P(X,U,5),0)),U)," ",$P(X,U,6)
 I $P(Y(0),U,10) W $C(7),!!," PERMANENT DEFERRAL " S Y=$P(Y(0),U,16) D D^LRU W " ",Y D F
 Q
 ;
END D V^LRU Q

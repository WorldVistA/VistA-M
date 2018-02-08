PRCBE ;WISC@ALTOONA/CTB-EDIT ROUTINE FOR BUDGET MODULE OF ADMIN ACTIVITIES PACKAGE ; 04/07/94  1:43 PM
V ;;5.1;IFCAP;**139,196**;Oct 20, 2000;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*196 If the 'AD' x-ref for file 421, site-fy has no 
 ;            entries, find the last sequence number used and
 ;            apply reverse entry to 'AD' x-ref site-fy,entry
 ;
 W "ROUTINE CAN ONLY BE ENTERED THROUGH MENU MANAGER OR DRIVER",$C(7),!! Q
SEQNUM S:'$D(PRCF("SIFY")) PRCF("SIFY")=PRC("SITE")_"-"_PRC("FY") S X=$O(^PRCF(421,"AD",PRCF("SIFY"),0)) I X="" D WAIT^PRCFYN,ENIT G SEQNUM
 E  K ^PRCF(421,"AD",PRCF("SIFY"),X+30) S X=100000-X+1
 S X="00000"_X,X=$E(X,$L(X)-4,$L(X)) S PRCB("TRANS")=PRC("SITE")_"-"_PRC("FY")_"-"_X,X=PRCB("TRANS")
 Q
EN1 ;ENTER NEW TRANSACTION
 S PRCF("X")="ABFS" D ^PRCFSITE G:'% OUT
SEQ D SEQNUM G:X="" OUT
 W ! S %A="I am going to create a new transaction with the number "_X,%A(1)="IS THIS OK ",%B="",%=1 D ^PRCFYN I %'=1 W !!,"Transaction number ",X," has been deleted",$C(7) R X:2 G OUT
 K DIC("A") S DIC=421,DIC(0)="LZ",DLAYGO=421 D ^DIC I $P(Y,"^",3)="" W !,X," has just been taken by someone else, please hold on while I get another one." G SEQ
 G:+Y<0 OUT S DIE=DIC,DA=+Y,DR="[PRCB NEW TRANSACTION]" D ^DIE I $D(Y)=0,$P(^PRCF(421,DA,0),"^",2)]"",$P($G(^(0)),U,23) G EN1
 I $P(^PRCF(421,DA,0),"^",2)="" W !,$C(7),"Control Point missing."
KILL W $C(7),!!,"Transaction terminated!  ",!,"Transaction # ",PRCB("TRANS")," is being deleted." S DIK="^PRCF(421," D ^DIK
OUT K A,B,D,D0,DA,DIC,DIE,DIK,DLAYGO,DQ,DR,DWDL,J,PRCF,PRCB,X,Y Q
 ;
 ;
EN2 ;EDIT EXISTING, UNRELEASED TRANSACTION
 S PRCF("X")="ABFS" D ^PRCFSITE Q:'%
 S DR="[PRCB NEW TRANSACTION]",DIC("A")="Select Sequence Number for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
 D EN21 K %,PRCFEN,A,B,DA,DIC,DIE,DR,I,J,K,X,Y,PRCF,PRCB Q
EN21 W ! S DIC("S")="S ZX=^(0) I $P(ZX,U)[PRCF(""SIFY"")&($P(ZX,U,11)="""")&($P(ZX,U)'[""00000"")&(+$P(ZX,U,20)<1)&'$P(ZX,U,22)"
 S DIC=421,DIC(0)="AEQZ",D="D" D IX^DIC K DIC Q:Y<0  S DA=+Y,DIE="^PRCF(421,"
 D ^DIE S DIC("A")="Select Next Sequence Number for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
 G EN21
 Q
 ;
EN3 ;DELETE AN UNRELEASED TRANSACTION
 S PRCF("X")="ABFS" D ^PRCFSITE Q:'%
 S DIC("A")="Select Sequence Number for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
 D EN31 K A,B,DA,DIC,DIK,DR,I,PRCB,X,Y,PRCF Q
EN31 W ! S DIC("S")="S ZX=^(0) I $P(ZX,U)[PRCF(""SIFY""),$P(ZX,U,11)="""",$P(ZX,U)'[""00000"",+$P(ZX,U,20)=0",DIC=421,DIC(0)="AEQZ",D="D" D IX^DIC K DIC,ZX Q:Y<0  S DA=+Y,DIK="^PRCF(421,"
 S %A="ARE YOU SURE YOU WANT TO DELETE THIS TRANSACTION",%B="Enter 'YES' to delete.",%=2 D ^PRCFYN I %'=1 W "  <NOTHING DELETED>",$C(7)
 E  S PRCB("TODA")=$P(^PRCF(421,DA,0),"^",22) D ^DIK S DA=PRCB("TODA") D:DA ^DIK S X=" Transaction Deleted.*" D MSG^PRCFQ
 S %A="Do you wish to delete another transaction for "_PRCF("SIFY"),%B="" D ^PRCFYN Q:%'=1
 S DIC("A")="Select Sequence Number for "_$S($D(PRCB("MDIV")):"Station "_PRC("SITE")_",",1:"")_" FY "_PRC("FY")_": "
 G EN31
 ;
NA W !!,$C(7),"THIS OPTION IS UNDER DEVELOPMENT AND NOT YET AVAILABLE",!! H 2 Q
ERR S ^PRC(420,PRC("SITE"),1,9999,0)="9999 GRAND TOTAL",^PRC(420,PRC("SITE"),1,"B","9999 GRAND TOTAL",9999)="",^PRC(420,PRC("SITE"),1,"C","GRAND TOTAL",9999)="" Q
 ;W !,$C(7),"Control Point '9999 GRAND TOTAL' does not exist for station ",PRC("SITE"),!,"Check documentation and use the 'ADD/EDIT FUND CONTROL POINT' to establish. ",!," Further processing is terminated." R X:3 S %X=9999 Q
ENIT I '$D(^PRC(420,PRC("SITE"),1,9999)) D ERR
 S X="00000",PRCB("TRANS")=PRC("SITE")_"-"_PRC("FY")_"-"_X,X=PRCB("TRANS")    ;PRC*5.1*196
 I $D(^PRCF(421,"B",X)) G ENIT1            ;PRC*5.1*196  
 K DIC("A") S DIC=421,DIC(0)="NL",DLAYGO=421 D ^DIC S DIE=DIC,DR="1////9999 GRAND TOTAL",DA=+Y    ;PRC*5.1*196
 D ^DIE S $P(^PRCF(421,DA,0),U,11)=.5
 S X=$P(^PRCF(421,DA,0),"^",16) K:X]"" ^PRCF(421,"AG",X,DA) K X S $P(^PRCF(421,DA,0),"^",16)="",$P(^(0),"^",20)=2,^(4)="1^1^1^1",^PRCF(421,"AL",PRCF("SIFY"),2,DA)="" K ^PRCF(421,"AL",PRCF("SIFY"),0,DA) Q
ENIT1 ;SET LAST USED SITE-FY REVERSE TXIN 'AD'    ;PRC*5.1*196
 N PRCBA,PRCBB,PRCBX
 S PRCBA=PRCF("SIFY"),PRCBB=100000,PRCBX=PRCBA
 F I=1:1 S PRCBA=$O(^PRCF(421,"B",PRCBA)) Q:PRCBA=""!($P(PRCBA,"-",1,2)'=PRCBX)  S PRCBB=+$P(PRCBA,"-",3)
 S:PRCBB'=100000 PRCBB=100000-PRCBB
 S ^PRCF(421,"AD",PRCBX,PRCBB)=""
 Q
DOLLAR I $D(IOST),"C-PK-"[$E(IOST,1,2) S:X["$" X=$P(X,"$",2) W "   $ ",$J(X,0,2)
 Q

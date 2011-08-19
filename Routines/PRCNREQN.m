PRCNREQN ;SSI/ALA-Enter a New Equipment Request ;[ 11/07/96  5:06 PM ]
 ;;1.0;Equipment/Turn-In Request;**1,12**;Sep 13, 1996
EN D NOW^%DTC S PRCNDTM=% K %I,%H
 D FYQ^PRCNUTL S PRCF("X")="S",PRC("MDIV")=1 D ^PRCFSITE G EQ:'$D(PRC("SITE"))
 S DIC("A")="Select CMR: ",DIC(0)="AEQZ",DIC="^ENG(6914.1," D ^DIC G EQ:Y<1
 S PRCN("CMR")=$P(Y(0),U),PRCNCMR=+Y,PRCNSRV=$P(Y(0),U,5)
 S PRCNRSP=$P(Y(0),U,2) I PRCNRSP="" W !!,"This CMR has no responsible official",$C(7) G EN
 I PRCNSRV="" D  G EQ:Y<1
 . S DIC="^DIC(49," D ^DIC S PRCNSRV=+Y
 K DIC,Y,PRCNRSP
 ;  Build next sequential number (PRCNDA) from site, CMR, fiscal year
 S TST=PRC("SITE")_"-"_PRCN("CMR")_"-"_PRC("FY") D SEQ^PRCNUTL
 S PRCNTRN=TST_"-"_$E("00000",$L(PRCNDA)+1,5)_PRCNDA,X=PRCNTRN
 S DIC="^PRCN(413,",DIC(0)="L",DLAYGO=413 D FILE^DICN S (DA,PRCNRDA)=+Y
 W !!,"This Request has been assigned Transaction #: ",PRCNTRN,!
 ;  Set defaulted information into file for this transaction
 S DIE=413,DIE("NO^")="OUTOK",DR="[PRCNEDIT]",NEW=1 D ^DIE
 I $G(PRCNTY)="" S DIK="^PRCN(413," D ^DIK G EQ
 I PRCNTY="R" D
 . I $G(TDA)="" S TDA=$P(^PRCN(413,DA,0),U,11)
 . I $G(PRCNTDA)="" S PRCNTDA=TDA
 . Q:$O(^PRCN(413.1,PRCNTDA,1,0))=""
 . S EDIT=2,DIE=413.1,DR="[PRCNTIRQ]",DA=PRCNTDA D ^DIE
EQ K C,D,NEW,PRC,PRCN,PRCNCMR,PRCNDA,PRCNSRV,PRCNTRN,PRCNTY,TST,DIWF,HL0
 K D0,DA,DIC,DIE,DLAYGO,DR,PRCNRDA,PRCNTDA,PRCF,PRCNDTM,I,LL,PL,PRCNQT
 K PRCNTXT,PRCNCT,PRCNPJT,J,D1,PRCNRTN,PRCNTYP,RDA,RDI,TDA
 K PRCNTDA,EDIT,PFL,QTY
 Q
REP ;   Build replacement entries for Turn-In request
 S RDA=D0,RDI=D1,NUM=0
 S QTY=$P(^PRCN(413,RDA,1,RDI,0),U,5),PRCNTYP=$P(^(0),U,12)
 S NM=$P($G(^PRCN(413.1,TDA,1,0)),U,3)
 I QTY>1 W !!,"A replacement item must be entered for each quantity requested.",!
 I $G(PRCNCMR)="" S PRCNCMR=$P(^PRCN(413,RDA,0),U,16)
 I NM="" S ^PRCN(413.1,TDA,1,0)="^413.11IPA^^"
RP2 S NM=NM+1,NUM=NUM+1
 G RPX:NUM>QTY
 S RQ=RDI,$P(^PRCN(413.1,TDA,1,0),U,3,4)=NM_U_NM
 NEW DIEL,DI,DK,DL,DM,DP,DU,DIC,DIE,DA,D0,D1,D,DR,Y,DQ,DIFLD,DOV,DE,DC,DG,DH,DN,DV
 D GNX Q:$G(DUOUT)=1
 G RP2
GNX W !!,"Select the Replacement Item to correspond with Line Item # "_RQ_" Quantity: "_NUM
 S DIC("A")="Select REPLACEMENT ITEM: ",DIC="^ENG(6914,",DIC(0)="AEMQZ"
 S DIC("S")="I $P($G(^(2)),U,9)=PRCNCMR"
GID D ^DIC I Y<1&(PRCNTYP="C") Q
 Q:$G(DUOUT)=1
 I Y<1&(PRCNTYP="P") W !,$C(7),"You MUST select the Item that is being replaced for a Parent!" G GNX
 S RI=+Y,RIDSC=$P(Y(0),U,2) D DISP^PRCNTIRQ K DIC("S")
 I $D(^PRCN(413.1,"AB",RI)) W $C(7),!!,"This ITEM "_RIDSC_" already has a request on file!" K RI G GNX
 K ^UTILITY($J,"W") S DIWR=70,DIWL=1,DIWF=""
 S X="Are you sure that "_RIDSC_" is the correct item being replaced by requested item, " D ^DIWP
 S RQD=0 F  S RQD=$O(^PRCN(413,RDA,1,RQ,1,RQD)) Q:RQD'>0  S X=^PRCN(413,RDA,1,RQ,1,RQD,0) D ^DIWP
 F I=1:1:^UTILITY($J,"W",DIWL) W !,^UTILITY($J,"W",DIWL,I,0)
G1 W " " D YN^DICN I %=0 W !,"Enter 'Yes' to match the replacement item with item being requested." G G1
 I %=2 K RI,X,RIDSC G GID
 I %<0 Q
 NEW DIEL,DI,DK,DL,DM,DP,DU,DIC,DIE,DA,D0,D1,D,DR,Y,DQ,DIFLD,DOV,DE,DC,DG,DH,DN,DV
 S DA(1)=TDA,DA=NM,DIC="^PRCN(413.1,"_DA(1)_",1,",DIE("NO^")=""
 S DR=".01///^S X=RI;2///^S X=RDI;3///^S X=RIDSC;.5Replacement Justification~;I X'=6 S Y="""";.7",DIE=DIC D ^DIE
 K DR,DIE("NO^") Q
RPX K QTY,NM,RQ,NUM,DR,DOV
 Q

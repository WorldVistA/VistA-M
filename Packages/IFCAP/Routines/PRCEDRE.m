PRCEDRE ;WISC/CLH/LDB/BGJ-ENTER/EDIT DAILY RECORD ;8/15/97  14:06
 ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRC410,PRC422,PRC424,PRC424D1,DIC,DR,DIE,DIR,X,Y,ZX,DRDA,DRTN,AUDA,X1,DA,AAMT,DIK,I,J,PODA,PRC,MSG,PRCACT
 ;S PRCF("X")="S" D ^PRCFSITE Q:'%
 D EN3^PRCSUT Q:'$D(PRC("CP"))  S DIC="^PRCS(410," D OROBL^PRCS58OB(DIC,.PRC,.Y)
 G:Y<0 EXIT
 S PRC410=+Y D NODE^PRCS58OB(+Y,.TRNODE) S PODA=$P($G(TRNODE(10)),U,3) Q:'PODA
 S PRC442=PODA,BAL=$$BAL^PRCH58(PODA)
 S MSG="Another user is editing this authorization. Try again later."
 S DIR(0)="L^1:3",DIR("A",1)="  1 Create a NEW bill activity",DIR("A",2)="  2 Edit existing bill activity",DIR("A",3)="  3 QUIT"
 S DIR("A")="Select ACTION" D ^DIR K DIR G:'Y!($L(Y)=2&($E(Y,1)=3)) EXIT
 ;
 ; K DIR F J=1:1:$L(Y,",")-1 S PRCACT=$P(Y,",",J) D  G EXIT ; <<<<  Why is the K and the F there????????  <<<<<<<<<<<<<<<<<<<<
 S PRCACT=$P(Y,",",1) D
  . ;N J,Y
  . ;I PRCACT=1 D CRE                F  D CREDR Q:'$D(CONT)  Q:'CONT  ; <<<< Escape needed here
  .  I PRCACT=1 D CRE Q:$G(CONT)=-1  F  D CREDR Q:'$D(CONT)  Q:'CONT  ; NOIS DAY-0796-41607
  . Q:PRCACT=1
  . S DIC="^PRC(424.1,",DIC(0)="AEMNQZ",DIC("A")="Select DAILY AUTHORIZATION RECORD: "
  . S DIC("S")="I $P($P(^(0),U),""-"",1,2)=(PRC(""SITE"")_""-""_$P($G(TRNODE(4)),U,5)),($P(^(0),U,11)=""P"")" D ^DIC K DIC("S") Q:Y<0  S DRDA=+Y,DRDA(0)=Y(0),AUDA=$P(DRDA(0),U,2) Q:'AUDA
  . L +^PRC(424,AUDA,0):3 E  S X=MSG W ! D MSG^PRCFQ Q
  . L +^PRC(424.1,DRDA):3 E  S X=MSG W ! D MSG^PRCFQ Q
  . D ED^PRCEDRE1 L:$D(DRDA) -^PRC(424.1,DRDA) Q
EXIT L:$D(AUDA) -^PRC(424,AUDA,0) K CONT,DIRUT,DTOUT,DIROUT,DUOUT,DRDA,DLAYGO,DX,DY,FLD,NUM,PRCADJ,PRCERD,PRCF,TRNODE,ACT,BAL1,BAL2,AUDA,Z,Z1,ZDY,ZX
 Q
 ;
 ;
CRE S X=PRC("SITE")_"-"_$P($G(TRNODE(4)),U,5)_"-" ; create first
 I $O(^PRC(424.1,"B",X_"0000"))'[X D  G EXIT:PRC424="",CRE0
 . D AU^PRCEDRE0(.PRC424)
 . QUIT:PRC424=""
 . S AUDA=PRC424,AUDA0=^PRC(424,PRC424,0),ABAL=$P(AUDA0,U,5)
 . QUIT
 K AUDA,AUDA0,ABAL
 S DIC="^PRC(424,",DIC(0)="AEMNQZ",DIC("A")="Select AUTHORIZATION: "
 S DIC("S")="I $P(^(0),U,9)="""",$P(^(0),U,3)=""AU"",$P($P(^(0),U),""-"",1,2)=(PRC(""SITE"")_""-""_$P($G(TRNODE(4)),U,5))"
 S D="B^AD^B1" D ^DIC K DIC("S") G:Y<0 EXIT S AUDA=+Y,AUDA0=Y(0),ABAL=$P(AUDA0,U,5)
 ;
CRE0 ;L +^PRC(424,AUDA,0):3 E  S X=MSG         D MSG^PRCFQ Q  ; won't exit cleanly  DAY-0796-41607
  L +^PRC(424,AUDA,0):3 E  S X=MSG,CONT=-1 D MSG^PRCFQ Q
 D WAIT^PRCFYN,AUTHDIS
 S X=$P(AUDA0,U),X1=$P(AUDA0,U,11)+1,X=X_"-"_X1
 G CRE1
 ;
 ;
CREDR L:$D(DRDA) -^PRC(424.1,DRDA) I $S('$D(AUDA):1,$G(FINAL):1,1:0) S CONT=0 Q  ; create subsequent
 S DIR("A")="Continue with this authorization",DIR(0)="YO",DIR("B")="NO" D ^DIR S CONT=Y Q:'Y!(Y<0)
 D AUTHDIS
 S X=$P(AUDA0,U),X1=$P(^PRC(424,AUDA,0),U,11)+1,X=X_"-"_X1,ABAL=$P(^(0),U,5)
CRE1 S DIC="^PRC(424.1,",DIC(0)="LMX",DIC("DR")=".02////^S X=AUDA;.011////^S X=""P""",DLAYGO=424.1 D ^DIC I '$P(Y,U,3) W $C(7),!,"UNABLE TO CREATE NEW ENTRY.  TRY LATER." Q
 S (DA,DRDA)=+Y,DRTN=$P(Y,U,2),$P(^PRC(424,AUDA,0),U,11)=X1
 W !!,"This DAILY ACTIVITY ENTRY has been assigned: ",DRTN,!!
 L +^PRC(424.1,DRDA):3 E  S X=MSG D MSG^PRCFQ Q
 S FINAL=0,DIR(0)="YO",DIR("B")="NO",DIR("A")="Is this the final daily activity" D ^DIR I Y S DIE=424.1,DR=".07////^S X=1" D ^DIE S FINAL=1 K DA,DIE,DR
 I $D(DUOUT)!$D(DTOUT) L -^PRC(424.1,DRDA) D DEL Q
AMT W ! K DIR S DIR(0)="N^-999999999.99:999999999.99:2"
 S DIR("A")="Daily Activity AMOUNT",DIR("?")="Enter amount of this authorization or '^' to QUIT" D ^DIR I $D(DIRUT) L -^PRC(424.1,DRDA) D DEL Q
 S AAMT=Y
 I AAMT>$P($G(^PRC(424,AUDA,0)),U,5) D AMTOVR^PRCEDRE0 I PRCADJ D DEL,EXIT Q
 D NOW^%DTC S TIME=% D BUL^PRCEAU0
 S DA=DRDA,DIE=424.1,DR=".02////^S X=AUDA;.03////^S X=-AAMT;.04///^S X=""NOW"";.05////^S X=DUZ;.06;.08;1.1;.1////^S X=DUZ" D ^DIE
 S $P(^PRC(424,AUDA,0),U,5)=$P($G(^PRC(424,AUDA,0)),U,5)-AAMT
 I FINAL S DA=AUDA D ZERO^PRCEAU1
 Q
DEL ;delete daily authorization
 S DIK="^PRC(424.1,",DA=$G(DRDA) D ^DIK S X=" --- Daily Authorization Entry Deleted ---*" D MSG^PRCFQ
 S $P(^PRC(424,AUDA,0),U,11)=$P($G(^PRC(424,AUDA,0)),U,11)-1
 Q
AUTHDIS W !!,"Authorization amount : ","$" S Y=$FN($P($G(^PRC(424,AUDA,0)),U,12),",P",2) W $$LBF1^PRCFU(Y,14)
 W !,"Authorization balance: ","$" S Y=$FN($P($G(^PRC(424,AUDA,0)),U,5),",P",2) W $$LBF1^PRCFU(Y,14)
 W !?8,"Daily Records: " S X=0 F  S X=$O(^PRC(424.1,"AR",AUDA,X)) Q:'X  I $D(^PRC(424.1,X,0)) W:$O(^PRC(424.1,"AR",AUDA,0))'=X ! W ?23,$P(^PRC(424.1,X,0),U),?44,"$",$J(($P(^(0),U,3)/-1),9,2)
 Q

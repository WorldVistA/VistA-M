PRCEDRE0 ;WISC/LDB-ENTER/EDIT DAILY RECORD CONT ; 06/09/93  1:24 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Called from PRCEDRE and PRCEDRE1 to increase authorization amount
AMTOVR W $C(7),!,"This amount exceeds the authorization balance by $",$FN((AAMT-ABAL),",P",2)
 W !!,"The available authorization balance is $",$FN(ABAL,",P",2)
 W $C(7),!!,"This daily record amount cannot be entered until an",!,"increase has been made to the authorization."
 K DIR N X,Y S PRCADJ=0,DIR("A")="Would you like to increase the authorization amount at this time by $"_$FN((ABAL-AAMT),",-",2),DIR(0)="Y0",DIR("B")="NO" D ^DIR I 'Y S PRCADJ=1 Q
 W !!,"Checking the available obligation balance . . ."
 S BAL=$$BAL^PRCH58(PODA)
 I $P(BAL,U,3)+AAMT-ABAL>+BAL D  Q
 . W !,"This authorization amount will exceed the obligation balance by $",$FN($P(BAL,U,3)+AAMT-ABAL-BAL,",P",2) S PRCADJ=2 D ASK^PRCEADJ
 . W !,"This daily record cannot be posted until Fiscal has obligated"
 . W !,"the increase adjustment."
 S PRCADJ=0,AAMT1=AAMT,AAMT=(AAMT-ABAL) D ADJ S AAMT=AAMT1 Q:PRCADJ
 S $P(^PRC(424,AUDA,0),U,5)=ABAL+(AAMT-ABAL),$P(^(0),U,12)=$P(^(0),U,12)+(AAMT-ABAL) D BALUP^PRCH58(PODA,(AAMT-ABAL)) Q
ADJ ;Called to make adjustment entry in 424.1 for authorization adjustment
 K DIC S DLAYGO=424.1,DIC="^PRC(424.1,",DIC(0)="L",X=""""_$P(AUDA0,U)_"-"_0_"""",DIC("DR")=".011////^S X=""A"";.02////^S X=AUDA;.03////^S X=AAMT;.04///^S X=""NOW"";05////^S X=DUZ"
 D ^DIC S:Y<0 PRCADJ=1 K DIC,X,Y
 Q
 ;WISC/PLT - add authorization from daily actvity option
AU(PRC424) ;add an authorization record called from PRCEDRE
 S PRC424=""
 D YN^PRC0A(.X,.Y,"Add an authorization","","YES") G EXIT:Y'=1
 N AMT,PRCF,DIC,DIR,DLAYGO,DIE,DA,DR,Y,X,TRDA,ER,TIME,IN,ABAL,ACT,AUDA,BAL1,BAL2,Z,X,Y
 D NOW^%DTC S TIME=% K Y
 S (X,Z)=PRC("SITE")_"-"_$P($G(TRNODE(4)),U,5)
 D WAIT^PRCFYN,EN1^PRCSUT3 S DIC="^PRC(424,",DLAYGO=424,DIC(0)="LXZ" D ^DIC I Y<0 S X="Unable to create an new entry.  Contact Application Coordinator.*" D MSG^PRCFQ G EXIT
 W !,"This entry has been assigned transaction number: ",$P(X,"-",3),"."
 S DIE=DIC,(AUDA,DA)=+Y,AUDA0=Y(0)
 D NOW^%DTC S TIME=% K Y
 D BALDIS^PRCEAU1
AMT ;ask authorization amount
 G:$D(DIRUT) EXIT K DIR S DIR(0)="N^.01:999999999.99:2",DIR("A")="AUTHORIZATION AMOUNT",DIR("?")="enter the amount of this authorization or '^' to QUIT" D ^DIR
 I $D(DIRUT)!(Y<.01) D AMTMSG,AMTDEL G EXIT
 ;balance alert message
 D BUL^PRCEAU0
 I Y>(+BAL-$P(BAL,U,3)) D  G EXIT
  . W $C(7),!,"This amount will EXCEED obligation balances by $",$FN((+BAL-$P(BAL,U,3))-Y,",",2),"."
  . W !!?20,"SERVICE BALANCE: $",$FN(+BAL-$P(BAL,U,3),",",2),!! H 3
  . W !!,"This authorization cannot be entered until CP/Fiscal have increased ",!,"and obligated the adjustment." K DIR,DIC
  . D ADJMSG,AMTDEL
EN1 S BAL1=+Y,DR=".02////^S X=PODA;.03////^S X=""AU"";.07////^S X=TIME;.08////^S X=DUZ;.05////^S X=BAL1;.12////^S X=BAL1;.13////^S X=BAL1;.1;1.1"
 D ^DIE
 I $D(Y) D DEL^PRCEAU0 G EXIT
 Q:'$D(^PRC(424,AUDA,0))  S X(1)=0
 ;add record in file 424.1 and edit balance in file 442
 D LREC^PRCEAU0 S:$D(^PRC(424,AUDA,0)) PRC424=AUDA
EXIT L:$D(AUDA) -^PRC(424,AUDA) K DIK,DIRUT,DIROUT,TRNODE,DTOUT,DUOUT Q
AMTMSG S X="----Amount missing - authorization deleted----" D MSG^PRCFQ Q
ADJMSG S X="Authorization deleted pending adjustment action by CP/Fiscal.." D MSG^PRCFQ Q
AMTDEL S DA=AUDA,DIK="^PRC(424," D ^DIK Q

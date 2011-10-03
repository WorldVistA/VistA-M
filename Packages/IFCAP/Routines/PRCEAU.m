PRCEAU ;WISC/CLH/LDB/BGJ-CREATE/EDIT AUTHORIZATIONS-CONTROL POINTS ; 15 Apr 93  1:20 PM
V ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Enter new or edit old authorizations
 N AMT,PRC,PRCF,DIC,DIR,DLAYGO,DIE,DA,DR,Y,X,PODA,TRDA,ER,TIME,IN,ABAL,ACT,AUDA,BAL,BAL1,BAL2,Z,X,Y
 ;S PRCF("X")="S" D ^PRCFSITE Q:'%
 D EN3^PRCSUT Q:'$D(PRC("CP"))
 ;look up obligation number
GO S DIC="^PRCS(410," D OROBL^PRCS58OB(DIC,.PRC,.Y) G EXIT:Y<0 S PRCRI(410)=+Y
EN0 K DIR,AMT,PRCF,PODA,TRDA,ER,TIME,IN,ABAL,ACT,AUDA,BAL,BAL1,BAL2,Z,X,Y
 D NODE^PRCS58OB(PRCRI(410),.TRNODE) S PODA=$P($G(TRNODE(10)),U,3)
 G:'$G(PODA) GO
EN ;when and poda and site variables are defined
 S BAL=$$BAL^PRCH58(PODA)
 D NOW^%DTC S TIME=% K Y
 K Y S DIR("?")=" ",DIR(0)="SOA^1:CREATE;2:EDIT",DIR("A")="Would you like to EDIT or CREATE an Authorization: ",DIR("?",1)="If you want to EDIT an existing authorization type 'E'"
 S DIR("?",2)="If you want to CREATE a NEW authorization type 'C'",DIR("?",3)="OR press <RETURN>" D ^DIR K DIR G:Y["^"!(Y="") GO I Y=2 D  G EN0
  . S DIC="^PRC(424," S DIC(0)="AEMNQ" S DIC("S")="I $P($P(^(0),U),""-"",1,2)=(PRC(""SITE"")_""-""_$P($G(TRNODE(4)),U,5)),$P(^(0),U,3)=""AU""" D ^DIC K DIC("S") Q:Y<0
  . S (AUDA,DA)=+Y,AUDA0=$P(Y,U,2),DIE=DIC
  . L +^PRC(424,DA):3 E  S X="Another user is editing this entry. Try later." D MSG^PRCFQ Q
  . D BALDIS^PRCEAU1 W ?35,"Authorization balance: ","$" S Y=$FN($P($G(^PRC(424,+AUDA,0)),U,5),",P",2) W $$LBF1^PRCFU(Y,14),!
  . K DIR S DIR(0)="L^1:6",DIR("A",1)="   1 Edit authorization",DIR("A",2)="   2 Mark authorization as COMPLETE"
  . S DIR("A",3)="   3 ZERO out authorization",DIR("A",4)="   4 Reopen Authorization",DIR("A",5)="   5 Enter/Edit COMMENTS",DIR("A",6)="   6 QUIT"
  . S DIR("A")="Select ACTION",DIR("?")="^D HLP^PRCEAU0" D ^DIR
  . Q:'Y
  . K FINAL S ACT=Y F JJ=1:1 S I=$P(ACT,",",JJ) Q:I=""  D  Q:$D(FINAL)
    .. Q:I=6
    .. I I<4,$P($G(^PRC(424,AUDA,0)),U,9) W !,"This authorization has been marked as completed",!,"and must first be reopened to continue." S FINAL=1 Q
    .. I I=1 N ACT,I D ADJ^PRCEAU1 Q
    .. I "23"[I N ACT,I D ZERO^PRCEAU1 Q
    .. I I=4,'$P(^PRC(424,AUDA,0),U,9) W !,"This authorization is not marked as complete yet.",$C(7) H 3 Q
    .. I I=4 S FINAL=1 N ACT,I D OPN^PRCEAU1 K FINAL Q
    .. S DR="1.1" D ^DIE Q
    .. Q
 S (X,Z)=PRC("SITE")_"-"_$P($G(TRNODE(4)),U,5)
 D WAIT^PRCFYN,EN1^PRCSUT3 S DIC="^PRC(424,",DLAYGO=424,DIC(0)="LXZ" D ^DIC I Y<0 S X="Unable to create an new entry.  Contact Application Coordinator.*" D MSG^PRCFQ G EXIT
 W !,"This entry has been assigned transaction number: ",$P(X,"-",3),"."
 S DIE=DIC,(AUDA,DA)=+Y,AUDA0=Y(0)
 D NOW^%DTC S TIME=% K Y
 D BALDIS^PRCEAU1
AMT ;looping area for authorization amount
 G:$D(DIRUT) EN0 K DIR S DIR(0)="N^.01:999999999.99:2",DIR("A")="AUTHORIZATION AMOUNT",DIR("?")="enter the amount of this authorization or '^' to QUIT" D ^DIR
 I $D(DIRUT)!(Y<.01) D AMTMSG,AMTDEL G EN0
 ;   no MAIL for create authorization
 ;D BUL^PRCEAU0
 I Y>(+BAL-$P(BAL,U,3)) D  G EN0
  . W $C(7),!,"This amount will EXCEED obligation balances by $",$FN((+BAL-$P(BAL,U,3))-Y,",",2),"."
  . W !!?20,"SERVICE BALANCE: $",$FN(+BAL-$P(BAL,U,3),",",2),!! H 3
  . W !!,"This authorization cannot be entered until Fiscal has obligated ",!,"the increase adjustment." K DIR,DIC
  . D ASK^PRCEADJ,ADJMSG,AMTDEL
EN1 S BAL1=+Y,DR=".02////^S X=PODA;.03////^S X=""AU"";.07////^S X=TIME;.08////^S X=DUZ;.05////^S X=BAL1;.12////^S X=BAL1;.13////^S X=BAL1;.1;1.1"
 D ^DIE
 I $D(Y) D DEL^PRCEAU0 G EN0
 Q:'$D(^PRC(424,AUDA,0))  S X(1)=0
 D LREC^PRCEAU0 G EN0
EXIT L:$D(AUDA) -^PRC(424,AUDA) K DIK,DIRUT,DIROUT,TRNODE,DTOUT,DUOUT Q
AMTMSG S X="----Amount missing - authorization deleted----" D MSG^PRCFQ Q
ADJMSG S X="Authorization deleted pending adjustment action by Fiscal.." D MSG^PRCFQ Q
AMTDEL S DA=AUDA,DIK="^PRC(424," D ^DIK Q

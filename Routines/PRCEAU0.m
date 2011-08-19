PRCEAU0 ;WISC/LDB/BGJ-CREATE/EDIT AUTHORIZATION-CONTROL POINTS CONT. ; 07/08/93  12:03 PM
V ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BUL ;called from PRCEAU,PRCEDRE/DRE1 to alert control about remaining balance
 Q:$P($G(^PRC(424,+$G(AUDA),0)),"^",5)=""
 ;  send bulletin, if remaining balance minus daily entry is 
 ;     smaller than 5% of the 1358 obligated balance.
 I $P(^PRC(424,+AUDA,0),U,5)-Y<($P(BAL,U)*.05) D EN^PRCEBL
 Q
DEL ;delete or retain when uparrow entered
 S DIR(0)="YO",DIR("A")="Would you like to DELETE this authorization",DIR("B")="YES",DIR("?")="press <RETURN> to delete this entry, enter NO or '^' to retain entry" D ^DIR
 I Y["^"!(Y=0) Q
 D WAIT^PRCFYN
 S DA=AUDA,DIK="^PRC(424," D ^DIK S X="--- Entry Deleted ---*" D MSG^PRCFQ
 S BAL1=-$G(BAL1) D BALUP^PRCH58(PODA,BAL1) S X="--- Obligation balances updated ---" D MSG^PRCFQ
 Q
HLP ;help response for the reader
 W !,"Enter the corresponding number for the action you want to take.",!,"You can select one or more items from the list provided."
 W !,"ZEROing out an authorization will mark the authorization as complete and return any monies left over to the obligation."
 W !,"The numbers can be seperated by commas, dashes or combination of",!,"both.  i.e. 1,2,3,4 or 1-4 or 1-3,4."
 Q
LREC ;Called from PRCEAU to enter 424.1 entry
 L +^PRC(424,AUDA,0):3 E  S X(1)=X(1)+1 G:(X(1)<4) LREC I X(1)>3 S X="Someone else is editing this authorization. Try later." D MSG^PRCFQ,AMTDEL^PRCEAU Q
DREC S DIC="^PRC(424.1,",DIC(0)="LX",DLAYGO=424.1,X=AUDA0,X=""""_X_"-"_0_"""" D ^DIC
 I Y<0 S X="The daily record entry cannot be entered. Please see the Application Coordinator." D MSG^PRCFQ,AMTDEL^PRCEAU
 I '$P(Y,U,3) S X1=X1+100 G DREC
 L -^PRC(424,AUDA,0)
 F  L +^PRC(424.1,+Y,0):1 I  Q
 S DIE="^PRC(424.1,",DA=+Y,DR=".011////^S X=""AU"";.02////^S X=AUDA;.03////^S X=BAL1;.04////^S X=TIME;.05////^S X=DUZ;.08////^S X=""ORIGINAL AMOUNT"";.1////^S X=DUZ" D ^DIE
 L -^PRC(424.1,DA,0)
 D BALUP^PRCH58(PODA,BAL1)
 Q

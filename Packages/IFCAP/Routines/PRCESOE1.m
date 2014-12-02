PRCESOE1 ;WISC/SJG-1358 OBLIGATION UTILITIES ; 
V ;;5.1;IFCAP;**176**;Oct 20, 2000;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 QUIT
 ; No top level entry
 ;
LOOKUP ; Lookup 1358 transaction which is pending fiscal action.
 N DIC,FSO,TN,PRCLOCK
 F  D  Q:$G(PRCLOCK)  W !!,"***The Transaction Number you are attempting to access is being accessed by another user***",!! ;Only allow one user to access 410 record at a time, PRC*5.1*176
 .S:'$D(TT) TT="O"
 .S DIC=410,DIC(0)="AEMNZ",FSO=$O(^PRCD(442.3,"AC",10,0)),DIC("S")="S TN=^(0) I $P($P(TN,U),""-"",1,2)=PRCF(""SIFY""),TT[$P(TN,U,2),$P(TN,""^"",4)=1,$D(^(10)),$P(^(10),U,4)=FSO"
 .D ^PRCSDIC
 .I Y>0 L +^PRCS(410,+Y):$G(DILOCKTM,3) S PRCLOCK=$T
 .I Y<1 S PRCLOCK=$T
 QUIT
POST ; Post data in file 424
 N X,Z,DAR,DIC,Y,DA,DIE,DR,TIME
 S (X,Z)=PATNUM,%=1 D EN1^PRCSUT3 I +$P(X,"-",3)>1 W $C(7),!,"This is not a new 1358.  Adjustments may only be entered through the",!,"adjustment option." H 3 S %=0 Q
 S DIC=424,DIC(0)="LX",DLAYGO=424 D ^DIC K DLAYGO I Y<0 W !,"ERROR IN CREATING 424 RECORD" S %=0 Q
 S DAR=+Y
 D NOW^%DTC S TIME=%,DIE=DIC,DA=DAR,X=PODA,DR=".02////^S X=PODA;.03////^S X=""O"";.06////^S X=$P(PO(0),U,11);.07////^S X=TIME;.08////^S X=DUZ;1.1///^S X=""INITIAL OBLIGATION"";.15////^S X=OB"
 D ^DIE S %=1
 QUIT
 ; Message Processing called from PRCESOE
MSG ;
 W !! K MSG S MSG="No further processing is being taken on this obligation."
 D EN^DDIOL(MSG) K MSG
 Q
MSG1    ;
 W !! K MSG S MSG(1)="No further processing is being taken on this 1358.  It has NOT been obligated."
 S MSG(2)="The entry in the Purchase Order file is being deleted."
 D EN^DDIOL(.MSG) K MSG
 Q
MSG2(MSG) ;
 S:'$D(ROUTINE) ROUTINE="PRCUESIG"
 W !!,$$ERROR^PRCFFU13(ROUTINE,MSG)
 D MSG
 Q
MSG3 ;
 S MSG(1)="No Obligation Number or Common Number Series has been selected."
 S MSG(2)="No further action taken on this obligation."
 W !! D EN^DDIOL(.MSG) H 3 K MSG
 Q

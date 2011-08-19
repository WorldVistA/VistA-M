EEOEOE1 ;HISC/CFB/CJM - CLOSE/DELETE;8/20/96
 ;;2.0;EEO Complaint Tracking;**10**;AUG-20-96
 ;
CLOSE ;Close a case
 S (DIC("A"),EEOYQ)="Close case."
 S (DIC,DIE)="^EEO(785,",DIC(0)="AEQMZ"
 S (EEOYSCR,DIC("S"))="I $$SCREEN^EEOEOSE(Y) I $P($G(^EEO(785,Y,1)),U,3)>0!(+$G(^EEO(785,Y,""SEC""))'>0)"
 S (EEOYDICA,DIC("A"))="Select Complainant:  "
 S DR="48;49" D CALL("CLOSE") G:$G(DA)>0 CLOSE
 Q
 ;
UNDELETE K DR
UND S DIC("S")="I $P($G(^EEO(785,+Y,12)),U,2)'=""""" S DIC="^EEO(785,"
 S DIC(0)="AEMQZ",DIC("A")=" Select Complainant to be Undeleted:  "
 S:$G(DR)["48.5" DIC("A")="Another:  "
 S DR="48.5///@",DIE=785 D CALL("UNDELETE") I $G(DA)>0 S $P(^XTMP("EEOX",DA,12),U,2)="@" W !!,"   Undeleted!!",!! G UND
 K Y,DIE,DR,DA,DIC Q
 ;
DELETE ;Delete a specific EEO case
 W !!,"** Deleting a complaint does not actually cause its deletion, but does",!,"prevent it from being viewed. It can be undeleted later if necessary. **",!
 S (DIC("A"),EEOYQ)="Delete a specific EEO case."
 S (DIC,DIE)="^EEO(785,",DIC(0)="AEQMZ"
 S (EEOYDICA,DIC("A"))="Select Complainant:  "
 S (EEOYSCR,DIC("S"))="I $$SCREEN^EEOEOSE(Y) I $P($G(^EEO(785,Y,1)),U,3)>0!(+$G(^EEO(785,Y,""SEC""))'>0)"
 S DR="48.5///D" D CALL("DELETE") I $G(DA)>0 W !!,"    Deleted!!",!! G DELETE
 Q
REOP ;
 S EEOYQ="Reopen a previously closed case "
 S (DIC,DIE)="^EEO(785,",DIC(0)="AEQMZ"
 S (EEOYSCR,DIC("S"))="I $$SCREEN^EEOEOSE(Y) I $G(^EEO(785,Y,4))'="""" I $G(^(4))'=""^"""
 S (EEODICA,DIC("A"))="Select Complainant:  "
 S DR="48///@;49///@" D CALL("REOPEN") I $G(DA)>0 S ^XTMP("EEOX",DA,4)="@^@" G REOP
 Q
CALL(ACTION) ;
 K DA D ^DIC Q:X="^"!("")!($D(DTOUT))
 S EOY=+Y
 Q:+Y'>0
 I (ACTION'="CLOSE")!($G(^EEO(785,+Y,4))="^")!($G(^EEO(785,+Y,4))="") I '$$RUSURE(ACTION) S DA=0 Q
 S DA=+Y,DR=DR_";62///X"
 D ^DIE
 D CASENO^EEOEOSE
 S ^XTMP("EEOX",0)=DT+5_"^"_DT
 Q
 ;
RUSURE(ACTION) ;asks user for confirmation if ACTION should be taken, returns 0 or 1
 ;
 N ANS
ASK W !!,"Are you sure you want to "_ACTION_" this complaint YES/"
 S ANS=""
 R ANS:30
 I '$T Q 0
 I ANS="" Q 1
 I ANS["?" W !!,"Enter YES or NO" G ASK
 I ANS["^" Q 0
 I "Yy"[$E(ANS,1) Q 1
 I "Nn"[$E(ANS,1) Q 0
 Q 0

QACNEWSV ;WCIOFO/ERC-Enter a new Service/Discipline ;9/13/97
 ;;2.0;Patient Representative;**3,5,12**;07/25/1995
 ;This routine allows Patient Advocates to make new entries in the
 ;Service/Discipline file (#745.55)
 S DIC="^QA(745.55,"
 S DIC(0)="AEL"
 S DIC("A")="Enter a new Service/Discipline: "
 S DLAYGO=745.55
 D ^DIC
 K DLAYGO
 Q:$G(Y)<0
 S DIE=DIC,DR=".01;1;2;3"
 S (DA,QACDA)=+Y
 D ^DIE
 ; if user does not enter a Discipline, display a message and give 
 ; another chance
 I $P(^QA(745.55,QACDA,0),U,3)']"" D
 . W !!?5,"Service/Discipline must point to a Discipline.",!
 . S DR="2;3" D ^DIE
 ; if still no discipline display a message & delete Service/Discipline
 I $P(^QA(745.55,QACDA,0),U,3)']"" D
 . W !!?5,"No Discipline entered - deleting Service/Discipline.",!
 . S DIK=DIE,DA=QACDA D ^DIK
 K DA,DIC,DIE,DR,QACDA
 Q

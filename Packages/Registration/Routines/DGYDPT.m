DGYDPT ;ALB/ESD - DG*5.3*9 Post Init Routine ;10/25/93
 ;;5.3;Registration;**9**;Aug 13, 1993
 ; This removes screen.
 S X="DGJ EDIT COMP IRT SUPER",DIC(0)="X",DIC="^ORD(101,"
 D ^DIC
 S DIE=DIC,DA=+Y,DR="24///@"
 D ^DIE K DIE,DIC,DA,DR,X,Y
 ; This runs ONITS.
 D ^DGYDONIT
 ; This loads the list template.
 D ^DGYDL
 Q

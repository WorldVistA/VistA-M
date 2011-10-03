GECSSCOM ;WISC/RFJ-stacker file enter user comments                 ;27 Sep 94
 ;;2.0;GCS;;MAR 14, 1995
 N D0,DA,DATA,DI,DIC,DIE,DQ,DR,GECSDOC,GECSXMZ,STATUS,X
 F  S DA=$$SELECT^GECSSTAA("","","","","Select Stack Document: ") Q:'DA  S GECSDOC=$P(DA,"^",2),DA=+DA D
 .   L +^GECS(2100.1,DA):5 I '$T W !,"Another user is working with the stack document, try again later." Q
 .   S STATUS=$P(^GECS(2100.1,DA,0),"^",4) S:STATUS="" STATUS="?"
 .   W !?5,"Current Status: ",$$STATUS^GECSSGET(GECSDOC)
 .   ;
 .   S (DIC,DIE)="^GECS(2100.1,",DR=4.1 D ^DIE
 .   L -^GECS(2100.1,DA)
 Q

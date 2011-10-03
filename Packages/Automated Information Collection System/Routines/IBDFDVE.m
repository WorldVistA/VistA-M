IBDFDVE ;ALB/AAS - AICS edit printers file ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% ; -- Edit Encounter Form Printers file (357.94)
 ;
 N I,J,X,Y,DA,DIC,DR,DIE,DLAYGO
 W !!,"Add/Edit Encounter Form Printers Terminal Type"
 ;
ASK W !!
 S DLAYGO=357.94,DIC="^IBE(357.94,",DIC(0)="AEQML" D ^DIC G:Y<1 END
 S DA=+Y D EDIT
 G ASK
 Q
 ;
EDIT ; -- edit entry
 S DR="[IBDF EDIT PRINTER]",DIE="^IBE(357.94,"
 D ^DIE
 K DIE,DA,DR
 Q
 ;
END Q

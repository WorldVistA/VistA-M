ENPAT14 ;WISC/SAB-ENG DJ SCREEN CORRECTION ;4/12/94
 ;;7.0;ENGINEERING;**14**;Aug 17, 1993
 N DA,DIC,DIE,DR,X,Y
 W !,"Correcting ENG DJ SCREEN 'ENEQNX1'...",!
 S DIC="^ENG(6910.9,",DIC(0)="X",X="ENEQNX1" D ^DIC I Y<0 W !!,"ERROR - Screen ENEQNX1 not found in ENG DJ SCREEN file!",!! Q
 S DIC="^ENG(6910.9,"_+Y_",1,",DIC(0)="X",X="MANUFACTURER" D ^DIC I Y<0 W !!,"ERROR - Label MANUFACTURER not found in ENEQNX1 Screen in ENG DJ SCREEN file!",!! Q
 S DA=+Y,DIE=DIC,DR="2///I $D(ENDA) S DA=ENDA D LAST^ENEQ2" D ^DIE
EXIT ;
 W !,"Correction completed. This routine (ENPAT14) can be deleted.",!
 Q

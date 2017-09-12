XT73P33 ;SF-CIOFO/JDS KIDs Post-Init for Patch XT*7.3*33 ;11/25/98  10:23
 ;;KIDs Post-Init
 Q
POST ;post init entry
 W !!,"Removing 'Affects Records Merge' entries in Package File for Toolkit..."
 N DIC
 S DIC="^DIC(9.4,",DIC(0)="XS",X="TOOLKIT" D ^DIC
 Q:+Y<0
 K ^DIC(9.4,+Y,20)
 W !!,"Finished",!
 Q

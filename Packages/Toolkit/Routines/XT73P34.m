XT73P34 ;SF-CIOFO/JDS KIDs Post-Init for Patch XT*7.3*34 ;02/04/99  13:22
 ;;KIDs Post-Init
 Q
POST ;post init entry
 W !!,"Removing 'Affects Records Merge X-ref' entries in Package File for Toolkit..."
 N DIC
 S DIC="^DIC(9.4,",DIC(0)="XS",X="TOOLKIT" D ^DIC
 Q:+Y<0
 ;dbia 2656, direct kill of "AMRG" x-ref
 K ^DIC(9.4,"AMRG",2,+Y)
 W !!,"Finished",!
 Q

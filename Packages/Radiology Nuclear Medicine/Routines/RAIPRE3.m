RAIPRE3 ;HIRMFO/GJC- Pre-init routine ;11/12/97  11:38
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN8 ; See that the "NM" nodes for sub-files 200.072 (Rad/Nuc Med
 ; Classification) and sub-file 200.074 (Rad/Nuc Med Location Access)
 ; are correct.  If nodes need to be corrected, delete the sub-file
 ; and retain the data.
 I $D(^DD(200.072,0,"NM","RAD NUC MED CLASSIFICATION"))#2 D
 . N %,DIC,DIU S DIU=200.072,DIU(0)="S" D EN^DIU2 Q
 I $D(^DD(200.074,0,"NM","RAD NUC MED LOCATION ACCESS"))#2 D
 . N %,DIC,DIU S DIU=200.074,DIU(0)="S" D EN^DIU2 Q
 Q

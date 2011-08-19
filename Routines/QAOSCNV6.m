QAOSCNV6 ;HISC/DAD-DELETE DESCRIPTIONS ;7/19/93  12:45
 ;;3.0;Occurrence Screen;;09/14/1993
 ;;
 W !!,"Cleaning up OPTION and FIELD descriptions"
 W !,"-----------------------------------------"
 W !!,"Working"
 F QAOSLINE=1:1 S QAOSDATA=$P($T(DATA+QAOSLINE),";;",2) Q:QAOSDATA=""  D
 . W "."
 . I QAOSDATA'>0 D OPTN Q
 . E  D FLDS Q
 K QAOSLINE,QAOSDATA,QAOSOPT,QAOSD0,QAOSDD,QAOSFLD,DIE,DA,DR
 Q
OPTN ; *** Delete OPTION file descriptions
 S QAOSOPT=QAOSDATA,QAOSD0=0
 F  S QAOSD0=$O(^DIC(19,"B",QAOSOPT,QAOSD0)) Q:QAOSD0'>0  D
 . Q:$P($G(^DIC(19,QAOSD0,0)),"^")'=QAOSOPT
 . S DIE="^DIC(19,",DA=QAOSD0,DR="3.5///@"
 . D ^DIE
 . Q
 Q
FLDS ; *** Delete FIELD descriptions
 S QAOSDD=$P(QAOSDATA,"^"),QAOSFLD=$P(QAOSDATA,"^",2)
 Q:$O(^DD(QAOSDD,QAOSFLD,21,0))'>0
 S DIE="^DD("_QAOSDD_",",DA=QAOSFLD,DR="21///@"
 D ^DIE
 Q
DATA ;; Option_Name   OR   DD_Number ^ Field_Number
 ;;QAOS GENERATE EWS BULLETIN
 ;;QAOS RPT REVIEW SUMMARY
 ;;741^19
 ;;741^22
 ;;741^28
 ;;741.01^4
 ;;741.01^9
 ;;741.6^.01

RMPFPSTC ;DDC/MAB-POSTINIT FOR PATCH RMPF*2*12; [ 05/12/98  2:24 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**12**;MAY 12, 1998
 ;;This postinit changes the NON CONTRACT ITEMS field in the Order
 ;;Type file to "do not allow non-contract items" for the Custom Hearing Aid entry
 N ZZ
 S ZZ=$O(^RMPF(791810.1,"AD","C",0)) Q:'ZZ
 Q:'$D(^RMPF(791810.1,ZZ,0))
 S DA=ZZ,DIE="^RMPF(791810.1,",DR=".09////0" D ^DIE
END K ZZ,I,DA,DIE,DR Q

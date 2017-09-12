RMPFPST ;DDC/MAB-POSTINIT FOR PATCH RMPF*2*5; [ 11/24/97  11:24 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**5**;NOV 24, 1997
 ;;This postinit changes the NON CONTRACT ITEMS field in the Order
 ;;Type file to "allow non-contract items" for the Accessories and accessorites stock entries only
 N ZZ,I
 F I="Q","W" D
 .S ZZ=$O(^RMPF(791810.1,"AD",I,0)) Q:'ZZ
 .Q:'$D(^RMPF(791810.1,ZZ,0))
 .S DA=ZZ,DIE="^RMPF(791810.1,",DR=".09////1" D ^DIE
END K ZZ,I,DA,DIE,DR Q

IBCNSMRE ;ALB/AAS,TJK - MRA EXTRACT ; 02-SEPT-97
 ;;2.0;INTEGRATED BILLING;**92,146**;21-MAR-94
 ;
 ;
BLDLST ; -- Build list of insurance companies for MRA extract
 N I,J
 W !!,"Create a list of Insurance Companies for the MRA Extract",!
 ;
 I '$O(^IBE(350.9,1,99,0)) W "  No Entries have been made."
 I $O(^IBE(350.9,1,99,0)) W "  The Following Entries have been made:"  D
 .S I=0
 .F  S I=$O(^IBE(350.9,1,99,I)) Q:'I  S J=$G(^IBE(350.9,1,99,I,0)) W !,?10,$P($G(^DIC(36,J,0)),"^")
 W !!
 ;
BLD1 N DA,DIC,DIE,DR,X,Y
 S DA=1
 S DIE="^IBE(350.9,",DR=99 D ^DIE
 Q

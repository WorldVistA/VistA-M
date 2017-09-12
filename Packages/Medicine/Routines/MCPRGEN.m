MCPRGEN ;HCIOFO/JCC-PRE INSTALL FOR G.P. (PATCH 8);5/23/97  09:21
 ;;2.3;Medicine;**8**;09/13/1996
EN ;Delete two screens for Generalized Procedure
 N Y
 S Y=$O(^MCAR(697.3,"B","MCFSGEN",0)) G NEXT:Y=""
 S DIK="^MCAR(697.3,",DA=Y D ^DIK
NEXT S Y=$O(^MCAR(697.3,"B","MCBSGEN",0)) G EXIT:Y=""
 S DIK="^MCAR(697.3,",DA=Y D ^DIK
EXIT K DIK,DA
 Q

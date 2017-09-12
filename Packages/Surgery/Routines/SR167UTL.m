SR167UTL ;BIR/ADM - SR*3*167 UTILITY ROUTINE ;09/11/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 Q
PRE ; remove 33945, 47135, 47136 from file 137
 K DA,DIK F DA=33945,47135,47136 S DIK="^SRO(137," D ^DIK K DA,DIK
 ;delete DD for modified field #69 in file #139.5
 S DA=69,DIK="^DD(139.5,",DA(1)=139.5 D ^DIK K DA,DIK
 Q

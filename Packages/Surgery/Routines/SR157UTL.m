SR157UTL ;BIR/SJA - SR*3*157 UTILITY ROUTINE ;07/05/06
 ;;3.0; Surgery ;**157**;24 Jun 93;Build 3
 Q
PRE ; pre-install action for SR*3*157
 ;
 ;delete DD for modified field #.232
 S DIK="^DD(130,",DA=.232,DA(1)=130 D ^DIK
 Q

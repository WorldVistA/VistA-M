SR153UTL ;BIR/ADM - SR*3*153 UTILITY ROUTINE ;02/24/06
 ;;3.0; Surgery ;**153**;24 Jun 93;Build 11
 Q
PRE ; pre-install action for SR*3*153
 ;
 ; delete data from file 136.5  and re-initialize file
 K ^SRO(136.5) S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^^"
 ;delete DD for modified field #202
 S DIK="^DD(130,",DA=202,DA(1)=130 D ^DIK
 Q
POST ; add ANION GAP to file 139.2
 N SRI
 I $G(^SRO(139.2,26,0))'="ANION GAP" D
 .S DA=26,DIK="^SRO(139.2," D ^DIK
 .S ^SRO(139.2,26,0)="ANION GAP",^SRO(139.2,26,2)=72
 .S DIK="^SRO(139.2,",DIK(1)=".01" D ENALL^DIK K DA,DIK
 ; add HEMOGLOBIN A1C to file 139.2
 I $G(^SRO(139.2,27,0))'="HEMOGLOBIN A1C" D
 .S DA=27,DIK="^SRO(139.2," D ^DIK
 .S ^SRO(139.2,27,0)="HEMOGLOBIN A1C",^SRO(139.2,27,2)=70
 .S DIK="^SRO(139.2,",DIK(1)=".01" D ENALL^DIK K DA,DIK
 ;
 ;VALVE REPAIR field (#370), convert any existing N's to '5' for NONE
 ;NUM OF PRIOR HEART SURGERIES (#352), convert any existing N's to '0' for NONE
 ;CURRENT SMOKER field (#202), existing data for CICSP in this field will be placed in CURRENT SMOKER (CARDIAC) field (#510)
 S SRTN=0 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  D
 .I $P($G(^SRF(SRTN,207)),"^",6)="N" S $P(^(207),"^",6)=5
 .I $P($G(^SRF(SRTN,206)),"^",15)="N" S $P(^(206),"^",15)=0
 .S SRI=$P($G(^SRF(SRTN,200)),"^",3) I SRI>0 S $P(^SRF(SRTN,200.1),"^",5)=SRI,$P(^SRF(SRTN,200),"^",3)=""
 Q

SR166UTL ;BIR/ADM,SJA - SR*3*166 UTILITY ROUTINE ;01/15/08
 ;;3.0; Surgery ;**166**;24 Jun 93;Build 6
 Q
PRE ; add normal ranges to the cardiac test in file 139.2
 S $P(^SRO(139.2,21,2),"^",2)="10^90"  ;HDL
 S $P(^SRO(139.2,23,2),"^",2)="33^250"  ;LDL
 S $P(^SRO(139.2,24,2),"^",2)="60^330"  ;Total Cholesterol
 S $P(^SRO(139.2,22,2),"^",2)="20^600"  ;Serum Triglyceride
 S $P(^SRO(139.2,5,2),"^",2)="1^6"  ;Serum Potassium
 S $P(^SRO(139.2,14,2),"^",2)="0.1^2"  ;Serum Bilirubin
 S $P(^SRO(139.2,1,2),"^",2)="8^19"  ;Hemoglobin
 S $P(^SRO(139.2,7,2),"^",2)="0.5^8"  ;Serum Creatinine
 S $P(^SRO(139.2,11,2),"^",2)="1^6"  ;Serum Albumin
 S $P(^SRO(139.2,27,2),"^",2)="3^17"  ;Hemoglobin A1c
 ; delete data from file 136.5 and re-initialize file
 K ^SRO(136.5) S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^^"
 ; delete SROAMIS as menu item
 D DELETE^XPDMENU("SROANES1","SROAMIS")
 D DELETE^XPDMENU("SR ANESTH REPORTS","SROAMIS")
 ; remove 47135 from file 137
 S DA=47135,DIK="^SRO(137," D ^DIK K DA,DIK
 ; delete AE x-ref
 K DIK,DA S DIK="^DD(130,513,1,",DA=1,DA(1)=513,DA(2)=130 D ^DIK K DIK,DA
 Q
POST ;post-install action for SR*3*166
 ; set AT x-ref nodes
 N SRA,SROP,SRX K ^SRF("AT")
 S SROP=0 F  S SROP=$O(^SRF(SROP)) Q:'SROP  S SRA=$G(^SRF(SROP,"RA")) I SRA'="" D
 .S SRX=$P(SRA,"^",8) I SRX S ^SRF("AT",SRX,SROP)="" Q
 .S SRX=$P(SRA,"^",4) I SRX S ^SRF("AT",SRX,SROP)=""
 Q

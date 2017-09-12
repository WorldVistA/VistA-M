SR175UTL ;BIR/SJA - SR*3*175 UTILITY ROUTINE ;12/13/10
 ;;3.0;Surgery;**175**;24 Jun 93;Build 6
 Q
PRE ; pre-install process for SR*3*175
 ; delete data from file 136.5 and re-initialize file
 K ^SRO(136.5) S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^^"
 Q
POST ; add new cancellation reasons to file 135
 N SRA,SRI,SRCD,SRTXT,SRIEN,SRZ,SRA4,SRA8,SREF
 ; kill the 'AT' x-ref and rebuild it
 K ^SRF("AT") S SRZ=0
 F  S SRZ=$O(^SRF(SRZ)) Q:'SRZ  I $D(^SRF(SRZ,"RA")) S SRA=$G(^SRF(SRZ,"RA")),SRA4=$P(SRA,"^",4),SRA8=$P(SRA,"^",8) D
 .Q:'SRA4&'SRA8
 .S $P(^SRF(SRZ,"RA"),"^",4)=+SRA4,$P(^SRF(SRZ,"RA"),"^",8)=+SRA8,^SRF("AT",$S($G(SRA8):+SRA8,1:+SRA4),SRZ)=""
 ;
 ; inactivate the existing cancellation reasons.
 S SRZ=0 F  S SRZ=$O(^SRO(135,SRZ)) Q:'SRZ!(SRZ>1000)  S DIE=135,DA=SRZ,DR="10////1" D ^DIE K DA,DIE,DR
 ; kill then rebuild "B","C" x-ref:
 K ^SRO(135,"B"),^SRO(135,"C")
 F SRI=1:1 S SRX=$T(TXT+SRI) Q:SRX=""  S SRCD=+$P(SRX,";;",2),SRTXT=$P($P(SRX,";;",2),"^",2) D
 .S SRIEN=1000+SRI I '$D(^SRO(135,SRIEN,0)) S ^SRO(135,SRIEN,0)=SRTXT_"^"_(SRIEN-1000)
 F SREF=".01^B","1^C" S DIK="^SRO(135,",DIK(1)=SREF D ENALL^DIK
 K DIK S ^DD(135,.01,7.5)="I $G(DIC(0))[""L"",'$D(XUMF) K X D EN^DDIOL(""File is locked. No new entries or edits are allowed."","""",""!?5,$C(7)"")"
 ; populate file 137 with FY11 excluded CPT codes
 D PEX^SR175UT0
 Q
TXT ;
 ;;1^PATIENT ACTION (NO SHOW, ETC)
 ;;2^CHANGE IN TREATMENT, PT HEALTH
 ;;3^NO CONSENT
 ;;4^NO LIP (SURG, ANESTH, ETC)
 ;;5^NO PERIOP NURSING (OR, PACU)
 ;;6^NO BED AVAILABLE
 ;;7^NO EQUIPMENT, NOT RME, (C-ARM)
 ;;8^NO RME (SPD, IMPLANT, DEFECT)
 ;;9^OTHER

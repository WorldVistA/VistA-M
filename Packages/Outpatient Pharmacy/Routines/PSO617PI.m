PSO617PI ;ALB/ASF - eRx 617 POST INSTALL; 10/01/2020 11:24Am
 ;;7.0;OUTPATIENT PHARMACY;**617**;DEC 1997;Build 110
 ;
EN ;add/replace eRX reason codes - File 52.45
 N CKIEN,BRIEF,DA,DIE,DIC,DR,PSDUP,TYPE,X,Y
 D BMES^XPDUTL("Starting post-install for PSO*7*617")
 S DIC="^PS(52.45,",DIC(0)=""
 ;Hold codes
 S X="HCR",BRIEF="PRESCRIBER'S CS CREDENTIAL IS NOT APPROPRIATE",TYPE="ERX" D ADD
 S X="HWR",BRIEF="CS PRESCRIPTION WRITTEN/ISSUE DATE HAS PROBLEMS",TYPE="ERX" D ADD
 S X="HIS",BRIEF="PROVIDER DEA# ISSUE",TYPE="ERX" D ADD
 S X="HRX",BRIEF="HOLD FOR RX EDIT",TYPE="ERX" D ADD
 S X="HDE",BRIEF="DRUG USE EVALUATION",TYPE="ERX" D ADD
 S X="HTI",BRIEF="THERAPUTIC INTERCHANGE",TYPE="ERX" D ADD
 S X="HSC",BRIEF="SCRIPT CLARIFICATION",TYPE="ERX" D ADD
 S X="HGS",BRIEF="GENERIC SUBSTITUTION",TYPE="ERX" D ADD
 ; Remove codes
 S X="REM09",BRIEF="ERX Issue not resolved-Provider contacted",TYPE="REM" D ADD
 ;Reject codes
 S X="PVD03",BRIEF="Missing/bad digital signature on inbound CS ERX",TYPE="REJ" D ADD
 S X="PVD04",BRIEF="Prescriber's CS credential is not appropriate",TYPE="REJ" D ADD
 S X="PTT03",BRIEF="Patient's mailing address is missing/mismatched",TYPE="REJ" D ADD
 S X="ERR99",BRIEF="Other",TYPE="REJ" D ADD
 ; Repurpose DRU06
 S X="DRU06" D ^DIC I +Y>0 S DA=+Y,DIE=DIC,DR=".02///CS prescription written/issue date has problems" D ^DIE
 ;
 D BMES^XPDUTL("Post-install for PSO*7*617 completed successfully")
 Q
CK(X) ;Check if already entered
 S PSDUP=0
 I $D(^PS(52.45,"B",X)) S PSDUP=1
 Q PSDUP
ADD ;add entry
 S PSDUP=$$CK(X) Q:PSDUP
 S DIC("DR")=".02///"_BRIEF_";.03///"_TYPE
 D FILE^DICN
 Q

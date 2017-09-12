IB20P356 ;BP/TJH - Preinit routine for IB*2.0*356 ; 6/14/2006
 ;;2.0;INTEGRATED BILLING;**356**;21-MAR-94
 ;
 Q
EN ; entry point
 ;
DELERR ; delete old error code from file 350.8
 ;
 D BMES^XPDUTL("Deleting entry IB315 from IB ERROR file...")
 S X="IB315",DIC(0)="",DIC="^IBE(350.8," D ^DIC
 I Y>0 S DA=+Y,DIK="^IBE(350.8," D ^DIK
 D BMES^XPDUTL("IB315 error code removal complete.")
 ;
FORMFLD ; change TOTAL OUTSIDE LAB CHARGES, record 783, to OUTPUT
 ;
 D BMES^XPDUTL("TOTAL OUTSIDE LAB CHARGES changing from CALCULATE ONLY to OUTPUT...")
 S DIE="^IBA(364.6,",DA=783,DR=".11////0" D ^DIE
 D BMES^XPDUTL("TOTAL OUTSIDE LAB CHARGES change complete.")
 ;
 Q

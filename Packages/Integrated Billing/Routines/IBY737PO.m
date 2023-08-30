IBY737PO ;AITC/TAZ - Post-Installation for IB patch 737; JUL 25, 2022
 ;;2.0;INTEGRATED BILLING;**737**;MAR 21,1994;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^%ZTLOAD in ICR #10063
 ; Reference to ^XLFDT in ICR #10103
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=1
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S IBINSTLD=$$INSTALDT^XPDUTL("IB*2.0*737","")
 D MES^XPDUTL("")
 ;
 D NEWINDX(1) ; populate new index 'BB' to PAYER file (#365.12) field .01 for full payer name.
 ;
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D BMES^XPDUTL("POST-Install for IB*2.0*737 Completed.")
 Q
 ;============================
 ;
NEWINDX(IBXPD) ; populate .01 field new BB index in file #365.12
 ;
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 N DIK,X,Y
 S DIK(1)=".01^BB",DIK="^IBE(365.12,"
 D BMES^XPDUTL("Initializing the PAYER file (#365.12) .01 field 'BB' index")
 D ENALL2^DIK
 D MES^XPDUTL("The 'BB' index for PAYER file (#365.12) .01 field has been initialized")
 D BMES^XPDUTL("Populating the 'BB' index for the .01 field in the PAYER file (#365.12).")
 S DIK(1)=".01^BB",DIK="^IBE(365.12,"
 D ENALL^DIK
 D MES^XPDUTL("The .01 field 'BB' index in the PAYER file (#365.12) has been populated.")
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT_" Complete")
 D MES^XPDUTL("-------------")
 Q

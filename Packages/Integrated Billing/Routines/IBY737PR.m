IBY737PR ;AITC/DTG PRE-Installation for IB patch 737; JUL 26, 2022
 ;;2.0;INTEGRATED BILLING;**737**;MAR 21,1994;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 Q
 ;
PRE ; pre-install
 ;
 N IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=1
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 D MES^XPDUTL("")
 ;
 D BMES^XPDUTL("PRE-INSTALL for IB*2.0*737 at "_$G(SITENAME)_":"_$G(SITENUM)_" Starting.")
 ;
 D REMCODE(1) I $G(XPDABORT) G PREX   ; remove '~NO PAYER' from PAYER File
 ;
 D BMES^XPDUTL("PRE-INSTALL for IB*2.0*737 at "_$G(SITENAME)_":"_$G(SITENUM)_" Finished.")
 ;
PREX ;
 Q
 ;============================
 ;
REMCODE(IBXPD) ; remove '~NO PAYER' from PAYER File (#365.12)
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing Payer '~NO PAYER' from the PAYER File (#365.12).")
 N DA,DIK,ERR,IBXMY,MSG,PIEN,RES
 ;
 ; first get IEN from 365.12
 S PIEN=$$FIND1^DIC(365.12,,"X","~NO PAYER")
 ;
 ;Not found
 I PIEN=0 S RES="Payer '~NO PAYER' not found in PAYER File (#365.12), which is okay." G REMCODEX
 ;
 ;ERROR Encountered
 I PIEN="" D  G REMCODEX
 . S RES="Error encountered - "_$G(ERR("DIERR",1,"TEXT",1))
 . S XPDABORT=1
 ;
 ; remove item from file
 S DIK="^IBE(365.12,",DA=PIEN
 D ^DIK
 ;
 ; was it removed
 S PIEN=$$FIND1^DIC(365.12,,"X","~NO PAYER")
 ;
 ;if not removed
 I PIEN S RES=" Not able to remove '~NO PAYER' from PAYER File (#365.12), which is an issue." S XPDABORT=1 G REMCODEX
 S RES="Payer '~NO PAYER' has been removed from the PAYER File (#365.12)."
 ;
REMCODEX ;
 I '$G(XPDABORT) D BMES^XPDUTL(RES)
 I $G(XPDABORT) D
 . S MSG(1)=""
 . S MSG(2)="     ***** PATCH IB*2.0*737 ABORTED *****"
 . S MSG(3)=""
 . S MSG(4)="Removal of the '~NO PAYER' Payer has failed."
 . S MSG(5)="INSTALLER: Please log a Service NOW (SNOW) Ticket to have the"
 . S MSG(6)="'~NO PAYER' entry removed from the PAYER File (#365.12)."
 . S MSG(7)=""
 . ; Only send to eInsurance Rapid Response if in Production
 . ;  1=Production Environment, 0=Test Environment
 . I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 . D MSG^IBCNEUT5(,"~NO PAYER not removed at ("_SITENUM_"-"_SITENAME_")","MSG(",,.IBXMY)
 . D BMES^XPDUTL(.MSG)
 . D REOPT
 Q
 ;
REOPT ;Re-enable Options
 ;IBCN INS RPTS - Insurance Reports Menu
 I $$OPTDE^XPDUTL("IBCN INS RPTS",1) D BMES^XPDUTL("Option [IBCN INS RPTS] Enabled.")
 ;IBJ MCCR SITE PARAMETERS - MCCR Site Parameter Display/Edit
 I $$OPTDE^XPDUTL("IBJ MCCR SITE PARAMETERS",1) D BMES^XPDUTL("Option [IBJ MCCR SITE PARAMETERS] Enabled.")
 ;IBCNE PAYER EDIT - Payer Edit
 I $$OPTDE^XPDUTL("IBCNE PAYER EDIT",1) D BMES^XPDUTL("Option [IBCNE PAYER EDIT] Enabled.")
 ;IBCN INSURANCE BUFFER PROCESS - Process Insurance Buffer
 I $$OPTDE^XPDUTL("IBCN INSURANCE BUFFER PROCESS",1) D BMES^XPDUTL("Option [IBCN INSURANCE BUFFER PROCESS] Enabled.")
 ;IBCNE REQUEST INQUIRY - Request Electronic Insurance Inquiry
 I $$OPTDE^XPDUTL("IBCNE REQUEST INQUIRY",1) D BMES^XPDUTL("Option [IBCNE REQUEST INQUIRY] Enabled.")
 Q

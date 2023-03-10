IBY713PO ;AITC/DTG - Post-Installation for IB patch 713; DEC 27, 2021
 ;;2.0;INTEGRATED BILLING;**713**;MAR 21,1994;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$INSTALDT^XPDUTL in ICR #10141
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,SITE,SITENAME,SITENUM,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=1
 ;
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S IBINSTLD=$$INSTALDT^XPDUTL("IB*2.0*713","")  ;ICR 10141
 D MES^XPDUTL("")
 ;
 D NEWSTAT(1) ; add a new code to (#365.15) for COMMUNICATION FAILURE
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*713 Completed.")
 Q
 ;============================
 ;
 ;
NEWSTAT(IBXPD) ; add a new code to the IIV STATUS TABLE (#365.15) for COMMUNICATION FAILURE
 S IBXPD=$G(IBXPD),XPDIDTOT=$G(XPDIDTOT)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 ;
 D MES^XPDUTL("Add a new COMMUNICATION FAILURE code to the IIV STATUS TABLE")
 N IBACTN,IBDATA,IBDESC,IBERR,IBIEN,IBLOOK,IBCHK,IBFND,IBTMP,IBTCT
 ; check for B17
 S (IBFND,IBCHK)="" K IBLOOK
 D FIND^DIC(365.15,"","@;.01;IX","X","B17","","","","","IBLOOK")
 I +$G(IBLOOK("DILIST",0)) D  I IBFND G NEWSTATX
 . ; verify that the code is B17
 . S IBTCT=$P($G(IBLOOK("DILIST",0)),U,1) I 'IBTCT Q
 . S IBTMP=$G(IBLOOK("DILIST",2,IBTCT)) I 'IBTMP Q
 . S IBCHK=$$GET1^DIQ(365.15,IBTMP_",",.01,"I")
 . I IBCHK="B17" D  S IBFND=1
 .. D BMES^XPDUTL("*** NEW 'B17' CODE NOT ADDED TO IIV STATUS TABLE (#365.15) ... ALREADY EXISTS ***")
 ;
 ;Set up WP Arrays
 S IBDESC("WP",1)="eIV was unable to electronically verify this insurance information as "
 S IBDESC("WP",2)="invalid characters were identified in a required field(s)."
 ;
 S IBACTN("WP",1)="Action to take:  Contact the insurance company to manually verify"
 S IBACTN("WP",2)="this insurance information."
 ;
 ;Set up File Nodes
 S IBDATA(.01)="B17"
 S IBDATA(.02)=33
 S IBDATA(.03)=0
 S IBDATA(1)=$NA(IBDESC("WP"))
 S IBDATA(2)=$NA(IBACTN("WP"))
 S IBIEN=$$ADD^IBDFDBS(365.15,,.IBDATA,.IBERR)
 I IBERR D  G NEWSTATX
 . D BMES^XPDUTL("*** ERROR ADDING 'B17' CODE TO THE IIV STATUS TABLE (#365.15) ***")
 D BMES^XPDUTL("   NEW 'B17' CODE SUCCESSFULLY ADDED TO IIV STATUS TABLE")
 ;
NEWSTATX ;
 Q

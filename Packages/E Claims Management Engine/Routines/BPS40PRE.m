BPS40PRE ;AITC/PED - Pre-install routine for BPS*1*40 ;02/20/2025
 ;;1.0;E CLAIMS MGMT ENGINE;**40**;JUN 2004;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*40 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL(" Starting pre-install for BPS*1*40")
 ;
 D BPSNPI
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1*40")
 ;
 Q
 ;
BPSNPI ; BPS Pharmacy
 ; Loop through BPS Pharmacies file and create a report
 ; showing Pharmacy Name, Status, NPI, and BPS Pharmacy
 ; for CS.  The report will be emailed to the ePharmacy
 ; developers to verify all BPS Pharmacies have an NPI.
 ;
 N BPSSITENAME,BPSSITENUMBER,BPSVASITE,BPSX,BPSXI,CS,DATA,DIFROM
 N ISSUE,NPI,PHAR,PHARM,SPACE,STATUS,VA200,XMDUZ,XMSUB,XMTEXT,XMY
 ;
 D BMES^XPDUTL("    Check BPS PHARMACIES File")
 ;
 S BPSVASITE=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 S BPSSITENAME=$P(BPSVASITE,"^")
 S BPSSITENUMBER=$P(BPSVASITE,"^",2)
 S XMSUB="BPS Pharmacy NPI Report"
 S XMDUZ=BPSSITENUMBER_" - "_BPSSITENAME
 I '$$PROD^XUPROD(1) D
 . S XMY(DUZ)=""
 . S VA200=$O(^VA(200,"B","DEVINE,PAUL","")) I VA200'="" S XMY(VA200)=""
 . S VA200=$O(^VA(200,"B","DAWSON,MARK R","")) I VA200'="" S XMY(VA200)=""
 . S VA200=$O(^VA(200,"B","HOLM,HEIDI","")) I VA200'="" S XMY(VA200)=""
 I $$PROD^XUPROD(1) D
 . S XMY("Paul.Devine@domain.ext")=""
 . S XMY("Mark.Dawson3@domain.ext")=""
 . S XMY("Heidi.Holm@domain.ext")=""
 S XMTEXT="BPSX("
 ;
 S BPSX(1)=""
 S BPSX(2)="BPS Pharmacy                         Status   NPI       CS Pharmacy"
 S BPSX(3)="-------------------------------------------------------------------------------"
 ;
 S ISSUE=0
 S BPSXI=3
 F I=1:1:79 S SPACE=$G(SPACE)_" "
 S PHAR=0
 F  S PHAR=$O(^BPS(9002313.56,PHAR)) Q:'PHAR  D
 . S PHARM=$$GET1^DIQ(9002313.56,PHAR,.01)
 . S PHARM=PHARM_$E(SPACE,1,(39-$L(PHARM)))
 . S STATUS=$E($$GET1^DIQ(9002313.56,PHAR,.1),1)
 . S STATUS=STATUS_"   "
 . S NPI=$$GET1^DIQ(9002313.56,PHAR,41.01)
 . I NPI="" S ISSUE=1
 . S NPI=NPI_$E(SPACE,1,(13-$L(NPI)))
 . S CS=$$GET1^DIQ(9002313.56,PHAR,2)
 . I CS="" S CS="N/A"
 . S CS=$E(CS,1,23)
 . S DATA=PHARM_STATUS_NPI_CS
 . S BPSXI=BPSXI+1
 . S BPSX(BPSXI)=DATA
 ;
 I ISSUE S XMSUB="*** "_XMSUB
 D ^XMD
 ;
 Q

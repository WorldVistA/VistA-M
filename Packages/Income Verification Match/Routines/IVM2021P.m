IVM2021P ;ALB/KCL - IVM*2*21 Post Install ; 26-JUN-1999
 ;;2.0;INCOME VERIFICATION MATCH;**21**; 21-OCT-94
 ;
 ;
EN ; This entry point will be used as a driver for post-install items.
 ;
 D HL771  ; Update HL7 APPLICATION PARAMETER file entry for IVM
 D MGRP  ; Update the ENROLLMENT ALERT MAIL GROUP field
 D REMMGRP  ; Update theENROLLMENT ALERT REMOTE MAIL GROUP field
 ;
 Q
 ;
 ;
HL771 ; Description: Update HL7 APPLICATION PARAMETER file entry for IVM
 N DA,DIK
 S DA=$O(^HL(771,"B","IVM",0))
 I 'DA D BMES^XPDUTL(">>> ERROR: Could not update HL7 APPLICATION PARAMETER file entry for IVM") Q
 ;
 D BMES^XPDUTL(">>> Updating HL7 APPLICATION PARAMETER file entry for IVM...")
 S ^HL(771,DA,"MSG",0)="^771.06P^5^5"
 S ^HL(771,DA,"MSG",1,0)=$O(^HL(771.2,"B","ORU",0)),^("R")="ORU^IVMPREC2"
 S ^HL(771,DA,"MSG",2,0)=$O(^HL(771.2,"B","QRY",0)),^("R")="QRY^IVMPREC"
 S ^HL(771,DA,"MSG",3,0)=$O(^HL(771.2,"B","ACK",0)),^("R")="ACK^IVMPREC1"
 S ^HL(771,DA,"MSG",4,0)=$O(^HL(771.2,"B","ORF",0)),^("R")="ORF^IVMCM"
 S ^HL(771,DA,"MSG",5,0)=$O(^HL(771.2,"B","MFN",0)),^("R")="MFN^DGENEGT2"
 S DIK="^HL(771," D IX1^DIK
 Q
 ;
 ;
MGRP ; Description: Update the ENROLLMENT ALERT MAIL GROUP (#.09) field
 ;  of the IVM SITE PARAMETER (#301.9) file. 
 ;
 N DA,DATA
 ;
 S DA=+$O(^IVM(301.9,0))
 I 'DA D BMES^XPDUTL(">>> ERROR: Could not update ENROLLMENT ALERT MAIL GROUP (#.09) field in IVM SITE PARAMETER file ") Q
 ;
 D BMES^XPDUTL(">>> Updating ENROLLMENT ALERT MAIL GROUP (#.09) field in IVM SITE PARAMETER file")
 S DATA(.09)=+$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",0))
 I $$UPD^DGENDBS(301.9,DA,.DATA)
 ;
 Q
 ;
 ;
REMMGRP ; Description: Update the ENROLLMENT ALERT REMOTE MAIL GROUP (#.1)
 ; field of the IVM SITE PARAMETER (#301.9) file. 
 ;
 N DA,DATA
 ;
 S DA=+$O(^IVM(301.9,0))
 I 'DA D BMES^XPDUTL(">>> ERROR: Could not update ENROLLMENT ALERT REMOTE MAIL GROUP (#.1) field in IVM SITE PARAMETER file ") Q
 ;
 D BMES^XPDUTL(">>> Updating ENROLLMENT ALERT REMOTE MAIL GROUP (#.1) field in IVM SITE PARAMETER file")
 S DATA(.1)="ELIGIBILITY ALERT@IVM.DOMAIN.EXT"
 I $$UPD^DGENDBS(301.9,DA,.DATA)
 ;
 Q

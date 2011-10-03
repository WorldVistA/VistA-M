DG53588P ;BAY/JAT; Post-init; ; 4/9/04 11:12am
 ;;5.3;Registration;**588**;Aug 13, 1993
ENV ;Environment check point
 S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 Q
 ;
POST ;
 N DGIEN,DGSUB,DGNODE,DGPTR,DGDOMAIN,DIE,DA,DR,DGFOUND,DGNAME
 S (DGIEN,DGFOUND)=0
 F  S DGIEN=$O(^VAT(407.7,DGIEN)) Q:'DGIEN  D
 .S DGSUB=0
 .F  S DGSUB=$O(^VAT(407.7,DGIEN,"R",DGSUB)) Q:'DGSUB  D
 ..S DGNODE=$G(^VAT(407.7,DGIEN,"R",DGSUB,0))
 ..Q:DGNODE=""
 ..S DGPTR=$P(DGNODE,U,2)
 ..Q:'DGPTR
 ..S DGDOMAIN=$$GET1^DIQ(4.2,DGPTR_",",.01)
 ..Q:DGDOMAIN'="IPDB-CHICAGO.VA.GOV"
 ..S DGFOUND=1
 ..S DA(1)=DGIEN
 ..S DA=DGSUB
 ..S DR="2///0"
 ..S DIE="^VAT(407.7,"_DA(1)_",""R"","
 ..D ^DIE
 ..S DGNAME=$P($G(^VAT(407.7,DGIEN,0)),U)
 ..D MES^XPDUTL(DGNAME_" Record updated.")
 I 'DGFOUND D MES^XPDUTL("No record found.  Contact Vista Support.")
 Q

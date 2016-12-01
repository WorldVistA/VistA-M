IBY547PO ;ALB/GEF - Post install routine for patch 547 ; 7-JUN-15
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; XPDUTL calls are DBIA#10141
 ;
DOC ;
 ; POINDX^IBY547PO will run post-install to set new CROSS-REFERENCES for
 ; existing fields 3.02 & 3.04 in file 36.
 ;  
 ; NEWRCS^IBY547PO sets the new multi-field in file #350.9 with the default Revenue Code Exclusions on the
 ; Printed Claims Report (FUNC REQ: 2.6.4.8, SDD REQ: 6.2.2.2.4.8)
 ;
 ; RFAI sets the initial values in fields 52.01 (null) & 52.02 (20 days) in file #350.9
 ;
EN ; start post-install activities
 D POINDX
 D NEWRCS
 D AC
 D RFAI
 D RIT
 Q
 ;
POINDX ; POST-INSTALL comes here to set new x-refs
 ; run triggers on new cross-refs for fields 3.02 & 3.04 (AEI & AEP)
 D MES^XPDUTL("Setting new EDI cross-references in INSURANCE COMPANY file ")
 N DIK,FLD
 ; file 36, top level
 S DIK="^DIC(36,"
 F FLD=3.02,3.04 S DIK(1)=FLD D ENALL^DIK
 Q
 ;
NEWRCS ; POST-INSTALL comes here to set new multi=field (#15) in file #350.9 for the default
 ; Revenue Code Exclusions on the Printed Claims Report.
 D MES^XPDUTL("Setting Default Revenue Code Exclusions in IB SITE PARAMETER file ")
 N DIE,DIC,DA,DR,IREVCD,REVCD,FDA,ERRMSG,RETIEN
 F REVCD=270:1:279,290:1:299 D
 . S IREVCD=$$FIND1^DIC(399.2,,"X",REVCD) Q:'IREVCD
 . I $D(^IBE(350.9,1,15,"B",IREVCD)) Q
 . K FDA,ERRMSG,RETIEN
 . S FDA(350.9399,"+1,1,",.01)=IREVCD
 . D UPDATE^DIE("","FDA","RETIEN","ERRMSG")
 D MES^XPDUTL("........Default Revenue Code Exclusions set. ")
 Q
 ;
AC ; set initial values in new multiple (#81) in file #350.9 to the default Administrative Contractors for Medicare.
 D MES^XPDUTL("Setting Default Administrative Contractor in IB SITE PARAMETER file ")
 N FDA,ERRMSG,RETIEN
 ;
 ; lookup or add to the pointed to file (adds the first time, lookups the rest)
 S FDA(355.98,"?+1,",.01)="DME"
 D UPDATE^DIE("E","FDA","RETIEN","ERRMSG")  ; returns RETIEN(1) with the value to add or ERRMSG if not found
 ;
 I $D(ERRMSG) Q  ;if you can't find the entry in the pointed to file, might as well quit
 K ERRMSG,FDA
 ;
 ; lookup or add to the multiple.
 S FDA(350.981,"?+1,1,",.01)=RETIEN(1)
 K RETIEN
 D UPDATE^DIE("","FDA","RETIEN","ERRMSG")
 D MES^XPDUTL("........Default Administrative Contractor 'DME' set. ")
 Q
 ;
RFAI ; set initial values in fields 52.01 & 52.02 in file #350.9
 N DA,DIE,DR,IBNL
 D MES^XPDUTL("Setting Default RFAI Purge Days in IB SITE PARAMETER file ")
 S IBNL="",DA=1,DIE=350.9,DR="52.01///^S X=IBNL" D ^DIE K DR
 D MES^XPDUTL("........Default RFAI Transaction Purge Days (#52.01) set to null for 'no purge'. ")
 S DR="52.02///20" D ^DIE
 D MES^XPDUTL("........Default RFAI Worklist Purge Days (#52.02) set to 20 days. ")
 K DA,DIE,DR
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:9,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN),Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B"),DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q 

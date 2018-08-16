XUY687P ;EDE/TAZ - Pre-/Post Installation for Kernel Patch 687 ;
 ;;8.0;KERNEL;**687**;Jul 10, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;ICR # 6864
 ;
POST ; POST ROUTINE(S)
 N XPD,XPDIDTOT
 S XPDIDTOT=3
 ;
 ; Delete the existing Cross Reference on Field 28
 D DELXREF(1)
 ;
 ; Check/remove any link from an insurance to the National MBI Payer
 D REINDEX(2)
 ; Set 'VR' and 'VRPK' fields
 D SETFIELD(3)
 ;
 ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
DELXREF(XPD) ; Delete traditional cross reference 
 N XUHIT,XUOUT,XUERR,XUXREF
 D BMES^XPDUTL(" STEP "_XPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Deleting the E xRef from field 28 of file 200 ... ")
 ;
 S (XUHIT,XUXREF)=0
 F  S XUXREF=$O(^DD(200,28,1,XUXREF)) Q:('+XUXREF)!(XUHIT)  D
 . I $P($G(^DD(200,28,1,XUXREF,0)),U,2)="E" D
 .. S XUHIT=1
 .. D DELIX^DDMOD(200,28,XUXREF,"K","XUOUT","XUERR")
 .. ;
 .. ; No error, xRef deleted
 .. I '$D(XUERR) D MES^XPDUTL("The E cross reference was deleted.")  Q
 .. ;
 .. ; Error encountered, xRef not deleted.
 .. D MES^XPDUTL("ERROR encountered deleting the E cross reference.")
 ;
 D:'XUHIT MES^XPDUTL("The E cross reference was not found.")
 ;
 D MES^XPDUTL("STEP "_XPD_" of "_XPDIDTOT_" COMPLETE")
 D UPDATE^XPDID(XPD)
 Q
 ;
REINDEX(XPD) ; Post Install
 D BMES^XPDUTL(" STEP "_XPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Re-Indexing the E xRef on field 29 of file 200 ... ")
 ;
 N DIK
 S DIK="^VA(200,"
 S DIK(1)="29^E"
 D ENALL^DIK
 ;
 D MES^XPDUTL("STEP "_XPD_" of "_XPDIDTOT_" COMPLETE")
 D UPDATE^XPDID(XPD)
 Q
 ;
SETFIELD(XPD) ; Set 'VR' and 'VRPK' fields 
 N XUHIT,XUOUT,XUERR,XUXREF
 D BMES^XPDUTL(" STEP "_XPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting the 'VR' and 'VRPK' fields ... ")
 ;
 S ^DD(200,0,"VR")="8.0"
 S ^DD(200,0,"VRPK")="XU"
 ;
 D MES^XPDUTL("STEP "_XPD_" of "_XPDIDTOT_" COMPLETE")
 D UPDATE^XPDID(XPD)
 Q

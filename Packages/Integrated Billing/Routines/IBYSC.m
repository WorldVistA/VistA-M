IBYSC ;ALB/ARH - IB*2*130 PRE INIT: REMOVE XREFS ; 4/20/00
 ;;2.0;INTEGRATED BILLING;**126**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
PRE ; PRE-INSTALL FOR IB*2*130
 ;
 ; delete cross references on some patient insurance fields (2,.312), they will be updated by the install
 ;
 ; the cross references on these fields were changed so they have to be removed before the new ones are added
 ;
 N IBX,X,Y,DIK,DA,IBFLD,IBXREF
 ;
 D BMES^XPDUTL("Pre-Installation Updates")
 ;
 F IBFLD=.01,3,8 D
 . ;
 . S IBXREF=0 F  S IBXREF=$O(^DD(2.312,IBFLD,1,IBXREF)) Q:'IBXREF  D
 .. ;
 .. S DIK="^DD(2.312,"_IBFLD_",1,",DA(2)=2.312,DA(1)=IBFLD,DA=IBXREF
 .. ;
 .. D ^DIK K DIK,DA
 ;
 D MES^XPDUTL("    * cross references deleted (will be updated during install)")
 ;
 D MES^XPDUTL("Pre-Installation Updates Completed")
 Q

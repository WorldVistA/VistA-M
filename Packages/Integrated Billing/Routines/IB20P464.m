IB20P464 ;ALB/CXW - Patch Install Routine ;02-07-2012 
 ;;2.0;INTEGRATED BILLING;**464**;21-MAR-94;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; File #399 input template compilation routine
 N DMAX,IBX,IBIEN,IBRTN,X,Y
 D MES^XPDUTL("Recompilation of [IB SCREEN1] Input Template..")
 S IBX="IB SCREEN1"
 S IBIEN=$O(^DIE("B",IBX,0)) Q:'IBIEN
 S DMAX=$$ROUSIZE^DILF
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 S X=IBRTN,Y=IBIEN
 D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
 ;

IB20P266 ;WOIFO/AAT - Code Set Versioning Post Install Procedure ;19-FEB-03
 ;;2.0;INTEGRATED BILLING;**266**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EN ;Recompile Input Templates
 N IBC,DMAX,IBMAX,IBN
 ;
 S IBMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("Recompiling affected input templates ...")
 F IBC=1:1 S IBN=$P($T(TMPL+IBC),";;",2) Q:IBN=""  D COMP(IBN,IBMAX)
 D MES^XPDUTL("Completed compiling input templates.")
 Q
 ;
COMP(TNAME,DMAX) ; Compile the Input Template
 N IBIEN,IBRTN,X,Y
 ;find the ien of the input template
 S IBIEN=$O(^DIE("B",TNAME,0)) Q:'IBIEN
 ;
 ;quit if input template not compiled
 S IBRTN=$P($G(^DIE(IBIEN,"ROUOLD")),U) Q:IBRTN=""
 ;
 D MES^XPDUTL("Compiling "_TNAME_" , compiled routine is "_IBRTN_" ...")
 S X=IBRTN,Y=IBIEN
 D EN^DIEZ
 D MES^XPDUTL("done")
 D MES^XPDUTL("")
 Q
 ;
TMPL ;
 ;;IB SCREEN4
 ;;IB SCREEN5
 ;;IB SCREEN6
 ;;IB SCREEN7
 ;;IB SCREEN8
 ;;IB SCREEN82
 ;;IB SCREEB8H
 ;;IB REVCODE EDIT
 ;;IBAT OUT PRICING EDIT
 ;;IBT ACTION INFO
 ;;IBT QUICK EDIT
 ;;

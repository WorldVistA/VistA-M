IB20P496 ;ALB/CXW - Source of Information Update ; 15-JAN-2013 
 ;;2.0;INTEGRATED BILLING;**496**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; Post-install of patch installation 
 N DA,DIC,DO,X,Y,IBI,IBX,IBCT S U="^",IBCT=0
 D MES^XPDUTL("Patch Post-Install starts...")
 D MES^XPDUTL("Add a new Source of Information for Insurance ...")
 F IBI=1:1 S IBX=$P($T(SOI+IBI),";;",2) Q:IBX=""  D
 . S X=$P(IBX,U,1)
 . ; quit if it exists
 . I $D(^IBE(355.12,"B",X)) Q
 . S DIC="^IBE(355.12,",DIC(0)="F"
 . S DIC("DR")=".02///"_$P(IBX,U,2)_";.03///"_$P(IBX,U,3)
 . D FILE^DICN
 . I Y=-1 D MES^XPDUTL("ERROR when adding a new Source of Information.  Log a Remedy ticket!") Q
 . D MES^XPDUTL("Source of Information: "_$P(IBX,U,2)_" added successfully")
 . S IBCT=IBCT+1
 D MES^XPDUTL("Total "_IBCT_" code"_$S(IBCT'=1:"s",1:"")_" updated in the Source of Information file (#355.12)")
 ;
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
SOI ; code^description^ib buffer acronym
 ;;11^KIOSK^KSK
 ;

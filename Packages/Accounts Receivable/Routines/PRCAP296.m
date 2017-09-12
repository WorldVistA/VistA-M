PRCAP296 ;ALB/CXW - post init for patch 296 ; 19-MAR-2013
 ;;4.5;Accounts Receivable;**296**;Mar 20, 1995;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;  AR event type of payment update
 N DA,DIC,DLAYGO,DO,RCI,RCX,RCCT,X,Y S U="^",RCCT=0
 D MES^XPDUTL("Patch Post-Install starts...")
 D MES^XPDUTL("Add a new AR event type of payment ...")
 F RCI=1:1 S RCX=$P($T(AET+RCI),";;",2) Q:RCX=""  D
 . S X=$P(RCX,U,1)
 . ;quit if it exists
 . I $D(^RC(341.1,"B",X)) Q
 . S DIC="^RC(341.1,",DIC(0)="L",DLAYGO=341.1
 . S DIC("DR")=".02///"_$P(RCX,U,2)_";.06///"_$P(RCX,U,3)
 . D FILE^DICN
 . I Y=-1 D MES^XPDUTL("ERROR when adding a new AR event type. Log a Remedy ticket!") Q
 . D MES^XPDUTL("AR event type of payment: "_$P(RCX,U,1)_" added successfully")
 . S RCCT=RCCT+1
 D MES^XPDUTL("Total "_RCCT_" code"_$S(RCCT'=1:"s",1:"")_" added to the AR Event Type file (#341.1)")
 ;
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
AET ; name^event number^category 
 ;;ADMINISTRATIVE OFFSET^15^PAYMENT
 ;;PRIVATE COLLECTION AGENCY^16^PAYMENT
 ;

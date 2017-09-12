IBY434PO ;ALB/ESG - Post Install for IB patch 434 ;5-Aug-2010
 ;;2.0;INTEGRATED BILLING;**434**;21-MAR-94;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ePharmacy TRICARE Active Duty - patch 434 post installation routine
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=1
 D CT(1)              ; 1. add a new Claims Tracking Reason Not Billable
 ;
EX ; exit point
 Q
 ;
CT(IBXPD) ; add a new CT RNB
 N DA,DIC,DO,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add a new Claims Tracking RNB ... ")
 ;
 F X="TRICARE INPATIENT/DISCHARGE" D
 . I $D(^IBE(356.8,"B",X)) D MES^XPDUTL("Already there...no action") Q
 . S DIC="^IBE(356.8,",DIC(0)="F"
 . S DIC("DR")=".04///RX16"
 . D FILE^DICN
 . I Y=-1 D MES^XPDUTL("ERROR when adding a new RNB to CT.  Please log a Remedy ticket!") Q
 . D MES^XPDUTL("Entry added successfully")
 . Q
 ;
CTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;

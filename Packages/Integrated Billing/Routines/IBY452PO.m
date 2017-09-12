IBY452PO ;ALB/ESG - Post Install for IB patch 452 ;27-Apr-2011
 ;;2.0;INTEGRATED BILLING;**452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ePharmacy Phase 6 - patch 452 post installation routine
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=1
 D CT(1)              ; 1. add new Claims Tracking Reasons Not Billable
 ;
EX ; exit point
 Q
 ;
CT(IBXPD) ; add new CT RNB
 N X
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add new Claims Tracking RNB ... ")
 ;
 F X="CHAMPVA INPATIENT/DISCHARGE","INPATIENT RX AUTO-REVERSAL" D
 . N DA,DIC,DO,Y
 . I $D(^IBE(356.8,"B",X)) D MES^XPDUTL(X_" - already there...no action") Q
 . S DIC="^IBE(356.8,",DIC(0)="F"
 . I X="CHAMPVA INPATIENT/DISCHARGE" S DIC("DR")=".04///RX17"
 . I X="INPATIENT RX AUTO-REVERSAL" S DIC("DR")=".02////1;.03////0;.04///RX18"
 . D FILE^DICN
 . I Y=-1 D MES^XPDUTL(X_" - ERROR when adding a new RNB to CT.  Please log a Remedy ticket!") Q
 . D MES^XPDUTL(X_" - Entry added successfully")
 . Q
 ;
CTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;

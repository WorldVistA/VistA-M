IBY473PO ;ALB/ESG - Post Install for IB patch 473 ;2-FEB-2012
 ;;2.0;INTEGRATED BILLING;**473**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=2
 D CVA(1)           ; update CHAMPVA Rx rate schedules
 D TRI(2)           ; update TRICARE Rx rate schedules
 ;
EX ; exit point
 Q
 ;
CVA(IBXPD) ; update CHAMPVA Rx rate schedule data
 N IBMSG,IBRXBS,ERO,ERB,RSNAME
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update CHAMPVA Rx Rate Schedules ... ")
 ;
 ; attempt to get the PRESCRIPTION billable service ien to file 399.1
 K IBMSG
 S IBRXBS=+$$FIND1^DIC(399.1,,"BO","PRESCRIPTION",,"I $P(^(0),U,13)","IBMSG")
 I IBRXBS'>0!$D(IBMSG("DIERR")) D  G CVAX   ; report error message and get out
 . D MES^XPDUTL("ERROR: Unable to determine the Prescription Billable Service.")
 . D MES^XPDUTL("       IBRXBS = "_IBRXBS)
 . S (ERO,ERB)="IBMSG(""DIERR"""
 . S ERO=ERO_")"
 . F  S ERO=$Q(@ERO) Q:ERO'[ERB  D MES^XPDUTL("       "_ERO_" = "_$G(@ERO))
 . D MES^XPDUTL(" ")
 . Q
 ;
 ; update both of the CHAMPVA pharmacy rate schedules
 F RSNAME="CVA-RX","CVA RI-RX" D
 . N IEN,DIE,DA,DR,X,Y
 . S IEN=+$O(^IBE(363,"B",RSNAME,""),-1)
 . I 'IEN D MES^XPDUTL("ERROR: Rate Schedule "_RSNAME_" not found.") Q
 . ;
 . ; check to see if the changes have already been performed
 . I $P($G(^IBE(363,IEN,0)),U,4)=IBRXBS,$P($G(^IBE(363,IEN,1)),U,1)=5 D  Q
 .. D MES^XPDUTL("Rate Schedule "_RSNAME_" has already been updated...no further action.")
 .. Q
 . ;
 . ; perform the updates
 . S DIE=363,DA=IEN,DR=".04////"_IBRXBS_";1.01////5"
 . D ^DIE
 . D MES^XPDUTL("Rate Schedule "_RSNAME_" has been updated successfully.")
 . Q
 ;
CVAX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
TRI(IBXPD) ; update TRICARE Rx rate schedule data with new dispensing fees
 N IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update TRICARE Rx Rate Schedules ... ")
 ;
 F IBRATY="TRICARE","TRICARE REIMB. INS." D
 . I '$O(^DGCR(399.3,"B",IBRATY,0)) D MES^XPDUTL("ERROR: Rate Type "_IBRATY_" not found.") Q
 . S IBEFFDT="01/23/2012"    ; new effective date
 . S IBADFE=""               ; admin fee (not used)
 . S IBDISP=10.27            ; dispensing fee amount
 . S IBADJUST="S X=X+10.27"  ; adjustment code
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . D MES^XPDUTL("Pharmacy Rate Schedules for "_IBRATY_" successfully updated.")
 . Q
 ;
TRIX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;

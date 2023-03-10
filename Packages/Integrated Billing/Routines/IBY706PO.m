IBY706PO ;EDE/YMG - POST-INSTALL FOR IB*2.0*706 ;02-JUL-2021
 ;;2.0;INTEGRATED BILLING;**706**;21-MAR-94;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D CANCEL
 Q
 ;
CANCEL ; cancel copays with service dates between 04/06/2020 and 09/30/2021 (COVID relief)
 D MES^XPDUTL("Searching for medical copays to cancel...")
 D CANCEL^IBAMTC(3200301,3210930,2)  ; start with entries added on 03/01/20 in order to catch all inpatient charges
 D MES^XPDUTL("Done.")
 Q

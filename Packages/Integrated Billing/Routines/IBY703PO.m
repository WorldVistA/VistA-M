IBY703PO ;EDE/YMG - POST-INSTALL FOR IB*2.0*703 ;12-MAY-2021
 ;;2.0;INTEGRATED BILLING;**703**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D SETPARAM
 D CANCEL
 Q
 ;
SETPARAM ; set default value for IB site parameter 350.9/71.01
 N DA,DIE,DR,X,Y
 D MES^XPDUTL("Setting default end date for COVID-19 relief in IB SITE PARAMETER file...")
 S DA=1,DIE=350.9,DR="71.01///^S X=3210930" D ^DIE
 D MES^XPDUTL("Done.")
 Q
 ;
CANCEL ; cancel copays with service dates between 04/06/2020 and 09/30/2021 (COVID relief)
 D MES^XPDUTL("Searching for medical copays to cancel...")
 D CANCEL^IBAMTC(3200301,3210930,2)  ; start with entries added on 03/01/20 in order to catch all inpatient charges
 D MES^XPDUTL("Done.")
 Q

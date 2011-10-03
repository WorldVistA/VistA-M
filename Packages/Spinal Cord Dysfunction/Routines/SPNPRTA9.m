SPNPRTA9 ;WDE/HIRMFO/WAA- PRINT ADHOC FUNCTIONAL STATUS ; 8/29/02
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;;
 ;This routines is to store ADHOC FUNCTIONAL STATUS into a file.
 ; NEW DUSOI REPORT LEAD IN ROUTINE
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE S SPNPAGE=1
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 D PRINT
 D EXIT
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 Q
PRINT ; Print main Body
 ;Called to build the menus for DUSOI'S
 S SPNARPT=7
 D ^SPNADF9 ; Adhoc Functional Status Generator FOR DUSOI
 Q

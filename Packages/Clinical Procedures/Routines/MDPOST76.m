MDPOST76 ;HPSC/MWA - POST INSTALLATION TASKS ;Oct 5, 2018
 ;;1.0;CLINICAL PROCEDURES;**76**;Oct 5, 2018;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL  Kernal  (supported)
 ;  #2263        - EN^XPAR     Kernal  (supported)
 ;
 Q
EN ; Update version number
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.76.2")
 ;
 Q
 ;

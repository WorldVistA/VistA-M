MDPOST64 ;HPSC/MWA - POST INSTALLATION TASKS ;Sept 20, 2018
 ;;1.0;CLINICAL PROCEDURES;**64**;Sept 20, 2018;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL  Kernal  (supported)
 ;  #2263        - EN^XPAR     Kernal  (supported)
 ;
 Q
EN ; Update version number
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPCONSOLE","1.0.64.1")
 ;
 Q
 ;

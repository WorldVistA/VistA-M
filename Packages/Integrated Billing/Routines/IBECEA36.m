IBECEA36 ;ALB/CPM-Cancel/Edit/Add... Urgent Care Add Utilities ; 23-APR-93
 ;;2.0;INTEGRATED BILLING;**646**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;DBIA #2918 - PRIORITY^DGENA call
 ;
UCCHRG ; Process Urgent Care Copay Charge
 ; set the initial charge to $30
 ; Undeclared parameters
 ;   IBFEE - Flag for Community Care Copays
 ;   IBUNIT - (Default 1) # units for the charge
 ;   IBCHG - Default Copay to charge
 ;   DFN   - Patient IEN
 ;
 ;N IBPRI
 S IBCHG=30,IBUNIT=1  ;initial copay amount
 S (IBDT,IBTO)=IBFR,IBX="O",(IBTYPE,IBUNIT)=1,IBEVDA="*"
 ;
 ; Ask for other UC copays for the year that are not at this site (future development)
 ;
 ; Retrieve Priority Group (future development)
 ;S IBPRI=$$PRIORITY^DGENA(DFN)
 ;
 ; If priority group 1-5, check total entries.  If <4, then print exemption message and quit
 ;
 ; Call CTBB^IBECEAU3 to confirm or substitute amount of Copay
 D CTBB^IBECEAU3
 ;
 Q

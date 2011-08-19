DGPZ07C ;BAJ - HL7 Z07 CONSISTENCY CHECKER -- DRIVER ROUTINE ; 10/14/05 11:48am
 ;;5.3;Registration;**653**;Aug 13,1993;Build 2
 ;
 ; This routine prompts the user for a patient name.  Then, when found, calls the IVMZ07C support routine 
 ; to check for inconsistencies in the patient record which will prevent the building of a Z07 HL7 record.  
 ; Data from this routine will be available on the Inconsistent Data report.
 ; 
 ; structure:
 ; 1. Begin loop
 ; 2. Select patient
 ; 3. Call IVMZ07C support routine
 ; 4. Notify user of Pass/Fail
 ; 
 ; Must be called from entry point
 Q
 ;
EN ; entry point.
 ; Start loop, quit when no more patients to check
 F  I '$$SELECT() Q
 ;
SELECT() ; Select patient and call support routine
 N DFN,DIC,Y,DGP,DGSD,PASS,SEL
 S SEL=0
 W !! S DIC=2,DIC(0)="AEQM",DIC("A")="Check consistency for which PATIENT: " D ^DIC
 I Y<0 Q SEL
 S DFN=+Y,SEL=1
 W !,"Checking..."
 S PASS=$$EN^IVMZ07C(DFN)
 D NOTIFY(PASS)
 ; we only need "CC" counter in batch mode so kill it here.
 K ^TMP($J,"CC")
 Q SEL
 ;
NOTIFY(PASS) ; Notify user of Pass/Fail
 W !!    ;write two blank lines
 I PASS W "NO INCONSISTENCIES FOUND..." Q
 W "INCONSISTENCIES FOUND..."
 D ON^DGRPC Q:DGER
 S DGVAR="DUZ^DFN",DGPGM="^DGPZ07P" D ZIS^DGUTQ G Q^DGPZ07P:POP U IO G ^DGPZ07P
 Q
 ;       

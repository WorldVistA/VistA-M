VAQDBIM ;ALB/JRP - MEANS TEST EXTRACTION;1-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;**38**;NOV 17, 1993
 ; **********
 ; * PARTS OF THIS ROUTINE HAVE BEEN COPIED AND ALTERED FROM THE
 ; * DGMTSC* ROUTINES.  FOR MODULES THIS WAS DONE FOR, A REFERENCE
 ; * TO THE DGMTSC* ROUTINE WILL BE INCLUDE.
 ; **********
 ;
EXTRACT(TRAN,DFN,ARRAY,OFFSET) ;EXTRACT MEANS TEST (DISPLAY READY)
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         DFN - Pointer to patient in PATIENT file
 ;         ARRAY - Where to store information (full global reference)
 ;         OFFSET - Where to start adding lines (defaults to 0)
 ;OUTPUT : n - Number of lines in display
 ;         -1^Error_text - Error
 ;NOTE   : If TRAN is passed
 ;           The patient pointer of the transaction will be used
 ;           Encryption will be based on the transaction
 ;         If DFN is passed
 ;           Encryption will be based on the site parameter
 ;       : Pointer to transaction takes precedence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;
 ;This module is not based on any single DGMTSC* routine.  Setting
 ;up of information required to extract Means Test information was
 ;drawn from several routines/utilitities.
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 Q:($G(ARRAY)="") "-1^Did not pass output array"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N DGMTDT,DGMTSC,DGVPRI,DGVINI,DGVIRI,DGMTPAR,DGERR,DGFL,DGDEP
 N DGMTYPT,DGMTI,LINES,TMP,VAQMT
 ;SAVE STARTING OFFSET
 S LINES=OFFSET
 ;SET MEANS TEST TYPE
 S DGMTYPT=1
 ;GET DATE OF LAST MEANS TEST
 S VAQMT=$$LST^DGMTU(DFN)
 S DGMTI=$P(VAQMT,U,1),DGMTDT=$P(VAQMT,U,2)
 Q:(DGMTDT="") $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,"Could not determine date of last Means Test")
 ;SET UP MEANS TEST VARIABLES
 D SETUP^DGMTSCU
 Q:(DGERR) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,"Unable to set up Means Test variables")
 ;PUT IN TITLE
 S TMP=$$TITLE^VAQDBIM0(ARRAY,OFFSET)
 Q:(TMP<0) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,$P(TMP,"^",2))
 S OFFSET=OFFSET+TMP
 ;EXTRACT SCREEN 1
 S TMP=$$XTRCT1^VAQDBIM1(DFN,ARRAY,OFFSET)
 Q:(TMP<0) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,$P(TMP,"^",2))
 S OFFSET=OFFSET+TMP
 F TMP=1:1:3 S @ARRAY@("DISPLAY",OFFSET,0)="" S OFFSET=OFFSET+1
 ;EXTRACT SCREEN 2
 S TMP=$$XTRCT2^VAQDBIM2(DFN,ARRAY,OFFSET)
 Q:(TMP<0) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,$P(TMP,"^",2))
 S OFFSET=OFFSET+TMP
 F TMP=1:1:3 S @ARRAY@("DISPLAY",OFFSET,0)="" S OFFSET=OFFSET+1
 ;EXTRACT SCREEN 3
 S TMP=$$XTRCT3^VAQDBIM3(DFN,ARRAY,OFFSET)
 Q:(TMP<0) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,$P(TMP,"^",2))
 S OFFSET=OFFSET+TMP
 F TMP=1:1:3 S @ARRAY@("DISPLAY",OFFSET,0)="" S OFFSET=OFFSET+1
 ;EXTRACT SCREEN 4
 S TMP=$$XTRCT4^VAQDBIM4(DFN,ARRAY,OFFSET)
 Q:(TMP<0) $$ERROR^VAQDBIM0(TRAN,ARRAY,LINES,$P(TMP,"^",2))
 S OFFSET=OFFSET+TMP
 F TMP=1:1:2 S @ARRAY@("DISPLAY",OFFSET,0)="" S OFFSET=OFFSET+1
 ;CHECK TO SEE IF ENCRYPTION IS ON - ENCRYPT ARRAY IF IT IS
 S:(TRAN) TMP=$$TRANENC^VAQUTL3(TRAN,0)
 S:('TRAN) TMP=$$NCRYPTON^VAQUTL2(0)
 S:(TMP) TMP=$$ENCDSP^VAQHSH(TRAN,ARRAY,TMP,LINES,(OFFSET-LINES))
 ;RETURN NUMBER OF LINES IN DISPLAY
 Q (OFFSET-LINES)

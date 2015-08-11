VPSWRIST ;DALOIFO/GT,SLOIFO/BT - PATIENT WRISTBAND LABEL RPC;07/15/14 15:08
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;MAR 13,2013;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #10061 - VADPT call                       (Supported)
 ; #10035 - ^DPT( references                 (Supported)
 ; #2119  - OPEN^%ZISUTL, USE^%ZISUTL, CLOSE^%ZISUTL (Supported)
 ; #5905  - SET^DGPWB, $$DIVISION^DGPWB      (Private)
 ;
 QUIT
 ;
PRINT(VPSRSLT,VPSTYP,VPSNUM,VPSIO) ;RPC: VPS PATIENT WRISTBAND PRINT
 ;The Print Patient Wristband option is used to generate a patient wristband with barcoded social security number.  
 ;The wristband will contain the patient name, primary long ID (usually the social security number), date of birth,
 ;religion, and an allergy flag (YES or a blank line for NO).  
 ;
 ;INPUT
 ;   VPSTYP   Patients ID Type - SSN or DFN OR ICN OR VIC/CAC (REQUIRED) 
 ;   VPSNUM   Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSIO    Output Device NAME
 ;OUTPUT
 ;   VPSRSLT  0 (Successful)
 ;           -1^Failure Message
 ;
 ; -- Get DFN based on Patient ID Type and Value pair
 S VPSRSLT=$$GETDFN^VPSPRINT($G(VPSTYP),$G(VPSNUM))
 QUIT:+VPSRSLT=-1
 N VPSDFN S VPSDFN=VPSRSLT
 ;
 ; -- Check Input parameters
 N WARD
 S VPSRSLT=$$VALIDATE(VPSDFN,$G(VPSIO),.WARD)
 QUIT:+VPSRSLT=-1
 ;
 ; -- Setup and open handle for output device.
 D OPEN^%ZISUTL("WRISTBAND",VPSIO)
 I POP S VPSRSLT=-1_U_"DEVICE IN USE - TRY AGAIN LATER" QUIT
 ; 
 ; -- Print Wristband 
 D USE^%ZISUTL("WRISTBAND")
 N $ETRAP,$ESTACK S $ETRAP="D ETRAP^VPSWRIST QUIT"
 N DFN S DFN=VPSDFN
 N VPSSSN S VPSSSN=$P(^DPT(DFN,0),U,9)
 D SET^DGPWB ;Requires DFN and WARD and potentially VPSSSN for barcode
 ;
 ; -- close output device
 D CLOSE^%ZISUTL("WRISTBAND")
 ;
 S VPSRSLT=0
 QUIT
 ;
VALIDATE(VPSDFN,VPSIO,WARD) ; Check input parameters
 ;INPUT
 ;   VPSDFN     : PATIENT DFN (Must be valid)
 ;   VPSIO      : Output Device NAME
 ;OUTPUT
 ;   WARD       : WARD (by reference)
 ;RETURN
 ;   successful : ""
 ;   failed     : -1^exception message
 ;
 ;-- Check Device
 N MSG S MSG=$$DEVEXIST^VPSPRINT($G(VPSIO))
 QUIT:+MSG=-1 MSG
 QUIT ""
 ;
ETRAP ; ERROR TRAP during printing wristband label
 S VPSRSLT="-1^"_$$EC^%ZOSV
 D CLOSE^%ZISUTL("WRISTBAND")
 QUIT

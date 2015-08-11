VPSRLBLS ;DALOIFO/GT,SLOIFO/BT - PATIENT LABELS RPC;07/15/14 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4**;Jul 15,2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #10035 - ^DPT( references         (Supported)
 ; #2119  - OPEN^%ZISUTL, USE^%ZISUTL, CLOSE^%ZISUTL (Supported)
 ; #5904  - START^DGPLBL call        (Private)
 ;
 QUIT
 ;
PRINT(VPSRSLT,VPSTYP,VPSNUM,VPSLOC,VPSLBCNT,VPSLPL,VPSIO) ;VPS PRINT PATIENT LABEL
 ;This RPC provide a patient demographics label that includes Patient Name,SSN, 
 ;DOB and an optional inpatient location (ward and bed).
 ;INPUT
 ;   VPSTYP    Patients ID Type - SSN or DFN OR ICN OR VIC/CAC (REQUIRED) 
 ;   VPSNUM    Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSLOC    include location flag (0 or 1)
 ;   VPSLBCNT  label count from 1 to 250
 ;   VPSLPL    lines per label can contain (6-25)
 ;   VPSIO     output device name
 ;OUTPUT
 ;   VPSRSLT   0 (Successful) 
 ;            -1^Failure Message
 ;
 ; -- Get DFN based on Patienr ID Type and Value pair
 S VPSRSLT=$$GETDFN^VPSPRINT($G(VPSTYP),$G(VPSNUM))
 QUIT:+VPSRSLT=-1 VPSRSLT
 N VPSDFN S VPSDFN=VPSRSLT
 ;
 ; -- Check Input parameters
 S VPSRSLT=$$VALIDATE(VPSDFN,$G(VPSLOC),$G(VPSLBCNT),$G(VPSLPL),$G(VPSIO))
 QUIT:+VPSRSLT=-1
 ;
 ; -- Setup handle for output device and open the device.
 D OPEN^%ZISUTL("PATIENTLABEL",VPSIO)
 I POP S VPSRSLT=-1_U_"DEVICE IN USE - TRY AGAIN LATER" QUIT
 ; 
 ; -- Print Wristband
 D USE^%ZISUTL("PATIENTLABEL")
 N $ETRAP,$ESTACK S $ETRAP="D ETRAP^VPSRLBLS QUIT"
 N DGDFNS S DGDFNS(VPSDFN)=""
 N DGLOC S DGLOC=VPSLOC
 N DGLBCNT S DGLBCNT=VPSLBCNT
 N DGLPL S DGLPL=VPSLPL
 N VPSSSN S VPSSSN=$P(^DPT(VPSDFN,0),U,9)
 D START^DGPLBL ; All the DG vars are required
 ;
 ; -- close output devcie
 D CLOSE^%ZISUTL("PATIENTLABEL")
 ;
 S VPSRSLT=0
 QUIT VPSRSLT
 ;
VALIDATE(VPSDFN,DGLOC,DGLBCNT,DGLPL,VPSIO) ; Check Input Parameters
 ;INPUT
 ;   VPSDFN   Patient DFN (Must be VALID)
 ;   DGLOC    include location flag (0 or 1)
 ;   DGLBCNT  label count from 1 to 250
 ;   DGLPL    lines per label can contain (6-25)
 ;   VPSIO    output device ien
 ;RETURN
 ;   successful : ""
 ;   failed     : -1^exception message
 ;
 ; -- check Include Ward Location input parameter
 QUIT:$G(DGLOC)="" "-1"_U_"INPUT PARAMETER 'INCLUDE WARD LOCATION FLAG' NOT SENT"
 QUIT:(DGLOC<0)!(DGLOC>1) "-1"_U_"INVALID VALUE FOR 'INCLUDE WARD LOCATION FLAG'. VALID NUMBER SHOULD BE 0 OR 1"
 ;
 ; -- check label count
 QUIT:$G(DGLBCNT)="" "-1"_U_"INPUT PARAMETER 'LABEL COUNT' NOT SENT"
 QUIT:(DGLBCNT<1)!(DGLBCNT>250) "-1"_U_"INVALID VALUE FOR 'LABEL COUNT'. VALID NUMBER IS BETWEEN 1 to 250"
 ;
 ; -- check number of lines/label
 QUIT:$G(DGLPL)="" "-1"_U_"INPUT PARAMETER 'LINES/LABEL' NOT SENT"
 QUIT:(DGLPL<6)!(DGLPL>25) "-1"_U_"INVALID VALUE FOR 'LINES/LABEL'. VALID NUMBER IS BETWEEN 6 to 25"
 ;
 ; -- check device
 N MSG S MSG=$$DEVEXIST^VPSPRINT($G(VPSIO))
 QUIT:+MSG=-1 MSG
 ;
 QUIT ""
 ;
ETRAP ; ERROR TRAP during printing patient label
 S VPSRSLT="-1^"_$$EC^%ZOSV
 D CLOSE^%ZISUTL("PATIENTLABEL")
 QUIT

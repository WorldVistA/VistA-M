VPSMRARU ;WOIFO/BT - UPDATE LAST MRAR TIU IEN;1/15/15 11:26
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 QUIT
 ;
UPDATE(VPSRSLT,VPSNUM,VPSTYP,VPSTIEN) ; RPC: VPS UPDATE LAST MRAR TIU IEN
 ; This RPC will be called by Vetlink after successfully create TIU NOTE.
 ;
 ; INPUT
 ;   VPSNUM  : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  : Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTIEN : TIU Note IEN
 ;
 ; OUTPUT
 ;   VPSRSLT : Result of operation (by reference)
 ;             1 - success, 0^exception - failed
 ;
 S VPSNUM=$G(VPSNUM)
 S VPSTYP=$G(VPSTYP)
 S VPSTIEN=$G(VPSTIEN)
 ;
 ; -- validate input parameters
 N VPSDFN S VPSDFN=$$VALIDATE^VPSRPC1(VPSTYP,VPSNUM)
 I VPSDFN<1 S VPSRSLT="0^"_$P(VPSDFN,U,2) QUIT
 I VPSTIEN'?1.N S VPSRSLT="0^Invalid TIU NOTE IEN" QUIT
 I $$GET1^DIQ(8925,VPSTIEN_",",.02,"I")'=VPSDFN S VPSRSLT="0^DFN does not match DFN associated with TIU note" QUIT
 ;
 ; -- get last transaction for this patient
 S VPSRSLT=$$GETLMRAR(VPSDFN)
 QUIT:'VPSRSLT
 ;
 ; -- update MRAR TIU NOTE IEN
 N LMRARDT S LMRARDT=VPSRSLT
 L +^VPS(853.5,VPSDFN):2 E  S VPSRSLT="0^There is another process updating File #853.5" Q
 S VPSRSLT=$$UPDMRAR(VPSDFN,LMRARDT,VPSTIEN)
 L -^VPS(853.5,VPSDFN)
 ;
 QUIT VPSRSLT
 ;
GETLMRAR(VPSDFN) ;get last MRAR date for this patient (VPSDFN)
 N LTRXNDT S LTRXNDT=$O(^VPS(853.5,VPSDFN,"MRAR","B",""),-1)
 I LTRXNDT="" QUIT "0^This patient doesn't have any MRAR transaction"
 QUIT LTRXNDT
 ;
UPDMRAR(VPSDFN,TRXNDT,VPSTIEN) ;update MRAR TIU NOTE ien
 ; INPUT
 ;   VPSDFN  : PATIENT DFN
 ;   TRXNDT  : Last MRAR Transaction Date for this patient
 ;   VPSTIEN : TIU Note IEN
 ; RETURN
 ;   1           : successful update
 ;   0^exception : update failure
 ;
 N RESULT S RESULT=1
 N VPSFDA,VPSERR
 S VPSFDA(853.51,TRXNDT_","_VPSDFN_",",105)=VPSTIEN
 D FILE^DIE(,"VPSFDA","VPSERR")
 I $D(VPSERR) D
 . N ERRNUM S ERRNUM=0
 . S ERRNUM=$O(VPSERR("DIERR",ERRNUM))
 . S RESULT=0_U_VPSERR("DIERR",ERRNUM,"TEXT",1)
 QUIT RESULT

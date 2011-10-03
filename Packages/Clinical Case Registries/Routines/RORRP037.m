RORRP037 ;HIOFO/SG,VC - RPC: HEPC PATIENT SAVE/CANCEL ;1/29/09 9:53am
 ;;1.5;CLINICAL CASE REGISTRIES;**2,8**;Feb 17, 2006;Build 8
 ;Per VHA Directive 10-92-142, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;
 ; #2053         FILE^DIC (supported)
 Q
 ;
 ;***** UPDATES THE PATIENT'S REGISTRY DATA
 ; RPC: [RORHEPC PATIENT SAVE]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PTIEN         IEN of the registry patient (DFN)
 ;
 ; [CANCEL]      Cancel the update and unlock the registry data
 ;
 ; .DATA         Reference to a local array that contains the data
 ;               in the same format as the output of the RORHEPC
 ;               PATIENT LOAD remote procedure. Only HEPC and LFV
 ;               segments are processed; the others are ignored.
 ; Revision for Patch 1.5*8 to add comments
 ;   In DATA array there will be a 3 piece record, formated as follows
 ; PC^STAT^COMMENT  If STAT is P then the COMMENT will be added. If
 ;                  STAT is C then the COMMENT will be a blank.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
SAVE(RESULTS,REGIEN,PTIEN,CANCEL,DATA) ;
 N IENS,LOCK,RC,RORERRDL,STAT,COMMENT
 D CLEAR^RORERR("SAVE^RORRP037",1)
 K RESULTS  S (RESULTS(0),RC)=0
 D
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PTIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PTIEN",$G(PTIEN))
 . S PTIEN=+PTIEN
 . ;--- Get the IENS of the registry record
 . S IENS=$$PRRIEN^RORUTL01(PTIEN,REGIEN)_","
 . S:IENS>0 LOCK(798,IENS)=""
 . Q:$G(CANCEL)=1
 . ;--- Save the data
 . S RC=$$SAVE1(.IENS)
 . I '$D(LOCK)  S:IENS>0 LOCK(798,IENS)=""
 . S:RC>0 RESULTS(0)=RC
 ;
 ;--- Do not unlock the records if there are errors in the data
 ;    (positive value is returned by the $$SAVE1), since the user
 ;--- will have another chance to correct the data and save it.
 D:RC'>0 UNLOCK^RORLOCK(.LOCK)
 D:RC<0 RPCSTK^RORERR(.RESULTS,RC)
 Q
 ;
 ;***** INTERNAL ENTRY POINT THAT UPDATES THE REGISTRY DATA
 ;
 ; IENS798       IENS of the registry record in the file #798
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SAVE1(IENS798) ;
 N IENS,LFIEN,LFV,RC,RDI,REGNAME,RORFDA,RORMSG,SEG,TMP
 ;
 ;=== Add the patient to the registry if necessary
 I IENS798'>0  S RC=0  D  Q:RC<0 RC
 . S REGNAME=$P($$REGNAME^RORUTL01(REGIEN),U)
 . ;--- Add the patient to the registry
 . S RC=$$ADDPAT^RORUPD06(PTIEN,REGNAME)  Q:RC<0
 . ;--- Get the IENS of the registry record
 . S IENS798=$$PRRIEN^RORUTL01(PTIEN,REGIEN)_","
 . S:IENS798'>0 RC=$$ERROR^RORERR(-97,,,PTIEN,REGNAME)
 ;
 ;=== Prepare the data
 N LFCNT ;added 'new' statement
 S (LFCNT,RDI,RC)=0
 F  S RDI=$O(DATA(RDI))  Q:RDI'>0  D  Q:RC
 . S SEG=$P(DATA(RDI),U)
 . ;--- Registry data
 . I SEG="HEPC"  D  Q
 . . ; Insert code here if/when necessary
 . ;--- Local field values
 . I SEG="LFV"  D  Q
 . . S LFIEN=+$P(DATA(RDI),U,3)
 . . S:LFIEN>0 LFV(LFIEN)=DATA(RDI)
 . ;--- If there is a comment for a Pending Patient
 . I SEG="PC" D  Q
 . . S STAT=$P(DATA(RDI),U,2)
 . . S COMMENT=$P(DATA(RDI),U,3)
 Q:RC RC
 ;
 ;=== Confirm the pending patient
 ;D:$$GET1^DIQ(798,IENS798,3,"I",,"RORMSG")=4
 I CANCEL=0 D
 . ;--- Do not clear the DON'T SEND flag for 'test' patients
 . S:'$$TESTPAT^RORUTL01(PTIEN) RORFDA(798,IENS798,11)="@"
 . ;--- Change the STATUS from 'Pending' to 'Active'
 . S RORFDA(798,IENS798,3)=0
 . ;--- Delete any comment fields
 . S RORFDA(798,IENS798,12)=" "
 ;
 ;=== Update local fields
 ;S RC=$$UPDLFV^RORUTL19(IENS798,.LFV)  Q:RC<0 RC
 S RC=$$UPDLFV^RORUTL19(IENS798,.LFV)
 S:RC RORFDA(798,IENS798,5)=1  ; UPDATE LOCAL REGISTRY DATA
 ;=== Add the COMMENT field to file 798 for pending patients
 I STAT="P" S RORFDA(798,IENS798,12)=$G(COMMENT)
 ;
 ;=== Update the record(s)
 I $D(RORFDA)>1  D  Q:RC<0 RC
 . K RORMSG D FILE^DIE(,"RORFDA","RORMSG")
 . ;S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IENS798)
 . S:$G(RORMSG("DIERR")) RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IENS798)
 ;
 ;=== Success
 Q 0

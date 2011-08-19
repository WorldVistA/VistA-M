RORRP040 ;HCIOFO/SG - RPC: LOCAL REGISTRY FIELDS ; 8/25/05 12:23pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** LOADS THE LIST OF LOCAL FIELD DEFINITIONS
 ; RPC: [ROR LIST LOCAL FIELDS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; FLAGS         Flags that control processing:
 ;                 I  Include inactive field definitions
 ;
 ; [LOCK]        Lock the local fields before loading the data and
 ;               leave them locked.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) node
 ; indicates an error (see the RPCSTK^RORERR procedure for details).
 ;
 ; If the local field table cannot be locked then the second
 ; "^"-piece of the @RESULTS@(0) will be greater than 0 and the
 ; node will contain the lock descriptor.
 ;
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of local fields
 ;                         ^02: Lock Descriptor (see the
 ;                         ...  LOCK^RORLOCK for details)
 ;
 ; The subsequent nodes will contain local field definitions.
 ;
 ; See the description of the ROR LIST LOCAL FIELDS remote procedure
 ; for more details.
 ;
LFLIST(RESULTS,REGIEN,FLAGS,LOCK) ;
 N CNT,IEN,IENS,LOCKRC,NAME,RC,ROOT,RORBUF,RORERRDL,RORMSG,TMP
 D CLEAR^RORERR("LFLIST^RORRP040",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Flags
 . S FLAGS=$G(FLAGS)
 ;
 ;=== Lock the ROR LOCAL FIELD file
 I $G(LOCK)  D  I LOCKRC<0  D RPCSTK^RORERR(.RESULTS,LOCKRC)  Q
 . S LOCKRC=$$LOCK^RORLOCK(799.53)
 ;
 ;=== Load the list of field definitions
 S DT=$$DT^XLFDT
 S ROOT=$$ROOT^DILFD(799.53,,1)
 S NAME="",(CNT,RC)=0
 F  S NAME=$O(@ROOT@("KEY",REGIEN,NAME))  Q:NAME=""  D  Q:RC<0
 . S IEN=0
 . F  S IEN=$O(@ROOT@("KEY",REGIEN,NAME,IEN))  Q:IEN'>0  D  Q:RC<0
 . . S IENS=IEN_","  K RORBUF,RORMSG
 . . D GETS^DIQ(799.53,IENS,".01;.02;1","I","RORBUF","RORMSG")
 . . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798.53)  Q
 . . ;--- Skip inactive field definition if necessary
 . . I FLAGS'["I"  D  I TMP>0  Q:TMP'>DT
 . . . S TMP=+$G(RORBUF(799.53,IENS,.02,"I"))
 . . ;--- Add the definition to the list
 . . S CNT=CNT+1,RORBUF=IEN
 . . S $P(RORBUF,U,2)=$G(RORBUF(799.53,IENS,.01,"I"))
 . . S $P(RORBUF,U,3)=$G(RORBUF(799.53,IENS,.02,"I"))
 . . S $P(RORBUF,U,4)=$G(RORBUF(799.53,IENS,1,"I"))
 . . S @RESULTS@(CNT)=RORBUF
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;
 ;=== Success
 S @RESULTS@(0)=CNT_U_$G(LOCKRC)
 Q
 ;
 ;***** UPDATES THE LIST OF LOCAL FIELD DEFINITIONS
 ; RPC: [ROR UPDATE LOCAL FIELDS]
 ;
 ; .RESULTS      Reference to a local variable
 ;
 ; REGIEN        Registry IEN
 ;
 ; [CANCEL]      Cancel the update and unlock the local fields
 ;
 ; [.LFLST]      Reference to a local variable that contains
 ;               a list of local fields
 ; .LFLST(
 ;
 ;   i)          Local Field Descriptor
 ;                 ^01: IEN
 ;                 ^02: Name
 ;                 ^03: Inactivation Date (FileMan)
 ;                 ^04: Description
 ;
 ; See the description of the ROR UPDATE LOCAL FIELDS remote procedure
 ; for more details.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) node
 ; indicates an error (see the RPCSTK^RORERR procedure for details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
LFLUPD(RESULTS,REGIEN,CANCEL,LFLST) ;
 N ECNT,I,IEN,RC,RORERRDL,TMP
 K RESULTS
 D CLEAR^RORERR("LFLUPD^RORRP040",1)
 S (ECNT,RC)=0
 ;
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- List of local fields
 . S I=0
 . F  S I=$O(LFLST(I))  Q:I'>0  D
 . . S IEN=+$P(LFLST(I),U)  S:IEN>0 LFLST("AI",IEN)=I
 ;
 D:'$G(CANCEL)
 . N DA,DIK,IENS,NAME,RORFDA,RORMSG,XREF
 . ;--- Delete the old records
 . S DIK=$$ROOT^DILFD(799.53)
 . S XREF=DIK_"""KEY"","_REGIEN_")"
 . S NAME=""
 . F  S NAME=$O(@XREF@(NAME))  Q:NAME=""  D
 . . S DA=""
 . . F  S DA=$O(@XREF@(NAME,DA))  Q:DA=""  D
 . . . D:'$D(LFLST("AI",DA)) LVDEL(DA),^DIK
 . ;--- Store the new records
 . S NODE=$$CREF^DILF(DIK)
 . S I=0
 . F  S I=$O(LFLST(I))  Q:I'>0  D
 . . S IEN=+$P(LFLST(I),U)
 . . S IENS=$S(IEN'>0:"+1,",$D(@NODE@(IEN)):IEN_",",1:"+1,")
 . . K RORFDA,RORMSG
 . . S RORFDA(799.53,IENS,.01)=$P(LFLST(I),U,2)  ; NAME
 . . S RORFDA(799.53,IENS,.02)=$P(LFLST(I),U,3)  ; DATE OF INACTIV.
 . . S RORFDA(799.53,IENS,.03)=REGIEN            ; REGISTRY
 . . S RORFDA(799.53,IENS,1)=$P(LFLST(I),U,4)    ; DESCRIPTION
 . . I $E(IENS,1)="+"  D
 . . . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . . E  D FILE^DIE(,"RORFDA","RORMSG")
 . . I $G(DIERR)  D  S ECNT=ECNT+1
 . . . D DBS^RORERR("RORMSG",-9,,,799.53,IENS)
 ;
 ;=== Unlock the file and check for errors
 D UNLOCK^RORLOCK(799.53)
 I ECNT>0  D RPCSTK^RORERR(.RESULTS,-9)  Q
 ;--- Success
 S RESULTS(0)=0
 Q
 ;
 ;***** DELETES THE LOCAL FIELD FROM THE PATIENTS' RECORDS
 ;
 ; LFIEN         IEN of the local field (file #799.53)
 ;
LVDEL(LFIEN) ;
 N DA,DIK,XREF
 S XREF=$$ROOT^DILFD(798)_"""ALF"","_LFIEN_")"
 S DA(1)=""
 F  S DA(1)=$O(@XREF@(DA(1)))  Q:DA(1)=""  D
 . S DA="",DIK=$$ROOT^DILFD(798.02,","_DA(1)_",")
 . F  S DA=$O(@XREF@(DA(1),DA))  Q:DA=""  D ^DIK
 Q

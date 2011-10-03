RORRP036 ;HCIOFO/SG - RPC: HEPC PATIENT LOAD ; 10/27/05 2:39pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PROCESSES THE ERROR(S) AND UNLOCKS THE RECORDS
ERROR(RESULTS,RC) ;
 D RPCSTK^RORERR(.RESULTS,RC)
 D UNLOCK^RORLOCK(.RORLOCK)
 Q
 ;
 ;***** LOADS THE PATIENT'S DATA FOR EDITING
 ; RPC: [RORHEPC PATIENT LOAD]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; [LOCK]        Lock the registry record before loading the data and
 ;               leave it locked.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; If locking was requested (see the LOCK parameter) and the record
 ; could not be locked then the first "^"-piece of the @RESULTS@(0)
 ; would be greater than 0. The @RESULTS@(0) would contain the lock
 ; descriptor and subsequent nodes of the global array would contain
 ; the data (see below). The lock descriptor contains information
 ; about the process, which owns the most recent lock of the record.
 ; The "O" flag (read-only) would also be added to the 15th field
 ; of the "PRD" segment.
 ;
 ; @RESULTS@(0)          Lock Descriptor
 ;                         ^01: Date/Time (FileMan)
 ;                         ^02: User/Process name
 ;                         ^03: User IEN (DUZ)
 ;                         ^04: $JOB
 ;                         ^05: Task number
 ;
 ; THE DATA IS LOADED ONLY FOR VIEWING PURPOSES (READ-ONLY)!
 ;
 ; Otherwise, zero is returned in the @RESULTS@(0) and the
 ; subsequent nodes of the global array contain the patient's data.
 ; 
 ; @RESULTS@(0)          0
 ;
 ; @RESULTS@(i)          Demographic data
 ;                         ^01: "DEM"
 ;                         ^02: ""
 ;                         ...  See description of the ROR PATIENT
 ;                              GET DATA remote procedure
 ;
 ; @RESULTS@(i)          Basic registry data
 ;                         ^01: "PRD"
 ;                         ^02: ""
 ;                         ...  See description of the ROR PATIENT
 ;                              GET DATA remote procedure
 ;
 ; RESULTS(i)            Local field data
 ;                         ^O1: "LFV"
 ;                         ...  See description of the ROR PATIENT
 ;                              GET DATA remote procedure
 ;
 ; RESULTS(i)            Selection Rule
 ;                         ^01: "PSR"
 ;                         ...  See description of the ROR PATIENT
 ;                              GET DATA remote procedure
 ;
LOAD(RESULTS,REGIEN,PATIEN,LOCK) ;
 N HEPCBUF,I,IENS,LOCKRC,RC,RESPTR,RORBUF,RORERRDL,RORLOCK,RORMSG,TMP
 D CLEAR^RORERR("LOAD^RORRP036",1)
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 S HEPCBUF="HEPC",LOCKRC=0
 ;=== Check the parameters
 S RC=0  D  I RC<0  D ERROR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 ;
 ;=== Get the IENS of the registry record
 S IENS=$$PRRIEN^RORUTL01(PATIEN,REGIEN)_","
 ;
 ;=== Lock the record
 I $G(LOCK),IENS>0  D  I LOCKRC<0  D ERROR(.RESULTS,+LOCKRC)  Q
 . S LOCKRC=$$LOCK^RORLOCK(798,IENS)
 ;
 ;=== Get the patient's data
 D GETPTDAT^RORRP021(.RORBUF,PATIEN,"LS",REGIEN)
 I $G(RORBUF(0))<0  D ERROR(.RESULTS,+RORBUF(0))  Q
 ;---
 S I=""
 F  S I=$O(RORBUF(I))  Q:I=""  Q:$P(RORBUF(I),U)="PRD"
 D:I'=""
 . S TMP=$P(RORBUF(I),U,15)
 . I TMP'["O"  S:LOCKRC $P(RORBUF(I),U,15)=TMP_"O" ; Read Only
 . E  D UNLOCK^RORLOCK(.RORLOCK)  S LOCKRC=0
 ;---
 M @RESULTS=RORBUF  S RESPTR=$O(RORBUF(""),-1)
 K RORBUF
 ;
 ;=== Load the HepC data
 I IENS>0  S RC=0  D  I RC<0  D ERROR(.RESULTS,RC)  Q
 . Q:$D(^RORDATA(798,+IENS))<10
 . ; Insert code here if/when necessary
 ;
 ;===
 S RESPTR=RESPTR+1,@RESULTS@(RESPTR)=HEPCBUF
 S @RESULTS@(0)=LOCKRC
 Q

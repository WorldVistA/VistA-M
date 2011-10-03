RORRP025 ;HCIOFO/SG - RPC: RORICR CDC LOAD ;2/3/04 8:11am
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #10060        Read access to the NEW PERSON file (#200)
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*14   APR  2011   A SAUNDERS   CS: quit if not 'yes'
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** DEMOGRAPHIC INFORMATION (III)
CDM(IENS) ;
 N BUF,RC,RORBUF,TMP
 S BUF="CDM"
 S RC=$$LOAD^RORRP026(IENS,"CDM^RORRP026",.BUF,.RORBUF)  Q:RC<0 RC
 ;--- Age at diagnosis
 S TMP=+$G(RORBUF(799.4,IENS,9.02,"I"))
 S:TMP=1 $P(BUF,U,4)=$G(RORBUF(799.4,IENS,9.03,"I"))
 S:TMP=2 $P(BUF,U,4)=$G(RORBUF(799.4,IENS,9.04,"I"))
 ;--- Country of birth
 S TMP=+$G(RORBUF(799.4,IENS,9.07,"I"))
 S:TMP=7 $P(BUF,U,8)=$G(RORBUF(799.4,IENS,9.08,"I"))
 S:TMP=8 $P(BUF,U,8)=$G(RORBUF(799.4,IENS,9.09,"I"))
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** COMMENTS (X)
CMT(IENS) ;
 N BUF,I,RC,RORBUF,RORMSG,TMP
 S TMP=$$GET1^DIQ(799.4,IENS,25,,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.4,IENS)
 ;--- Store the data into the result buffer
 S I=0
 F  S I=$O(RORBUF(I))  Q:I'>0  D
 . S RORPTR=RORPTR+1,RORDST(RORPTR)="CMT"_U_I_U_RORBUF(I)
 Q 0
 ;
 ;***** CLINICAL STATUS (VIII)
CS(IENS) ;
 N BUF,I,IENS1,RC,RORBUF,RORMSG,TMP
 S BUF="CS"
 S RC=$$LOAD^RORRP026(IENS,"CS^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 ;--- Load the AIDS Indicator diseases
 S IENS1=","_IENS,TMP="@;.01I;.02I;.03I"
 D LIST^DIC(799.41,IENS1,TMP,,,,,"B",,,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.41,IENS1)
 ;--- Process the list
 S I=0
 F  S I=$O(RORBUF("DILIST","ID",I))  Q:I'>0  D
 . S BUF="AID"_U_$G(RORBUF("DILIST","ID",I,.01))
 . S TMP=$G(RORBUF("DILIST","ID",I,.02))  Q:TMP'=1
 . S $P(BUF,U,3)=TMP
 . S $P(BUF,U,4)=$$DATE^RORRP026($G(RORBUF("DILIST","ID",I,.03)))
 . ;--- Store the data into the result buffer
 . S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** PROCESSES THE ERROR(S) AND UNLOCKS THE RECORDS
ERROR(RESULTS,RC) ;
 D RPCSTK^RORERR(.RESULTS,RC)
 D UNLOCK^RORLOCK(.RORLOCK)
 Q
 ;
 ;***** FACILITY OF DIAGNOSIS (IV)
FD(IENS) ;
 N BUF,RC,RORBUF,TMP
 S BUF="FD"
 S RC=$$LOAD^RORRP026(IENS,"FD^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** FORM HEADERS
HDR(IENS) ;
 N BUF,IENS200,RC,RORBUF,RORMSG,TMP
 S BUF="HDR"
 S RC=$$LOAD^RORRP026(IENS,"HDR^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Date when the CDC form was completed
 S:$P(BUF,U,3)="" $P(BUF,U,3)=$$DT^XLFDT
 ;--- Person who is completing the form
 S IENS200=DUZ_","
 D GETS^DIQ(200,IENS200,".01;.132",,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,200,IENS200)
 S $P(BUF,U,4)=DUZ
 S $P(BUF,U,5)=$G(RORBUF(200,IENS200,.01))
 S $P(BUF,U,6)=$G(RORBUF(200,IENS200,.132))
 ;--- Medical record number (it is the SSN now)
 S $P(BUF,U,7)=$P($G(RORDST(1)),U,6)
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** LABORATORY DATA (VI)
LD(IENS) ;
 N BUF,FLD,RC,RORBUF,TMP
 S BUF="LD1"
 S RC=$$LOAD^RORRP026(IENS,"LD1^RORRP026",.BUF,.RORBUF)  Q:RC<0 RC
 ;--- Positive HIV detection test
 S FLD=$$PHIVFLD^RORRP026($P(BUF,U,12))
 S:FLD $P(BUF,U,13)=$$DATE^RORRP026($G(RORBUF(799.4,IENS,FLD,"I")))
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 ;--- The second segment
 S BUF="LD2"
 S RC=$$LOAD^RORRP026(IENS,"LD2^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** LOADS THE ICR CDC DATA
 ; RPC: [RORICR CDC LOAD]
 ;
 ; .RORDST       Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; [LOCK]        Lock the ICR record before loading the data and
 ;               leave it locked.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RORDST(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; If locking was requested (see the LOCK parameter) and the record
 ; could not be locked then the first "^"-piece of the RORDST(0)
 ; would be greater than 0. The RORDST(0) would contain the lock
 ; descriptor and subsequent nodes of the global array would contain
 ; the data (see below). The lock descriptor contains information
 ; about the propcess, which owns the most recent lock of the record.
 ;
 ; RORDST(0)             Lock Descriptor
 ;                         ^01: Date/Time (FileMan)
 ;                         ^02: User/Process name
 ;                         ^03: User IEN (DUZ)
 ;                         ^04: $JOB
 ;                         ^05: Task number
 ;
 ; THE DATA ARE LOADED ONLY FOR VIEWING PURPOSES (READ-ONLY)!
 ;
 ; Otherwise, zero is returned in the RORDST(0) and the subsequent
 ; nodes of the array contain the data.
 ; 
 ; RORDST(0)             0
 ;
 ; RORDST(i)             Data Item
 ;                         ^01: Type
 ;                         ^02: Sequential Number or Item Code
 ;                         ^03: Value
 ;                         ^04: ...
 ;
 ;                       Item Types:
 ;                         DEM  Demographic Information
 ;                         ADR  Patient's Address
 ;                         RCE  Race Information
 ;                         ETN  Ethnicity Information
 ;                         HDR  Headers
 ;                         CDM  CDC Demographics
 ;                         FD   Facility of Diagnosis
 ;                         PH   Patient History
 ;                         LD1  Laboratory Data
 ;                         LD2  Laboratory Data
 ;                         CS   Clinical Status
 ;                         AID  AIDS Indicator Disease
 ;                         TS1  Treatment/Services
 ;                         TS2  Treatment/Services
 ;                         CMT  Comments
 ;
 ; See the CDC FIELD TABLE section (CDCFLDS^RORRP026) and the
 ; description of the RORICR CDC LOAD remote procedure for details.
 ;
LOADCDC(RORDST,REGIEN,PATIEN,LOCK) ;
 N BUF,IEN,RC,RDONLY,RORERRDL,RORLOCK,RORPTR
 D CLEAR^RORERR("LOADCDC^RORRP025",1)
 K RORDST  S (RDONLY,RORDST(0))=0
 ;--- Check the parameters
 S RC=0  D  I RC<0  D ERROR(.RORDST,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 ;
 ;--- Load the patient's demographic data
 D GETPTDAT^RORRP021(.RORDST,PATIEN,"AER")
 Q:$G(RORDST(0))<0
 S RORPTR=+$O(RORDST(""),-1)
 ;
 ;--- Get the IEN of the registry record
 S IEN=$$PRRIEN^RORUTL01(PATIEN,REGIEN)  Q:IEN'>0
 S IENS=IEN_","
 ;
 ;--- Lock the record
 I $G(LOCK)  D  I RDONLY<0  D ERROR(.RORDST,+RDONLY)  Q
 . S RORLOCK(799.4,IENS)=""
 . S RDONLY=$$LOCK^RORLOCK(799.4,IENS)
 ;
 ;--- Create the data segments
 S RC=0  D  I RC<0  D ERROR(.RORDST,RC)  Q
 . S RC=$$HDR(IENS)  Q:RC<0
 . S RC=$$CDM(IENS)  Q:RC<0
 . S RC=$$FD(IENS)   Q:RC<0
 . S RC=$$PH(IENS)   Q:RC<0
 . S RC=$$LD(IENS)   Q:RC<0
 . S RC=$$CS(IENS)   Q:RC<0
 . S RC=$$TS(IENS)   Q:RC<0
 . S RC=$$CMT(IENS)  Q:RC<0
 ;---
 S RORDST(0)=RDONLY
 Q
 ;
 ;***** PATIENT HISTORY (V)
PH(IENS) ;
 N BUF,RC,RORBUF,TMP
 S BUF="PH"
 S RC=$$LOAD^RORRP026(IENS,"PH^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0
 ;
 ;***** TREATMENT/SERVICES REFERRALS (IX)
TS(IENS) ;
 N BUF,RC,RORBUF,TMP
 S BUF="TS1"
 S RC=$$LOAD^RORRP026(IENS,"TS1^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 ;--- The second segment
 S BUF="TS2"
 S RC=$$LOAD^RORRP026(IENS,"TS2^RORRP026",.BUF)  Q:RC<0 RC
 ;--- Store the data into the result buffer
 S RORPTR=RORPTR+1,RORDST(RORPTR)=BUF
 Q 0

RORRP027 ;HCIOFO/SG - RPC: RORICR CDC SAVE ; 10/16/06 1:58pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,9**;Feb 17, 2006;Build 1
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 ; 05/23/2009 BAY/KAM ROR*1.5*9 Remedy Call 319731 Correct AIDS OI 
 ;                              Checkbox populating incorrectly
 ;                              Remove 3 lines
 Q
 ;
 ;***** AIDS INDICATOR DISEASE (VIII)
AID(IENS) ;
 N CODE,RC,TMP
 S CODE=+$P(RORDATA(RORPTR),U,2)
 Q:CODE'>0 "2^AID"_U_CODE
 ;--- Initial diagnosis
 S RORAILST(CODE)=$P(RORDATA(RORPTR),U,3)
 ;--- Initial date
 S TMP=$$DATE1^RORRP026($P(RORDATA(RORPTR),U,4))
 Q:TMP<0 "4^AID"_U_CODE
 S $P(RORAILST(CODE),U,2)=TMP
 Q 0
 ;
 ;***** STORES THE AIDS INDICATOR DICEASES INTO THE FDA
AIDSTORE() ;
 N CODE,DATE,DTMIN,II,NODE,RC,TMP
 S NODE=$$ROOT^DILFD(799.41,","_IENS,1)
 S RC=0,DTMIN=""
 ;--- Mark the old records for removal
 S CODE=0
 F  S CODE=$O(@NODE@(CODE))  Q:CODE'>0  D:'$D(RORAILST(CODE))
 . S RORFDAFI(799.41,CODE_","_IENS,.01)="@"
 ;--- Prepare the records to be added/updated
 S II=+$O(RORIEN(""),-1)
 S CODE=0
 F  S CODE=$O(RORAILST(CODE))  Q:CODE'>0  D
 . S DATE=$P(RORAILST(CODE),U,2)
 . I DATE>0  S:(DATE<DTMIN)!(DTMIN'>0) DTMIN=DATE
 . ;--- Update the record
 . I $D(@NODE@(CODE))  D  Q
 . . S TMP=CODE_","_IENS
 . . S RORFDAFI(799.41,TMP,.02)=$P(RORAILST(CODE),U,1)
 . . S RORFDAFI(799.41,TMP,.03)=DATE
 . ;--- Add the record
 . S II=II+1,RORIEN(II)=CODE,TMP="?+"_II_","_IENS
 . S RORFDAUP(799.41,TMP,.01)=CODE
 . S RORFDAUP(799.41,TMP,.02)=$P(RORAILST(CODE),U,1)
 . S RORFDAUP(799.41,TMP,.03)=DATE
 ;--- Populate the CLINICAL AIDS fields (if they are empty)
 ;
 ; Remedy call 319731 two lines removed to not populate the CLINICAL 
 ; AIDS fields unless trigged by an AIDS Indicator Disease (CDC form
 ; Section VIII)
 ;---
 Q RC
 ;
 ;***** CANCELS THE EDITING
 ; RPC: [RORICR CDC CANCEL]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
CANCEL(RESULTS,REGIEN,PATIEN) ;
 N IENS,RC,RORERRDL
 D CLEAR^RORERR("CANCEL^RORRP027",1)  K RESULTS
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 ;
 ;--- Get the IENS of the registry record
 S IENS=$$PRRIEN^RORUTL01(PATIEN,REGIEN)_","
 ;
 ;--- Unlock the records
 I IENS>0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$UNLOCK^RORLOCK(799.4,IENS)
 S RESULTS(0)=0
 Q
 ;
 ;***** DEMOGRAPHIC INFORMATION (III)
CDM(IENS) ;
 N BUF,RC,TMP
 S BUF=RORDATA(RORPTR)
 S RC=$$CDCFDA^RORRP026(IENS,"CDM^RORRP026",BUF,.RORFDAFI)
 Q:RC RC
 ;--- Default values
 F TMP=9.04,9.08,9.09  S RORFDAFI(799.4,IENS,TMP)=""
 ;--- Age at diagnosis
 S TMP=+$P(BUF,U,3)
 I TMP  Q:$P(BUF,U,4)'?.2N "4^CDM"  D
 . S:TMP=1 RORFDAFI(799.4,IENS,9.03)=$P(BUF,U,4)
 . S:TMP=2 RORFDAFI(799.4,IENS,9.04)=$P(BUF,U,4)
 ;--- Country of birth
 S TMP=+$P(BUF,U,7)
 S:TMP=7 RORFDAFI(799.4,IENS,9.08)=$P(BUF,U,8)
 S:TMP=8 RORFDAFI(799.4,IENS,9.09)=$P(BUF,U,8)
 Q 0
 ;
 ;***** COMMENTS (X)
CMT(IENS) ;
 N CNT,NE,PTR,RC,SEG,TMP  K RORCMT
 ;--- Load the comments
 S PTR=RORPTR,(CNT,NE,RC)=0
 F  D  Q:RC!(SEG'="CMT")  S PTR=$O(RORDATA(PTR))  Q:PTR=""
 . S SEG=$P(RORDATA(PTR),U)  Q:SEG'="CMT"
 . S RORPTR=PTR  Q:CNT'<3
 . S TMP=$P(RORDATA(RORPTR),U,3)
 . S CNT=CNT+1,RORCMT(CNT)=TMP
 . S:TMP'="" NE=NE+1
 ;--- Store the reference into the FDA
 S RORFDAFI(799.4,IENS,25)=$S(NE>0:"RORCMT",1:"@")
 Q RC
 ;
 ;***** CLINICAL STATUS (VIII)
CS(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"CS^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC
 ;
 ;***** PROCESSES THE ERROR(S) AND UNLOCKS THE RECORDS
ERROR(RESULTS,RC) ;
 D RPCSTK^RORERR(.RESULTS,RC)
 D UNLOCK^RORLOCK(.RORLOCK)
 Q
 ;
 ;***** FACILITY OF DIAGNOSIS (IV)
FD(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"FD^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC
 ;
 ;***** FORM HEADERS
HDR(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"HDR^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 ;--- Person who completed the form
 S RORFDAFI(799.4,IENS,9.05)=DUZ
 Q RC
 ;
 ;***** LABORATORY DATA (VI)
LD1(IENS) ;
 N BUF,FLD,DATE,RC,TMP
 S BUF=RORDATA(RORPTR)
 S RC=$$CDCFDA^RORRP026(IENS,"LD1^RORRP026",BUF,.RORFDAFI)
 Q:RC RC
 ;--- Positive HIV detection test
 S FLD=$$PHIVFLD^RORRP026($P(BUF,U,12))
 I FLD  S RC=0  D  Q:RC RC
 . S DATE=$$DATE1^RORRP026($P(BUF,U,13))
 . I DATE<0  S RC="13^LD1"  Q
 . S RORFDAFI(799.4,IENS,FLD)=DATE
 Q 0
 ;
LD2(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"LD2^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC
 ;
 ;***** PATIENT HISTORY (V)
PH(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"PH^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC
 ;
 ;***** UPDATES THE CDC DATA
 ; RPC: [RORICR CDC SAVE]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; PATIEN        IEN of the registry patient (DFN)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 H  Update the patient history. If this flag is
 ;                    not provided, the PH data segment is ignored.
 ;
 ; .RORDATA      Reference to a local array that contains the CDC
 ;               data in the same format as the output of the RORICR
 ;               CDC LOAD remote procedure (see the LOADCDC^RORRP025
 ;               and description of the RPC for more details).
 ;
 ; NOTE #1: The CS data segment must be always included before the
 ;          AID segments. Otherwise, the latter will be ignored.
 ;
 ; NOTE #2: Any AIDS indicator disease, which has empty 3rd piece
 ;          in the corresponding AID segment (or no segment at all),
 ;          will be removed from the patient record.
 ;
 ; NOTE #3: There should be at least one empty comment (i.e. the
 ;          "CMT^1" segment) among the data if you want to clear
 ;          the CDC comments. Otherwise, they will not be updated.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Positive value of the first "^"-piece of the RESULTS(0) indicates
 ; an error in the CDC data. The value is the number of the erroneous
 ; piece of the data segment whose name is returned in the second
 ; piece of the RESULTS(0). For example, the "11^CDM" means that the
 ; 11th piece of the CDM data segment (ONSET OF ILLNESS/AIDS- STATE)
 ; contains an invalid value.
 ;
 ; Otherwise, zero is returned in the RESULTS(0).
 ;
SAVECDC(RESULTS,REGIEN,PATIEN,FLAGS,RORDATA) ;
 N RORAILST      ; List of AIDS indicator diseases
 N RORCMT        ; Buffer for the CDC comments (WP field)
 N RORFDAFI      ; FDA for FILE^DIE
 N RORFDAUP      ; FDA for UPDATE^DIE
 N RORIEN        ; List of IEN's to be assigned
 ;
 N I,IEN,IENS,RC,RORERRDL,RORMSG,RORPTR,SEG,SEGLST
 D CLEAR^RORERR("SAVECDC^RORRP027",1)
 K RESULTS  S (RESULTS(0),RORPTR)=0
 ;--- Check the parameters
 S RC=0  D  I RC<0  D ERROR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Patient IEN
 . I $G(PATIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PATIEN",$G(PATIEN))
 . S PATIEN=+PATIEN
 . ;--- Flags
 . S FLAGS=$$UP^XLFSTR($G(FLAGS))
 ;
 ;--- Get IEN of the registry record
 S IEN=$$PRRIEN^RORUTL01(PATIEN,REGIEN)  Q:IEN'>0
 S IENS=IEN_","
 S RORLOCK(799.4,IENS)=""
 ;
 ;--- Prepare the data
 S SEGLST=",HDR,CDM,FD,LD1,LD2,CS,AID,TS1,TS2,CMT,"
 S:FLAGS["H" SEGLST=SEGLST_"PH,"
 S (RC,RORPTR)=0
 F  S RORPTR=$O(RORDATA(RORPTR))  Q:RORPTR'>0  D  Q:RC
 . S SEG=$TR($P(RORDATA(RORPTR),U)," ")
 . X:SEGLST[(","_SEG_",") "S RC=$$"_SEG_"(IENS)"
 I RC<0  D ERROR(.RESULTS,RC)  Q
 I RC>0  S RESULTS(0)=RC  Q
 ;
 ;--- Process the list of AIDS indicator diseases
 S RC=$$AIDSTORE()
 I RC<0  D ERROR(.RESULTS,RC)  Q
 ;
 ;--- Update the record(s)
 I $D(RORFDAFI)>1  D  I RC<0  D ERROR(.RESULTS,RC)  Q
 . D FILE^DIE(,"RORFDAFI","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PATIEN,799.4,IENS)
 ;--- Add the record(s)
 I $D(RORFDAUP)>1  D  I RC<0  D ERROR(.RESULTS,RC)  Q
 . D UPDATE^DIE(,"RORFDAUP","RORIEN","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PATIEN,799.4,IENS)
 ;
 ;--- Unlock the records
 S RC=$$UNLOCK^RORLOCK(.RORLOCK)
 I RC<0  D ERROR(.RESULTS,RC)  Q
 S RESULTS(0)=0
 Q
 ;
 ;***** TREATMENT/SERVICES REFERRALS (IX)
TS1(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"TS1^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC
 ;
TS2(IENS) ;
 N RC,TMP
 S RC=$$CDCFDA^RORRP026(IENS,"TS2^RORRP026",RORDATA(RORPTR),.RORFDAFI)
 Q RC

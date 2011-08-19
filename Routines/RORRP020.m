RORRP020 ;HIOFO/SG,VC - RPC: PATIENT DATA UTILITIES ;4/7/09 9:53am
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8**;Feb 17, 2006;Build 8
 ;
 ; This routine uses the following IAs:
 ;
 ; #2051         LIST^DIC (supported)
 ; #2056         GET1^DIQ, GETS^DIQ (supported)
 ; #10061        4^VADPT (supported)
 ;
 Q
 ;
 ;***** LOADS THE DATA FROM THE 'PATIENT' FILE (#2)
 ;
 ; DFN           Patient IEN
 ;
 ; .RORDEM       Reference to a local variable where the demographic
 ;               information is returned to:
 ;
 ;                 ^01: Patient IEN (DFN)
 ;                 ^02: Patient Name
 ;                 ^03: Date of Birth (FileMan)
 ;                 ^04: SSN
 ;                 ^05: Date of Death (FileMan)
 ;                 ^06: Sex (F/M)
 ;
 ; [.RORADR]     Reference to a local variable where the patient's
 ;               address is returned to:
 ;
 ;                 ^01: Address (1)
 ;                 ^02: Address (2)
 ;                 ^03: Address (3)
 ;                 ^04: City
 ;                 ^05: State (IEN)
 ;                 ^06: State (Name)
 ;                 ^07: ZIP
 ;                 ^08: ZIP+4
 ;                 ^09: County (IEN)
 ;                 ^10: County (Name)
 ;                 ^11: Home Phone
 ;
 ; [.VADM]       Reference to a local array that is populated by
 ;               the 4^VADM API inside this function
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOAD2(DFN,RORDEM,RORADR,VADM) ;
 N I,VA,VAHOW,VAPA,VAROOT  D 4^VADPT
 ;--- Demographic information
 S RORDEM=DFN                          ; DFN
 S $P(RORDEM,U,2)=$G(VADM(1))          ; Name
 S $P(RORDEM,U,3)=$P($G(VADM(3)),U)    ; DOB
 S $P(RORDEM,U,4)=$P($G(VADM(2)),U)    ; SSN
 S $P(RORDEM,U,5)=$P($G(VADM(6)),U)    ; DOD
 S $P(RORDEM,U,6)=$P($G(VADM(5)),U)    ; Sex
 ;--- Patient's address
 S RORADR=$G(VAPA(1))                  ; Address (1)
 S $P(RORADR,U,2)=$G(VAPA(2))          ; Address (2)
 S $P(RORADR,U,3)=$G(VAPA(3))          ; Address (3)
 S $P(RORADR,U,4)=$G(VAPA(4))          ; City
 S $P(RORADR,U,5)=$P($G(VAPA(5)),U,1)  ; State IEN
 S $P(RORADR,U,6)=$P($G(VAPA(5)),U,2)  ; State Name
 S $P(RORADR,U,7)=$P($G(VAPA(6)),U,1)  ; ZIP
 S $P(RORADR,U,8)=$P($G(VAPA(6)),U,2)  ; ZIP+4
 S $P(RORADR,U,9)=$P($G(VAPA(7)),U,1)  ; County IEN
 S $P(RORADR,U,10)=$P($G(VAPA(7)),U,2) ; County Name
 S $P(RORADR,U,11)=$G(VAPA(8))         ; Home Phone Number
 Q 0
 ;
 ;***** LOADS THE REGISTRY DATA FOR THE PATIENT
 ;
 ; IEN           IEN of the registry record (file #798)
 ;
 ; .ROR8DST      Reference to a local variable where the results
 ;               are returned to:
 ;
 ;                 ^01: Date Entered (FileMan)
 ;                 ^02: Status Code (Field 3, File #798)
 ;                 ^03: Active (0/1)
 ;                 ^04: Do not Send (0/1)
 ;                 ^05: Data Acknowledged Until (FileMan)
 ;                 ^06: Data Extracted Until (FileMan)
 ;                 ^07: Date Selected (FileMan)
 ;                 ^08: Date Confirmed (FileMan)
 ;                 ^09: Location Selected (Institution Name)
 ;                 ^10: Description of the Earliest Selection Rule
 ;                 ^11: reserved
 ;                 ^12: reserved
 ;                 ^13: Action Flags (see the description below)
 ;
 ;               The Action Flags field indicates the actions that
 ;               can be performed on the patient's record in the
 ;               registry:
 ;
 ;                   C  CDC form can be edited/printed
 ;                   D  The record can be deleted
 ;                   E  The record can be edited
 ;                   O  Read-only mode
 ;
 ; DOD           Date of Death (for deceased patients)
 ;
 ; COMMENT        Comment of no more than 100 characters added for
 ;                Patch 1.5*8  January, 2009
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOAD798(IEN,ROR8DST,DOD) ;
 N FLAGS,IENS,RC,RORBUF,RORMSG,TMP
 S ROR8DST=""
 ;
 ;--- Check if the patient is in the registry
 I (IEN'>0)!($D(^RORDATA(798,+IEN))<10)  D  Q 0
 . S $P(ROR8DST,U,13)=""
 ;
 ;--- Load values from the registry record
 S IENS=(+IEN)_","
 ;****************************** ONE LINE OF OLD CODE
 ;D GETS^DIQ(798,IENS,"1;2;3;8;9.1;9.2;11","I","RORBUF","RORMSG")
 K RORMSG D GETS^DIQ(798,IENS,"1;2;3;8;9.1;9.2;11;12","I","RORBUF","RORMSG")
 ;Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798,IENS)
 Q:$G(RORMSG("DIERR")) $$DBS^RORERR("RORMSG",-9,,,798,IENS)
 ;
 ;--- Registry data
 S ROR8DST=$G(RORBUF(798,IENS,1,"I"))            ; DATE ENTERED
 S $P(ROR8DST,U,2)=+$G(RORBUF(798,IENS,3,"I"))   ; STATUS
 S $P(ROR8DST,U,3)=+$G(RORBUF(798,IENS,8,"I"))   ; ACTIVE
 S $P(ROR8DST,U,4)=+$G(RORBUF(798,IENS,11,"I"))  ; DON'T SEND
 S $P(ROR8DST,U,5)=$G(RORBUF(798,IENS,9.1,"I"))  ; ACKNOWLEDGED UNTIL
 S $P(ROR8DST,U,6)=$G(RORBUF(798,IENS,9.2,"I"))  ; EXTRACTED UNTIL
 S $P(ROR8DST,U,8)=$G(RORBUF(798,IENS,2,"I"))    ; DATE CONFIRMED
 ; -- ADDED COMMENT
 S $P(ROR8DST,U,14)=$G(RORBUF(798,IENS,12,"I"))  ; COMMENT
 ;
 ;--- Earliest selection rule
 S IENS=","_IENS,TMP="@;.01I;1I;2E"  K RORBUF
 K RORMSG D LIST^DIC(798.01,IENS,TMP,"PU",1,,,"AD",,,"RORBUF","RORMSG")
 ;Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.01,IENS)
 Q:$G(RORMSG("DIERR")) $$DBS^RORERR("RORMSG",-9,,,798.01,IENS)
 I $G(RORBUF("DILIST",0))>0  S RC=0  D  Q:RC<0 RC
 . S TMP=$G(RORBUF("DILIST",1,0))
 . S $P(ROR8DST,U,7)=$P(TMP,U,3)                 ; DATE
 . S $P(ROR8DST,U,9)=$P(TMP,U,4)                 ; LOCATION
 . S IENS=+$P(TMP,U,2)_","
 . K RORMSG S TMP=$$GET1^DIQ(798.2,IENS,4,,,"RORMSG")
 . ;S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.2,IENS)
 . S:$G(RORMSG("DIERR")) RC=$$DBS^RORERR("RORMSG",-9,,,798.2,IENS)
 . S $P(ROR8DST,U,10)=TMP                        ; SELECTION RULE
 ;
 ;--- Action flags
 ; The actions and modes are enabled/disabled according to the
 ; following table:
 ;-----------------------------------------------------;
 ;   Actions    ;        Status of the patient         ;
 ;     and      ;--------------------------------------;
 ;    Modes     ;Not Added;Pending;Active;Inactive;Dead;
 ;--------------+---------+-------+------+--------+----;
 ; (C)DC        ;    D    ;   D   ;      ;        ;    ;
 ; (D)elete     ;    D    ;       ;      ;        ;    ;
 ; (E)dit       ;    D    ;       ;      ;        ;    ;
 ; Read (O)nly  ;         ;       ;      ;        ;    ;
 ;-----------------------------------------------------;
 ; D  the action is disabled if at least one of the marked
 ;    conditions is true;
 ;
 ; E  the action is enabled if at least one of the marked
 ;    conditions is true.
 ;---
 D
 . I $P(ROR8DST,U,2)=4  S FLAGS="DE"  Q    ; Pending
 . S FLAGS="CDE"
 S $P(ROR8DST,U,13)=FLAGS
 Q 0
 ;
 ;***** PERFORMS THE POST-PROCESSING OF THE LISTS
 ;
 ; RESULTS       Closed root of the array that contains the
 ;               results of the query
 ;
 ; REGIEN        Registry IEN
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
POSTPROC(RESULTS,REGIEN,FLAGS) ;
 N BUF,DOD,FNP,FO,IEN,IR,PATIEN,RC,TMP
 S FNP=($TR(FLAGS,"P")'=FLAGS),FO=(FLAGS["O")
 ;--- Process the resulting records
 S (IR,RC)=0
 F  S IR=$O(@RESULTS@(IR))  Q:IR'>0  D  Q:RC<0
 . S BUF=$G(@RESULTS@(IR,0)),PATIEN=+$P(BUF,U,2)
 . I PATIEN'>0  S PATIEN=+BUF  Q:PATIEN'>0
 . ;--- Load the required fields from the PATIENT file
 . Q:$$LOAD2(PATIEN,.BUF)<0
 . S DOD=$P(BUF,U,5)
 . S @RESULTS@(IR,0)=BUF
 . ;--- Add optional registry fields if necessary
 . I FO  D  Q:RC<0
 . . ;--- Get the IEN of the registry record
 . . S IEN=$$PRRIEN^RORUTL01(PATIEN,REGIEN)
 . . ;--- Try to load the data from the ROR REGISTRY RECORD file
 . . S RC=$$LOAD798(IEN,.BUF,DOD)
 . . S:RC'<0 @RESULTS@(IR,1)="O^"_BUF
 ;---
 Q $S(RC<0:RC,1:0)

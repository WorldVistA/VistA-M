RORRP021 ;HCIOFO/SG - RPC: PATIENT DATA ; 8/19/05 10:28am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** LOADS THE PATIENT DATA
 ; RPC: [ROR PATIENT GET DATA]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; PTIEN         IEN of the patient (DFN)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 A  Load the patient's address
 ;                 E  Load the ethnicity information
 ;                 L  Load values of patient's active local fields
 ;                 R  Load the race information
 ;                 S  Load the selection rules
 ;
 ;               The "L" and "S" flags require the REGIEN parameter.
 ;               Otherwise, they are ignored.
 ;
 ; [REGIEN]      Registry IEN.
 ;               If value of this parameter is greater than 0
 ;               then the "PRD" segment with the basic patient's
 ;               registry data will be returned. If the patient
 ;               is not in the registry then an empty "PRD" segment
 ;               will be returned anyway.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, zero is returned in the RESULTS(0) and the subsequent
 ; nodes of the array contain the patient's data.
 ; 
 ; RESULTS(0)            0
 ;
 ; RESULTS(i)            Demographic Information
 ;                         ^01: "DEM"
 ;                         ^02: ""
 ;                         ...  See the $$LOAD2^RORRP020 (RORDEM)
 ;
 ; RESULTS(i)            Patient's Address
 ;                         ^01: "ADR"
 ;                         ^02: ""
 ;                         ...  See the $$LOAD2^RORRP020 (RORADR)
 ;
 ; RESULTS(i)            Race Information
 ;                         ^01: "RCE"
 ;                         ^02: Race IEN
 ;                         ^03: Race HL7 Value
 ;                         ^04: Race
 ;                         ^05: Collection Method HL7 Value
 ;                         ^06: Collection Method
 ;
 ;                       Race HL7 Values
 ;                         1002-5  American Indian or Alaska Native
 ;                         2028-9  Asian
 ;                         2054-5  Black or African American
 ;                         0000-0  Declined to Answer
 ;                         2076-8  Native Hawaiian or Pacific Islander
 ;                         9999-4  Unknown by Patient
 ;                         2106-3  White
 ;
 ;                       Collection Method HL7 Values
 ;                         OBS     Observer
 ;                         PRX     Proxy
 ;                         SLF     Self Identification
 ;                         UNK     Unknown
 ;
 ; RESULTS(i)            Ethnicity Information
 ;                         ^01: "ETN"
 ;                         ^02: Ethnicity IEN
 ;                         ^03: Ethnicity HL7 Value
 ;                         ^04: Ethnicity
 ;                         ^05: Collection Method HL7 value
 ;                         ^06: Collection Method
 ;
 ;                       Ethnicity HL7 Values
 ;                         0000-0  Declined to Answer
 ;                         2135-2  Hispanic or Latino
 ;                         2186-5  Not Hispanic or Latino
 ;                         9999-4  Unknown by Patient
 ;
 ; RESULTS(i)            Patient's Registry Data
 ;                         ^01: "PRD"
 ;                         ^02: ""
 ;                         ...  See the $$LOAD798^RORRP020
 ;
 ; RESULTS(i)            Local field data
 ;                         ^O1: "LFV"
 ;                         ^02: IEN in the LOCAL FIELD multiple
 ;                              of the ROR REGISTRY RECORD file
 ;                         ^03: Field Definition IEN
 ;                              (in the ROR LOCAL FIELD file)
 ;                         ^04: Field Name
 ;                         ^05: Date (FileMan)
 ;                         ^06: Comment
 ;
 ; RESULTS(i)            Selection Rule
 ;                         ^01: "PSR"
 ;                         ^02: IEN in the SELECTION RULE multiple
 ;                              of the ROR REGISTRY RECORD file
 ;                         ^03: Rule Definition IEN
 ;                              (in the ROR SELECTION RULE file)
 ;                         ^04: Name of the Rule
 ;                         ^05: Date (FileMan)
 ;                         ^06: Location IEN  (Institution IEN)
 ;                         ^07: Location Name (Institution Name)
 ;                         ^08: Short Description
 ;
GETPTDAT(RESULTS,PTIEN,FLAGS,REGIEN) ;
 N BUF,BUF1,DOD,IEN,RC,RESPTR,RORERRDL,VADM
 D CLEAR^RORERR("GETPTDAT^RORRP021",1)
 K RESULTS  S (RESULTS(0),RESPTR)=0
 ;=== Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Patient IEN
 . I $G(PTIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"PTIEN",$G(PTIEN))
 . S PTIEN=+PTIEN
 . ;--- Flags
 . S FLAGS=$$UP^XLFSTR($G(FLAGS))
 ;=== Load the data from the PATIENT file
 S RC=$$LOAD2^RORRP020(PTIEN,.BUF,.BUF1,.VADM)
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 S DOD=$P(BUF,U,5)
 ;
 ;=== Demographic information and address
 S RESPTR=RESPTR+1,RESULTS(RESPTR)="DEM^^"_BUF
 S:FLAGS["A" RESPTR=RESPTR+1,RESULTS(RESPTR)="ADR^^"_BUF1
 ;
 ;=== Race information
 I FLAGS["R"  D:$G(VADM(12))>0
 . N I,METHOD,RACE
 . S I=""
 . F  S I=$O(VADM(12,I))  Q:I=""  D
 . . S RACE=$G(VADM(12,I))  Q:RACE'>0
 . . S METHOD=$G(VADM(12,I,1))
 . . S BUF="RCE"_U_(+RACE)
 . . ;--- 
 . . S $P(BUF,U,3)=$$PTR2CODE^DGUTL4(+RACE,1,2)
 . . S $P(BUF,U,4)=$P(RACE,U,2)
 . . S $P(BUF,U,5)=$$PTR2CODE^DGUTL4(+METHOD,3,2)
 . . S $P(BUF,U,6)=$P(METHOD,U,2)
 . . ;---
 . . S RESPTR=RESPTR+1,RESULTS(RESPTR)=BUF
 ;
 ;=== Ethnicity information
 I FLAGS["E"  D:$G(VADM(11))>0
 . N ETHN,I,METHOD
 . S I=""
 . F  S I=$O(VADM(11,I))  Q:I=""  D
 . . S ETHN=$G(VADM(11,I))  Q:ETHN'>0
 . . S METHOD=$G(VADM(11,I,1))
 . . S BUF="ETN"_U_(+ETHN)
 . . ;--- 
 . . S $P(BUF,U,3)=$$PTR2CODE^DGUTL4(+ETHN,2,2)
 . . S $P(BUF,U,4)=$P(ETHN,U,2)
 . . S $P(BUF,U,5)=$$PTR2CODE^DGUTL4(+METHOD,3,2)
 . . S $P(BUF,U,6)=$P(METHOD,U,2)
 . . ;---
 . . S RESPTR=RESPTR+1,RESULTS(RESPTR)=BUF
 ;
 ;=== Patient's registry data
 I $G(REGIEN)>0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RESPTR=RESPTR+1
 . ;--- Get the IEN of the registry record
 . S IEN=$$PRRIEN^RORUTL01(PTIEN,REGIEN)
 . I IEN'>0  S RESULTS(RESPTR)="PRD"  Q
 . ;--- Load the data from the patient's registry record
 . S RC=$$LOAD798^RORRP020(IEN,.BUF,DOD)  Q:RC<0
 . S RESULTS(RESPTR)="PRD^^"_BUF
 . ;--- Local field values
 . I FLAGS["L"  D  Q:RC<0
 . . S RC=$$LFV(IEN,.RESULTS,.RESPTR)
 . ;--- Selection rules
 . I FLAGS["S"  D  Q:RC<0
 . . S RC=$$PSR(IEN,.RESULTS,.RESPTR)
 ;===
 Q
 ;
 ;***** GET THE LOCAL FIELD VALUES
LFV(IEN798,RESULTS,RESPTR) ;
 N I,IEN,IENS,RORBUF,SCR,RORMSG
 S DT=$$DT^XLFDT
 ;--- Load the data
 S SCR="I $$LFACTIVE^RORDD01(+$G(^(0)))"
 S IENS=","_IEN798_",",I="@;.01I;.01E;.02I;1"
 D LIST^DIC(798.02,IENS,I,"P",,,,"B",SCR,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.02,IENS)
 ;--- Add the data to the output array
 S I=0
 F  S I=$O(RORBUF("DILIST",I))  Q:I'>0  D
 . S RESPTR=RESPTR+1
 . S RESULTS(RESPTR)="LFV^"_RORBUF("DILIST",I,0)
 ;--- Success
 Q 0
 ;
 ;***** GET THE SELECTION RULES
PSR(IEN798,RESULTS,RESPTR) ;
 N BUF,I,IEN,IENS,RORBUF,RORMSG,TMP
 ;--- Load the data
 S IENS=","_IEN798_",",TMP="@;.01I;.01E;1I;2I;2E"
 D LIST^DIC(798.01,IENS,TMP,"P",,,,"AD",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.01,IENS)
 ;--- Add the data to the output array
 S I=0
 F  S I=$O(RORBUF("DILIST",I))  Q:I'>0  D
 . S BUF=RORBUF("DILIST",I,0),IEN=+$P(BUF,U,2)  Q:IEN'>0
 . S TMP=$$GET1^DIQ(798.2,IEN_",",4,,,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.2,IEN_",")
 . S $P(BUF,U,7)=$S(TMP'="":TMP,1:$P(BUF,U,3))
 . S RESPTR=RESPTR+1,RESULTS(RESPTR)="PSR^"_BUF
 ;--- Success
 Q 0

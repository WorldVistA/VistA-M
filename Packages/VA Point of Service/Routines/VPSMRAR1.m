VPSMRAR1  ;DALOI/KML,WOIFO/BT - Update of VPS MRAR PDO file ;1/15/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
WRITE(RESULT,VPSNUM,VPSTYP,VPSINTFC,VPSMRAR) ; RPC=VPS WRITE MRAR PDO
 ; Vetlink Kiosk has the Medication Review Allergy Review modules where a veteran can review and make
 ; changes to his medications and any allergies. The MRAR can also be facilitated by a provider.
 ; The local arrays identify the field to be updated along with the respective data changes and serves to RPC
 ; 
 ; INPUT
 ;   RESULT   : represents the results of processing and passed in by reference (required by RPC Broker)
 ;   VPSNUM   : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP   : Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSINTFC : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;            : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   VPSMRAR  : local array representing the kiosk Medication and Allergy Review passed in by reference 
 ;              VPSMRAR represents allergy related fields, medication related fields, and statistical information about the MRAR session.
 ;              Each subscript in the array is assigned a composite, delimited string. 
 ;              VPSMRAR(n) = FIELD NAME^ARRAY IENS^DATA 
 ;                n is an incremental number
 ;                FIELD NAME represents the name of the field in 853.5 file
 ;                ARRAY IENS represent entry and sub-entry ctrs
 ;                  e.g., if patient has 3 allergies with entry numbers of (10,20,30) then a given value "1,20"
 ;                  where "1" represents top level entry (patient level; ien and .01) and "20" represents the allergy entry level (.01 not the SUB IEN)
 ;                DATA is the actual data that is populated at an entry in 853.5 
 ; 
 ; OUTPUT
 ;   RESULT  : local array that returns the results of each updated field per array data element.
 ; 
 ;   SUCCESS : localArray(n) = FIELD NAME^ARRAY IENS^DATA^1
 ;             1 equals successful update to the database of the specific field declared at field label. 
 ; 
 ;   FAILED  : localArray(n)="FIELD NAME^ARRAY IENS^DATA^99^exception message" 
 ;             99 means an exception and no update was made to the database for that specific field and exception message describes the error. 
 ;
 ; -- Validate parameters
 N VPSDFN
 S VPSINTFC=$G(VPSINTFC)
 S VPSNUM=$G(VPSNUM)
 S VPSTYP=$G(VPSTYP)
 S RESULT(0)=$$VALPARAM(VPSNUM,VPSTYP,VPSINTFC,.VPSMRAR,.VPSDFN)
 Q:RESULT(0)'=""
 ;
 ; -- Create MRAR PDO entry if it does not exist for this patient
 S RESULT(0)=$$CRPTMRAR(VPSDFN)
 Q:RESULT(0)'=""
 ;
 ; -- Lock File before adding/updating sub files records
 L +^VPS(853.5,VPSDFN):3 E  S RESULT(0)=$$RESULT^VPSMRAR0(VPSDFN,99,"VPS PDO MRAR cannot be locked. Update to patient data object cannot occur at this time.")
 Q:RESULT(0)'=""
 ;
 ; -- Create new transaction - sub entry at 853.51 
 N TRNDT
 S TRNDT=$$NOW^XLFDT() ; IA #10103 - supported use of XLFDT function 
 S RESULT(0)=$$CRTSUB51(VPSDFN,VPSINTFC,TRNDT)
 ;
 ; -- Update PDO sub files with VPSMRAR data
 I RESULT(0)="" D
 . K RESULT
 . D EXTRACT(VPSDFN,VPSINTFC,TRNDT,.VPSMRAR,.RESULT)
 ;
 L -^VPS(853.5,VPSDFN)
 Q
 ;
VALPARAM(VPSNUM,VPSTYP,INTERFC,VPSMRAR,VPSDFN) ;Validate RPC Input parameters
 ; INPUT
 ;   VPSNUM  : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  : Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   INTERFC : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;           : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   VPSMRAR : encounter, statistics, allergy and medication related data sent in a subscripted array by kiosk client
 ; OUTPUT
 ;   VPSDFN  : Patient DFN
 ; RETURN
 ;   No Error   : ""
 ;   With Error : FIELD^PARAMETER^VALUE^99^error
 ;
 S VPSDFN=$$VALIDATE^VPSRPC1(VPSTYP,VPSNUM)
 I VPSDFN<1 Q $$RESULT^VPSMRAR0("PATIENT^PARAMETER^",99,$P(VPSDFN,U,2))
 I '$F("^S^P^",U_INTERFC_U) Q $$RESULT^VPSMRAR0("INTERFACE MODULE^PARAMETER^"_INTERFC,99,"Interface Module must be 'S' for Staff or 'P' for Patient")
 I $D(VPSMRAR)<10 Q $$RESULT^VPSMRAR0("DATA^PARAMETER^",99,"MRAR FIELDS not sent")
 I '$D(^DPT(VPSDFN)) Q $$RESULT^VPSMRAR0("PATIENT^PARAMETER^"_VPSDFN,99,"PATIENT not in VistA database")
 Q ""
 ;
CRPTMRAR(VPSDFN) ;Create MRAR PDO entry if it does not exist for this patient
 ; INPUT
 ;   VPSDFN : Patient IEN
 ; 
 ; OUTPUT
 ;   No Error : ""
 ;   With Error : PATIENT^PATIENT IEN^PATIENT IEN^99^error
 N VPSPTIEN,RESULT
 S RESULT=""
 S VPSPTIEN=$$GETPTIEN(VPSDFN)
 I 'VPSPTIEN D
 . S RESULT=$$CRPATPDO(VPSDFN)
 . Q:RESULT'=""
 . S VPSPTIEN=$$GETPTIEN(VPSDFN)
 Q RESULT
 ; 
GETPTIEN(VPSDFN) ;Return VPS IEN for FILE 853.5 if exist, otherwise return 0
 ; INPUT
 ;   VPSDFN : Patient IEN
 ; 
 ; OUTPUT
 ;   VPS IEN for FILE 853.5
 ; 
 Q $O(^VPS(853.5,"B",VPSDFN,""))
 ;
CRPATPDO(VPSDFN) ;create PDO
 ; INPUT
 ;   VPSDFN : Patient IEN
 ; 
 ; OUTPUT
 ;   No Error : ""
 ;   With Error : PATIENT^PATIENT IEN^PATIENT IEN^99^error
 ; 
 N VPSFDA,VPSIEN,VPSERR
 S VPSIEN(1)=VPSDFN
 S VPSFDA(853.5,"+1,",.01)=VPSDFN
 D UPDATE^DIE("","VPSFDA","VPSIEN","VPSERR")
 ;
 N ERR S ERR=""
 N PATDATA S PATDATA="PATIENT^"_VPSDFN_"^"_VPSDFN
 I $D(VPSERR) S ERR=$$ERROR^VPSMRAR0(.VPSERR,PATDATA,"VPS PDO MRAR could not be created.")
 Q ERR
 ;
CRTSUB51(VPSPTIEN,INTERFC,TRNDT) ;create stub entry at 853.51
 ; INPUT
 ;   VPSPTIEN : VPS IEN for FILE 853.5
 ;   INTERFC  : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;            : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   TRNDT    : Transaction Date
 ; 
 ; OUTPUT
 ;   No Error   : ""
 ;   With Error : PATIENT^PATIENT IEN^PATIENT IEN^99^error
 ; 
 N VPSERR,VPSFDA
 S VPSFDA(853.51,"+1,"_VPSPTIEN_",",.01)=TRNDT
 S VPSFDA(853.51,"+1,"_VPSPTIEN_",",.13)=INTERFC
 D UPDATE^DIE("E","VPSFDA","","VPSERR")
 ;
 N PATDATA S PATDATA="PATIENT^"_VPSPTIEN_"^"_VPSPTIEN
 I $D(VPSERR) Q $$ERROR^VPSMRAR0(.VPSERR,PATDATA,"Update to patient data object cannot occur at this time.")
 Q ""
 ;
EXTRACT(VPSPTIEN,INTERFC,TRNDT,VARRAY,RES) ; process each subscript in the MRAR array and file data at MRAR sub-entries at 853.5 patient entry
 ; INPUT
 ;   VPSPTIEN : VPS IEN for FILE 853.5
 ;   INTERFC  : value of 'S' indicates that the entries in VPSMRAR coming from Staff-facing interface module.
 ;            : value of 'P' indicates that the entries in VPSMRAR coming from Patient-facing interface module.
 ;   TRNDT    : Transaction Date
 ;   VARRAY   : encounter, statistics, allergy and medication related data sent in a subscripted array by kiosk client
 ;              VARRAY(n) = FIELD NAME^ARRAY IENS^FIELD VALUE
 ; 
 ; OUTPUT
 ;   RES      : output result array.
 ;              Success : RES(n) = Field Name^IENS^Field Value^1
 ;              failed  : RES(n) = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;                        IENS is composite string assigned to a subscript in the local array passed in by Vecna for the specific field
 K RES
 N DDFLD,SUB
 ;
 ; DDARRY = array of DD definitions defined at 853.51, 853.52, 853.53, 853.57 used for 
 ;          validating and filing the data sent by kiosk client
 ;          each subscript at this array is constructed as: 
 ;          DDARRY(n) = FILE NUMBER^FIELD NUMBER^FIELD NAME
 ; 
 ;Build MRAR definition table
 N DDARRY D TABLE^VPSMRAR0(.DDARRY)
 ;
 ;Build REQFLDS array. Each sub file must have the required field in the array otherwise generates error
 N REQFLDS D GREQFLD^VPSMRAR0(.VARRAY,.DDARRY,.REQFLDS)
 N SUBS
 S SUBS(853.525)="ACHG",SUBS(853.526)="ACNFR",SUBS(853.527)="ADISCR"
 S SUBS(853.5454)="MCHG",SUBS(853.5455)="MCNFR",SUBS(853.5452)="MDISCR"
 ;
 ;Update PDO Sub Files
 S SUB=""
 N RESULT,STOPFLG
 S STOPFLG=0
 F  S SUB=$O(VARRAY(SUB)) Q:SUB=""!(STOPFLG)  D
 . S RESULT=""
 . S RESULT=$$CHKTRN(.REQFLDS,VARRAY(SUB))
 . I RESULT'="" S RES(0)=RESULT,STOPFLG=1 Q
 . S DDFLD=$P(VARRAY(SUB),U) ; name of field label passed in by Vecna
 . I DDFLD="" S RES(SUB)=$$RESULT^VPSMRAR0(VARRAY(SUB),99,"Invalid Field Name") Q
 . I '$D(DDARRY(DDFLD)) S RES(SUB)=$$RESULT^VPSMRAR0(VARRAY(SUB),99,DDFLD_" does not exist in VPS MRAR PDO file or this field should not be processed during this event. Data not written to PDO") Q  ; Does Vecna need this type exception? Confirm
 . N FIL S FIL=$P(DDARRY(DDFLD),U) ; file #
 . N FLD S FLD=$P(DDARRY(DDFLD),U,2) ; field #
 . N DIEFLAG S DIEFLAG=$P(DDARRY(DDFLD),U,3) ; filing type
 . N VALID
 . S VALID=1
 . I DIEFLAG="I" D
 .. N OUT,FILE
 .. S FILE=$P(DDARRY(DDFLD),U,4)
 .. Q:+FILE=0
 .. ;D FIND^DIC(FILE,"","@","A",$P(VARRAY(SUB),U,3),"","","","","OUT")
 .. ;S VALID=+$G(OUT("DILIST",0))
 .. S VALID=$$FIND1^DIC(FILE,"","A","`"_$P(VARRAY(SUB),U,3),"","","")
 .. I VALID=0,$P($P(VARRAY(SUB),U,2),",",3)="" S RES(SUB)=$$RESULT^VPSMRAR0(VARRAY(SUB),99,"Invalid IEN value")
 .. I VALID=0,$P($P(VARRAY(SUB),U,2),",",3)]"" S RES(SUB)=$$RESULT^VPSMRAR0(VARRAY(SUB),99,"Value does not match third index")
 . Q:VALID=0
 . I DIEFLAG="D" D
 .. N Y,OK
 .. S Y=$P(VARRAY(SUB),U,3)
 .. S H=$$FMTH^XLFDT(Y)
 .. S FM=$$HTFM^XLFDT(H)
 .. S OK=($$FR^XLFDT(Y)=0)&(H=FM)
 .. S DIEFLAG=$S(OK:"",1:"E")
 . I ",E,"'[(","_DIEFLAG_",") S DIEFLAG=""
 . I FIL=853.51 S RES(SUB)=$$SUB51(VPSPTIEN,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; transaction subfile
 . I FIL=853.5121 S RES(SUB)=$$SUB5121(VPSPTIEN,TRNDT,VARRAY(SUB),DIEFLAG) ; 'MRAR Conducted with' subfile
 . I FIL=853.52 S RES(SUB)=$$SUB52^VPSMRAR2(VPSPTIEN,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; allergies subfile
 . I FIL=853.525!(FIL=853.526)!(FIL=853.527) S RES(SUB)=$$SUB52X^VPSMRAR2(FIL,SUBS(FIL),VPSPTIEN,TRNDT,VARRAY(SUB),.REQFLDS,DIEFLAG) ; allergies changed/confirmed/discrepancy subfile
 . I FIL=853.57 S RES(SUB)=$$SUB57^VPSMRAR7(VPSPTIEN,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; allergy reactions subfile
 . I FIL=853.54 S RES(SUB)=$$SUB54^VPSMRAR4(VPSPTIEN,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; medications subfile
 . I FIL=853.5454!(FIL=853.5455)!(FIL=853.5452) S RES(SUB)=$$SUB54X^VPSMRAR4(FIL,SUBS(FIL),VPSPTIEN,TRNDT,VARRAY(SUB),.REQFLDS,DIEFLAG) ; MED changed/confirmed/discrepancy subfile
 . I FIL=853.53 S RES(SUB)=$$SUB53^VPSMRAR3(VPSPTIEN,INTERFC,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; additional allergies subfile
 . I FIL=853.55 S RES(SUB)=$$SUB55^VPSMRAR5(VPSPTIEN,INTERFC,TRNDT,FLD,DIEFLAG,VARRAY(SUB),.REQFLDS) ; additional medications subfile
 Q
 ;
SUB51(PTIEN,DTIEN,FLD,DIEFLAG,DATA,REQFLDS) ; file the MRAR transaction (853.51)
 ; INPUTS
 ;   PTIEN   : D0 for 853.5 entry (Patient DFN Level)
 ;   DTIEN   : D1 for 853.51 sub-entry (transaction date/time level)
 ;   FLD     : Field # where the data will be filed
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ;   DATA    : Field Name^IENS^Field Value
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ;
 ; -- Check required transaction 853.51 fields
 ;S RESULT=$$CHKTRN(.REQFLDS,DATA)
 ;Q:RESULT'="" RESULT
 ;
 ; -- file the transaction level data
 N IENS S IENS=DTIEN_","_PTIEN_","
 I FLD=105,$$GET1^DIQ(8925,$P(DATA,U,3)_",",.02,"I")'=PTIEN S RESULT=$$RESULT^VPSMRAR0(DATA,99,"DFN does not match DFN associated with TIU note")
 Q:RESULT'="" RESULT
 S RESULT=$$FILE^VPSMRAR0(853.51,0,IENS,FLD,DIEFLAG,DATA)
 Q RESULT
 ;
SUB5121(PTIEN,DTIEN,DATA,DIEFLAG) ; file the 'MRAR conducted with' multiple (853.5121)
 ; INPUTS
 ;   PTIEN : D0 for 853.5 entry (Patient DFN Level)
 ;   DTIEN : D1 for 853.51 sub-entry (transaction date/time level)
 ;   DATA  : Field Name^IENS^Field Value
 ;   DIEFLAG : Filing Type (I = Internal, E = External)
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ;
 ; -- Get MRAR CONDUCTED WITH
 N CNDCTWTH S CNDCTWTH=$P($P(DATA,U,2),",",2) ;Conduct With
 I 'CNDCTWTH S RESULT=$$RESULT^VPSMRAR0(DATA,99,"MRAR Conduct With is required")
 Q:RESULT'="" RESULT
 ;
 ; -- Add MRAR CONDUCTED WITH sub entry if it doesn't exist
 N EXIST S EXIST=$D(^VPS(853.5,PTIEN,"MRAR",DTIEN,"MRARWITH","B",CNDCTWTH))
 I EXIST D
 . S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Duplicate MRAR CONDUCTED WITH entry")
 I 'EXIST D
 . N ADDOK S ADDOK=$$ADDMRAR^VPSMRAR0(853.5121,DTIEN_","_PTIEN,CNDCTWTH,DIEFLAG)
 . I 'ADDOK S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Data was not filed into MRAR PDO. Failed to add MRAR CONDUCTED WITH entry")
 ;
 Q:RESULT'="" RESULT
 Q $$RESULT^VPSMRAR0(DATA,1,"")
 ;
CHKTRN(REQFLDS,DATA) ;Check required transaction fields
 ; INPUTS 
 ;   REQFLDS : Array of required fields by fieldname and entry number
 ;   DATA    : Field Name^IENS^Field Value
 ; 
 ; OUTPUT
 ;   success : RESULT = Field Name^IENS^Field Value^1
 ;   failed  : RESULT = Field Name^IENS^Field Value^99^error text describing why data did not get filed
 ;
 N RESULT S RESULT=""
 ; -- Check required Kiosk Group or Encounter Clinic field
 I '$D(REQFLDS("KIOSK GROUP",0)),'$D(REQFLDS("ENCOUNTER CLINIC",0)) D
 . ;S RESULT=$$RESULT^VPSMRAR0(DATA,99,"Kiosk Group or Encounter Clinic is required for every MRAR transaction")
 . S RESULT=$$RESULT^VPSMRAR0("Required fields missing",99,"Kiosk Group or Encounter Clinic is required. Data not written to PDO.")
 Q RESULT

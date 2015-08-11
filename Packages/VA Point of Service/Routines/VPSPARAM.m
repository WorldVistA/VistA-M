VPSPARAM ;WOIFO/BT - Update VPS PARAMETER file ;11/14/12 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Nov 14, 2012;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 Q
 ;
WRITE(RESULT,PARAMTYP,PARAMNAM,PARAM) ; RPC: VPS WRITE KIOSK PARAMETERS
 ; Many facets of MRAR behavior are dictated by a set of business parameters defined and
 ; entered by the healthcare facility administrator.
 ; For statistical purposes, VetLink will call this RPC to store these configuration changes.
 ; There are two ways to store the configuration changes, by KioskGroup and by Clinic.
 ; 
 ; INPUT
 ;   RESULT   : the results of processing and passed in by reference (required by RPC Broker)
 ;   PARAMTYP : type of configuration changes, By KIOSK GROUP (K) or by Clinic (C).
 ;   PARAMNAM : KIOSK GROUP or CLINIC IEN depend on the PARMTYP.
 ;   PARAM    : array representing the configuration parameters changed made in Vetlinks passed in by reference 
 ;              PARAM(0..n) = FIELD NAME^FIELD VALUE
 ;              n is an incremental number; 
 ;              FIELD NAME represents the field that was changed in VetLink
 ;              FIELD VALUE is the actual data that was updated in VetLink and to be stored in File 853.
 ;             
 ; OUTPUT
 ;   RESULT  : array that returns the results of each updated field per array data element.
 ;             SUCCESS RESULT:
 ;             RESULT(n) = FIELD NAME^FIELD VALUE^1
 ;             '1' at the end of the result string indicates successful update to the database of the specific field declared at field label.
 ;         
 ;             FAILED RESULT :
 ;             RESULT(n)="FIELD NAME^FIELD VALUE^99^exception message"  
 ;             '99^exception message' at the end of the result string indicates an exception and no update was made to the database for that specific field and exception message describes the error.
 ;
 K RESULT
 S RESULT(0)=$$ISVALID($G(PARAMTYP),$G(PARAMNAM),.PARAM)
 Q:RESULT(0)'=""
 ;
 ; -- Lock File 853 before adding/updating
 N XREF S XREF=$S(PARAMTYP="C":"C",1:"D")
 L +^VPS(853,XREF,PARAMNAM):5 E  S RESULT(0)=$$RESULT(99,"VPS PARAMETER",PARAMTYP_","_PARAMNAM,"VPS PARAMETER cannot be locked for this Parameter Name. Update cannot occur at this time.") Q
 ;
 ; -- Create PARAM TOP Level if doesn't exist
 I '$D(^VPS(853,XREF,PARAMNAM)) S RESULT(0)=$$CRPARAM(PARAMTYP,PARAMNAM)
 ;
 ; -- Store parameters
 I RESULT(0)="" D UPDPARAM(PARAMTYP,PARAMNAM,.PARAM,.RESULT)
 ;
 L -^VPS(853,XREF,PARAMNAM)
 Q
 ;
UPDPARAM(PARAMTYP,PARAMNAM,PARAM,RESULT) ;Store input parameters 
 ; INPUT
 ;   PARAMTYP : type of configuration changes, By KIOSK GROUP (K) or by Clinic (C).
 ;   PARAMNAM : KIOSK GROUP or CLINIC IEN depend on the PARMTYP.
 ;   PARAM    : array representing the configuration parameters changed made in Vetlinks passed in by reference 
 ;              PARAM(0..n) = FIELD NAME^FIELD VALUE
 ;              n is an incremental number; 
 ;              FIELD NAME represents the field that was changed in VetLink
 ;              FIELD VALUE is the actual data that was updated in VetLink and to be stored in File 853.
 ;             
 ; INPUT/OUTPUT
 ;   RESULT  : array that returns the results of each updated field per array data element.
 ;             SUCCESS RESULT:
 ;             RESULT(n) = FIELD NAME^FIELD VALUE^1
 ;             '1' at the end of the result string indicates successful update to the database of the specific field declared at field label.
 ;         
 ;             FAILED RESULT :
 ;             RESULT(n)="FIELD NAME^FIELD VALUE^99^exception message"  
 ;             '99^exception message' at the end of the result string indicates an exception and no update was made to the database for that specific field and exception message describes the error.
 ;
 ; -- Get VPS PARAM IEN
 N PARAMIEN S PARAMIEN=$$GPARMIEN(PARAMTYP,PARAMNAM)
 I 'PARAMIEN S RESULT(0)=$$RESULT(99,"VPS PARAMETER",PARAMTYP_","_PARAMNAM,"Unable to retrieve record for this Parameter Name. Update cannot occur at this time.") Q
 ;
 ; -- Store parameters
 K RESULT
 N MULT,RSNTYP
 N TRNDT S TRNDT=$$NOW^XLFDT() ; IA #10103 - supported use of XLFDT function 
 N FLDDEF D TABLE(.FLDDEF) ;get array of valid fields defined to VPS PARAMETER (#853)
 N SUB S SUB=""
 ;
 F  S SUB=$O(PARAM(SUB)) Q:SUB=""  D
 . N FLDNAM S FLDNAM=$P(PARAM(SUB),U,1)
 . N FLDVAL S FLDVAL=$P(PARAM(SUB),U,2)
 . S:FLDNAM="" RESULT(SUB)=$$RESULT(99,FLDNAM,FLDVAL,"Missing Field. Data not written.")
 . Q:FLDNAM=""
 . S:'$D(FLDDEF(FLDNAM)) RESULT(SUB)=$$RESULT(99,FLDNAM,FLDVAL,FLDNAM_" does not exist in VPS CONFIG HISTORY file. Data not written.")
 . Q:'$D(FLDDEF(FLDNAM))
 . N FLDVAL S FLDVAL=$P(PARAM(SUB),U,2)
 . N ISMULT S ISMULT=($P(FLDDEF(FLDNAM),U,4)'="")
 . I 'ISMULT S RESULT(SUB)=$$STRFIL(TRNDT,PARAMIEN,FLDDEF(FLDNAM),FLDNAM,FLDVAL) ;file the data to 853.01 sub-entry
 . I ISMULT D  ; save multiple in a MULT array and store later, want to make sure .01 field is valid
 . . N FIL S FIL=$P(FLDDEF(FLDNAM),U,1)
 . . N FLD S FLD=$P(FLDDEF(FLDNAM),U,2)
 . . N RSNTYP S RSNTYP=$P(FLDVAL,",")
 . . N VALID S VALID=RSNTYP>0&(RSNTYP<6)
 . . S:VALID MULT(FIL,FLDNAM,RSNTYP)=SUB_U_FLDVAL
 . . S:'VALID RESULT(SUB)=$$RESULT(99,FLDNAM,FLDVAL,"Invalid Incomplete Reason Type")
 ;
 ; - Store multiple fields
 I $D(MULT) D STRMULT(.RESULT,PARAMIEN,TRNDT,.FLDDEF,.MULT)
 Q
 ;
STRMULT(RESULT,PARAMIEN,TRNDT,FLDDEF,MULT) ; Store multiple fields
 ; INPUT/OUTPUT
 ;   RESULT   : array that returns the results of each updated field per array data element.
 ; INPUT
 ;   TRNDT    : Transaction Date/Time - this field is also used as SUB IEN for this Transaction Level
 ;   PARAMIEN : PARAMETER IEN for file 853
 ;   FLDDEF   : array of field name definition
 ;   MULT     : array of multiple field entries
 ;   RSNTYP   : array of Incomplete Reason Types
 ;
 N FIL S FIL=""
 F  S FIL=$O(MULT(FIL)) Q:FIL=""  D
 . N FLDNAM S FLDNAM=""
 . F  S FLDNAM=$O(MULT(FIL,FLDNAM)) Q:FLDNAM=""  D
 . . N RSNTYP S RSNTYP=""
 . . F  S RSNTYP=$O(MULT(FIL,FLDNAM,RSNTYP)) Q:RSNTYP=""  D
 . . . N REC S REC=MULT(FIL,FLDNAM,RSNTYP)
 . . . N SUB S SUB=$P(REC,U)
 . . . N FLDVAL S FLDVAL=$P(REC,U,2)
 . . . S RESULT(SUB)=$$STRFIL(TRNDT,PARAMIEN,FLDDEF(FLDNAM),FLDNAM,FLDVAL) ;file the data to 853.01 sub-entry
 Q
 ; 
ISVALID(PARAMTYP,PARAMNAM,PARAM) ;validate RPC input parameters
 ; INPUT
 ;   PARAMTYP : type of configuration changes, (eg, By KIOSK GROUP (K) or by Clinic (C)).
 ;   PARAMNAM : Value of Parameter, (eg, KIOSK GROUP or CLINIC IEN depend on the PARMTYP.)
 ;   PARAM    : local array representing the configuration parameters changed made in Vetlinks passed in by reference 
 ; OUTPUT
 ;   SUCCESS  : Empty String
 ;   FAILED   : FIELD NAME^FIELD VALUE^99^exception
 ;
 N PARAMVAL S PARAMVAL=PARAMTYP_","_PARAMNAM
 S PARAMTYP=$$STRIP^XLFSTR(PARAMTYP," ") ;Parameter Type can't be empty - IA #10104
 I PARAMTYP="" Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"Invalid Parameter Type")
 I '$F(",K,C,",","_PARAMTYP_",") Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"Parameter Type must be 'K' for KIOSK GROUP or 'C' for CLINIC")
 ;
 S PARAMNAM=$$STRIP^XLFSTR(PARAMNAM," ") ;Parameter name can't be empty - IA #10104
 I PARAMNAM="" Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"Invalid Parameter Name")
 I PARAMNAM'?1.ANP Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"Parameter name can't have Non-printable characters")
 I PARAMTYP="C",PARAMNAM'?1.N Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"CLINIC IEN must be a numeric value")
 ;
 I $D(PARAM)<10 Q $$RESULT(99,"VPS PARAMETER",PARAMVAL,"No Configuration Parameters")
 Q ""
 ;
CRPARAM(PARAMTYP,PARAMNAM) ; Create PARAM entry in root level of file #853
 ; INPUT
 ;   PARAMTYP : type of configuration changes, (eg, By KIOSK GROUP (K) or by Clinic (C)).
 ;   PARAMNAM : Value of Parameter, (eg, KIOSK GROUP or CLINIC IEN depend on the PARMTYP.)
 ; OUTPUT
 ;   SUCCESS : Empty String
 ;   FAILED  : FIELD NAME^FIELD VALUE^99^exception
 ;
 N IENS,UPDERR,FDA
 N FLD S FLD=$S(PARAMTYP="C":.02,1:.03)
 S FDA(853,"+1,",.01)=PARAMTYP
 S FDA(853,"+1,",FLD)=PARAMNAM
 D UPDATE^DIE("","FDA",,"UPDERR")
 ;
 N ERR S ERR=""
 I $D(UPDERR) S ERR=$$ERROR(.UPDERR,"VPS PARAMETER",PARAMTYP_","_PARAMNAM)
 I $P(ERR,U,3)=1 S ERR=""
 Q ERR
 ;
GPARMIEN(PARAMTYP,PARAMNAM) ; Get PARAM IEN for FILE 853
 ; INPUT
 ;   PARAMTYP : type of configuration changes, (eg, By KIOSK GROUP (K) or by Clinic (C)).
 ;   PARAMNAM : Value of Parameter name, (eg, KIOSK GROUP or CLINIC name depend on the PARMTYP.)
 ; OUTPUT
 ;   SUCCESS : PARAMETER IEN for FILE 843
 ;   FAILED  : Empty string
 ;
 N PARAMIEN S PARAMIEN=0
 I PARAMTYP="C" S PARAMIEN=$O(^VPS(853,"C",PARAMNAM,""))
 I PARAMTYP="K" S PARAMIEN=$O(^VPS(853,"D",PARAMNAM,""))
 Q PARAMIEN
 ;
STRFIL(TRNDT,PARAMIEN,UPDFLD,FLDNAM,FLDVAL) ; Store the modified field value
 ; INPUT
 ;   TRNDT    : Transaction Date/Time - this field is also used as SUB IEN for this Transaction Level
 ;   PARAMIEN : PARAMETER IEN for file 853
 ;   UPDFLD   : field info (File Number^Field Number^input type)
 ;   FLDNAM   : field name to update
 ;   FLDVAL   : field value to update
 ; OUTPUT
 ;   SUCCESS  : FIELD NAME^FIELD VALUE^1
 ;   FAILED   : FIELD NAME^FIELD VALUE^99^exception message
 ; 
 ; create entry in Transaction Date/Time level
 N EXIST S EXIST=$D(^VPS(853,PARAMIEN,"PARAM",TRNDT))
 I 'EXIST S ERR=$$ADDTRXN(TRNDT,PARAMIEN)
 Q:ERR'="" ERR
 ; 
 ; update the parameter value on the Transaction Date/Time level
 N RESULT S RESULT=$$UPDTRXN(PARAMIEN,TRNDT,UPDFLD,FLDNAM,FLDVAL)
 Q RESULT
 ;
ADDTRXN(TRNDT,PARAMIEN) ; create an entry in Transaction Date/Time level
 ; INPUT
 ;   TRNDT    : Transaction Date/Time - this field is also used as SUB IEN for this Transaction Level
 ;   PARAMIEN : PARAMETER IEN for file 853
 ; RETURN
 ;   SUCCESS  : empty string
 ;   FAILED   : FIELD NAME^FIELD VALUE^99^exception message
 N IENS S IENS(1)=TRNDT
 N FDA,UPDERR
 S FDA(853.01,"+1,"_PARAMIEN_",",.01)=TRNDT
 D UPDATE^DIE("","FDA","IENS","UPDERR")
 ;
 N ERR S ERR=""
 I $D(UPDERR) S ERR=$$ERROR(.UPDERR,"TRXN DATE/TIME",TRNDT)
 Q ERR
 ;
UPDTRXN(PARAMIEN,TRNDT,UPDFLD,FLDNAM,FLDVAL) ; update fields in transaction level
 ; INPUT
 ;   PARAMIEN : PARAMETER IEN for file 853
 ;   TRNDT    : Transaction Date/Time - this field is also used as SUB IEN for this Transaction Level
 ;   UPDFLD   : field info (File Number^Field Number^input type^Admin level Field Number^Admin level Field name)
 ;   FLDNAM   : field name to update
 ;   FLDVAL   : field value to update
 ; OUTPUT
 ;   SUCCESS  : FIELD NAME^FIELD VALUE^1
 ;   FAILED   : FIELD NAME^FIELD VALUE^99^exception message
 ;   
 N FIL S FIL=$P(UPDFLD,U,1) ;File Number to update
 N FLD S FLD=$P(UPDFLD,U,2) ;Field Number to update
 N TYP S TYP=$P(UPDFLD,U,3) ;input type (I(nternal) or E(xternal)
 N RSNSUB S RSNSUB=$P(UPDFLD,U,4) ;Reason Subscript (ARREASON, MRREASON, AMRREASON)
 N RSNTYP S RSNTYP=$P(FLDVAL,",")
 S:TYP="" TYP="E"
 N MULT S MULT=(RSNSUB'="")
 N SUBS S SUBS=TRNDT_","_PARAMIEN
 ;
 ; -- Store fields for file 853.01 and multiple 853.011, 853.012, 853.013
 N ERR
 S:MULT SUBS=$$ADDMULT(FIL,PARAMIEN,TRNDT,RSNSUB,RSNTYP,.ERR)
 Q:$D(ERR) $$ERROR(.ERR,FLDNAM,FLDVAL)
 ;
 N FDA S FDA(FIL,SUBS_",",FLD)=$S(MULT:$P(FLDVAL,",",2),1:FLDVAL)
 D FILE^DIE(TYP,"FDA","ERR")
 Q:$D(ERR) $$ERROR(.ERR,FLDNAM,FLDVAL)
 Q $$RESULT(1,FLDNAM,FLDVAL,"") ; data for specific field was filed successfully
 ;
ADDMULT(FIL,PARAMIEN,TRNDT,RSNSUB,RSNTYP,ERR) ; Add field .01 for Multiple fields if doesn't exist
 ; INPUT
 ;   FIL      : File number (853.011, 853.012, 853.013)
 ;   PARAMIEN : PARAMETER IEN for file 853
 ;   TRNDT    : Transaction Date/Time - this field is also used as SUB IEN for this Transaction Level
 ;   RSNSUB   : This is the literal subscript for the sub file (eq: ARREASON, MRREASON, AMRREASON)
 ;   RSNTYP   : field value of Incomplete Reason Type 
 ; OUTPUT
 ;   ERR      : FileMan Error array
 ; RETURN
 ;   Multiple SUBS IEN
 ; 
 K ERR
 N EXIST S EXIST=$D(^VPS(853,PARAMIEN,"PARAM",TRNDT,RSNSUB,RSNTYP,0))
 I 'EXIST D
 . N IENS S IENS(1)=RSNTYP
 . N FDA S FDA(FIL,"+1,"_TRNDT_","_PARAMIEN_",",.01)=RSNTYP
 . D UPDATE^DIE("","FDA","IENS","ERR")
 Q RSNTYP_","_TRNDT_","_PARAMIEN
 ;
ERROR(FDAERR,FLDNAME,FLDVAL) ; Return error string that VetLink can recognize
 ; INPUT
 ;   FDAERR : error array that was created when attempting to file the changes
 ;   FLDNAME: the field that has invalid value
 ;   FLDVAL : the invalid value
 ; RETURN
 ;   Field Name^Field Value^99^error
 ;
 N RESULT
 N ERRNUM S ERRNUM=0
 S ERRNUM=$O(FDAERR("DIERR",ERRNUM))
 N ERRTXT S ERRTXT=FDAERR("DIERR",ERRNUM,"TEXT",1)
 N EXIST S EXIST=ERRTXT["already exists"
 S:EXIST RESULT=$$RESULT(1,FLDNAME,FLDVAL,"") ; not an exception as far as Vecna is concerned.
 S:'EXIST RESULT=$$RESULT(99,FLDNAME,FLDVAL,ERRTXT)
 Q RESULT
 ; 
RESULT(STATCODE,FLDNAME,FLDVAL,ERRMSG) ;return result in the structure that VetLink expects
 ; INPUT
 ;   STATCODE : status code (1 = successfull, 99 = error)
 ;   FLDNAME  : field name
 ;   FLDVAL   : field value
 ;   ERRMSG   : (OPTIONAL) error message to send back to RPC caller
 ; RETURN
 ;   FLDNAME^FLDVAL^STATCODE^ERMSG
 ;
 S:ERRMSG'="" ERRMSG=U_ERRMSG
 Q FLDNAME_U_FLDVAL_U_STATCODE_ERRMSG
 ;
TABLE(FLDDEF) ;build array of valid fields defined to VPS PARAMETER (#853)
 ; INPUT/OUTPUT
 ;   FLDDEF : array by field names
 ;            FLDDEF(field name)=file number^field number^input type^root field number
 ;            type : I(nternal) or E(xternal)
 ;            root field number : optional field. this field contains the current field value of the field being updated
 ;            ex: FLDDEF("PDO INVOCABLE PDO")="853.01^1^I^.02"
 K FLDDEF
 N LN,LINE,STRING
 F LN=2:1 S LINE=$T(PARMFLDS+LN),STRING=$P(LINE,";;",2) Q:STRING=""  D
 . S FLDDEF($P(STRING,U,3))=$P(STRING,U,1,2)_U_$P(STRING,U,4,6)
 Q
 ;
PARMFLDS ; list of Configuration Parameter Statistics fields defined in VPS PARAMETER file (#853)
 ;;FILE NUMBER^FIELD NUMBER^FIELD NAME^INPUT TYPE^
 ;;853.01^1^PDO INVOCABLE PERIOD^E^^
 ;;853.01^2^AR ENABLED/DISABLED DT^E^^
 ;;853.01^3^MR ENABLED/DISABLED DT^E^^
 ;;853.01^4^AUDIT ENABLED DT^E^^
 ;;853.01^5^AR FREE TEXT ENABLED^E^^
 ;;853.01^6^MR FREE TEXT ENABLED^E^^
 ;;853.01^7^TIME LIMIT TOO LATE ARRIVAL^E^^
 ;;853.01^8^TIME LIMIT TOO EARLY ARRIVAL^E^^
 ;;853.01^9^TIME LIMIT NOT EARLY ENOUGH^E^^
 ;;853.01^10^DESIRED AMR SESSION COMPLETED^E^^
 ;;853.01^11^DESIRED AMR TIME COMPLETED^E^^
 ;;853.01^12^DESIRED AR SESSION COMPLETED^E^^
 ;;853.01^13^DESIRED AR TIME COMPLETED^E^^
 ;;853.01^14^DESIRED MR SESSION COMPLETED^E^^
 ;;853.01^15^DESIRED MR TIME COMPLETED^E^^
 ;;853.01^16^TIME LIMIT AR COMPLETE^E^^
 ;;853.01^17^TIME LIMIT MR COMPLETE^E^^
 ;;853.01^18^TIME LIMIT AMR COMPLETE^E^^
 ;;853.01^19^LOW USE THRESHOLD PDO^E^^
 ;;853.01^20^AMR ENABLED/DISABLED DT^E^^
 ;;853.01^21^AR ENABLED^E^^
 ;;853.01^22^ALLERGY DISCREP UCL NO AR^E^^
 ;;853.01^23^ALLERGY DISCREP UCL POST AR^E^^
 ;;853.01^24^MED DISCREP UCL NO MR^E^^
 ;;853.01^25^MED DISCREP UCL POST MR^E^^
 ;;853.01^26^MR ENABLED^E^^
 ;;853.01^27^AMR ENABLED^E^^
 ;;853.011^1^LOW USE THRESHOLD AMR^E^AMRREASON^
 ;;853.012^1^LOW USE THRESHOLD AR^E^ARREASON^
 ;;853.013^1^LOW USE THRESHOLD MR^E^MRREASON^
 ;;

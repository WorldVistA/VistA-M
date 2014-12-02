VPSRPC2  ;DALOI/KML - Update of Patient Demographics RPC;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**2**;Oct 21, 2011;Build 41
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; ICR# 5799 - Edit existing entry in PATIENT file (#2).
 Q
EDIT(RESULT,VPSDFN,VPSLST) ;
 ; RPC=VPS EDIT PATIENT DEMOGRAPHICS
 ; Vetlink Kiosk allows edit of patient data (PATIENT File (#2)) 
 ; Kiosk identifies the field to be updated along with the respective data changes and serves to RPC
 ; INPUT - RESULT represents the results of processing and passed in by reference  
 ;         VPSDFN=(patient) DFN
 ;         VPSLST=contains the  imported and pre-validated data from Vecna that is intended to update the patient record in file 2 
 ; OUTPUT - RESULT=local array that returns the results of each updated field per array data element.
 ;
 ; structure of VPSLST input parameter: 
 ;       VPSLST(n)=field name^data  
 ;        where n is an incremental number and field label^data  are literal values
 ;        e.g., array(1)="MARITAL STATUS^SINGLE"
 ;  output structure:
 ;       RESULT(n)="field label^data^1"
 ;         where n equals to the incremental number belonging to the incoming array element  
 ;         where 1 equals successful update to the database of the specific field declared at field label.  
 ;      RESULT(n)="field label^data^99^exception message"  
 ;         where 99 means an exception and no update was made to the database for that specific field and exception message describes the error.  
 N RN,DDFLDS,DDFIELD,FIELD,FILE,X1,REQFLDS
 N VPSERR,VPSFDA
 I '+$G(VPSDFN) S RESULT(0)="99^PATIENT DFN not sent" Q
 I '$D(^DPT(VPSDFN)) S RESULT(0)="99^PATIENT not in VistA database" Q
 I '$D(VPSLST) S RESULT(0)="99^FIELD CHANGES WERE NOT SENT" Q
 K RESULT
 S RN=0
 L +^DPT(VPSDFN):30 E  S RESULT(0)=VPSDFN_"^99^Patient record cannot be locked.  UPdate to patient record cannot occur at this time." Q
 D TABLE(.DDFLDS,.REQFLDS,.VPSLST)
 D DDVAL(.RN,.VPSLST,.DDFLDS,.RESULT)
 D ADDRVAL^VPSRPC21(VPSDFN,.RN,.REQFLDS,.VPSLST,.RESULT)
 D SPVAL(VPSDFN,.RN,.REQFLDS,.VPSLST,.RESULT)
 D ECONT(VPSDFN,.RN,.REQFLDS,.VPSLST,.RESULT)
 ; read thru input array sent in by Vecna that has undergone pre-validation in PREVAL and ADDRVAL procedures
 ; Some subscripts may have been removed due to the results of validation processing to support
 ; patient record integrity (invalid or incomplete data should not be filed into patient record)
 S X1=-1 F  S X1=$O(VPSLST(X1)) Q:X1=""  D
 . S RN=RN+1
 . I $P(VPSLST(X1),U,2)="" S RESULT(RN)=VPSLST(X1)_"99^data was not sent for this field.  Write to Patient record not performed for this field." Q  ; data not was not sent by Vecna; no update to occur for this field
 . S DDFIELD=$P(VPSLST(X1),U)  ; name of field label passed in by Vecna 
 . S FILE=$P(DDFLDS(DDFIELD),U),FIELD=$P(DDFLDS(DDFIELD),U,2)  ; file and field number
 . I FILE>2 S RESULT(RN)=$$FILERACE(VPSDFN,FILE,FIELD,VPSLST(X1),.RN) Q  ;RACE and ETHNICITY multiples need special handling at write to patient record
 . S RESULT(RN)=$$FILE(VPSDFN,FILE,FIELD,VPSLST(X1),.RN)
 L -^DPT(VPSDFN)
 Q
 ;
FILE(PTIEN,FIL,FLD,DATA,N) ; write to patient record
 ; PTIEN=DFN
 ; FIL=FILE NUMBER (e.g., 2.02 or 2.06)
 ; FLD=FIELD NUMBER
 ; DATA=Data that gets populated at that field (sent from client)
 ; N=sequential number associated with the array element sent in by Vecna
 N VALUE,RIEN,PIEN,VPSFDA
 K RES
 S VPSFDA(FIL,PTIEN_",",FLD)=$P(DATA,U,2)  ; build the FDA array needed when filing the changes via Fileman; assign with the value brought in by Vecna
 D FILE^DIE("E","VPSFDA","VPSERR") K VPSFDA
 I '$D(VPSERR) S RES(N)=DATA_"^1"   ; data for specific field was filed successfully into patient record
 E  S RES(N)=$$ERROR(.VPSERR,N,DATA)
 Q RES(N)
 ;
FILERACE(PTIEN,FIL,FLD,DATA,N) ; write to patient record at the RACE or ETHNICITY multiple
 ; PTIEN=DFN
 ; FIL=FILE NUMBER (e.g., 2.02 or 2.06)
 ; FLD=FIELD NUMBER
 ; DATA=Data that gets populated at that field (sent from client)
 ; N=sequential number associated with the array element sent in by Vecna
 N VALUE,RIEN,PIEN,VPSFDA
 K RES
 I $E($P(DATA,U,2),1)="@" D  Q RES(N)  ; delete existing entries
 . S (RIEN,PIEN)=0
 . S VALUE=$E($P(DATA,U,2),2,99)
 . I VALUE']"" S RES(N)=DATA_"^99^no value provided for the Race or Ethnicity delete action.  Data deletion did not occur." Q
 . F  S RIEN=$O(^DPT(PTIEN,"."_$P(FIL,".",2),"B",RIEN)) Q:'RIEN  F  S PIEN=$O(^DPT(PTIEN,"."_$P(FIL,".",2),"B",RIEN,PIEN)) Q:'PIEN  D
 . . I $$GET1^DIQ(FIL,PIEN_","_PTIEN_",",.01,"E")=VALUE S VPSFDA(FIL,PIEN_","_PTIEN_",",FLD)="@"
 . I '$D(VPSFDA) S RES(N)=DATA_"^99^Race value does not exist for patient.  Delete did not occur."
 . D FILE^DIE("E","VPSFDA","VPSERR") K VPSFDA
 . I '$D(VPSERR) S RES(N)=DATA_"^1"
 . E  S RES(N)=$$ERROR(.VPSERR,N,DATA)
 ; if not deleting existing entries, then assumption is to add
 S VPSFDA(FIL,"+1,"_PTIEN_",",FLD)=$P(DATA,U,2)
 D UPDATE^DIE("E","VPSFDA","","VPSERR") K VPSFDA
 I '$D(VPSERR) S RES(N)=DATA_"^1"
 E  S RES(N)=$$ERROR(.VPSERR,N,DATA)
 Q RES(N)
 ;
ERROR(VERR,N,STRING) ; 
 ; VERR=error array that was created when attempting to file the changes
 ; N=seq number associated with the array element sent in by Vecna
 ; STRING=the string of data that could not be updated in patient record sent by Vecna
 ; RETURNS results string
 N ERRNUM,ERRTXT
 K ERRSTR
 S ERRNUM=0
 S ERRNUM=$O(VERR("DIERR",ERRNUM)),ERRTXT=VERR("DIERR",ERRNUM,"TEXT",1)
 I ERRTXT["already exists" S ERRSTR(N)=STRING_"^1"  ; not an exception as far as Vecna is concerned.
 E  S ERRSTR(N)=STRING_"^99^"_ERRTXT
 K VERR
 Q ERRSTR(N)
 ;
DDVAL(REC,ILST,DDEFS,VRES) ; Validate that incoming field labels sent by Vecna exist in patient file data definition
 ; INPUT - all input parameters passed in by reference
 ; REC = incremental number assigned to each subscript built in the OUTPUT array
 ; ILST = validate the data passed in by Vecna
 ; DDEFS = Data definitions as defined in PATIENT file (#2) to be used during validation 
 ; OUTPUT -
 ; VRES = the array to return the results of pre-validation processing. Exceptions (only) made available as RPC output for client
 N DDFLD,X2
 S X2=0 F  S X2=$O(ILST(X2)) Q:'X2  D
 . S DDFLD=$P(ILST(X2),U)
 . I '$D(DDEFS(DDFLD)) S REC=REC+1,VRES(REC)=ILST(X2)_"^99^"_DDFLD_" does not exist in VistA PATIENT file. Write to Patient record cannot be performed" K ILST(X2)
 Q
 ;
SPVAL(PTIEN,REC,REQLST,ILST,VRES) ; pre-validate on conditions related to spouse's information
 ; If marital status is NOT MARRIED, UNKNOWN, or WIDOWED then SPOUSE'S data elements should not be submitted for update. Exception message needs to 
 ; be returned.
 ;INPUT - all input parameters except PTIEN passed in by reference
 ; PTIEN = DFN
 ; REC = incremental number assigned to each subscript built in the OUTPUT array
 ; REQLST = array to be used when validating the spouse's info data
 ; ILST = data passed in by Vecna (VPSLST array)
 ; OUTPUT -
 ; RES = the array to return the VRESults of ADDVRESS validation processing.  Exceptions (only) made available as RPC output for client
 ; 
 ; marital status needs to be checked in 2 places.  First check the input array and then if needed check the patient record.
 ; Input array check -   vet can update marital status at kiosk so check needs to occur in the input array for a value in the MARITAL STATUS element for a 
 ; value of DIVORCED, MARRIED, or SEPARATED.  If that value in the input array does equal any of those 3 values then quit this validation procedure
 ;  since any spousal information update would be rationale.
 ; Patient record check  -   If the value in the MARITAL STATUS input array is null then an alternative check for NEVER MARRIED,
 ; UNKNOWN, or WIDOWNED would need to be performed to the patient record.  If the patient record does not contain any one of those 3 values then 
 ; quit this validation procedure since any spousal information update would be rationale.
 ; When NEVER MARRIED, UNKNOW, or WIDOWED marital status exist for a patient then this procedure needs to ensure that the SPOUSE'S EMPLOYER NAME,
 ; SPOUSE'S EMP PHONE NUMBER, SPOUSE'S EMPLOYMENT STATUS and SPOUSE'S RETIREMENT DATE has not been submitted to the patient record.
 ;
 N QUIT,MARITAL,X2,NUM
 S MARITAL=$P(REQLST(.05),U,3)
 S QUIT=$S(MARITAL="MARRIED":1,MARITAL="SEPARATED":1,1:0)  ; leave the procedure if any one of these values are submitted
 Q:QUIT
 S MARITAL=$S(MARITAL="":$$GET1^DIQ(2,PTIEN_",",.05),1:MARITAL)  ; need to get marital status from patient record if MARITAL is null
 S QUIT=$S(MARITAL="NEVER MARRIED":0,MARITAL="UNKNOWN":0,MARITAL="WIDOWED":0,MARITAL="DIVORCED":0,1:1)
 Q:QUIT
 F NUM=.251,.258,.2515,.2516 I $P(REQLST(NUM),U,3)]"" D
 . S X2=$P(REQLST(NUM),U),REC=REC+1,VRES(REC)=ILST(X2)_"^99^"_$P(REQLST(NUM),U,2)_" should not be sent when patient MARITAL STATUS is "_MARITAL
 . K ILST(X2)  ; remove from input array so they are not processed for filing into patient record
 Q
 ;
ECONT(PTIEN,REC,REQLST,ILST,VRES) ;  pre-validate emergency contact and next of kin fields
 ;'NEXT OF KIN' name must EXIST in order to update the NOK-2 set of fields
 ;'EMERGENCY CONTACT' name must EXIST in order to update the EMERGENCY CONTACT-2 set of fields
 ;INPUT - all input parameters except PTIEN passed in by reference
 ; PTIEN = DFN
 ; REC = incremental number assigned to each subscript built in the OUTPUT array
 ; REQLST = array to be used when validating the spouse's info data
 ; ILST = data passed in by Vecna (VPSLST array)
 ; OUTPUT -
 ; VRES = the array to return the results of ADDRESS validation processing.  Exceptions (only) made available as RPC output for client
 ; 
 ; Name check existence for NEXT OF KIN and EMERGENCY CONTACT needs to be checked first at the patient record and if needed  at the input array 
 ; Patient record check -   If name values do exist for both these fields, then quit the validation procedure since any update to the NOK-2 
 ;and EMERGENCY CONTACT 2 set of fields would be appropriate.  If these 2 fields are null in the patient record then existence of these 2 values needs 
 ; to be performed on the input array submitted by VPS kiosk.
 ; Input array check - patient can update NEXT OF KIN and EMERGENCY CONTACT information at the VPS kiosk, so first check is at the K-NAME OF PRIMARY NOK 
 ; and E-NAME data elements of the input array.  If a value exists for those 2 data elements then quit the validation procedure since any update to
 ; the NOK-2 and EMERGENCY CONTACT 2 set of fields would be appropriate.
 N NOK,ENAM,X2,NUM
NOK S NOK=$$GET1^DIQ(2,PTIEN_",",.211)
 I NOK="",$P(REQLST(.211),U,3)]"" D
 . S X2=$P(REQLST(.211),U),REC=REC+1,VRES(REC)=$$FILE(PTIEN,2,.211,ILST(X2),.REC) ; need to file the NOK name before filing of any submitted NOK 2 fields
 . K ILST(X2)  ; remove the already processed input array subscript
 . S NOK=$$GET1^DIQ(2,PTIEN_",",.211)   ;  retrieve the newly filed name. If any data filing exceptions occurred then any NOK-2 fields submitted cannot be filed
 I NOK="" D  ; next of kin name doesn't exist at the patient record or at the input array so any NOK-2 fields submitted need to be rejected
 . F NUM=.2191,.2192,.2193,.2194,.2195,.2196,.2197,.2203,.2199,.211011 I $P(REQLST(NUM),U,3)]"" D
 . . S X2=$P(REQLST(NUM),U),REC=REC+1,VRES(REC)=ILST(X2)_"^99^NEXT OF KIN name must exist before sending NOK-2 field "_$P(REQLST(NUM),U,2)
 . . K ILST(X2)
EMER S ENAM=$$GET1^DIQ(2,PTIEN_",",.331)
 I ENAM="",$P(REQLST(.331),U,3)]"" D
 . S X2=$P(REQLST(.331),U),REC=REC+1,VRES(REC)=$$FILE(PTIEN,2,.331,ILST(X2),.REC) ; need to file the EMERGENCY name before filing of any submitted E2 fields
 . K ILST(X2)  ; remove the already processed input array subscript
 . S ENAM=$$GET1^DIQ(2,PTIEN_",",.331)   ;  retrieve the newly filed name. If any data filing exceptions occurred then any E2 fields submitted cannot be filed
 I ENAM="" D  ; emergency name doesn't exist at the patient record or at the input array so any EMERGENCY 2 fields submitted need to be rejected
 . F NUM=.3311,.3312,.3313,.3314,.3315,.3316,.3317,.2204,.3319,.331011 I $P(REQLST(NUM),U,3)]"" D
 . . S X2=$P(REQLST(NUM),U),REC=REC+1,VRES(REC)=ILST(X2)_"^99^EMERGENCY CONTACT name must exist before sending E2 field "_$P(REQLST(NUM),U,2)
 . . K ILST(X2)
 Q
 ;
TABLE(ARRAY1,ARRAY2,VLST) ;build array of valid fields defined to PATIENT file (#2)
 ;input/output - 
 ; all input parameters passed in by reference
 ; ARRAY1, ARRAY2 will be built in this subroutine; and returned as output
 ; ARRAY1 = Data definitions as defined in PATIENT file (#2) to be used for pre-validation and filing procedures 
 ;  structure example:  DDFLDS("CITY")="2^.114"
 ;                      DDFLDS("COUNTRY")="2^.1173"
 ; ARRAY2 = array to be used during pre-validation of required address sets.
 ;        Structure example of a subscript having data:       ARRAY2(".111")="3^STREET ADDRESS [LINE 1]^123 MARIGOLD
 ;        Structure example of a subscript not having data:   ARRAY2(".114")="^CITY"   
 ; VLST contains the  imported and unvalidated data from Vecna that is intended to update the patient record in file 2
 N LN,LINE,STRING,REC,INTARRY
 S REC=-1
 F  S REC=$O(VLST(REC)) Q:REC=""  S INTARRY($P(VLST(REC),U))=REC_U_VLST(REC)
 F LN=2:1 S LINE=$T(FIELDLST+LN),STRING=$P(LINE,";;",2) Q:STRING=""  D
 . S ARRAY1($P(STRING,U,3))=$P(STRING,U)_U_$P(STRING,U,2),ARRAY2($P(STRING,U,2))=U_$P(STRING,U,3)
 . I $D(INTARRY($P(STRING,U,3))) S ARRAY2($P(STRING,U,2))=INTARRY($P(STRING,U,3))
 Q
 ;
 ;
FIELDLST ; list of fields defined in PATIENT file (#2)
 ;;FILE NUMBER^FIELD NUMBER^FIELD NAME^REQUIRED FIELD (DOCUMENTATION PURPOSES ONLY)
 ;;2^.05^MARITAL STATUS
 ;;2^.08^RELIGIOUS PREFERENCE
 ;;2^.111^STREET ADDRESS [LINE 1]
 ;;2^.112^STREET ADDRESS [LINE 2]
 ;;2^.113^STREET ADDRESS [LINE 3]
 ;;2^.114^CITY
 ;;2^.115^STATE
 ;;2^.117^COUNTY
 ;;2^.1171^PROVINCE
 ;;2^.1172^POSTAL CODE
 ;;2^.1173^COUNTRY^Required permanent address field
 ;;2^.1112^ZIP+4^R
 ;;2^.121^BAD ADDRESS INDICATOR
 ;;2^.131^PHONE NUMBER [RESIDENCE]
 ;;2^.132^PHONE NUMBER [WORK]
 ;;2^.134^PHONE NUMBER [CELLULAR]
 ;;2^.133^EMAIL ADDRESS
 ;;2^.1211^TEMPORARY STREET [LINE 1]^Required temporary address field
 ;;2^.1212^TEMPORARY STREET [LINE 2]
 ;;2^.1213^TEMPORARY STREET [LINE 3]
 ;;2^.1214^TEMPORARY CITY^Required temporary address field
 ;;2^.1215^TEMPORARY STATE^Required temporary address field if country = united states
 ;;2^.1217^TEMPORARY ADDRESS START DATE^Required temporary address field
 ;;2^.1218^TEMPORARY ADDRESS END DATE^Required temporary address field
 ;;2^.12111^TEMPORARY ADDRESS COUNTY^Required when country is USA
 ;;2^.12112^TEMPORARY ZIP+4^Required when country is USA
 ;;2^.1221^TEMPORARY ADDRESS PROVINCE
 ;;2^.1222^TEMPORARY ADDRESS POSTAL CODE
 ;;2^.1223^TEMPORARY ADDRESS COUNTRY^Required temporary address field
 ;;2^.1219^TEMPORARY PHONE NUMBER
 ;;2^.211^K-NAME OF PRIMARY NOK
 ;;2^.212^K-RELATIONSHIP TO PATIENT
 ;;2^.213^K-STREET ADDRESS [LINE 1]
 ;;2^.214^K-STREET ADDRESS [LINE 2]
 ;;2^.215^K-STREET ADDRESS [LINE 3]
 ;;2^.216^K-CITY
 ;;2^.217^K-STATE
 ;;2^.2207^K-ZIP+4
 ;;2^.219^K-PHONE NUMBER
 ;;2^.21011^K-WORK PHONE NUMBER
 ;;2^.2191^K2-NAME OF SECONDARY NOK
 ;;2^.2192^K2-RELATIONSHIP TO PATIENT
 ;;2^.2193^K2-STREET ADDRESS [LINE 1]
 ;;2^.2194^K2-STREET ADDRESS [LINE 2]
 ;;2^.2195^K2-STREET ADDRESS [LINE 3]
 ;;2^.2196^K2-CITY
 ;;2^.2197^K2-STATE
 ;;2^.2203^K2-ZIP+4
 ;;2^.2199^K2-PHONE NUMBER
 ;;2^.211011^K2-WORK PHONE NUMBER
 ;;2^.331^E-NAME
 ;;2^.332^E-RELATIONSHIP TO PATIENT
 ;;2^.333^E-STREET ADDRESS [LINE 1]
 ;;2^.334^E-STREET ADDRESS [LINE 2]
 ;;2^.335^E-STREET ADDRESS [LINE 3]
 ;;2^.336^E-CITY
 ;;2^.337^E-STATE
 ;;2^.2201^E-ZIP+4
 ;;2^.339^E-PHONE NUMBER
 ;;2^.33011^E-WORK PHONE NUMBER
 ;;2^.3311^E2-NAME OF SECONDARY CONTACT
 ;;2^.3312^E2-RELATIONSHIP TO PATIENT
 ;;2^.3313^E2-STREET ADDRESS [LINE 1]
 ;;2^.3314^E2-STREET ADDRESS [LINE 2]
 ;;2^.3315^E2-STREET ADDRESS [LINE 3]
 ;;2^.3316^E2-CITY
 ;;2^.3317^E2-STATE
 ;;2^.2204^E2-ZIP+4
 ;;2^.3319^E2-PHONE NUMBER
 ;;2^.331011^E2-WORK PHONE NUMBER
 ;;2^.3111^EMPLOYER NAME
 ;;2^.3119^EMPLOYER PHONE NUMBER
 ;;2^.31115^EMPLOYMENT STATUS
 ;;2^.31116^DATE OF RETIREMENT
 ;;2^.251^SPOUSE'S EMPLOYER NAME
 ;;2^.258^SPOUSE'S EMP PHONE NUMBER
 ;;2^.2515^SPOUSE'S EMPLOYMENT STATUS
 ;;2^.2516^SPOUSE'S RETIREMENT DATE
 ;;2.02^.01^RACE INFORMATION
 ;;2.06^.01^ETHNICITY INFORMATION
 ;;
 Q

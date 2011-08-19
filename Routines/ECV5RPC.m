ECV5RPC ;ALB/ACS;Event Capture Spreadsheet Data Validation ;07 Aug 01
 ;;2.0; EVENT CAPTURE ;**25,30,36,47**;8 May 96
 ;
 ;-----------------------------------------------------------------------
 ;  Validates the following Event Capture Spreadsheet Upload fields for
 ;  records sent to PCE:
 ;    1. DIAGNOSIS CODE
 ;    2. ASSOCIATED CLINIC
 ;-----------------------------------------------------------------------
 ;=======================================================================
 ;MODIFICATIONS
 ;08/2001    EC*2.0*30   Updated the Diagnosis validation logic
 ;=======================================================================
 ;
VALDIAG ;Validate Diagnosis Code.  Make sure it exists on the ICD9 file
 N ECDT
 S %DT="XST",X=$G(ECENCV,"NOW") D ^%DT S ECDT=+Y
 I ECDXV="" D
 . ; Spreadsheet is missing diagnosis code
 . S ECERRMSG=$P($T(DIAG1^ECV5RPC),";;",2)
 . S ECCOLERR=ECDXPC
 . D ERROR
 ;if diag invalid, send error message
 I ECDXV'="" S (ECDXIEN,ECSFOUND)=0 D
 . S ECDXIEN=$$ICDDX^ICDCODE(ECDXV,ECDT)
 . I +ECDXIEN>0,$P(ECDXIEN,"^",10) S ECDXIEN=+ECDXIEN,ECSFOUND=1 Q
 . I 'ECSFOUND D
 . . ; Invalid Diagnosis code
 . . S ECERRMSG=$P($T(DIAG2^ECV5RPC),";;",2)
 . . S ECCOLERR=ECDXPC
 . . D ERROR
 . . Q
 . Q
 Q
 ;
VALCLIN ;Validate Associated Clinic.  Make sure the clinic is active for
 ;the date of the encounter
 S ECERRFLG=0
 I ECCLNV="" D
 . ; Spreadsheet is missing the associated clinic
 . S ECERRMSG=$P($T(CLIN1^ECV5RPC),";;",2)
 . S ECCOLERR=ECCLNPC
 . D ERROR
 . Q
 I 'ECERRFLG,'$D(^SC("B",ECCLNV)) D
 . ; No B x-ref on file
 . S ECERRMSG=$P($T(CLIN2^ECV5RPC),";;",2)
 . S ECCOLERR=ECCLNPC
 . D ERROR
 . Q
 I 'ECERRFLG,$D(^SC("B",ECCLNV)) D
 . ;get associated clinic ien
 . S ECCLNIEN=$O(^SC("B",ECCLNV,0))
 . I '$D(^SC(ECCLNIEN,0)) D
 . . ; Associated clinic ien not on file
 . . S ECERRMSG=$P($T(CLIN3^ECV5RPC),";;",2)
 . . S ECCOLERR=ECCLNPC
 . . D ERROR
 . . Q
 . I 'ECERRFLG D
 . . ;make sure it is of type 'clinic'
 . . N CLINDATA
 . . S CLINDATA=$G(^SC(ECCLNIEN,0))
 . . I $P(CLINDATA,U,3)'="C" D
 . . . S ECERRMSG=$P($T(CLIN4^ECV5RPC),";;",2)
 . . . S ECCOLERR=ECCLNPC
 . . . D ERROR
 . . . Q
 . . Q
 . ;
 . ;check for inactivate and reactivate dates
 . I 'ECERRFLG,$D(^SC(ECCLNIEN,"I")) D
 . . ;get inactivated and reactivated dates
 . . N INACT,REACT
 . . S INACT=$P(^SC(ECCLNIEN,"I"),U,1),REACT=$P(^SC(ECCLNIEN,"I"),U,2)
 . . I INACT'="" D
 . . . I REACT="",ECENCV'<INACT D CLINERR^ECV5RPC
 . . . I REACT,ECENCV'<INACT,ECENCV<REACT D CLINERR^ECV5RPC
 . . . Q
 . . Q
 . Q
 Q
 ;;
CLINERR ;Clinic inactive for this encounter date
 S ECERRMSG=$P($T(CLIN5^ECV5RPC),";;",2)
 S ECCOLERR=ECCLNPC
 D ERROR
 Q
 ;;
ERROR ;--Set up array entry to contain the following:
 ;1. record number
 ;2. column number on spreadsheet containing the record number
 ;3. column number on spreadsheet containing the data in error
 ;4. error message
 ;
 S ECINDEX=ECINDEX+1
 S RESULTS(ECINDEX)=ECRECV_"^"_ECRECPC_"^"_ECCOLERR_"^"_ECERRMSG_"^"
 S ECERRFLG=1
 Q
 ;
 ;Error messages:
 ;
DIAG1 ;;Diagnosis code is required for this DSS Unit
DIAG2 ;;Invalid Diagnosis code
CLIN1 ;;Associated Clinic is required for this DSS Unit
CLIN2 ;;Assoc Clinic "B" x-ref not found on Hosp Location File(#44)
CLIN3 ;;Assoc Clinic not found on Hosp Location File(#44)
CLIN4 ;;Assoc Clinic must be of type "C" (clinic)
CLIN5 ;;Assoc Clinic inactive for this encounter date

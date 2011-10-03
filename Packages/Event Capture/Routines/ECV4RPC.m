ECV4RPC ;ALB/ACS;Event Capture Spreadsheet Data Validation ;Oct 13, 2000
 ;;2.0; EVENT CAPTURE ;**25,33,49**;8 May 96
 ;
 ;-----------------------------------------------------------------------
 ;  Validates the following Event Capture Spreadsheet Upload fields:
 ;    1. VOLUME
 ;    2. ENCOUNTER DATE/TIME
 ;    3. PROVIDER NAME
 ;
 ;  Determines the following:
 ;    1. PATIENT STATUS
 ;-----------------------------------------------------------------------
 ;
 ;--Volume must be 1 thru 99--
 N ECVOLVN,ECPDT
 S ECVOLVN=ECVOLV
 I (+ECVOLVN'=ECVOLVN)!(ECVOLVN<1)!(ECVOLVN>99)!(ECVOLVN?.E1"."1N.N) D
 . S ECERRMSG=$P($T(VOL1^ECV4RPC),";;",2)
 . S ECCOLERR=ECVOLPC
 . D ERROR
 . Q
 I $L(ECVOLVN)'=$L(ECVOLV) D
 . ; Volume must be numeric
 . S ECERRMSG=$P($T(VOL2^ECV4RPC),";;",2)
 . S ECCOLERR=ECVOLPC
 . D ERROR
 . Q
 ;
 ;--Encounter Date/Time--
 S ECERRFLG=0
 N ECRETVAL
 S %DT(0)="-NOW",ECENCV=$TR(ECENCV," ","")
 D CHK^DIE(721,2,"E",ECENCV,.ECRETVAL)
 I $G(ECRETVAL)="^" D
 . ; Invalid encounter date/time
 . S ECERRMSG=$P($T(ENC1^ECV4RPC),";;",2)
 . S ECCOLERR=ECENCPC
 . D ERROR
 . Q
 I $G(ECRETVAL)'="^" D
 . S %DT="XST",X=ECENCV
 . D ^%DT
 . S ECENCV=+Y
 . Q
 ;
 ;--Provider Name or IEN must be on the New Person file--
 ;--and provider must have active person class  --
 N ECPROV1
 S ECERRFLG=0,ECPRVIEN=0
 ; Remove punctuation if necessary
 I ECPROVV?.E1P S ECPROVV=$E(ECPROVV,1,$L(ECPROVV)-1)
 ; If provider ien passed in, find on file
 S ECPROV1=ECPROVV
 I +ECPROVV>0 D
 . I '$D(^VA(200,ECPROVV)) D
 . . ; Provider ien not found on New Person file
 . . S ECERRMSG=$P($T(PROV4^ECV4RPC),";;",2)
 . . S ECCOLERR=ECPRVLPC
 . . D ERROR
 . E  S ECPRVIEN=ECPROVV
 ;
 ; If provider name passed in, find on B x-ref and
 ; make sure there isn't more than 1 with same name
 N ECPRVNXT,ECPRVMOR,ECPRVMNT
 S (ECPRVMOR,ECPRVMNT)=0,ECCOLERR=ECPRVLPC
 I +ECPROVV'>0,$D(^VA(200,"B",ECPROVV)) D
 . S ECPRVIE2=$O(^VA(200,"B",ECPROVV,""))
 . S ECPRVNXT=$O(^VA(200,"B",ECPROVV,ECPRVIE2))
 . I ECPRVNXT'="" D
 . . S ECERRMSG=$P($T(PROV5^ECV4RPC),";;",2)
 . . S ECCOLERR=ECPRVLPC
 . . D ERROR
 . . S ECPRVMOR=1
 . E  S ECPRVIEN=ECPRVIE2
 ;
 I +ECPROVV'>0,'$D(^VA(200,"B",ECPROVV)) D
 . ; Exact match not found on New Person file
 . ; Generate standard error message
 . S ECERRMSG=$P($T(PROV1^ECV4RPC),";;",2)
 . S ECCOLERR=ECPRVLPC
 . D ERROR
 . S ECPRVMNT=1
 ; If exact match not found, get provider info
 I ECPRVMNT D
 . ; look at next provider on file for 'close' match
 . N ECINFO,ECLENPRV,NOMATCH,ECSPEC,ECSUBSP
 . N ECCOUNT,ECFIRST,ECLAST,ECPRVNXT,ECPRVIE2,ECPRVIE3
 . S ECLENPRV=$L(ECPROVV),(ECPRVIE2,ECPRVIE3)="",(ECCOUNT,NOMATCH)=0
 . S ECPRVNXT=ECPROVV
 . F  S ECPRVNXT=$O(^VA(200,"B",ECPRVNXT)) Q:NOMATCH=1  D
 . . F  S ECPRVIE3=$O(^VA(200,"B",ECPRVNXT,ECPRVIE3)) Q:ECPRVIE3=""  D
 . . . I ECPROVV'=$E(ECPRVNXT,1,ECLENPRV) S NOMATCH=1
 . . . E  D
 . . . . ;get provider info and add to end of error string
 . . . . S ECINFO=$$GET^XUA4A72(ECPRVIE3,ECENCV)
 . . . . I +ECINFO'>0 D
 . . . . . S ECERRMSG=ECPRVNXT_"-"_ECPRVIE3_"-Inactive Provider for this encounter date"
 . . . . . D ERROR
 . . . . . ;S ECCOUNT=ECCOUNT+1
 . . . . I +ECINFO>0 D
 . . . . . S ECCOUNT=ECCOUNT+1
 . . . . . S ECSPEC=$P(ECINFO,U,3)
 . . . . . I ECSPEC=" " S ECSPEC=""
 . . . . . S ECSUBSP=$P(ECINFO,U,4)
 . . . . . I ECSUBSP=" " S ECSUBSP=""
 . . . . . S ECPCLASS=$P(^VA(200,ECPRVIE3,"USC1",0),U,3)
 . . . . . I ECPCLASS="" S ECPCLASS="PERSON CLASS NOT FOUND"
 . . . . . S ECERRMSG=ECPRVNXT_"-"_ECPRVIE3_"-"_ECSPEC_"-"_ECSUBSP_"-"_ECPCLASS
 . . . . . D ERROR
 ; If more than one provider with that name, get info
 I ECPRVMOR D
 . N ECINFO,ECSPEC,ECSUBSP,ECPCLASS,ECCOUNT,ECFIRST,ECLAST,ECPRVIE2
 . S ECCOUNT=0,ECPRVIE2=0
 . ;look at each provider for exact match
 . F  S ECPRVIE2=$O(^VA(200,"B",ECPROVV,ECPRVIE2)) Q:ECPRVIE2=""  D
 . . S ECINFO=$$GET^XUA4A72(ECPRVIE2,ECENCV)
 . . I +ECINFO'>0 D
 . . . S ECERRMSG=ECPROVV_"-"_ECPRVIE2_"-Inactive Provider for this encounter date"
 . . . D ERROR
 . . I +ECINFO>0 D
 . . . S ECCOUNT=ECCOUNT+1
 . . . S ECSPEC=$P(ECINFO,U,3)
 . . . I ECSPEC=" " S ECSPEC=""
 . . . S ECSUBSP=$P(ECINFO,U,4)
 . . . I ECSUBSP=" " S ECSUBSP=""
 . . . S ECPCLASS=$P(^VA(200,ECPRVIE2,"USC1",0),U,3)
 . . . I ECPCLASS="" S ECPCLASS="PERSON CLASS NOT FOUND"
 . . . S ECERRMSG=ECPROVV_"-"_ECPRVIE2_"-"_ECSPEC_"-"_ECSUBSP_"-"_ECPCLASS
 . . . D ERROR
 ;
 ; Check person class of valid provider
 S ECPROVV=ECPROV1
 S %DT="XST",X=ECENCV D ^%DT S ECPDT=$S(+Y>0:+Y,1:DT)
 I 'ECERRFLG D
 . I ECPRVIEN=0 S ECPRVIEN=$O(^VA(200,"B",ECPROVV,0))
 . I '$D(^VA(200,ECPRVIEN,"USC1",0)) D 
 . . ; Person class xref doesn't exist
 . . S ECERRMSG=$P($T(PROV2^ECV4RPC),";;",2)
 . . S ECCOLERR=ECPRVLPC
 . . D ERROR
 . . Q
 . Q
 ;
 I 'ECERRFLG D
 . S ECPCLASS=$P(^VA(200,ECPRVIEN,"USC1",0),U,3)
 . I ECPCLASS="" D
 . . ; Person class field empty
 . . S ECERRMSG=$P($T(PROV2^ECV4RPC),";;",2)
 . . S ECCOLERR=ECPRVLPC
 . . D ERROR
 . . Q
 . Q
 ;
 I 'ECERRFLG,'$D(^VA(200,ECPRVIEN,"USC1",ECPCLASS,0)) D
 . ; Person class information missing
 . S ECERRMSG=$P($T(PROV2^ECV4RPC),";;",2)
 . S ECCOLERR=ECPRVLPC
 . D ERROR
 . Q
 ;
 ; Check for person class expiration date
 I 'ECERRFLG,$$GET^XUA4A72(ECPRVIEN,ECPDT)<1 D
 . ; Person class contains an expiration date
 . S ECERRMSG=$P($T(PROV3^ECV4RPC),";;",2)
 . S ECCOLERR=ECPRVLPC
 . D ERROR
 . Q
 ;
 I 'ECERRFLG D
 . S ECPRVTYP=$P(^VA(200,ECPRVIEN,"USC1",ECPCLASS,0),U,1)
 . I $P(^USC(8932.1,ECPRVTYP,0),U,4)'="a" D
 . . ; Person class is not active
 . . S ECERRMSG=$P($T(PROV3^ECV4RPC),";;",2)
 . . S ECCOLERR=ECPRVLPC
 . . D ERROR
 . . Q
 . Q
 ;
 ;--Determine Patient Status--
 S ECPSTAT=""
 I ECSSNIEN D
 . S ECERRFLG=0
 . S ECPSTAT=$$INOUTPT^ECUTL0(ECSSNIEN,+ECENCV)
 . I ECPSTAT="" D
 . . ; Unable to determine patient status
 . . S ECERRMSG=$P($T(STAT1^ECV4RPC),";;",2)
 . . S ECCOLERR=ECENCPC
 . . D ERROR
 . . Q
 . I ECPSTAT="I",'ECPSTATV,'ECERRFLG D
 . . ; Patient status is Inpatient and override flag is false
 . . S ECERRMSG=$P($T(STAT2^ECV4RPC),";;",2)
 . . S ECCOLERR=ECENCPC
 . . D ERROR
 . . Q
 ;
 ;--Check to see if the DSS Unit is 'send to PCE'--
 S ECDXIEN="",ECCLNIEN=""
 I ECPSTAT'="",ECDSSIEN'="" D
 . N ECDSSDAT,ECDSSPCE
 . S ECDSSDAT=$G(^ECD(ECDSSIEN,0))
 . S ECDSSPCE=$P(ECDSSDAT,U,14)
 . ; If Outpatient and send=O, or send=A
 . I ((ECPSTAT="O")&(ECDSSPCE["O"))!(ECDSSPCE["A") D
 . . ;Validate Diagnosis code and Associated Clinic
 . . D VALDIAG^ECV5RPC
 . . D VALCLIN^ECV5RPC
 . Q
 ;
 ;--Check to see if DUZ is defined
 S ECDUZ=$S($D(DUZ):DUZ,1:"")
 I ECDUZ="" D
 . ; Invalid DUZ
 . S ECERRMSG=$P($T(DUZ^ECV4RPC),";;",2),ECCOLERR=0
 . D ERROR
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
VOL1 ;;Volume must be a whole number from 1 to 99
VOL2 ;;Volume must contain numeric characters only
PROV1 ;;Provider has no B x-ref on New Person file(#200)
PROV2 ;;Unable to determine person class
PROV3 ;;Provider does not have an active person class
PROV4 ;;Provider IEN not found on New Person file(#200)
PROV5 ;;More than one provider  with this name - use IEN
ENC1 ;;Invalid encounter date/time.  Date cannot be in the future.
STAT1 ;;Unable to determine patient status
STAT2 ;;The patient status is Inpatient
DUZ ;;User DUZ not defined

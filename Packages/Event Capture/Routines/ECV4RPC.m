ECV4RPC ;ALB/ACS;Event Capture Spreadsheet Data Validation ;11/7/16  15:43
 ;;2.0;EVENT CAPTURE;**25,33,49,131,134**;8 May 96;Build 12
 ;
 ;----------------------------------------------------------------------
 ;  Validates the following Event Capture Spreadsheet Upload fields:
 ;    1. VOLUME
 ;    2. ENCOUNTER DATE/TIME
 ;    3. PROVIDER NAME
 ;
 ;  Determines the following:
 ;    1. PATIENT STATUS
 ;----------------------------------------------------------------------
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
 N ECPROV1,ECPROVV,NUM,PRVARR,DSSUPCE ;131,134
 S DSSUPCE=$S($P($G(^ECD(+$G(ECDSSIEN),0)),U,14)="N":"N",1:"A") ;134 DSS unit's send to PCE setting, either (N)o records or (A)ll records
 ;131 Entire section modified to add checking for up to 7 providers
 F NUM=1:1:7 S ECPROVV=@("ECPRV"_NUM_"V") I ECPROVV'="" D  I '$G(ECERRFLG) S @("ECPRV"_NUM_"V")=$G(ECPRVIEN)  ;If no error, set provider value to IEN
 .S ECERRFLG=0,ECPRVIEN=0
 .; Remove punctuation if necessary
 .I ECPROVV?.E1P S ECPROVV=$E(ECPROVV,1,$L(ECPROVV)-1)
 .; If provider ien passed in, find on file
 .S ECPROV1=ECPROVV
 .I +ECPROVV>0 D
 . . I '$D(^VA(200,ECPROVV)) D
 . . . ; Provider ien not found on New Person file
 . . . S ECERRMSG=$P($T(PROV4^ECV4RPC),";;",2)
 . . . S ECCOLERR=@("ECPRV"_NUM_"PC")
 . . . D ERROR
 . . E  S ECPRVIEN=ECPROVV
 .;
 .; If provider name passed in, find on B x-ref and
 .; make sure there isn't more than 1 with same name
 .N ECPRVNXT,ECPRVMOR,ECPRVMNT
 .S (ECPRVMOR,ECPRVMNT)=0,ECCOLERR=@("ECPRV"_NUM_"PC")
 .I +ECPROVV'>0,$D(^VA(200,"B",ECPROVV)) D
 . . S ECPRVIE2=$O(^VA(200,"B",ECPROVV,""))
 . . S ECPRVNXT=$O(^VA(200,"B",ECPROVV,ECPRVIE2))
 . . I ECPRVNXT'="" D
 . . . S ECERRMSG=$P($T(PROV5^ECV4RPC),";;",2)
 . . . S ECCOLERR=@("ECPRV"_NUM_"PC")
 . . . D ERROR
 . . . S ECPRVMOR=1
 . . E  S ECPRVIEN=ECPRVIE2
 .;
 .I +ECPROVV'>0,'$D(^VA(200,"B",ECPROVV)) D
 . . ; Exact match not found on New Person file
 . . ; Generate standard error message
 . . S ECERRMSG=$P($T(PROV1^ECV4RPC),";;",2)
 . . S ECCOLERR=@("ECPRV"_NUM_"PC")
 . . D ERROR
 . . S ECPRVMNT=1
 .; If exact match not found, get provider info
 .I ECPRVMNT D
 . . ; look at next provider on file for 'close' match
 . . N ECINFO,ECLENPRV,NOMATCH,ECSPEC,ECSUBSP
 . . N ECCOUNT,ECFIRST,ECLAST,ECPRVNXT,ECPRVIE2,ECPRVIE3
 . . S ECLENPRV=$L(ECPROVV),(ECPRVIE2,ECPRVIE3)="",(ECCOUNT,NOMATCH)=0
 . . S ECPRVNXT=ECPROVV
 . . F  S ECPRVNXT=$O(^VA(200,"B",ECPRVNXT)) Q:NOMATCH=1!(ECPRVNXT="")  D  ;131 Added check for null
 . . . F  S ECPRVIE3=$O(^VA(200,"B",ECPRVNXT,ECPRVIE3)) Q:ECPRVIE3=""  D
 . . . . I ECPROVV'=$E(ECPRVNXT,1,ECLENPRV) S NOMATCH=1
 . . . . E  D
 . . . . . ;get provider info and add to end of error string
 . . . . . S ECINFO=$$GET^XUA4A72(ECPRVIE3,ECENCV)
 . . . . . I +ECINFO'>0 D
 . . . . . . S ECERRMSG=ECPRVNXT_"-"_ECPRVIE3_"-"_$S(DSSUPCE="N"&($D(^EC(722,"B",ECPRVIE3))):"Non Licensed Provider",+ECINFO=-1:"Not a provider",1:"Inactive Provider for this encounter date") ;134
 . . . . . . D ERROR
 . . . . . . ;S ECCOUNT=ECCOUNT+1
 . . . . . I +ECINFO>0 D
 . . . . . . S ECCOUNT=ECCOUNT+1
 . . . . . . S ECSPEC=$P(ECINFO,U,3)
 . . . . . . I ECSPEC=" " S ECSPEC=""
 . . . . . . S ECSUBSP=$P(ECINFO,U,4)
 . . . . . . I ECSUBSP=" " S ECSUBSP=""
 . . . . . . S ECPCLASS=$P(^VA(200,ECPRVIE3,"USC1",0),U,3)
 . . . . . . I ECPCLASS="" S ECPCLASS="PERSON CLASS NOT FOUND"
 . . . . . . S ECERRMSG=ECPRVNXT_"-"_ECPRVIE3_"-"_ECSPEC_"-"_ECSUBSP_"-"_ECPCLASS
 . . . . . . D ERROR
 .; If more than one provider with that name, get info
 .I ECPRVMOR D
 . . N ECINFO,ECSPEC,ECSUBSP,ECPCLASS,ECCOUNT,ECFIRST,ECLAST,ECPRVIE2
 . . S ECCOUNT=0,ECPRVIE2=0
 . . ;look at each provider for exact match
 . . F  S ECPRVIE2=$O(^VA(200,"B",ECPROVV,ECPRVIE2)) Q:ECPRVIE2=""  D
 . . . S ECINFO=$$GET^XUA4A72(ECPRVIE2,ECENCV)
 . . . I +ECINFO'>0 D
 . . . . S ECERRMSG=ECPROVV_"-"_ECPRVIE2_"-"_$S(DSSUPCE="N"&($D(^EC(722,"B",ECPRVIE2))):"Non Licensed Provider",+ECINFO=-1:"Not a provider",1:"Inactive Provider for this encounter date") ;134
 . . . . D ERROR
 . . . I +ECINFO>0 D
 . . . . S ECCOUNT=ECCOUNT+1
 . . . . S ECSPEC=$P(ECINFO,U,3)
 . . . . I ECSPEC=" " S ECSPEC=""
 . . . . S ECSUBSP=$P(ECINFO,U,4)
 . . . . I ECSUBSP=" " S ECSUBSP=""
 . . . . S ECPCLASS=$P(^VA(200,ECPRVIE2,"USC1",0),U,3)
 . . . . I ECPCLASS="" S ECPCLASS="PERSON CLASS NOT FOUND"
 . . . . S ECERRMSG=ECPROVV_"-"_ECPRVIE2_"-"_ECSPEC_"-"_ECSUBSP_"-"_ECPCLASS
 . . . . D ERROR
 .;
 .; Check for valid provider
 .S ECPROVV=ECPROV1
 .S %DT="XST",X=ECENCV D ^%DT S ECPDT=$S(+Y>0:+Y,1:DT)
 .I 'ECERRFLG D  ;134
 . .I DSSUPCE="A"!(DSSUPCE="N"&('$D(^EC(722,"B",ECPRVIEN)))) D  ;134 Checking "traditional" providers if DSS unit sends all records or sends no records and person is not in file 722
 . . . ;134 section updated
 . . . I ECPRVIEN=0 S ECPRVIEN=$O(^VA(200,"B",ECPROVV,0))
 . . . S ECINFO=$$GET^XUA4A72(ECPRVIEN,ECPDT) I +ECINFO<0 D  ;134
 . . . . S ECERRMSG=$S(+ECINFO=-1:$P($T(PROV8^ECV4RPC),";;",2),1:$P($T(PROV3^ECV4RPC),";;",2)) ;134
 . . . . S ECCOLERR=@("ECPRV"_NUM_"PC")
 . . . . D ERROR
 . . . . Q
 . . . Q
 . .;134 Added section to check for non licensed providers
 . .I DSSUPCE="N",'$D(^EC(722,"B",ECPRVIEN)),$$GET^XUA4A72(ECPRVIEN,ECPDT)<0 D
 . . . S ECERRMSG=$P($T(PROV7^ECV4RPC),";;",2)
 . . . S ECCOLERR=@("ECPRV"_NUM_"PC")
 . . . D ERROR
 . . . Q
 . . Q
 .I 'ECERRFLG D  ;131 Section added to check for duplicate providers
 ..I $D(PRVARR(ECPRVIEN)) D
 ...S ECERRMSG=$P($T(PROV6^ECV4RPC),";;",2)
 ...S ECCOLERR=@("ECPRV"_NUM_"PC")
 ...D ERROR
 ..S PRVARR(ECPRVIEN)=""
 ..Q
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
PROV5 ;;More than one provider with this name - use IEN
PROV6 ;;Duplicate provider identified - providers must be unique
PROV7 ;;Provider not identified as a non licensed provider
PROV8 ;;The provider has never been assigned a provider class
ENC1 ;;Invalid encounter date/time.  Date cannot be in the future.
STAT1 ;;Unable to determine patient status
STAT2 ;;The patient status is Inpatient
DUZ ;;User DUZ not defined

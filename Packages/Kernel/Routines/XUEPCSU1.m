XUEPCSU1 ;ALB/BI - DEA Manual Entry ;05/15/2018
 ;;8.0;KERNEL;**689**;Jul 10, 1995;Build 113
 Q
 ;
WSGET(FG,DEA) ; Function to Get the Remote DEA information, Return in FG.
 ; INPUT:   DEA      ;Properly formatted DEA Number for lookup.
 ;
 ; OUTPUT:  FG       ;Web Service Response Global
 ;
 ; RETURN:  Status code with a text message.
 ;          If not filled successfully a "0^Error Message" will be returned.
 ;
 ; VARIABLES:
 N DATA      ;The body portion of the RESPONSE object.
 N ERRORS    ;Errors that may be returned from the JSON to MUMPS convertion.
 ; FG        ;The JSON string converted to a MUMPS global.
 N REQUEST   ;The web service object.
 N RESOURCE  ;Input variable for the $$GET^XOBWLIB call, in this case the DEA number.
 N RESPJSON  ;Used to store the JSON response in the DATA object into a single line string.
 N RESPONSE  ;The response object portion of the REQUEST object.
 N SC        ;Status Code response from the $$GET^XOBWLIB call.
 N SERVER    ;The web server identifier.
 N SERVICE   ;The web service identifier.
 N XU        ;Left over variable from the XOBWLIB processes.
 N PSOERR    ;Left over variable from the XOBWLIB processes.
 ;
 Q:$G(DEA)="" "0^No DEA Number Entered."
 S SERVER="PSO DOJ/DEA WEB SERVER"
 S SERVICE="PSO DOJ/DEA WEB SERVICE"
 S RESOURCE=DEA
 ;
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 ;
 ; Execute the HTTP Get method.
 S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 I 'SC Q "0^General Service Error"
 ;
 ; Process the response.  REQUEST(O) -> RESPONSE(0) -> DATA(S) -> RESPJSON(S)
 S RESPONSE=REQUEST.HttpResponse
 S DATA=RESPONSE.Data
 S RESPJSON=""
 ;
 F  Q:DATA.AtEnd  Set RESPJSON=RESPJSON_DATA.ReadLine()
 S RESPJSON=$TR(RESPJSON,$C(10),"")
 I RESPJSON="" Q "0^No Data Returned."
 ;
 ; Decode the JSON format into a MUMPS global in FG
 D DECODE^XLFJSON("RESPJSON","FG","ERRORS")
 ;
 ; Handle a "DEA NOT FOUND" gracefully.
 I FG("deaNumber")="DEA NOT FOUND" Q "0^DEA NUMBER NOT FOUND. Please enter the provider's DEA number."
 ;
 ; Define the TYPE field
 S FG("type")=$P($$PROVTYPE^PSODEAUT(FG("businessActivityCode")),"^",2)
 ;
 ; Default the businessActivitySubcode.
 I $G(FG("businessActivitySubcode"))="" S FG("businessActivitySubcode")=0
 ;
 Q "1^Success"
 ;
FILEFM(RET,DATA,NPIEN)  ; -- File DEA Information in the DEA NUMBERS FILE #8991.9
 ; Invoked by RPC: XU EPCS ADD DEA
 N DNDEAIEN,DNDEATXT,FDA,IENROOT,IENS,MSGROOT,SUFFIX,XSTATE,XIP
 S RET=0
 I '$D(DATA) S RET=0 G FILEFMX
 ;
 S DNDEATXT=$P(DATA,U,11) I DNDEATXT="" G FILEFMX
 S DNDEAIEN=$O(^XTV(8991.9,"B",DNDEATXT,0))
 S IENS=$S($G(DNDEAIEN):$G(DNDEAIEN)_",",1:"+1,")
 ;
 ; INPUT:  DATA - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 S FDA(1,8991.9,IENS,1.1)=$P(DATA,U,1)         ;  1 - PROVIDER NAME
 S FDA(1,8991.9,IENS,1.2)=$P(DATA,U,2)         ;  2 - ADDRESS 1
 S FDA(1,8991.9,IENS,1.3)=$P(DATA,U,3)         ;  3 - ADDRESS 2
 S FDA(1,8991.9,IENS,1.4)=$P(DATA,U,4)         ;  4 - ADDRESS 3
 S FDA(1,8991.9,IENS,1.5)=$P(DATA,U,5)         ;  5 - CITY
 ;
 ; Special State Processing
 D POSTAL^XIPUTIL($P(DATA,U,8),.XIP)
 S XSTATE=$G(XIP("STATE"))
 I XSTATE'="" S FDA(1,8991.9,IENS,1.6)=XSTATE  ;  6 - STATE
 ;
 S FDA(1,8991.9,IENS,1.7)=$P(DATA,U,8)         ;  8 - ZIP CODE
 S FDA(1,8991.9,IENS,.02)=$P(DATA,U,9)         ;  9 - ACTIVITY CODE
 S FDA(1,8991.9,IENS,.07)=$P(DATA,U,10)        ; 10 - TYPE
 S FDA(1,8991.9,IENS,.01)=$P(DATA,U,11)        ; 11 - DEA NUMBER
 S FDA(1,8991.9,IENS,.04)=$P(DATA,U,12)        ; 12 - EXPIRATION DATE
 S FDA(1,8991.9,IENS,10.2)="N"                 ; 13 - PROCESSED DATE
 I $$DEANUM^XUEPCSUT($P(DATA,U,14)) D                   ; ONLY CLEAR AND SET IF VALIDATED
 . I $P(DATA,U,14)'="" D CLEARDTX^XUEPCSUT(NPIEN)       ; REMOVE DETOX NUMBERS FROM OTHER DEA NUMBERS
 . S FDA(1,8991.9,IENS,.03)=$P(DATA,U,14)      ; 14 - DETOX NUMBER
 I $P(DATA,U,10)="INDIVIDUAL" D
 . S FDA(1,8991.9,IENS,2.1)=$P(DATA,U,15)        ; 15 - SCHEDULE II NARCOTIC
 . S FDA(1,8991.9,IENS,2.2)=$P(DATA,U,16)        ; 16 - SCHEDULE II NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.3)=$P(DATA,U,17)        ; 17 - SCHEDULE III NARCOTIC
 . S FDA(1,8991.9,IENS,2.4)=$P(DATA,U,18)        ; 18 - SCHEDULE III NON-NARCOTIC
 . S FDA(1,8991.9,IENS,2.5)=$P(DATA,U,19)        ; 19 - SCHEDULE IV
 . S FDA(1,8991.9,IENS,2.6)=$P(DATA,U,20)        ; 20 - SCHEDULE V
 I $P(DATA,U,10)'="INDIVIDUAL" D
 . N SRET,SDEA
 . S SDEA=$P(DATA,U,11) ;dea number
 . D DEADOJ^XUEPCSUT(.SRET,SDEA) ;call doj server for doj institutional schedules
 . I SRET(0) D  ;doj server is up
 . . S FDA(1,8991.9,IENS,2.1)=$P(SRET(1),"^",15) ; 15 - SCHEDULE II NARCOTIC
 . . S FDA(1,8991.9,IENS,2.2)=$P(SRET(1),"^",16) ; 16 - SCHEDULE II NON-NARCOTIC
 . . S FDA(1,8991.9,IENS,2.3)=$P(SRET(1),"^",17) ; 17 - SCHEDULE III NARCOTIC
 . . S FDA(1,8991.9,IENS,2.4)=$P(SRET(1),"^",18) ; 18 - SCHEDULE III NON-NARCOTIC
 . . S FDA(1,8991.9,IENS,2.5)=$P(SRET(1),"^",19) ; 19 - SCHEDULE IV
 . . S FDA(1,8991.9,IENS,2.6)=$P(SRET(1),"^",20) ; 20 - SCHEDULE V
 . ;
 S FDA(1,8991.9,IENS,.06)=$P(DATA,U,21)        ; 21 - USE FOR INPATIENT FLAG
 S SUFFIX=$P(DATA,U,22)                        ; 22 - DEA INSTITUTIONAL SUFFIX
 ;
 D UPDATE^DIE("E","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) S RET="0^DATA DIDN'T FILE SUCCESSFULLY." G FILEFMX
 S DNDEAIEN=$S($D(IENROOT(1)):IENROOT(1)_",",1:IENS)
 I '+DNDEAIEN S RET="0^DATA DIDN'T FILE SUCCESSFULLY." G FILEFMX
 S FDA(2,8991.9,DNDEAIEN,10.1)=$G(DUZ) D FILE^DIE("","FDA(2)","MSGROOT")
 S:DNDEAIEN RET=+DNDEAIEN_"^SUCCESSFULLY SAVED/UPDATED IN 8991.9"
 I $L(DNDEATXT),$G(NPIEN),$G(DNDEAIEN) S RET=RET_"^"_$$NPFILE^XUEPCSUT(DNDEATXT,NPIEN,DNDEAIEN,SUFFIX)
 I RET,$P(DATA,U,21)="YES" S FDA(200,NPIEN_",",53.2)=$P(DATA,U,11) D UPDATE^DIE(,"FDA")
 I $P(RET,"^",3),$G(NPIEN),$P($G(DATA),"^",10)'="INDIVIDUAL" S RET=RET_"^"_$$NPSFILE^XUEPCSUT(NPIEN,DATA)
FILEFMX  ; -- Subroutine Exit Point
 Q
 ;
DNDEAGET(RET,DEA) ;
 I '$D(^XTV(8991.9,"B",DEA)) S RET(0)="0^DEA NOT ON FILE" Q
 I $D(^XTV(8991.9,"B",DEA)) S DNDEAIEN=$O(^XTV(8991.9,"B",DEA,0)) I +DNDEAIEN D
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT")
 . K RET(1)
 . S RET(1)=""
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.1))_"^"    ; PROVIDER NAME
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.2))_"^"    ; ADDRESS 1
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.3))_"^"    ; ADDRESS 2
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.4))_"^"    ; ADDRESS 3
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.5))_"^"    ; CITY
 . ;
 . ; Special State Processing
 . N XSTATE,XSTATEAB,XIP,BAC,X,Y D POSTAL^XIPUTIL($G(DNDEADAT(8991.9,DNDEAIEN_",",1.7)),.XIP)
 . S XSTATEAB=$$GET1^DIQ(5,XIP("STATE POINTER"),1)
 . S RET(1)=RET(1)_XSTATEAB_"^"                         ; STATE ABREVIATION
 . S XSTATE=$G(XIP("STATE"))
 . S RET(1)=RET(1)_$G(XSTATE)_"^"                       ; STATE
 . ;
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",1.7))_"^"  ; ZIP CODE
 . S BAC=$G(DNDEADAT(8991.9,DNDEAIEN_",",.02))                ; ACTIVITY CODE
 . S RET(1)=RET(1)_BAC_"^"                             ; ACTIVITY CODE
 . S RET(1)=RET(1)_$P($$PROVTYPE^XUEPCSUT($G(BAC)),"^",2)_"^"   ; TYPE
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",.01))_"^"  ; DEA NUMBER
 . S X=$P($G(DNDEADAT(8991.9,DNDEAIEN_",",.04)),"@") D ^%DT
 . S RET(1)=RET(1)_$$FMTHL7^XLFDT(Y)_"^"  ; EXPIRATION DATE
 . S X=$P($G(DNDEADAT(8991.9,DNDEAIEN_",",10.2)),"@") D ^%DT
 . S RET(1)=RET(1)_$$FMTHL7^XLFDT(Y)_"^" ; PROCESSED DATE
 . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",.03))_"^"  ; DETOX NUMBER
 . I $G(DNDEADAT(8991.9,DNDEAIEN_",",.07))="INDIVIDUAL" D
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.1))_"^"  ; SCHEDULE II NARCOTIC
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.2))_"^"  ; SCHEDULE II NON-NARCOTIC
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.3))_"^"  ; SCHEDULE III NARCOTIC
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.4))_"^"  ; SCHEDULE III NON-NARCOTIC
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.5))_"^"  ; SCHEDULE IV
 . . S RET(1)=RET(1)_$G(DNDEADAT(8991.9,DNDEAIEN_",",2.6))      ; SCHEDULE V
 . I $G(DNDEADAT(8991.9,DNDEAIEN_",",.07))'="INDIVIDUAL" D
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE II NARCOTIC
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE II NON-NARCOTIC
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE III NARCOTIC
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE III NON-NARCOTIC
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE IV
 . . S RET(1)=RET(1)_"^"  ; SCHEDULE V
 S RET(0)=RET(0)_"; OFFLINE DEA DATA IN USE"
 ;

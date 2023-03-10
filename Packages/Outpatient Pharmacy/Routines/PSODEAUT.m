PSODEAUT ;ALB/BI - DEA MANUAL ENTRY ;05/15/2018
 ;;7.0;OUTPATIENT PHARMACY;**529,684**;DEC 1997;Build 57
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA BUSINESS ACTIVITY CODES file (#8991.8) is supported by DBIA 7001
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to DEA NUMBERS file (#8991.6) is supported by DBIA 7015
 Q
 ;
DEALIST(RET,NPIEN)  ; -- RPC to return a List of DEA numbers and information for a single provider.
 ; INPUT:  NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 ;           1 - DEA NUMBER
 ;           2 - INDIVIDUAL DEA SUFFIX
 ;           3 - STATE
 ;           4 - DETOX NUMBER
 ;           5 - EXPIRATION DATE: FROM THE DEA NUMBERS FILE (#8991.9), FIELD EXPIRATION DATE (#.04)
 ;           6 - NPIENS
 ;           7 - DNIENS
 ;           8 - SCHEDULE II NARCOTIC
 ;           9 - SCHEDULE II NON-NARCOTIC
 ;          10 - SCHEDULE III NARCOTIC
 ;          11 - SCHEDULE III NON-NARCOTIC
 ;          12 - SCHEDULE IV
 ;          13 - SCHEDULE V
 ;          14 - USE FOR INPATIENT ORDERS?
 ;
 Q:'$G(NPIEN)
 N CNT,DNDEADAT,DNDEAIEN,FAIL,IENS,NPDEADAT,NPDEAIEN
 S NPDEAIEN=0 F CNT=1:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . S IENS=NPDEAIEN_","_NPIEN_","
 . K NPDEADAT D GETS^DIQ(200.5321,IENS,"**","","NPDEADAT") Q:'$D(NPDEADAT)
 . S DNDEAIEN=$$GET1^DIQ(200.5321,IENS,.03,"I") Q:'DNDEAIEN
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT") Q:'$D(DNDEADAT)
 . ;
 . S RET(CNT)=""
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.01)_"^"        ; NEW PERSON DEA NUMBER
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.02)_"^"        ; INDIVIDUAL DEA SUFFIX
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.6)_"^"  ; STATE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.03)_"^"  ; DETOX NUMBER
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.04)_"^"  ; EXPIRATION DATE
 . S RET(CNT)=RET(CNT)_IENS_"^"                               ; NEW PERSON IENS
 . S RET(CNT)=RET(CNT)_DNDEAIEN_"^"                           ; DEA NUMBERS IEN
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.1)_"^"  ; SCHEDULE II NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.2)_"^"  ; SCHEDULE II NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.3)_"^"  ; SCHEDULE III NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.4)_"^"  ; SCHEDULE III NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.5)_"^"  ; SCHEDULE IV
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.6)_"^"  ; SCHEDULE V
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.06)      ; USE FOR INPATIENT ORDERS?
 Q
 ;
DEADOJ(RET,DEA)  ; -- RPC to return DEA Information for a single DEA Number
 ; INPUT:  DEA - PROPERLY FORMATTED DEA NUMBER
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 ;           1 - PROVIDER NAME
 ;           2 - ADDITIONAL COMPANY INFO
 ;           3 - ADDRESS 1
 ;           4 - ADDRESS 2
 ;           5 - CITY
 ;           6 - STATE
 ;           7 - STATE POINTER
 ;           8 - ZIP CODE
 ;           9 - ACTIVITY CODE
 ;          10 - TYPE
 ;          11 - DEA NUMBER
 ;          12 - EXPIRATION DATE
 ;          13 - PROCESSED DATE
 ;          14 - DETOX NUMBER
 ;          15 - SCHDEULE II NARCOTIC
 ;          16 - SCHEDULE II NON-NARCOTIC
 ;          17 - SCHEDULE III NARCOTIC
 ;          18 - SCHEDULE III NON-NARCOTIC
 ;          19 - SCHEDULE IV
 ;          20 - SCHEDULE V
 ;
 N FG,NAME,NPIEN,VALUE,DS,BAC,SC
 I $G(DEA)="" S RET(0)="0^INVALID DEA NUMBER" Q
 I '$$DEANUMFL(DEA) S RET(0)="0^Invalid DEA Number due to error in first letter" Q
 I '$$DEANUM(DEA) S RET(0)="0^Invalid DEA Number due to error in the numbers" Q
 S SC=$$WSGET(.FG,DEA)
 I $P($P(SC,"^",2),".",1)="DEA NUMBER NOT FOUND" S RET(0)="0^DEA NUMBER NOT FOUND. Please enter the provider's DEA number." Q
 I 'SC S RET(0)="0^WEB SERVICE FAILURE" Q
 ;
 S RET(1)=""
 S RET(1)=RET(1)_$G(FG("name"))_"^"                   ; PROVIDER NAME
 S RET(1)=RET(1)_$G(FG("additionalCompanyInfo"))_"^"  ; ADDITIONAL COMPANY INFO
 S RET(1)=RET(1)_$G(FG("address1"))_"^"               ; ADDRESS 1
 S RET(1)=RET(1)_$G(FG("address2"))_"^"               ; ADDRESS 2
 S RET(1)=RET(1)_$G(FG("city"))_"^"                   ; CITY
 ;
 ; Special State Processing
 S RET(1)=RET(1)_$G(FG("state"))_"^"                  ; STATE
 N XSTATE,XIP D POSTAL^XIPUTIL($G(FG("zipCode")),.XIP) S XSTATE=$G(XIP("STATE"))
 S RET(1)=RET(1)_$G(XSTATE)_"^"                       ; STATE POINTER
 ;
 S RET(1)=RET(1)_$G(FG("zipCode"))_"^"                ; ZIP CODE
 S BAC=$G(FG("businessActivityCode"))_$G(FG("businessActivitySubcode"))
 S RET(1)=RET(1)_BAC_"^"  ; ACTIVITY CODE
 S RET(1)=RET(1)_$P($$PROVTYPE($G(FG("businessActivityCode"))),"^",2)_"^"  ; TYPE
 S RET(1)=RET(1)_$G(FG("deaNumber"))_"^"              ; DEA NUMBER
 S RET(1)=RET(1)_$G(FG("expirationDate"))_"^"         ; EXPIRATION DATE
 S RET(1)=RET(1)_$G(FG("processedDate"))_"^"          ; PROCESSED DATE
 ;
 S DS=$G(FG("drugSchedule"))
 S NPIEN=$O(^VA(200,"PS4",DEA,0))
 S RET(1)=RET(1)_$S($$DETOXCHK^PSODEAUT(BAC):"X"_$E(FG("deaNumber"),2,9),1:"")_"^"  ; DETOX NUMBER
 S RET(1)=RET(1)_$S(DS["22N":"YES",(DS["2"&(DS'["2N")):"YES",1:"NO")_"^"  ; SCHEDULE II NARCOTIC
 S RET(1)=RET(1)_$S(DS["2N":"YES",1:"NO")_"^"                             ; SCHEDULE II NON-NARCOTIC
 S RET(1)=RET(1)_$S(DS["33N":"YES",DS["3"&(DS'["3N"):"YES",1:"NO")_"^"    ; SCHEDULE III NARCOTIC
 S RET(1)=RET(1)_$S(DS["3N":"YES",1:"NO")_"^"                             ; SCHEDULE III NON-NARCOTIC
 S RET(1)=RET(1)_$S(DS["4":"YES",1:"NO")_"^"                              ; SCHEDULE IV
 S RET(1)=RET(1)_$S(DS["5":"YES",1:"NO")                                  ; SCHEDULE V
 S RET(0)="1^SUCCESS"
 Q
 ;
DEAREM(RET,NPIEN,DEATXT)  ; Functionality to remove a DEA multiple from file #200, Field 53.21
 ; INPUT:  NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;         DEATXT - PROPERLY FORMATTED DEA NUMBER
 ; OUTPUT: RET - 1 for SUCCESS, 0 for UNSUCCESSFUL
 N FDA,IENS,MSGROOT,NPDEAIEN,DNDEAIEN,DEATYPE,DA,DIE,DR
 S RET=0 Q:'$G(NPIEN)  Q:$G(DEATXT)=""
 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4","B",DEATXT,0)) I 'NPDEAIEN Q
 S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 S DEATYPE=$$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")
 S FDA(1,200.5321,NPDEAIEN_","_NPIEN_",",.01)="@"
 S FDA(2,8991.9,DNDEAIEN_",",.01)="@"
 D UPDATE^DIE(,"FDA(1)",,"MSGROOT") Q:$D(MSGROOT)
 I DNDEAIEN,DEATYPE=2 D UPDATE^DIE(,"FDA(2)",,"MSGROOT") Q:$D(MSGROOT)
 S RET=1
 Q
 ;
VIEWFM(RET,DEA)  ; -- Request for DEA Information stored in DEA NUMBERS FILE #8991.9, Return DEA Information in RET
 N DEAIEN,GETSTMP
 I $G(DEA)="" S RET(0)="0^INVALID DEA NUMBER" Q
 S DEAIEN=$O(^XTV(8991.9,"B",DEA,0)) I 'DEAIEN S RET(0)="0^DEA NUMBER NOT FOUND" Q
 D GETS^DIQ(8991.9,DEAIEN,"**","R","GETSTMP")
 I '$D(GETSTMP) S RET(0)="0^NO DATA FOUND" Q
 S RET(0)="1^SUCCESS"
 S CNT=0,NAME="" F  S NAME=$O(GETSTMP(8991.9,DEAIEN_",",NAME)) Q:NAME=""  D
 . S CNT=CNT+1,RET(CNT)=NAME_"^"_GETSTMP(8991.9,DEAIEN_",",NAME)
 Q
 ;
FILEWS(RET,ARRAY)  ; -- File DEA Information in ARRAY, Return the IEN Number from DEA NUMBERS FILE #8991.9
 N FG,NAME,VALUE,CNT
 F CNT=1:1:$O(ARRAY(""),-1) S FG($P(ARRAY(CNT),"^",1))=$P(ARRAY(CNT),"^",2)
 I $G(FG("deaNumber"))="" S RET(0)="0^INVALID DEA NUMBER" Q
 I '$$DEANUMFL(FG("deaNumber")) S RET(0)="0^Invalid DEA Number due to error in first letter" Q
 I '$$DEANUM(FG("deaNumber")) S RET(0)="0^Invalid DEA Number due to error in the numbers" Q
 S RET=$$DEACOPY^PSODEAUT(.FG)
 Q
 ;
DEACOPY(FG) ; -- Private Subroutine to Copy import data in the GETS Array
 ; POSTAL^XIPUTL used in agreement with Integration Agreement: 3618
 ;
 ; INPUT:  FG       ;Web Service Response Global
 ;
 ; VARIABLES:
 N DS       ;Single drug schedule field as sent from the VA DOJ Web Service.
 N XIP      ;Used to calculate the state from a zip code.
 N XSTATE   ;Used to calculate the state from a zip code.
 N BAC      ;Business Activity Code
 N DTRESULT
 ;
 S DS=$G(FG("drugSchedule"))
 S GETS(.01)=$G(FG("deaNumber"))
 S BAC=$G(FG("businessActivityCode"))_$G(FG("businessActivitySubcode"))
 S GETS(.02)=BAC ; Pointer to file #8991.8
 S GETS(.03)=$S($$GETDNDTX^PSODEAUT(NPIEN)'="":"",$$DETOXCHK^PSODEAUT(BAC):"X"_$E($G(FG("deaNumber")),2,9),1:"")  ; DETOX NUMBER
 D DT^DILF("E",$G(FG("expirationDate")),.DTRESULT)
 S GETS(.04)=$G(DTRESULT(0))
 S GETS(.07)=$G(FG("type"))
 S GETS(1.1)=$G(FG("name"))
 S GETS(1.2)=$G(FG("additionalCompanyInfo"))
 S GETS(1.3)=$G(FG("address1"))
 S GETS(1.4)=$G(FG("address2"))
 S GETS(1.5)=$G(FG("city"))
 ;
 ; Special State Processing
 S GETS(1.6)=$G(FG("state"))
 D POSTAL^XIPUTIL($G(FG("zipCode")),.XIP)
 S XSTATE=$G(XIP("STATE"))
 I XSTATE'="" S GETS(1.6)=XSTATE ; Pointer to the State File #5.
 ;
 S GETS(1.7)=$G(FG("zipCode"))
 ;
 S GETS(2.1)=$S(DS["22N":"YES",(DS["2"&(DS'["2N")):"YES",1:"NO") ; SCHEDULE II NARCOTIC
 S GETS(2.2)=$S(DS["2N":"YES",1:"NO") ; SCHEDULE II NON-NARCOTIC
 S GETS(2.3)=$S(DS["33N":"YES",(DS["3"&(DS'["3N")):"YES",1:"NO") ; SCHEDULE III NARCOTIC
 S GETS(2.4)=$S(DS["3N":"YES",1:"NO") ; SCHEDULE III NON-NARCOTIC
 S GETS(2.5)=$S(DS["4":"YES",1:"NO") ; SCHEDULE IV
 S GETS(2.6)=$S(DS["5":"YES",1:"NO") ; SCHEDULE V
 ;
 D DT^DILF("E",%DT,.DTRESULT)
 S GETS(10.2)=$G(DTRESULT(0))  ; LAST UPDATED DATE/TIME
 D DT^DILF("E",$G(FG("processedDate")),.DTRESULT)
 S GETS(10.3)=$G(DTRESULT(0))  ; LAST DOJ UPDATE DATE/TIME
 S GETS(10.1)=DUZ
 Q
 ;
FILEFM(RET,DATA,NPIEN)  ; -- File DEA Information in the DEA NUMBERS FILE #8991.9
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
 S FDA(1,8991.9,IENS,1.2)=$P(DATA,U,2)         ;  2 - ADDITIONAL COMPANY INFO
 S FDA(1,8991.9,IENS,1.3)=$P(DATA,U,3)         ;  3 - ADDRESS 1
 S FDA(1,8991.9,IENS,1.4)=$P(DATA,U,4)         ;  4 - ADDRESS 2
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
 I $$DEANUM($P(DATA,U,14)) D                   ; ONLY CLEAR AND SET IF VALIDATED
 . I $P(DATA,U,14)'="" D CLEARDTX(NPIEN)       ; REMOVE DETOX NUMBERS FROM OTHER DEA NUMBERS
 . S FDA(1,8991.9,IENS,.03)=$P(DATA,U,14)      ; 14 - DETOX NUMBER
 S FDA(1,8991.9,IENS,2.1)=$P(DATA,U,15)        ; 15 - SCHDEULE II NARCOTIC
 S FDA(1,8991.9,IENS,2.2)=$P(DATA,U,16)        ; 16 - SCHEDULE II NON-NARCOTIC
 S FDA(1,8991.9,IENS,2.3)=$P(DATA,U,17)        ; 17 - SCHEDULE III NARCOTIC
 S FDA(1,8991.9,IENS,2.4)=$P(DATA,U,18)        ; 18 - SCHEDULE III NON-NARCOTIC
 S FDA(1,8991.9,IENS,2.5)=$P(DATA,U,19)        ; 19 - SCHEDULE IV
 S FDA(1,8991.9,IENS,2.6)=$P(DATA,U,20)        ; 20 - SCHEDULE V
 S FDA(1,8991.9,IENS,.06)=$P(DATA,U,21)        ; 21 - USE FOR INPATIENT FLAG
 S SUFFIX=$P(DATA,U,22)                        ; 22 - DEA INSTITUTIONAL SUFFIX
 ;
 D UPDATE^DIE("E","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) S RET="0^DATA DIDN'T FILE SUCCESSFULLY." G FILEFMX
 S DNDEAIEN=$S($D(IENROOT(1)):IENROOT(1)_",",1:IENS)
 I '+DNDEAIEN S RET="0^DATA DIDN'T FILE SUCCESSFULLY." G FILEFMX
 S FDA(2,8991.9,DNDEAIEN,10.1)=$G(DUZ) D FILE^DIE("","FDA(2)","MSGROOT")
 S:DNDEAIEN RET=+DNDEAIEN_"^SUCCESSFULLY SAVED/UPDATED IN 8991.9"
 I $L(DNDEATXT),$G(NPIEN),$G(DNDEAIEN) S RET=RET_"^"_$$NPFILE(DNDEATXT,NPIEN,DNDEAIEN,SUFFIX)
 I RET,$P(DATA,U,21)="YES" S FDA(200,NPIEN_",",53.2)=$P(DATA,U,11) D UPDATE^DIE(,"FDA")
FILEFMX  ; -- Subroutine Exit Point
 Q
 ;
NPFILE(DNDEATXT,NPIEN,DNDEAIEN,SUFFIX) ; -- File the DEA NUMBER in the NEW PERSON FILE #200.
 N FDA,IEN,IENROOT,MSGROOT
 Q:'$G(NPIEN)  Q:'$G(DNDEAIEN)
 S IEN="+1,"
 I $D(^VA(200,NPIEN,"PS4","B",DNDEATXT)) S IEN=$O(^VA(200,NPIEN,"PS4","B",DNDEATXT,0))_","
 S FDA(1,200.5321,IEN_NPIEN_",",.01)=DNDEATXT
 S FDA(1,200.5321,IEN_NPIEN_",",.02)=SUFFIX
 S FDA(1,200.5321,IEN_NPIEN_",",.03)=+DNDEAIEN
 D UPDATE^DIE("","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) Q "0^DATA DIDN'T FILE SUCCESSFULLY."
 Q "1^SUCCESSFULLY SAVED/UPDATED IN 200"
 ;
PROVTYPE(BA)  ; -- Calculate the Provider Type from the Business Activity Code.
 N RESULT S RESULT="1^INSTITUTIONAL"
 S:$G(BA)="" RESULT="2^INDIVIDUAL"
 S:$E(BA)="C" RESULT="2^INDIVIDUAL"
 S:$E(BA)="M" RESULT="2^INDIVIDUAL"
 Q RESULT
 ;
CONVNAME(CN)  ; -- Set up a NAME conversion array.
 S CN("additionalCompanyInfo")="COMPANY INFO"
 S CN("address1")="ADDRESS 1"
 S CN("address2")="ADDRESS 2"
 S CN("businessActivityCode")="ACTIVITY CODE"
 S CN("businessActivitySubcode")="ACTIVITY SUB"
 S CN("city")="CITY"
 S CN("deaNumber")="DEA NUMBER"
 S CN("drugSchedule")="DRUG SCHEDULE"
 S CN("expirationDate")="EXPIRATION DATE"
 S CN("name")="NAME"
 S CN("processedDate")="PROCESSED DATE"
 S CN("state")="STATE"
 S CN("type")="TYPE"
 S CN("zipCode")="ZIP CODE"
 Q
 ;
GETS(DEAIEN,GETS)  ; -- Get the existing data from the DEA NUMBERS FILE #8991.9
 N GETSTMP
 D GETS^DIQ(8991.9,DEAIEN,"**","","GETSTMP")
 M GETS=GETSTMP(8991.9,DEAIEN_",")
 Q
 ;
DEANUM(X) ; -- Check DEA # part
 N VA1,VA2
 S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 S VA1=VA1#10,VA2=$E(X,9)
 Q VA1=VA2
 ;
DEANUMFL(X) ;Check DEA # First Letter Part
 Q $S("ABCDEFGHIJKLMNOPQRSTUVWXYZ"[$E(X):1,1:0)
 ;
DUPCHK(RET,DEATXT,SUFFIX)  ; -- Check for duplicate DEA number or duplicate SUFFIX usage.
 ; INPUTS:  DEATXT - The text format of a DEA Number
 ;          SUFFIX - The DEA suffix for an Institutional DEA number
 I $G(DEATXT)="" S RET="0^No DEA number supplied" Q
 S SUFFIX=$G(SUFFIX)
 S RET="1^Success"
 I SUFFIX="",$D(^VA(200,"PS4",DEATXT)) S RET="0^Provider DEA number is already associated to another profile. Please check the number entered." Q
 I SUFFIX'="",$D(^VA(200,"F",DEATXT,SUFFIX)) S RET="0^Duplicate Usage of a SUFFIX" Q
 Q
 ;
DETOXCHK(BAC)  ; -- Test Business Activity Code for DEXTOX (DW)
 N BACIEN
 I $G(BAC)="" Q 0
 I '$D(^XTV(8991.8,"B",BAC)) Q 0
 S BACIEN=$O(^XTV(8991.8,"B",BAC,0)) I 'BACIEN Q 0
 I $$GET1^DIQ(8991.8,BACIEN,1)["DW/" Q 1
 Q 0
 ;
DETOXDUP(DEA,DETOX,DUPDEA)  ; -- Check for duplicate Detox number
 N I,NXTDET S NXTDEA=0,DUPDEA=""
 I $G(DETOX)=""!($G(DEA)="") Q 0                   ; Missing required input, can't check
 I '$D(^XTV(8991.9,"D",$G(DETOX))) Q 0             ; If Detox not on file, not a duplicate
 I $D(^XTV(8991.9,"D",$G(DETOX))),'$D(^XTV(8991.9,"D",$G(DETOX),$G(DEA))) D  Q 1  ; On file for another prescriber, duplicate
 .S DUPDEA=$O(^XTV(8991.9,"D",$G(DETOX),$G(DUPDEA)))
 F  S NXTDEA=$O(^XTV(8991.9,"D",DETOX,NXTDEA)) Q:NXTDEA=""  S DUPDEA=$S($G(DUPDEA)'="":DUPDEA_","_NXTDEA,1:NXTDEA)
 I $G(DUPDEA)'="" Q 1                                         ; If more than one entry on file for this Detox number, duplicate
 Q 0
 ;
MBM(RET) ; -- MEDS BY MAIL for ePCS GUI
 N SYS
 S RET=0
 S SYS=$$GET^XPAR("SYS^PKG","PSO VAMC MBM PHARMACY MODE",1,"E")
 I SYS="MBM" S RET=1
 Q
 ;
ENTRY(RESULT,INPUT) ; -- remoteprocedure
 NEW I,NOW
 SET NOW=$P($$HTE^XLFDT($H),":",1,2)
 FOR I=-1:0 SET I=$O(INPUT(I)) QUIT:I=""  DO RECORD(INPUT(I),NOW)
 SET RESULT=1
 QUIT
 ;
RECORD(LINE,NOW) ;
 N FDA,VALUE,IEN,MSG,I
 FOR I=1:1:5 SET VALUE=$P(LINE,U,I),FDA(8991.6,"+1,",(I/100))=VALUE
 SET FDA(8991.6,"+1,",.06)=NOW
 DO UPDATE^DIE("E","FDA","IEN","MSG")
 QUIT
 ;
CLEARDTX(NPIEN)  ; REMOVE DETOX NUMBERS FROM ALL OF A PROVIDERS DEA NUMBERS
 N DNDEAIEN,FDA,NPDEAIEN
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . K FDA S FDA(1,8991.9,DNDEAIEN_",",.03)="@" D UPDATE^DIE("","FDA(1)") K FDA
 Q
 ;
GETDNDTX(NPIEN,DNDEAX)  ; GET A SINGLE DETOX NUMBER FROM ALL OF A PROVIDERS DEA NUMBERS IN 8991.9
 N GETDNDTX,DNDEAIEN,NPDEAIEN S GETDNDTX=""
 K DNDEAX
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  Q:$L(GETDNDTX)  D
 . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I") Q:'DNDEAIEN
 . S GETDNDTX=$$GET1^DIQ(8991.9,DNDEAIEN_",",.03)
 . S DNDEAX=$$GET1^DIQ(8991.9,DNDEAIEN_",",.01)
 Q GETDNDTX
 ;
WSGET(FG,DEA) ; Function to Get the Remote DEA information, Return in FG.
 ; INPUT:   DEA      ;Properly formatted DEA Number for lookup.
 ;
 ; OUTPUT:  FG       ;Web Service Response Global
 ;
 ; RETURN:  Status code with a text message.
 ;          If not filled successfully a "0^Error Message" will be returned.
 ;
 Q $$WSGET^PSODEAU0(.FG,DEA)

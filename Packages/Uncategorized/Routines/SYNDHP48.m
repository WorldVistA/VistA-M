SYNDHP48 ; HC/PWC/art - HealthConcourse - retrieve patient medication data ;2019-11-05  10:18 AM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ; (c) 2017-2019 Perspecta
 ; (c) 2019 OSEHRA
 ; 
 ; Licensed under the Apache License, Version 2.0 (the "License");
 ; you may not use this file except in compliance with the License.
 ; You may obtain a copy of the License at
 ; 
 ; http://www.apache.org/licenses/LICENSE-2.0
 ; 
 ; Unless required by applicable law or agreed to in writing, software
 ; distributed under the License is distributed on an "AS IS" BASIS,
 ; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ; See the License for the specific language governing permissions and
 ; limitations under the License.
 ;
 ;
 Q
 ;
 ; ---------------- Get patient medication statement ----------------------------
PATMEDS(RETSTA,DHPICN,FRDAT,TODAT) ; Patient medication statement for ICN
 ;
 ; Return patient medication statement for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional
 ;   TODAT   - to date (inclusive), optional
 ; Output:
 ;   RETSTA  - a delimited string that lists the following information
 ;      PatientICN ^ RESOURSE ID ^ STATUS ^ MEDICATION ^ DATE ASSERTED; DATE STARTED; DATE ENDED
 ;      ^ CONDITION ^ DOSAGE , SITE ; ROUTE ; DOSE ^ QUANTITY ^ DAYS ^ RXN |
 ;
 ;   Identifier will be "V"_SITE ID_"_"_FILEMAN #_"_"_FILE IEN   i.e. V_500_55_930
 ;
STM ;
 ; ZEXCEPT: SYNDEBUG - print to screen
 ; ZEXCEPT: HTTPARGS,HTTPERR - Web Server variables
 N C,ACU,P,S,UL,D1,IDENT,ORDDAT,ORDNUM,ROUTE,STATUS,DOSORD,STDT,STDTFM,DRUG,SITE,SITEA,VUID
 N RETDESC,QTY,DAYS,RXN,IENS,IDATE,IDATEFM,RX,PATIEN,DRUGI
 S C=",",P="|",S=";",UL="_"
 N SITE S SITE=$$SITE^VASITE($$DT^XLFDT)
 ;
 ; Filter validation
 ;
 ; Id (e.g. V-999-52-2150, V-999-55-17-55.06-1)
 N QID,QIDMED,QIDMEDF ; ID, Med IENS, Medfile
 S QIDMEDF=""
 I $D(HTTPARGS("_id")) D  I $G(HTTPERR) QUIT
 . S QID=HTTPARGS("_id")
 . N P2,P3,P4,P5,P6
 . S P2=$P(QID,"-",2) ; 999
 . S P3=$P(QID,"-",3) ; 55
 . S P4=$P(QID,"-",4) ; 17
 . S P5=$P(QID,"-",5) ; 55.06
 . S P6=$P(QID,"-",6) ; 1
 . ;
 . ; Validate site
 . N STATION S STATION=$P(SITE,U,3)
 . I P2'=STATION D ERRMSG^SYNDHPUTL(400,"Condition not located at this site") QUIT
 . ;
 . ; Validate file and set QIDMED for query
 . I (U_52_U_55_U)'[(U_P3_U) D ERRMSG^SYNDHPUTL(400,"Only 52 and 55 are allowed") QUIT
 . S QIDMEDF=P3
 . I QIDMEDF=52,'$D(^PSRX(P4,0)) D ERRMSG^SYNDHPUTL(400,"Entry not found") QUIT
 . I QIDMEDF=55,'$D(^PS(55,P4,5,P6,0)) D ERRMSG^SYNDHPUTL(400,"Entry not found") QUIT
 . I QIDMEDF=52 S QIDMED=P4_C
 . I QIDMEDF=55 S QIDMED=P4_C_P6_C
 . ;
 . ; Get ICN
 . N DFN
 . I P3=52 S DFN=$P(^PSRX(P4,0),U,2)
 . I P3=55 S DFN=P4
 . S DHPICN=$$GETICN^MPIF001(DFN) ; ICR 2701
 ;
 N QSTATUS,QVSTATUS,QUNREL ; Status, VistA Status, Unreleased?
 I $D(HTTPARGS("status")) D  I $G(HTTPERR) QUIT
 . S QSTATUS=HTTPARGS("status")
 . ; Supported FHIR statuses: active | completed | entered-in-error (op only) | stopped | on-hold | not-taken (op only)
 . ; Unsupported statuses:    intended | unknown
 . I "^active^completed^entered-in-error^stopped^on-hold^not-taken^"'[(U_QSTATUS_U) D ERRMSG^SYNDHPUTL(400,"Status Search not supported with "_QSTATUS) QUIT
 . I QSTATUS="active"    S QVSTATUS="ACTIVE"
 . I QSTATUS="completed" S QVSTATUS="EXPIRED"
 . I QSTATUS="entered-in-error" S QVSTATUS="DELETED"
 . I QSTATUS="stopped"   S QVSTATUS="DISCONTINUED"
 . I QSTATUS="on-hold"   S QVSTATUS="HOLD"
 . I QSTATUS="not-taken" S QUNREL=1  ; Unreleased
 ;
 ; Effective [Date]
 N QEFF
 N QEFFREV S QEFFREV=0 ; Reverse condition
 I $D(HTTPARGS("effective")) D  I $G(HTTPERR) QUIT
 . S QEFF=HTTPARGS("effective")
 . D SETFRTO^SYNDHPUTL(QEFF,.FRDAT,.TODAT,.QEFFREV)
 ;
 ; validate ICN
 I $G(DHPICN)="",$D(HTTPARGS("patient")) S DHPICN=HTTPARGS("patient")
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETDESC=""
 S SITE=$P($$SITE^VASITE,U,3)
 N SYNCNT S SYNCNT=0
 S RETSTA=$NA(^TMP($T(+0),$J))
 K @RETSTA
 S SYNCNT=SYNCNT+1
 S @RETSTA@(SYNCNT)=DHPICN_U
 ;
 D STMUD Q:(QIDMEDF=55)  ; Unit Dose
 D STMOP Q:(QIDMEDF=52)  ; Outpatient
 ;
 QUIT
 ;
STMUD ; [Private] /MedicationStatement Unit Dose
 ; ZEXCEPT: RETSTA,PATIEN,C,P,S,SITE,SYNCNT,SYNDEBUG
 ; ZEXCEPT: QIDMED,QIDMEDF,QVSTATUS,QUNREL,QEFF,QEFFREV - Filters
 ; ZEXCEPT: SDTFM,FRDAT,TODAT
 N D1 S D1=0
 I QIDMEDF=55 S D1=$P(QIDMED,C,2)
 D:QIDMEDF=55  Q:QIDMEDF  F  S D1=$O(^PS(55,PATIEN,5,D1)) Q:'D1  D
 .; filter on "not taken". Only applies to Outpatient.
 .I $G(QUNREL) QUIT
 .; end
 .N IENS S IENS=D1_C_PATIEN_C
 .N MEDX,MEDERR
 .D GETS^DIQ(55.06,IENS,".01;3;10;28;27;34","IEN","MEDX","MEDERR")
 .QUIT:$D(MEDERR)
 .N STATUS S STATUS=$G(MEDX(55.06,IENS,28,"E"))    ; status
 .; status filter
 .I $D(QVSTATUS),STATUS'[QVSTATUS QUIT
 .; end filter
 .N ORDNUM S ORDNUM=$G(MEDX(55.06,IENS,.01,"E"))   ; order number
 .; route is most likely not stored in vista as SCT code, but should check this
 .N ROUTE S ROUTE=$G(MEDX(55.06,IENS,3,"E"))      ; route
 .N DOSORD S DOSORD=$P($G(^PS(55,PATIEN,5,D1,.2)),U,2)          ; dosage ordered
 .N SDTFM S SDTFM=$G(MEDX(55.06,IENS,10,"I"))      ; start date
 .I $D(SYNDEBUG),$D(QEFF) W SDTFM," ",FRDAT," ",TODAT," ",QEFFREV," ",$$RANGECK^SYNDHPUTL(SDTFM,FRDAT,TODAT,QEFFREV),!
 .I $D(QEFF) QUIT:'$$RANGECK^SYNDHPUTL(SDTFM,FRDAT,TODAT,QEFFREV)    ;quit if outside of requested date range
 .N ODTFM S ODTFM=$G(MEDX(55.06,IENS,27,"I"))       ; order date
 .N EDTFM S EDTFM=$G(MEDX(55.06,IENS,34,"I"))       ; stop date
 .N ODTHL7 S ODTHL7=$$FMTHL7^XLFDT(ODTFM)      ; order date
 .N SDTHL7 S SDTHL7=$$FMTHL7^XLFDT(SDTFM)      ; start date
 .N EDTHL7 S EDTHL7=$$FMTHL7^XLFDT(EDTFM)      ; end date
 .N DRUG S DRUG=$$GET1^DIQ(55.07,1_C_IENS,.01,"E")  ; medication
 .N DRUGI S DRUGI=$$GET1^DIQ(55.07,1_C_IENS,.01,"I")
 .I DRUGI="" QUIT  ; Bad data
 .N RXN,VUID S RXN=$$GETRXN^SYNDHPUTL(DRUGI)
 .I RXN S RXN="RXN"_RXN
 .E  S VUID=$$GETVUID(DRUGI) I VUID S RXN="VUID"_VUID
 .E  S RXN="DRUG"_DRUGI
 .N IDENT S IDENT=$$RESID^SYNDHP69("V",SITE,55,PATIEN,55.06_U_D1)
 .N DAYS S DAYS=""
 .N QTY S QTY=""
 .N SITEA S SITEA=""
 .S SYNCNT=SYNCNT+1
 .S @RETSTA@(SYNCNT)=IDENT_U_STATUS_U_DRUG_U_ODTHL7_S_SDTHL7_S_EDTHL7_U_"REASON"_U_SITEA_S_ROUTE_S_DOSORD_U_QTY_U_DAYS_U_RXN_P
 QUIT
 ;
STMOP ; [Private] /MedicationStatement Outpatient
 ; ZEXCEPT: RETSTA,PATIEN,C,P,S,SITE,SYNCNT,SYNDEBUG
 ; ZEXCEPT: QIDMED,QIDMEDF,QVSTATUS,QUNREL,QEFF,QEFFREV - Filters
 ; ZEXCEPT: SDTFM,FRDAT,TODAT
 N D1 S D1=0
 N RX
 I QIDMEDF=52 S RX=$P(QIDMED,C)
 D:QIDMEDF=52  Q:QIDMEDF  F  S D1=$O(^PS(55,PATIEN,"P",D1)) Q:'D1  S RX=$G(^PS(55,PATIEN,"P",D1,0)) D
 . N MEDX,MEDERR
 . D GETS^DIQ(52,RX_",",".01;1;2;6;7;8;100;26;22;31","IEN","MEDX","MEDERR")
 . N STATUS S STATUS=$G(MEDX(52,RX_",",100,"E"))  ;status
 . ; status filter
 . I $D(QVSTATUS),STATUS'[QVSTATUS QUIT
 . ; end filter
 . QUIT:$D(MEDERR)
 . N IDATEFM S IDATEFM=$G(MEDX(52,RX_",",1,"I"))     ;issue date
 . N FDATEFM S FDATEFM=$G(MEDX(52,RX_",",22,"I"))    ;fill date
 . I $D(SYNDEBUG),$D(QEFF) W FDATEFM," ",FRDAT," ",TODAT," ",QEFFREV," ",$$RANGECK^SYNDHPUTL(FDATEFM,FRDAT,TODAT,QEFFREV),!
 . I $D(QEFF),'FDATEFM QUIT                                             ;filter but med hasn't beeen filled yet
 . I $D(QEFF) QUIT:'$$RANGECK^SYNDHPUTL(FDATEFM,FRDAT,TODAT,QEFFREV)    ;quit if outside of requested date range
 . N EDATEFM S EDATEFM=$G(MEDX(52,RX_",",26,"I"))    ;expiration date
 . N RDATEFM S RDATEFM=$G(MEDX(52,RX_",",31,"I"))    ;release date
 . ; status filter 2 - not taken (i.e. unreleased medication. If released, quit.)
 . I $G(QUNREL),RDATEFM QUIT
 . ; end status filter 2
 . I 'RDATEFM S STATUS="UNRELEASED"                  ;override status if unreleased
 . N IDATE S IDATE=$$FMTHL7^XLFDT(IDATEFM)           ;issue date HL7
 . N SDATE S SDATE=$$FMTHL7^XLFDT(FDATEFM)           ;start date HL7
 . N EDATE S EDATE=$$FMTHL7^XLFDT(EDATEFM)           ;end date hl7
 . N DRUG S DRUG=$G(MEDX(52,RX_",",6,"E"))           ;medication
 . N DRUGI S DRUGI=$G(MEDX(52,RX_",",6,"I"))
 . I DRUGI="" QUIT  ; Bad data
 . N RXN,VUID S RXN=$$GETRXN^SYNDHPUTL(DRUGI)
 . I RXN S RXN="RXN"_RXN
 . E  S VUID=$$GETVUID(DRUGI) I VUID S RXN="VUID"_VUID
 . E  S RXN="DRUG"_DRUGI
 . N QTY S QTY=$G(MEDX(52,RX_",",7,"E"))       ;quantity
 . N DAYS S DAYS=$G(MEDX(52,RX_",",8,"E"))      ;days supply
 . N ROUTE S ROUTE=$$GET1^DIQ(52.0113,"1,"_RX_",",6,"EN")  ;route
 . N SITEA S SITEA=""
 . N DOSORD S DOSORD=""                        ; TODO: Fill this
 . N IDENT S IDENT=$$RESID^SYNDHP69("V",SITE,52,RX)
 . S SYNCNT=SYNCNT+1
 . S @RETSTA@(SYNCNT)=IDENT_U_STATUS_U_DRUG_U_IDATE_S_SDATE_S_EDATE_U_"REASON"_U_SITEA_S_ROUTE_S_DOSORD_U_QTY_U_DAYS_U_RXN_P
 QUIT
 ;
 ; ---------------- Get patient medication administration ----------------------------
PATMEDA(RETSTA,DHPICN,FRDAT,TODAT) ; Patient medication administration for ICN
 ;
 ; Return patient medication administration for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional
 ;   TODAT   - to date (inclusive), optional
 ; Output:
 ;   RETSTA  - a delimited string that lists the following information
 ;      PatientICN ^ RESOURSE ID ^ STATUS ^ MEDICATION ^ DATE ASSERTED ^ CONDITION
 ;      ^ DOSAGE , SITE ; ROUTE ; DOSE ^ QUANTITY ^ DAYS ^ RXN |
 ;
 ;   Identifier will be "V"_SITE ID_"_"_FILEMAN #_"_"_FILE IEN   i.e. V_500_55_930
 ;
 ; validate ICN
 ; ZEXCEPT: SYNDEBUG - print to screen
STA ;
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(SYNDEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 N C,ACU,P,S,UL,D1,IDENT,ORDDAT,ORDNUM,ROUTE,STATUS,DOSORD,STDT,STDTFM,DRUG,SITE,IENS
 N RETDESC,SITEA,QTY,DAYS,RXN,IDATE,IDATEFM,PATIEN,DRUGI,RX
 S C=",",P="|",S=";",UL="_"
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETDESC=""
 S SITE=$P($$SITE^VASITE,U,3)
 S RETSTA=""
 ; loop through the PHARMACY PATIENT file #55 (^PS(55)) for patient (this will contain both IP and OP orders)
 ;
 ; this is start of Inpatient Orders
 S D1=0
 F  S D1=$O(^PS(55,PATIEN,5,D1)) Q:D1'?1N.N  D
 .S IENS=D1_C_PATIEN_C
 .S (ORDDAT,ORDNUM,ROUTE,STATUS,DOSORD,STDT,STDTFM,DRUG,SITEA,QTY,DAYS,RXN)=""
 .N MEDX,MEDERR
 .D GETS^DIQ(55.06,IENS,".01;3;10;28","IEN","MEDX","MEDERR")
 .QUIT:$D(MEDERR)
 .S ORDNUM=$G(MEDX(55.06,IENS,.01,"E"))   ; order number
 .; route is most likely not stored in vista as SCT code, but should check this
 .S ROUTE=$G(MEDX(55.06,IENS,3,"E"))      ; route
 .S STATUS=$G(MEDX(55.06,IENS,28,"E"))    ; status
 .S DOSORD=$P($G(^PS(55,PATIEN,5,D1,.2)),U,2)          ; dosage ordered
 .S STDTFM=$G(MEDX(55.06,IENS,10,"I"))      ; start date
 .QUIT:((STDTFM\1)<FRDAT)!((STDTFM\1)>TODAT)  ;quit if outside of requested date range
 .S STDT=$$FMTHL7^XLFDT($G(MEDX(55.06,IENS,10,"I")))      ; start date
 .S DRUG=$$GET1^DIQ(55.07,1_C_IENS,.01,"E")  ; medication
 .S DRUGI=$$GET1^DIQ(55.07,1_C_IENS,.01,"I")
 .S RXN=$$GETRXN^SYNDHPUTL(DRUGI)
 .I RXN?1.N S RXN="RXN"_RXN
 .S IDENT=$$RESID^SYNDHP69("V",SITE,55,PATIEN,55.06_U_D1)
 .S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(STDT)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_$G(QTY)_U_$G(DAYS)_U_$G(RXN)_P
 ;
 ; start here for outpatient orders
 S D1=0
 F  S D1=$O(^PS(55,PATIEN,"P",D1)) Q:D1'?1N.N  D
 . S RX=$G(^PS(55,PATIEN,"P",D1,0))
 . S (IDENT,IDATE,DRUG,QTY,DAYS,STATUS,ROUTE)=""
 . N MEDX,MEDERR
 . D GETS^DIQ(52,RX_",",".01;1;2;6;7;8;100","IEN","MEDX","MEDERR")
 . QUIT:$D(MEDERR)
 . S IDENT=$$RESID^SYNDHP69("V",SITE,52,RX)
 . S IDATEFM=$G(MEDX(52,RX_",",1,"I"))     ;issue date
 . QUIT:((IDATEFM\1)<FRDAT)!((IDATEFM\1)>TODAT)  ;quit if outside of requested date range
 . S IDATE=$$FMTHL7^XLFDT($G(MEDX(52,RX_",",1,"I")))     ;issue date
 . S DRUG=$G(MEDX(52,RX_",",6,"E"))      ;medication
 . S DRUGI=$G(MEDX(52,RX_",",6,"I"))
 . S RXN=$$GETRXN^SYNDHPUTL(DRUGI)
 . I RXN?1.N S RXN="RXN"_RXN
 . S QTY=$G(MEDX(52,RX_",",7,"E"))       ;quantity
 . S DAYS=$G(MEDX(52,RX_",",8,"E"))      ;days supply
 . S STATUS=$G(MEDX(52,RX_",",100,"E"))  ;status
 . S ROUTE=$$GET1^DIQ(52.0113,"1,"_RX_",",6,"EN")  ;route
 . S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(IDATE)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_$G(QTY)_U_$G(DAYS)_U_$G(RXN)_P
 S RETSTA=DHPICN_U_RETDESC
 Q
 ;
 ; ---------------- Get patient medication dispense ----------------------------
 ;
PATMEDD(RETSTA,DHPICN,FRDAT,TODAT) ; Patient medication dispense for ICN
 ;
 ; Return patient medication dispense for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional
 ;   TODAT   - to date (inclusive), optional
 ; Output:
 ;   RETSTA  - a delimited string that lists the following information
 ;      PatientICN ^ RESOURSE ID ^ STATUS ^ MEDICATION ^ DATE ASSERTED ^ CONDITION
 ;      ^ DOSAGE , SITE ; ROUTE ; DOSE ^ QUANTITY ^ DAYS ^ RXN |
 ;
 ;   Identifier will be "V"_SITE ID_"_"_FILEMAN #_"_"_FILE IEN   i.e. V_500_55_930
 ;
 ; ZEXCEPT: SYNDEBUG - print to screen
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(SYNDEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 N C,ACU,P,S,UL,D1,IDENT,ORDDAT,ORDNUM,ROUTE,STATUS,DOSORD,STDT,STDTFM,DRUG,SITEA
 N RETDESC,SITE,QTY,DAYS,RXN,PATIEN,RX
 S C=",",P="|",S=";",UL="_"
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETDESC=""
 S SITE=$P($$SITE^VASITE,U,3)
 S RETSTA=""
 ; loop through the PHARMACY PATIENT file #55 (^PS(55)) for patient (this will contain both IP and OP orders).
 ; OP orders will need to get additional information from the PRESCRIPTION file #52 (^PSRX)
 S D1=0
 F  S D1=$O(^PS(55,PATIEN,5,D1)) Q:D1'?1N.N  D
 .N IENS S IENS=D1_C_PATIEN_C
 .S (ORDDAT,ORDNUM,ROUTE,STATUS,DOSORD,STDT,STDTFM,DRUG,SITEA,QTY,DAYS,RXN)=""
 .N MEDX,MEDERR
 .D GETS^DIQ(55.06,IENS,".01;3;10;28","IEN","MEDX","MEDERR")
 .QUIT:$D(MEDERR)
 .S ORDNUM=$G(MEDX(55.06,IENS,.01,"E"))   ; order number
 .; route is most likely not stored in vista as SCT code, but should check this
 .S ROUTE=$G(MEDX(55.06,IENS,3,"E"))      ; route
 .S STATUS=$G(MEDX(55.06,IENS,28,"E"))    ; status
 .S DOSORD=$P($G(^PS(55,PATIEN,5,D1,.2)),U,2)          ; dosage ordered
 .S STDTFM=$G(MEDX(55.06,IENS,10,"I"))      ; start date
 .QUIT:'$$RANGECK^SYNDHPUTL(STDTFM,FRDAT,TODAT)  ;quit if outside of requested date range
 .S STDT=$$FMTHL7^XLFDT($G(MEDX(55.06,IENS,10,"I")))      ; start date
 .S DRUG=$$GET1^DIQ(55.07,1_C_IENS,.01,"E")  ; medication
 .N DRUGI S DRUGI=$$GET1^DIQ(55.07,1_C_IENS,.01,"I")
 .S RXN=$$GETRXN^SYNDHPUTL(DRUGI)
 .I RXN?1.N S RXN="RXN"_RXN
 .S IDENT=$$RESID^SYNDHP69("V",SITE,55,PATIEN,55.06_U_D1)
 .S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(STDT)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_$G(QTY)_U_$G(DAYS)_U_$G(RXN)_P
 ;
 S RETSTA=DHPICN_U_RETDESC
 Q
 ;
GETVUID(X) ; [Public] Get VUID for drug
 Q $$GET1^DIQ(50,X,"22:99.99")
 ;
 ;
 ;
 ;Statement
 ;IP S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(STDT)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_QTY_U_DAYS_U_RXN_P
 ;OP S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(IDATE)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_QTY_U_DAYS_U_RXN_P
 ;Administer
 ;IP S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(STDT)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_QTY_U_DAYS_U_RXN_P
 ;OP S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(IDATE)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_QTY_U_DAYS_U_RXN_P
 ;Dispense
 ;IP S RETDESC=RETDESC_$G(IDENT)_U_$G(STATUS)_U_$G(DRUG)_U_$G(STDT)_U_"REASON"_U_$G(SITEA)_S_$G(ROUTE)_S_$G(DOSORD)_U_QTY_U_DAYS_U_$G(RXN)_P

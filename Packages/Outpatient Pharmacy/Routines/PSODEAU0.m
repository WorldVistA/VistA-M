PSODEAU0 ;ALB/BI - DEA MANUAL ENTRY ;05/15/2018
 ;;7.0;OUTPATIENT PHARMACY;**529,684**;DEC 1997;Build 57
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA BUSINESS ACTIVITY CODES file (#8991.8) is supported by DBIA 7001
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to DEA NUMBERS file (#8991.6) is supported by DBIA 7015
 ;References to Cache methods class.HttpResponse, class.Data, class.AtEnd, class.ReadLine() are supported by SAC exemption 20210601-01
 Q
 ;
DETOXDUP(DEA,DETOX,DUPDEA)  ; -- Test Business Activity Code for DEXTOX (DW)
 N I,NXTDET S NXTDEA=0,DUPDEA=""
 I $G(DETOX)=""!($G(DEA)="") Q 0                   ; Missing required input, can't check
 I '$D(^XTV(8991.9,"D",$G(DETOX))) Q 0             ; If Detox not on file, not a duplicate
 I $D(^XTV(8991.9,"D",$G(DETOX))),'$D(^XTV(8991.9,"D",$G(DETOX),$G(DEA))) D  Q 1  ; On file for another prescriber, duplicate
 .S DUPDEA=$O(^XTV(8991.9,"D",$G(DETOX),$G(DUPDEA)))
 F  S NXTDEA=$O(^XTV(8991.9,"D",DETOX,NXTDEA)) Q:NXTDEA=""  S DUPDEA=$S($G(DUPDEA)'="":DUPDEA_","_NXTDEA,1:NXTDEA)
 I $G(DUPDEA)'="" Q 1                                         ; If more than one entry on file for this Detox number, duplicate
 Q 0
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
 N PSOECODE  ;Error Code
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
 S SC=$$GETXOBW(REQUEST,RESOURCE,.PSOERR,.PSOECODE)
 ;
 ;S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 ;I 'SC S PSOECODE=PSOERR.code
 ;
 ; Handle a "DEA NOT FOUND" gracefully.
 I 'SC I PSOECODE=404 Q "0^DEA NUMBER NOT FOUND. Please enter a valid DEA number."
 ; Handle a connection error gracefully.
 I 'SC I PSOECODE=6059 Q "0^UNABLE TO ESTABLISH A CONNECTION TO "_SERVER_"^6059"
 I 'SC Q "0^General Service Error"_$S($G(PSOECODE)]"":"^"_$G(PSOECODE),1:"")
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
 ; Define LAST DOJ UPDATE DATE/TIME 
 S FG("processedDate")=DT
 S:'$D(FG("address2")) FG("address2")=""
 ; 
 ; Define the TYPE field
 S FG("type")=$P($$PROVTYPE^PSODEAUT(FG("businessActivityCode")),"^",2)
 ;
 ; Default the businessActivitySubcode.
 I $G(FG("businessActivitySubcode"))="" S FG("businessActivitySubcode")=0
 ;
 Q "1^Success"
 ;
DTXDUPIT(DEA,DETOX,NPIEN)  ; Check for DETOX # on file for another provider
 N DUP,DUPDEA,DTXDEAPC,DEANXT,DUPMSG
 S DUP=0,DUPMSG=0
 Q:($L($G(DEA))'=9)!($G(DETOX)="")!'$G(NPIEN) 0
 S DUP=$$DETOXDUP^PSODEAU0(DEA,DETOX,.DUPDEA)
 I DUP,($G(DUPDEA)=DEA) Q 0
 F DTXDEAPC=1:1:99 S DEANXT=$P(DUPDEA,",",DTXDEAPC) Q:DEANXT=""  D
 .N PSOPROV S PSOPROV=0 F  S PSOPROV=$O(^VA(200,"PS4",DEANXT,PSOPROV)) Q:'PSOPROV  D
 ..Q:PSOPROV=NPIEN
 ..N PSOPRVNM S PSOPRVNM=$$GET1^DIQ(200,PSOPROV_",",.01)
 ..I 'DUPMSG W !!,"DETOX NUMBER "_$G(DETOX)_" ALREADY ASSIGNED TO "_PSOPRVNM S DUPMSG=1
 ..W !,"(IEN: ",PSOPROV,", DEA NUMBER: "_DEANXT_") AND CANNOT BE ASSIGNED"
 ..W !," TO THIS PROVIDER."
 Q DUP
 ;
GETXOBW(REQUEST,RESOURCE,PSOERR,PSOECODE) ; Execute the HTTP Get method.
 K PSOECODE S PSOECODE=""
 S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 I 'SC S PSOECODE=PSOERR.code
 Q SC

SDECPRVSRCHJSON ;ALB/LAB,TAW - Get Providers based on Search String ;DEC 17, 2021
 ;;5.3;Scheduling;**797,800,804**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 Q
 ;
JSONPRVLIST(SDPRVJSON,SDSRCHSTR) ;Search PROVIDERS and get data needed to make VIDEO VISIT SERVICE (VVS) Appointment
 ;INPUT - SDSRCHSTR (Search String)
 ;RETURN PARMETER:
 ; List of Providers from NEW PERSON (#200) File. Data is delimited by carat (^).
 ; Field List:
 ; (1)     Provider Name
 ; (2)     Provider IEN
 ; (3)     Primary Phone
 ; (4)     Email Address
 ; (5)     Title
 ; (6)     Provider Class
 ;
 N PROVIDERNAME,STRINGLENGTH,SDPRVSREC,ERRPOP,ERR,ERRMSG,SDECI
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D BLDPRVREC
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0
 S SDECI=$G(SDECI,0),ERR=""
 S STRINGLENGTH=$L(SDSRCHSTR)
 S PROVIDERNAME=$O(^VA(200,"B",SDSRCHSTR),-1)
 I $E(PROVIDERNAME,1,SDSRCHSTR)=SDSRCHSTR D
 .S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME),-1)
 S ERRPOP=0,SDECI=0,ERRMSG=""
 Q
 ;
VALIDATE ; validate incoming parameters
 I $L(SDSRCHSTR)<2 D
 . ;create error message - Search String must be at least 2 characters
 . D ERRLOG^SDESJSON(.SDPRVSREC,64)
 . S ERRPOP=1
 Q
 ;
BLDJSON ;
 D ENCODE^SDESJSON(.SDPRVSREC,.SDPRVJSON,.ERR)
 K SDPRVSREC
 Q
 ;
BLDPRVREC ;Build a list of Providers
 ;
 N VVSPROVIDER,PROVIDERIEN,TERMDATE,SDPOP
 F  S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME)) Q:PROVIDERNAME=""!($E(PROVIDERNAME,1,STRINGLENGTH)'=SDSRCHSTR)  D
 .I SDECI>49 Q
 .S (VVSPROVIDER,PROVIDERIEN)=""
 .F  S PROVIDERIEN=$O(^VA(200,"B",PROVIDERNAME,PROVIDERIEN)) Q:PROVIDERIEN=""  D
 ..S TERMDATE=$$GET1^DIQ(200,PROVIDERIEN,9.2,"I")
 ..S SDPOP=0
 ..I TERMDATE'="" D
 ... S:TERMDATE<DT SDPOP=1
 ..I ($$GET1^DIQ(200,PROVIDERIEN,7,"I")'=1)&('SDPOP)  D
 ...D GETPROINFO^SDECVVS(.VVSPROVIDER,PROVIDERIEN)
 ...I VVSPROVIDER'="" D
 ....S SDECI=SDECI+1
 ....S SDPRVSREC("Provider",SDECI,"IEN")=$P(VVSPROVIDER,"^",1)
 ....S SDPRVSREC("Provider",SDECI,"Name")=$P(VVSPROVIDER,"^",2)
 ....S SDPRVSREC("Provider",SDECI,"Email")=$P(VVSPROVIDER,"^",3)
 ....S SDPRVSREC("Provider",SDECI,"Cell")=$P(VVSPROVIDER,"^",4)
 ....S SDPRVSREC("Provider",SDECI,"Title")=$P(VVSPROVIDER,"^",5)
 ....S SDPRVSREC("Provider",SDECI,"ProviderClass")=$P(VVSPROVIDER,"^",6)
 I '$D(SDPRVSREC("Provider")) S SDPRVSREC("Provider")=""
 I SDECI=0 D
 . ;create error message - No Providers found that match Search String
 . D ERRLOG^SDESJSON(.SDPRVSREC,65)
 . S ERRPOP=1
 Q
 ;

SDES2RECPRVSRCH  ;ALB/TJB,TAW - VISTA SCHEDULING RECALL PROVIDER USER SEARCH RPC; AUG 25, 2025
 ;;5.3;Scheduling;**880,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVE^XUSER is supported by ICR #2343
 ; Reference to DUZ^XUP is supported by IA #7487
 Q
 ; RPC = SDES2 SEARCH RECALL PROVIDERS
RECPROVSEARCH(RESULT,SDCONTEXT,SDINPUT) ;Search for Healthcare Providers and provide return of providers in JSON STRING
 ;INPUT - SDINPUT("SEARCHSTRING") = free text string that represents the provider name that will be searched
 ;OUTPUT - RETURN in JSON format
 ; List of active Providers from the RECALL REMINDERS PROVIDERS (#403.54) file with data pulled from the NEW PERSON (#200) File.
 ;
 N USERLIST,ERRORS,PROVIDERETURN,SEARCHSTRING
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Provider",1)="" D BUILDJSON^SDES2JSON(.RESULT,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 S SEARCHSTRING=$$VALIDATE(.ERRORS,$G(SDINPUT("SEARCHSTRING")))
 I $D(ERRORS) D BUILDJSON^SDES2JSON(.RESULT,.ERRORS) Q
 D GETPROVLIST(SEARCHSTRING,.USERLIST)
 D BUILDRETURN(.USERLIST,.PROVIDERETURN)
 D BUILDJSON^SDES2JSON(.RESULT,.PROVIDERETURN)
 Q
 ;
VALIDATE(ERRORLIST,SEARCHSTRING) ; validate incoming parameters
 ; input - ERRORLIST = passed in by reference, represents the errors that could be generated when validating the searchstring
 ;         SEARCHSTRING = represents the name or partial name of the provider
 ; returns search string
 I ($L(SEARCHSTRING)<3)!($L(SEARCHSTRING)>35) D  Q ""
 . D ERRLOG^SDES2JSON(.ERRORLIST,230)
 . S ERRORLIST("Provider",1)=""
 Q SEARCHSTRING
 ;
GETPROVLIST(SEARCHSTRING,USERLIST) ; pull matching providers using the first input parameter passed in by the RPC
 ; Input - SEARCHSTRING = string that represents the name of the person
 ;         USERLIST = passed in by reference; represents the array that will be returned as output
 ; Output - USERLIST = list of USER names and internal entry numbers from NEW PERSON file (200)
 N IEN40354,RESULTS,SUB3,USERDUZ,USRISACTIVE,USERLOC,USERTEAM,CNT
 K USERLIST
 S SUB3=0,CNT=1
 D FIND^DIC(403.54,,"@;.01IE;1IE;2IE;5IE","B",SEARCHSTRING,,,,,"RESULTS")
 F  S SUB3=$O(RESULTS("DILIST",2,SUB3)) Q:SUB3=""  D
 . S IEN40354=RESULTS("DILIST",2,SUB3)
 . Q:$G(RESULTS("DILIST","ID",SUB3,5,"I"))="I"
 . S USERDUZ=$G(RESULTS("DILIST","ID",SUB3,.01,"I"))
 . S USRISACTIVE=$$ACTIVE^XUSER(USERDUZ) ;check if user is not TERMINATED or DIUSER'ed or User cannot sign-on (no AC/VC assigned)
 . Q:$P(USRISACTIVE,"^")'=1  ;Quit if User is TERMINATED or DIUSER'ed or User cannot sign-on (no AC/VC assigned)
 .;SD*5.3*827
 . S USERTEAM=$G(RESULTS("DILIST","ID",SUB3,1,"E"))
 . S USERLOC=$G(RESULTS("DILIST","ID",SUB3,2,"E"))
 . S USERLIST(CNT)=USERDUZ_"^"_USERTEAM_"^"_USERLOC_"^"_IEN40354
 . S CNT=CNT+1
 Q
 ;
BUILDRETURN(PROVIDERLIST,PROVIDERETURN) ;Build return array with provider data
 ; input - PROVIDERLIST = array of active providers
 ;         PROVIDERETURN = passed by reference, represents the array of providers and associated data that will be returned to the client
 ; output - PROVIDERETURN = provider array and their associated data to be sent back to the client
 ;
 N PROVIDERDATA,IEN,IENS,RECORDNUMBER,INFO,CNT
 K INFO
 S (RECORDNUMBER,IEN,CNT)=0
 F  S CNT=$O(PROVIDERLIST(CNT)) Q:'CNT  S IEN=$P(PROVIDERLIST(CNT),"^",1) D GETS^DIQ(200,IEN_",",".01;.131:.138;.151;8;53.5;205.1","IE","INFO") D
 . S RECORDNUMBER=RECORDNUMBER+1
 . S PROVIDERETURN("Provider",RECORDNUMBER,"IEN")=IEN
 . S PROVIDERETURN("Provider",RECORDNUMBER,"RecallProviderIEN")=$P(PROVIDERLIST(CNT),"^",4)
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Name")=INFO(200,IEN_",",.01,"E")
 . ;
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Team")=$P(PROVIDERLIST(CNT),"^",2)
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Division")=$P(PROVIDERLIST(CNT),"^",3)
 . ;
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Homephone")=INFO(200,IEN_",",.131,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Officephone")=INFO(200,IEN_",",.132,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Phone3")=INFO(200,IEN_",",.133,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Phone4")=INFO(200,IEN_",",.134,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"CommercialPhone")=INFO(200,IEN_",",.135,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Fax")=INFO(200,IEN_",",.136,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"VoicePager")=INFO(200,IEN_",",.137,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"DigitalPager")=INFO(200,IEN_",",.138,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Email")=INFO(200,IEN_",",.151,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Title")=INFO(200,IEN_",",8,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"ProviderClass")=INFO(200,IEN_",",53.5,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"ProviderSecID")=INFO(200,IEN_",",205.1,"E")
 . S PROVIDERETURN("Provider",RECORDNUMBER,"PersonClass",1)=""
 . S PROVIDERETURN("Provider",RECORDNUMBER,"UserClass",1)=""
 . S IENS=0 F  S IENS=$O(^VA(200,IEN,"USC1",IENS)) Q:'IENS  D
 . . S PROVIDERETURN("Provider",RECORDNUMBER,"PersonClass",IENS)=$$GET1^DIQ(200.05,IENS_","_IEN_",",.01)
 . S IENS=0 F  S IENS=$O(^VA(200,IEN,"USC3",IENS)) Q:'IENS  D
 . . S PROVIDERETURN("Provider",RECORDNUMBER,"UserClass",IENS)=$$GET1^DIQ(200.07,IENS_","_IEN_",",.01)
 I '$D(PROVIDERETURN("Provider")) S PROVIDERETURN("Provider",1)=""
 Q

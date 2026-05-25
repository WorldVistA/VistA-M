SDESPROVSEARCH ;BAYPINES/KML,MGD,JAS,LAB - Get Provider based on Search String ;Apr 17, 2025
 ;;5.3;Scheduling;**819,826,877,906**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 ; Reference to $$ACTIVE^XUSER is supported by IA #2343
 Q
 ; rpc = SDES SEARCH PROVIDERS
 ; rewrote much of the RPC logic to loop through DUZ only once and to remove extra function calls. 
 ; removed the $$FIND with the "B" cross reference loop as the $$FIND was increasing response times dramatically
PROVIDERSEARCH(JSONRETURN,SEARCHSTRING) ;Search for Healthcare Providers and provide return of providers in JSON STRING
 ;INPUT - SEARCHSTRING = free text string that represents the provider name that will be searched
 ;OUTPUT - JSONRETURN
 ; List of Providers from NEW PERSON (#200) File.
 ; Field List:
 ; (1)     Provider Name
 ; (2)     Provider IEN
 ; (3)     Office Phone
 ; (4)     Email Address
 ; (5)     Title
 ; (6)     Provider Class
 ; (7)     Security ID (SECID)
 ; (8)     Fax
 ; (9)     Home Phone
 ; (10)    Commercial Phone
 ; (11)    Digital Pager
 ; (12)    Voice Pager
 ; (13)    Person Class
 ; (14)    Provider Class
 ; (15)    User Class
 ;
 ;
 N USERLIST,ERROREXISTS,ERRORS,PROVIDERETURN,PROVIDERLIST
 K JSONRETURN
 S SEARCHSTRING=$G(SEARCHSTRING)
 S SEARCHSTRING=$TR(SEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 D VALIDATE(.ERRORS,SEARCHSTRING)
 I $D(ERRORS) S ERRORS("Provider",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 D NEWPROVLIST(SEARCHSTRING,.PROVIDERLIST)
 D BUILDRETURN(.PROVIDERLIST,.PROVIDERETURN)
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.PROVIDERETURN)
 Q
 ;
VALIDATE(ERRORS,SEARCHSTRING) ; validate incoming parameters
 ; input - ERRORS = passed in by reference, represents the errors that could be generated when validating the searchstring
 ;         SEARCHSTRING = represents the name or partial name of the provider
 ; returns 0 or 1
 ; 0 = no validation errors
 ; 1 = validation errors
 I ($L(SEARCHSTRING)<3)!($L(SEARCHSTRING)>35) D  Q 1
 . D ERRLOG^SDESJSON(.ERRORS,230)
 Q
 ;
BUILDRETURN(PROVIDERLIST,PROVIDERETURN) ;Build return array with provider data
 ; input - PROVIDERLIST = array of active providers
 ;         PROVIDERETURN = passed by reference, represents the array of providers and associated data that will be returned to the client
 ; output - PROVIDERETURN = provider array and their associated data to be sent back to the client
 ;
 N PROVIDERDATA,IEN,IENS,RECORDNUMBER,INFO
 K INFO
 S (RECORDNUMBER,IEN)=0
 F  S IEN=$O(PROVIDERLIST(IEN)) Q:'IEN  D GETS^DIQ(200,IEN_",",".01;.131:.138;.151;8;53.5;205.1","IE","INFO") D
 . S RECORDNUMBER=RECORDNUMBER+1
 . S PROVIDERETURN("Provider",RECORDNUMBER,"IEN")=IEN
 . S PROVIDERETURN("Provider",RECORDNUMBER,"Name")=INFO(200,IEN_",",.01,"E")
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
 ;
NEWPROVLIST(SEARCHSTRING,PROVIDERLIST) ;Loop through "B" cross reference for providers
 N USERDUZ,PROVIDERNAME,STRINGLENGTH,DATE
 S USERDUZ=""
 S DATE=$P(DT,".")
 S STRINGLENGTH=$L(SEARCHSTRING)
 S PROVIDERNAME=$O(^VA(200,"B",SEARCHSTRING),-1)
 I $E(PROVIDERNAME,1,STRINGLENGTH)=SEARCHSTRING D
 . S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME),-1)
 F  S PROVIDERNAME=$O(^VA(200,"B",PROVIDERNAME)) Q:PROVIDERNAME=""!($E(PROVIDERNAME,1,STRINGLENGTH)'=SEARCHSTRING)  D
 . S USERDUZ=""
 . F  S USERDUZ=$O(^VA(200,"B",PROVIDERNAME,USERDUZ)) Q:USERDUZ=""  D
 . . I $$ACTIVPRV^PXAPI(USERDUZ,DATE)&($$ACTIVE^XUSER(USERDUZ)) S PROVIDERLIST(USERDUZ)=""
 Q
 ;

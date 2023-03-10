SDESPROVSEARCH ;BAYPINES/KML,MGD - Get Provider based on Search String ;Sept 23, 2022
 ;;5.3;Scheduling;**819,826**;Aug 13, 1993;Build 18
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$ACTIVPRV^PXAPI is supported by IA #2349
 Q
 ; rpc = SDES SEARCH PROVIDERS
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
 N USERLIST,ERROREXISTS,ERRORLIST,PROVIDERETURN,PROVIDERLIST
 K JSONRETURN
 S SEARCHSTRING=$G(SEARCHSTRING)
 S SEARCHSTRING=$TR(SEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 S ERROREXISTS=0
 S ERROREXISTS=$$VALIDATEINPUT(.ERRORLIST,SEARCHSTRING)
 I ERROREXISTS D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.ERRORLIST) Q
 D GETUSERLIST(SEARCHSTRING,.USERLIST)
 D BLDPROVIDERLIST(.USERLIST,.PROVIDERLIST)
 D BUILDRETURN(.PROVIDERLIST,.PROVIDERETURN)
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.PROVIDERETURN)
 Q
 ;
VALIDATEINPUT(ERRORLIST,SEARCHSTRING) ; validate incoming parameters
 ; input - ERRORLIST = passed in by reference, represents the errors that could be generated when validating the searchstring
 ;         SEARCHSTRING = represents the name or partial name of the provider
 ; returns 0 or 1
 ; 0 = no validation errors
 ; 1 = validation errors
 I ($L(SEARCHSTRING)<3)!($L(SEARCHSTRING)>35) D  Q 1
 . D ERRLOG^SDESJSON(.ERRORLIST,230)
 . S ERRORLIST("Provider",1)=""
 Q 0
 ;
BLDPROVIDERLIST(USERLIST,PROVIDERLIST) ;
 ; input - USERLIST = list of USER names and internal entry numbers from NEW PERSON file (200)
 ;         PROVIDERLIST = passed by reference, represents the screened list of actual providers that are active
 ; output - PROVIDERLIST = array of active providers
 N USERDUZ
 S USERDUZ=0
 F  S USERDUZ=$O(USERLIST(USERDUZ)) Q:'USERDUZ  I $$SCREEN(USERDUZ,DT) S PROVIDERLIST(USERDUZ)=""
 Q
 ;
SCREEN(USERDUZ,DATE) ;
 ;
 ; Selects active providers with an active entry in the NEW PERSON
 ; file (#200) for PERSON CLASS.
 ;
 ; INPUT:  USERDUZ = ien of file 200
 ;         DATE = today's date
 ; OUTPUT: 1 to select; 0 to not select
 ;
 ; DBIA #2349 - ACTIVE PROVIDER will be used for validation.
 ;   The TERMINATION DATE (#9.2) and the PERSON CLASS (#8932.1) fields
 ;   will be used to determine if selection is active in the
 ;   NEW PERSON (#200) file for a given date.
 ;
 I '+$G(USERDUZ) Q 0
 S:'+$G(DATE) DATE=DT
 S DATE=$P(DATE,".")
 I $$ACTIVPRV^PXAPI(USERDUZ,DATE) Q 1
 Q 0
 ;
BUILDRETURN(PROVIDERLIST,PROVIDERETURN) ;Build return array with provider data
 ; input - PROVIDERLIST = array of active providers
 ;         PROVIDERETURN = passed by reference, represents the array of providers and associated data that will be returned to the client
 ; output - PROVIDERETURN = provider array and their associated data to be sent back to the client
 ;
 N PROVIDERDATA,IEN,IENS,RECORDNUMBER
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
GETUSERLIST(SEARCHSTRING,USERLIST) ; pull matching providers using the first input parameter passed in by the RPC
 ; Input - SEARCHSTRING = string that represents the name of the person
 ;         USERLIST = passed in by reference; represents the array that will be returned as output
 ; Output - USERLIST = list of USER names and internal entry numbers from NEW PERSON file (200)
 N RESULTS,SUB3,USERDUZ
 K USERLIST
 S SUB3=0
 D FIND^DIC(200,,"@;.01",,SEARCHSTRING,,,,,"RESULTS")
 F  S SUB3=$O(RESULTS("DILIST",2,SUB3)) Q:SUB3=""  D
 . S USERDUZ=RESULTS("DILIST",2,SUB3)
 . S USERLIST(USERDUZ)=RESULTS("DILIST","ID",SUB3,.01)
 Q
 ;

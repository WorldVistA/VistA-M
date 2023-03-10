SDESPRIVUSRSRCH  ;ALB/RRM,MGD - VISTA SCHEDULING PRIVILEGED USER SEARCH RPC; Sept 23, 2022@01:21
 ;;5.3;Scheduling;**819,826**;Aug 13, 1993;Build 18
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to LIST^DIC       is supported by IA #2051
 ; Reference to $$UP^XLFSTR    is supported by IA #10104
 ; Reference to $$ACTIVE^XUSER is supported by IA #2343
 ;
 ;Global References
 ;-----------------
 ; Reference to LIST^DIC(200   is supported by IA #10060
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
SEARCHPRIVUSR(RETURNJSON,SEARCHSTRING) ;Called from the RPC: SDES SEARCH PRIVILEGED USER
 ; Input:
 ;   SEARCHSTRING  - (Required) Partial OR Full name text of at least 3-35 characters
 ;
 ;Output:
 ;  Successful Return:
 ;    RETURNJSON = Returns a JSON formatted string that match the search criteria that was supplied.
 ;    Otherwise, JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR ;temp data storage for input validation error
 N SDPRIVUSERINFO ;temp data storage of all the names that match the search criteria
 N HASSEARCHERROR
 ;Search String Validation
 S SEARCHSTRING=$$UP^XLFSTR($G(SEARCHSTRING)) ;convert the search string into all Uppercase
 S HASSEARCHERROR=$$VALIDATESRCHSTR(.ERRORS,SEARCHSTRING)
 I HASSEARCHERROR M RETURNERROR=ERRORS
 ;
 I $O(RETURNERROR("Error",""))'="" D EMPTYJSON(SEARCHSTRING),BUILDJSON^SDESBUILDJSON(.RETURNJSON,.RETURNERROR) Q
 ;
 D GETPRIVUSER(SEARCHSTRING,.SDPRIVUSERINFO) ;retrieve all the names that matches the criteria from the New Person Fiel #200
 D BUILDJSON^SDESBUILDJSON(.RETURNJSON,.SDPRIVUSERINFO)
 Q
 ;
GETPRIVUSER(SEARCHSTRING,SDPRIVUSERINFO) ;seach and retrieve user
 N USERIEN,RECORDCNTR,USRISACTIVE,USERLIST,LISTERROR,RECNUM,SDERROR,SDMULTARY,FIELDS
 S RECORDCNTR=0
 S FIELDS="@;.01;1;8;.111;.112;.113;.114;.115;.116;.151;4;5;501.1"
 D LIST^DIC(200,,FIELDS,"PB","*",,SEARCHSTRING,"B",,,"USERLIST","LISTERROR")
 I $D(LISTERROR) S SDPRIVUSERINFO("Error",1)=LISTERROR("DIERR",1,"TEXT",1) D EMPTYJSON(SEARCHSTRING) Q
 S RECNUM=0 F  S RECNUM=$O(USERLIST("DILIST",RECNUM)) Q:RECNUM=""  D
 . Q:RECNUM<1
 . S USERIEN=$P(USERLIST("DILIST",RECNUM,0),"^")
 . S USRISACTIVE=$$ACTIVE^XUSER(USERIEN) ;check if user is not TERMINATED or DIUSER'ed or User cannot sign-on (no AC/VC assigned)
 . Q:$P(USRISACTIVE,"^")<1  ;Quit if User is TERMINATED or DIUSER'ed or User cannot sign-on (no AC/VC assigned)
 . S RECORDCNTR=RECORDCNTR+1
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserIEN")=USERIEN
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserName")=$P(USERLIST("DILIST",RECNUM,0),"^",2)            ;Name
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserInitial")=$P(USERLIST("DILIST",RECNUM,0),"^",3)         ;Initial
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserTitle")=$P(USERLIST("DILIST",RECNUM,0),"^",4)           ;Title
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserStreetAddress1")=$P(USERLIST("DILIST",RECNUM,0),"^",5)  ;Street Address 1
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserStreetAddress2")=$P(USERLIST("DILIST",RECNUM,0),"^",6)  ;Street Address 2
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserStreetAddress3")=$P(USERLIST("DILIST",RECNUM,0),"^",7)  ;Street Address 3
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserCity")=$P(USERLIST("DILIST",RECNUM,0),"^",8)            ;City
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserState")=$P(USERLIST("DILIST",RECNUM,0),"^",9)           ;State
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserZipCode")=$P(USERLIST("DILIST",RECNUM,0),"^",10)        ;Zip Code
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserEmailAddress")=$P(USERLIST("DILIST",RECNUM,0),"^",11)   ;Email Address
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserSex")=$P(USERLIST("DILIST",RECNUM,0),"^",12)            ;Sex
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserDOB")=$P(USERLIST("DILIST",RECNUM,0),"^",13)            ;DOB
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserNetworkID")=$P(USERLIST("DILIST",RECNUM,0),"^",14)      ;Network Username
 . D GETUSERDIVISION(USERIEN,.SDPRIVUSERINFO) ;retrieve Division Multiple data
 . D GETUSERCLASS(USERIEN,.SDPRIVUSERINFO) ;retrieve User Class Multiple data
 . D GETPERSONCLASS(USERIEN,.SDPRIVUSERINFO) ;retrieve Person Class Multiple data
 ;if no record found,set the array into a NULL value
 D EMPTYJSON(SEARCHSTRING,.SDPRIVUSERINFO)
 Q
 ;
GETUSERDIVISION(USERIEN,SDPRIVUSERINFO) ;retrieve Division Multiple data
 N SDERROR,SDMULTARY,II,ISDIVDEFAULT,RECNTR
 S RECNTR=0
 D LIST^DIC(200.02,","_USERIEN_",","@;.01I;.01E;1I;1E","PQ",,,,"#",,,"SDMULTARY","SDERROR")
 I $D(SDERROR) D EMPTYDIV(.SDPRIVUSERINFO,RECORDCNTR)
 S II=0 F  S II=$O(SDMULTARY("DILIST",II)) Q:II=""  D
 . Q:II<1
 . S RECNTR=RECNTR+1
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",RECNTR,"DivisionIEN")=$P(SDMULTARY("DILIST",II,0),"^",2)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",RECNTR,"DivisionName")=$P(SDMULTARY("DILIST",II,0),"^",3)
 . S ISDIVDEFAULT=$P(SDMULTARY("DILIST",II,0),"^",5)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",RECNTR,"DivisionDefault")=$S(ISDIVDEFAULT'="":ISDIVDEFAULT,1:"NO")
 I $P(SDMULTARY("DILIST",0),"^")=0 D EMPTYDIV(.SDPRIVUSERINFO,RECORDCNTR) ;user does not have division set up
 Q
 ;
GETUSERCLASS(USERIEN,SDPRIVUSERINFO) ;retrieve User Class Multiple data
 N SDERROR,SDMULTARY,II,ISUCPRIMARY,RECNTR
 S RECNTR=0
 D LIST^DIC(200.07,","_USERIEN_",","@;.01I;.01E;2I;2E","PQ",,,,"#",,,"SDMULTARY","SDERROR")
 I $D(SDERROR) D EMPTYUSC(.SDPRIVUSERINFO,RECORDCNTR)
 S II=0 F  S II=$O(SDMULTARY("DILIST",II)) Q:II=""  D
 . Q:II<1
 . S RECNTR=RECNTR+1
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",RECNTR,"UserClassIEN")=$P(SDMULTARY("DILIST",II,0),"^",2)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",RECNTR,"UserClassName")=$P(SDMULTARY("DILIST",II,0),"^",3)
 . S ISUCPRIMARY=$P(SDMULTARY("DILIST",II,0),"^",5)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",RECNTR,"UserClassIsPrimary")=$S(ISUCPRIMARY'="":ISUCPRIMARY,1:"NO")
 I $P(SDMULTARY("DILIST",0),"^")=0 D EMPTYUSC(.SDPRIVUSERINFO,RECORDCNTR) ;user does not have USER CLASS set up
 Q
 ;
GETPERSONCLASS(USERIEN,SDPRIVUSERINFO) ;retrieve Person Class Multiple data
 N SDERROR,SDMULTARY,RECNTR,II
 S RECNTR=0
 D LIST^DIC(200.05,","_USERIEN_",","@;.01I;.01E;2E;3E","PQ",,,,"#",,,"SDMULTARY","SDERROR")
 I $D(SDERROR) D EMPTYPC(.SDPRIVUSERINFO,RECORDCNTR)
 S II=0 F  S II=$O(SDMULTARY("DILIST",II)) Q:II=""  D
 . Q:II<1
 . S RECNTR=RECNTR+1
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",RECNTR,"PersonClassIEN")=$P(SDMULTARY("DILIST",II,0),"^",2)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",RECNTR,"PersonClassName")=$P(SDMULTARY("DILIST",II,0),"^",3)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",RECNTR,"EffectiveDate")=$P(SDMULTARY("DILIST",II,0),"^",4)
 . S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",RECNTR,"ExpirationDate")=$P(SDMULTARY("DILIST",II,0),"^",5)
 I $P(SDMULTARY("DILIST",0),"^")=0 D EMPTYPC(.SDPRIVUSERINFO,RECORDCNTR) ;user does not have PERSON CLASS set up
 Q
 ;
VALIDATESRCHSTR(ERRORS,SEARCHSTRING) ;Validate Privileged user search string that was supplied
 N ERRORFLAG
 S ERRORFLAG=0
 I SEARCHSTRING="" S ERRORFLAG=1 D ERRLOG^SDESJSON(.ERRORS,231) Q ERRORFLAG
 I $L(SEARCHSTRING)<3!($L(SEARCHSTRING)>35) S ERRORFLAG=1 D ERRLOG^SDESJSON(.ERRORS,230)
 Q ERRORFLAG
 ;
EMPTYDIV(SDPRIVUSERINFO,RECORDCNTR) ;set Division subscript to NULL
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",1,"DivisionIEN")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",1,"DivisionName")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"Division",1,"DivisionDefault")=""
 Q
 ;
EMPTYUSC(SDPRIVUSERINFO,RECORDCNTR) ;Set User Class subscript to Null
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",1,"UserClassIEN")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",1,"UserClassName")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"UserClass",1,"UserClassIsPrimary")=""
 Q
 ;
EMPTYPC(SDPRIVUSERINFO,RECORDCNTR) ;Set Person Class subscript to Null
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",1,"PersonClassIEN")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",1,"PersonClassName")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",1,"EffectiveDate")=""
 S SDPRIVUSERINFO("NewPerson",RECORDCNTR,"PersonClass",1,"ExpirationDate")=""
 Q
 ;
EMPTYJSON(SEARCHSTRING,SDPRIVUSERINFO) ;return an empty string JSON Format if an Error occur or no data found
 I $O(SDPRIVUSERINFO("NewPerson",""))="" D
 . I $O(RETURNERROR("Error",""))="" D  Q
 . . S SDPRIVUSERINFO("NewPerson",1)=""
 . S RETURNERROR("NewPerson",1)=""
 Q
 ;

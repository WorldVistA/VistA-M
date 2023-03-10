SDESRECCLINSRCH  ;ALB/MGD - VISTA SCHEDULING RECALL CLINIC SEARCH RPC; Aug 24, 2022@15:04
 ;;5.3;Scheduling;**823**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ; RPC = SDES SEARCH RECALL CLINICS
SEARCHRECALLCLIN(JSONRETURN,SEARCHSTRING) ;Search for Recall clinics and provide return of matches in JSON STRING
 ; INPUT - SEARCHSTRING = free text string that represents the recall clinic name that will be searched
 ; OUTPUT - JSONRETURN
 ; List of Recall Clinics from the RECALL REMINDERS (#403.5) file with the following data.
 ; Field List:
 ; (1) Recall Clinic IEN
 ; (2) Recall Clinic Name
 ; (3) Recall Reminder IEN
 ;
 N CLINICLIST,ERROREXISTS,ERRORLIST,CLINICRETURN,CLINICLIST
 K JSONRETURN
 S SEARCHSTRING=$G(SEARCHSTRING)
 S ERROREXISTS=0
 S ERROREXISTS=$$VALIDATEINPUT(.ERRORLIST,SEARCHSTRING)
 I ERROREXISTS D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.ERRORLIST) Q
 D GETPROVLIST(SEARCHSTRING,.CLINICLIST)
 D BUILDRETURN(.CLINICLIST,.CLINICRETURN)
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.CLINICRETURN)
 Q
 ;
VALIDATEINPUT(ERRORLIST,SEARCHSTRING) ; validate incoming parameters
 ; input - ERRORLIST = passed in by reference, represents the errors that could be generated when validating the searchstring
 ;         SEARCHSTRING = represents the name or partial name of the Recall Clinic
 ; returns 0 or 1
 ; 0 = no validation errors
 ; 1 = validation errors
 S SEARCHSTRING=$TR(SEARCHSTRING,$C(13)_$C(10)_$C(9),"")
 I ($L(SEARCHSTRING)<3)!($L(SEARCHSTRING)>35) D  Q 1
 . D ERRLOG^SDESJSON(.ERRORLIST,230)
 . S ERRORLIST("Recall Clinic",1)=""
 Q 0
 ;
GETPROVLIST(SEARCHSTRING,CLINICLIST) ; pull matching recall clinics using the first input parameter passed in by the RPC
 ; Input - SEARCHSTRING = string that represents the name of the recall clinic
 ;         CLINICLIST = passed in by reference; represents the array that will be returned as output
 ; Output - CLINICLIST = list of recall clinic names, clinic IENs and the associated recall reminder IENs.
 N RESULTS,SUB3
 K CLINICLIST
 S SUB3=0
 D FIND^DIC(403.5,,"@;4.5",,SEARCHSTRING,,"E",,,"RESULTS")
 F  S SUB3=$O(RESULTS("DILIST",2,SUB3)) Q:SUB3=""  D
 . S CLINNAME=$G(RESULTS("DILIST","ID",SUB3,4.5))
 . S CLINICLIST(CLINNAME,SUB3)=$G(RESULTS("DILIST",2,SUB3))
 Q
 ;
BUILDRETURN(CLINICLIST,CLINICRETURN) ;Build return array with recall reminder clinic data
 ; input - CLINICLIST = array of recall clinics
 ;         CLINICRETURN = passed by reference, represents the array of recall clinics and associated data that will be returned to the client
 ; output - CLINICRETURN = recall clinic array and their associated data to be sent back to the client
 ;
 N CLINIEN,CLINNAME,RECIEN,RECCNT
 S (CLINNAME,RECCNT)=0
 F  S CLINNAME=$O(CLINICLIST(CLINNAME)) Q:CLINNAME=""  D
 . S CLINIEN=$$FIND1^DIC(44,"","X",CLINNAME,"B","","ERROR")
 . Q:'CLINIEN
 . S RECIEN=0
 . F  S RECIEN=$O(CLINICLIST(CLINNAME,RECIEN)) Q:'RECIEN  D
 . . S CLINICRETURN("Recall Clinic",CLINNAME,RECIEN,"ClinicIEN")=CLINIEN
 . . S CLINICRETURN("Recall Clinic",CLINNAME,RECIEN,"ClinicName")=CLINNAME
 . . S CLINICRETURN("Recall Clinic",CLINNAME,RECIEN,"ClinicRecallIEN")=RECIEN
 . . S RECCNT=RECCNT+1
 I RECCNT=0 S CLINICRETURN("Recall Clinic",1)=""
 Q

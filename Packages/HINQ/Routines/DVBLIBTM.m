DVBLIBTM ;ALB/NGC - Reusable Library Processes - Taskman ; 9/22/25 1:01pm
 ;;2.7;AMIE;**255**;Apr 10, 1995;Build 21
 ;Per VHA Directive 6402 this routine should not be modified
 ;
 ;ICR 
 ; Reference to File 19 in ICR #10075
 ; Reference to File 19.2 in ICR #4086
 ; Reference to FIND1^DIC in ICR #10006
 ; Reference to GET1^DIQ in ICR #10004
 ; Reference to UPDATE^DIE in ICR #2053
 ;
 Q  ;no direct entry
 ;
 ;
FINDIDBYNAME(DVBTASKMANNAME) ;CAPRI-12374:NGC - Get taskman DA and associated options DA from the taskman name
  Q $$FIND1^DIC(19.2,,"A",DVBTASKMANNAME)
  ;
  ;
GETNAMEDVALUE(DVBOPTIONDA,DVBNAME,DVBDEFAULT) ;CAPRI-12374:NGC - Get a value from the taskman name/value pair storage.
  ;Parameters - DVBOPTIONDA : Options Scheduling Id (piece 1 returned by $$FINDBYNAME) OR Taskman Name
  ;           - DVBNAME     : Name of Name/Value pair
  ;           - DVBDEFAULT  : Default value if name not found 
  N DVBDA,DVBRETURN
  S DVBOPTIONDA=$$FINDIDBYNAME(DVBOPTIONDA)                            ; Find Taskman IEN for the DVBOPTIONDA name/ien
  S DVBDA=+$$FIND1^DIC(19.21,","_DVBOPTIONDA_",",,DVBNAME)             ; lookup name/value entry based on the name
  S DVBRETURN=$TR($$GET1^DIQ(19.21,DVBDA_","_DVBOPTIONDA_",",1),"""")  ; get 'value' of the found name/value pairW
  Q $S(DVBRETURN="":$G(DVBDEFAULT),1:DVBRETURN)
  ;
  ;
SETNAMEDVALUE(DVBOPTIONDA,DVBNAME,DVBVALUE) ;CAPRI-12376:NGC - Set a Name/Value pair - 
  ;Parameters - DVBOPTIONDA : Options Scheduling Id (Name or IEN to File 19.2)
  ;           - DVBNAME     : Name of Name/Value pair
  ;           - DVBVALUE    : Value to set against the name (can't contain ^) 
  ;                           Value = "@" will blank the value, not delete the pair (See DELNAMEDVALUE below)
  N DVBDA,DVBFDA,DVBERR
  S DVBOPTIONDA=$$FINDIDBYNAME(DVBOPTIONDA) Q:('+DVBOPTIONDA) ""
  S:(DVBVALUE'="@")&(DVBVALUE'?1N.N) DVBVALUE=""""_DVBVALUE_""""
  S DVBDA=+$$FIND1^DIC(19.21,","_DVBOPTIONDA_",",,DVBNAME)                 ; lookup existing name/value based on the name
  S DVBFDA(19.21,$S(+DVBDA:DVBDA,1:"+1")_","_DVBOPTIONDA_",",.01)=DVBNAME  ; set to create if not exists
  S DVBFDA(19.21,$S(+DVBDA:DVBDA,1:"+1")_","_DVBOPTIONDA_",",1)=DVBVALUE
  D UPDATE^DIE("E","DVBFDA","","DVBERR")  ;Flag 'E' because non DVB file - update with value (create if needed)
  Q $S($D(DVBERR):-1,1:"")
  ;
  ;
DELNAMEDVALUE(DVBOPTIONDA,DVBNAME) ;CAPRI-12378:NGC - Delete a Name/Value pair
  ;Parameters - DVBOPTIONDA : Options Scheduling Id  (Name or IEN to File 19.2)
  ;           - DVBNAME     : Name of Name/Value pair
  ;Return     - 0 = success ! -1^<errormessage>
  N DVBDA,DVBFDA,DVBERR
  S DVBOPTIONDA=$$FINDIDBYNAME(DVBOPTIONDA) Q:('+DVBOPTIONDA) "1^Taskman option not found"
  S DVBDA=+$$FIND1^DIC(19.21,","_DVBOPTIONDA_",",,DVBNAME) Q:('+DVBDA) "-1^Name not found"
  S DVBFDA(19.21,DVBDA_","_DVBOPTIONDA_",",.01)="@"
  D UPDATE^DIE("E","DVBFDA","","DVBERR") ;Flag 'E' because non DVB file
  Q $S($D(DVBERR):-1,1:0)
  ;
CREATETASKMAN(DVBNAME,DVBENDPOINT,DVBPARAM)  ;CAPRI-23170:NGC
  N DVBOPT,DVBSCH,DVBFDA,DVBERR
  ;Check to create Option file record
  S DVBOPT=$$FIND1^DIC(19,,"X",DVBNAME)
  I DVBOPT=0 D
  . K DFBFDA
  . S DVBFDA(19,"+1,",.01)=DVBNAME
  . S DVBFDA(19,"+1,",1)=DVBNAME
  . S DVBFDA(19,"+1,",4)="Action"
  . S DVBFDA(19,"+1,",12)="AUTOMATED MED INFO EXCHANGE"
  . S DVBFDA(19,"+1,",14)="YES"
  . S DVBFDA(19,"+1,",20)=DVBENDPOINT
  . S DVBFDA(19,"+1,",209)="YES"
  . M DVBFDA(19,"+1,")=DVBPARAM(19)
  . K DVBERR D UPDATE^DIE("E","DVBFDA","","DVBERR")
  S DVBOPT=$$FIND1^DIC(19,,"A",DVBNAME)
  I (DVBOPT=0)!($D(DVBERR("DIERR"))) Q "-1^Failed to create taskman record "_DVBNAME
  ;Check to create schedule file record
  S DVBSCH=$$FIND1^DIC(19.2,,"X",DVBNAME)
  I DVBSCH=0 D
  . K DVBFDA
  . S DVBFDA(19.2,"+1,",.01)=DVBNAME
  . M DVBFDA(19.2,"+1,")=DVBPARAM(19.2)
  . K DVBERR D UPDATE^DIE("E","DVBFDA","","DVBERR")
  S DVBSCH=$$FIND1^DIC(19.2,,"X",DVBNAME)
  I (DVBSCH=0)!($D(DVBERR("DIERR"))) Q "-1^Failed to create taskman schedule "_DVBNAME
  Q "1^"_DVBOPT_"^"_DVBSCH

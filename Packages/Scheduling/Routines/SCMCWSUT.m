SCMCWSUT ;ALB/ART - PCMM Web Call Patient Summary Web Service ;09/11/2014
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #5421 - XOBWLIB - Public APIs for HWSC
 ; #2051 - Database Server API: Lookup Utilities (DIC)
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ;
SETUP(SCDATA) ;Web service setup
 ;   Lookup server name
 ;   Validate server name
 ;   Validate service name
 ;   Get REST request object
 ; Inputs: SCDATA - array of variables, passed by reference
 ; Output: 
 ; Returns: success = 1
 ;          failure = 0^error message
 ;
 NEW SCRC,SCSERVER,SCLIST
 ;
 ; Get PCMM/R Web Server Name
 SET SCRC=$$SNAME4KY^XOBWLIB(SCDATA("serverNameKey"),.SCSERVER)
 QUIT:'SCRC "0^>>> CONFIGURATION ERROR: No Server Key Definition <<<"
 SET SCDATA("serverName")=SCSERVER
 ;
 ; Validate PCMM/R Web Server Name
 DO LKUPSRVR(SCDATA("serverName"),.SCLIST)
 QUIT:$GET(SCLIST(1))=0 "0^>>> CONFIGURATION ERROR: No Server Definition <<<"
 ;
 ; Validate PCMM/R Web Service Name
 NEW SCLIST
 DO LKUPSRVS(SCDATA("webServiceName"),.SCLIST)
 QUIT:$GET(SCLIST(1))=0 "0^>>> CONFIGURATION ERROR: No Service Definition <<<"
 ;
 QUIT 1
 ;
LKUPSRVR(SCNAME,SCLIST) ; Web Server Lookup
 ; Inputs: SCNAME - name of the server
 ; Output: SCLIST - list of matching IENs, by reference
 ;                  ien^name
 ;FIND^DIC(FILE,IENS,FIELDS,FLAGS,[.]VALUE,NUMBER,[.]INDEXES,[.]SCREEN,IDENTIFIER,TARGET_ROOT,MSG_ROOT)
 N I,SCRET,SCERR,Y
 SET SCLIST(1)=0
 ; Fileman DBS Web Server Lookup
 DO FIND^DIC(18.12,"","@;.01","P",SCNAME,"","B","","","SCRET","SCERR")
 SET I=0
 FOR  SET I=$ORDER(SCRET("DILIST",I)) QUIT:'I  DO
 . SET SCLIST(I)=SCRET("DILIST",I,0)
 QUIT
 ;
LKUPSRVS(SCNAME,SCLIST) ; Web Service Lookup
 ; Inputs: SCNAME - name of the service
 ; Output: SCLIST - list of matching IENs and names, by reference
 ;                  ien^name
 ;FIND^DIC(FILE,IENS,FIELDS,FLAGS,[.]VALUE,NUMBER,[.]INDEXES,[.]SCREEN,IDENTIFIER,TARGET_ROOT,MSG_ROOT)
 N I,SCRET,SCERR,Y
 SET SCLIST(1)=0
 ; Fileman DBS Web Service Lookup
 DO FIND^DIC(18.02,"","@;.01","P",SCNAME,"","B","","","SCRET","SCERR")
 SET I=0
 FOR  SET I=$ORDER(SCRET("DILIST",I)) QUIT:'I  DO
 . SET SCLIST(I)=SCRET("DILIST",I,0)
 QUIT
 ;
CPRSHEAD(SCDFN) ;Get data for CPRS PCMMR Header
 ; Inputs: SCDFN - Patient DFN
 ; Returns: String of PACT info from Outpatient Profile (404.41), CPRS Header Text (.06) 
 ;
 QUIT:$GET(SCDFN)="" "Internal Error: Missing DFN"
 NEW SCIENS,SCTEXT
 SET SCIENS=SCDFN_","
 SET SCTEXT=$$GET1^DIQ(404.41,SCIENS,.06)
 SET:SCTEXT="" SCTEXT="No PACT assigned at any VA location"
 QUIT SCTEXT
 ;

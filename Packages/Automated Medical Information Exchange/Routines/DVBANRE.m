DVBANRE ;ALB/NGC - New Requests Export - RPCs and Taskman entry points ; 9/22/25 12:57pm
 ;;2.7;AMIE;**255**;Apr 10, 1995;Build 21
 ;Per VHA Directive 6402 this routine should not be modified
 ;
 ;ICRs 
 ; Reference to $$SITE^VASITE in ICR #10112
 ; Reference to File 2 ^DPT in ICR #10035
 ; Reference to File 19.2 ^DIC(19.2) in ICR #4078 
 ; Reference to File 40.8 ^DIC(40.8) in ICR #728
 ; Reference to NOW^XLFDT in ICR #10103
 ; Reference to FMTE^XLFDT in ICR #10103
 ; Reference to FMADD^XLFDT in ICR #10103
 ; Reference to LOW^XLFSTR in ICR #10104
 ; Reference to GET1^DIQ in ICR #10004
 ;
 Q  ;no direct entry
 ;
 ;
 ;DVBA CAPRI NRE HISTORY
 ;Parameters   - DVBDIVID   : internal division Id
 ;             - DVBRANGEID : range identifier supplied to CAPRI by RPC:NRE STATIC 
 ;Returns      - history array  () = processId ^ date/time ^ description ^ 1 ^ info mark ^ run method
HISTORYRPC(DVBRETURN,DVBDIVID,DVBRANGEID) ;CAPRI-12377:NGC - Export history for a division and date range(coded)
 N DVBOPTIONDA,DVBFROMDATE,DVBTODATE,DVBPROCESSSTATUS,DVBPAIRNAME,DVBHISTORYROW,DVBDIVSTATUS,DVBPROCESSID
 S DVBRETURN=$NA(^TMP("RPCHISTORY",$J)) K @DVBRETURN
 I (DVBDIVID="") S @DVBRETURN@(0)="-1^Missing division" Q
 I ('$D(^DVB(396.1,1,3,"B",DVBDIVID))) S @DVBRETURN@(0)="-1^No such division" Q
 I ('+$G(DVBRANGEID)) S @DVBRETURN@(0)="-1^Range ID not specified/correct" Q
 D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 S DVBOPTIONDA=DVBDIVSTATUS("optionDA")
 S DVBFROMDATE=$$FMADD^XLFDT(DT,-DVBRANGEID),DVBTODATE=DT
 S DVBPAIRNAME=""
 F  S DVBPAIRNAME=$O(^DIC(19.2,DVBOPTIONDA,2,"B",DVBPAIRNAME)) Q:DVBPAIRNAME=""  D:(DVBPAIRNAME?1"DVBANREPROC".E)
 . S DVBPROCESSID=$P($P(DVBPAIRNAME,"(",2),")",1)
 . D PROCESSSTATUS^DVBANREP(DVBPROCESSID,.DVBPROCESSSTATUS)
 . Q:(DVBPROCESSSTATUS("divId")'=DVBDIVID)  ;not for this division
 . Q:(DVBPROCESSSTATUS("processDate")<DVBFROMDATE)!(DVBPROCESSSTATUS("processDate")>DVBTODATE)  ;out of range
 . S DVBHISTORYROW=""
 . S $P(DVBHISTORYROW,"^",1)=DVBPROCESSID                                  ; ProcessId
 . S $P(DVBHISTORYROW,"^",2)=$E(DVBPROCESSSTATUS("processDTM"),1,12)       ; Date Time (no seconds)
 . S $P(DVBHISTORYROW,"^",3)="Complete with "_DVBPROCESSSTATUS("request")_" request(s) exported"
 . S $P(DVBHISTORYROW,"^",4)=1
 . S $P(DVBHISTORYROW,"^",5)=$$LOW^XLFSTR(DVBPROCESSSTATUS("exportMark"))  ; Informational Mark
 . S $P(DVBHISTORYROW,"^",6)=DVBPROCESSSTATUS("runMethod")                 ; How run
 . S @DVBRETURN@($O(@DVBRETURN@(""),-1)+1)=DVBHISTORYROW
 . Q
 Q
 ;
 ;
LOADRPC(DVBRETURN,DVBDIVID) ;CAPRI-12375:NGC - Return NRE configuration for a division
 ;DVBA CAPRI NRE LOAD
 ;Parameters - DVBDIVID - division Id
 ;Returns    - divId ^ timeList ^ rowGroup ^^^^^^^ divSummary ^ divName
 N DVBDIVSTATUS
 K DVBRETURN
 S DVBRETURN=""
 I (DVBDIVID="") S DVBRETURN="-1^Missing Division" Q
 I ('$D(^DVB(396.1,1,3,"B",DVBDIVID))) S DVBRETURN="-1^No such division" Q
 D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS) ; retrieve standard data set for a division
 S $P(DVBRETURN,"^",1)=DVBDIVID
 S $P(DVBRETURN,"^",2)=DVBDIVSTATUS("divTimeList")
 S $P(DVBRETURN,"^",3)=+DVBDIVSTATUS("divRowGroup")
 S $P(DVBRETURN,"^",10)=DVBDIVSTATUS("summary")
 S $P(DVBRETURN,"^",11)=DVBDIVSTATUS("name")
 Q
 ;
 ;
MARKRPC(DVBRSLT,DVBPROCESSID,DVBEXPORTMARK) ;CAPRI-12378:NGC - Mark a export item with an annotated status 
 ;DVBA CAPRI NRE MARK
 ;Parameters  - dvbProcessId : processing (export file) id
 ;            - dvbExportMark : ('viewed' | 'in-progress' | 'complete')
 ;Returns     - none
 N DVBOPTIONDA,DVBPROCESSSTORE
 I (DVBEXPORTMARK'?1.20E) S DVBRSLT="-1^Invalid information mark" Q
 S DVBRSLT=0,DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA)
 S DVBPROCESSSTORE=$$GETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREPROC("_DVBPROCESSID_")")  ;load record
 I (DVBPROCESSSTORE="") S DVBRSLT="-1^Process Id not specified / not found" Q
 S $P(DVBPROCESSSTORE,"|",4)=$$LOW^XLFSTR(DVBEXPORTMARK)                                  ;update values
 S $P(DVBPROCESSSTORE,"|",7)=$$NOW^XLFDT
 S $P(DVBPROCESSSTORE,"|",8)=DUZ
 D SETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREPROC("_DVBPROCESSID_")",DVBPROCESSSTORE)    ;save record
 Q
 ;
 ;
OPENRPC(DVBRETURN,DVBPROCESSID) ;CAPRI-12377:NGC - Return an array of the selected export file
 ;DVBA CAPRI NRE OPEN
 ;Parameters  - dvbProcessId : processing (export file) id
 ;Returns     - global array of string.  header row followed by nn csv rows
 N DVBROW,DVBREQID,DVBDFN,DVBCSV,DVBEXAM,DVBCNUMBER,DVBSSN,DVBCOUNT
 S DVBRETURN=$NA(^TMP("RPCNREOPEN",$J)) K @DVBRETURN
 D PROCESSSTATUS^DVBANREP(DVBPROCESSID,.DVBPROCESSSTATUS)
 I ('$D(DVBPROCESSSTATUS)) S @DVBRETURN@(0)="-1^Process Id not found" Q
 S DVBROW=0,@DVBRETURN@(DVBROW)="0^File View^DVBANRE_2507s_Export_"_DVBPROCESSID_".csv"
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=$$CSV^DVBLIBGN("C&P New Requests Export - Division: "_$$GET1^DIQ(40.8,DVBPROCESSSTATUS("divId"),.01))
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=$$CSV^DVBLIBGN("Export generated: "_$$FMTE^XLFDT(DVBPROCESSSTATUS("processDTM"),"1PM")_". Last run: "_$$FMTE^XLFDT(DVBPROCESSSTATUS("prevProcessDTM"),"1PM"))
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=""
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)="Patient,SSN,DateOfBirth,RequestDate,Requester,ExamCount,CurrentStatus"
 S DVBREQID=""
 F  S DVBREQID=$O(DVBPROCESSSTATUS("request",DVBREQID)) Q:DVBREQID=""  D
 . S DVBDFN=$$GET1^DIQ(396.3,DVBREQID,.01,"I")
 . S DVBCSV="",$P(DVBCSV,"~",8)=""
 . S $P(DVBCSV,"~",1)=$$CSV^DVBLIBGN($$GET1^DIQ(2,DVBDFN,.01))                               ; patient Name
 . D:('$$ISSENSITIVE^DVBLIBGN(DVBDFN))
 .. S DVBSSN=$$GET1^DIQ(2,DVBDFN,.09,"I"),$P(DVBCSV,"~",2)=$$CSV^DVBLIBGN($S(DVBSSN?9N:$TR("abc-de-fghi","abcdefghi",DVBSSN),1:DVBSSN)) ; SSN
 .. S $P(DVBCSV,"~",3)=$$CSV^DVBLIBGN($$GET1^DIQ(2,DVBDFN,.03,"E"))                          ; Date of Birth
 .. S $P(DVBCSV,"~",4)=$$CSV^DVBLIBGN($$FMTE^XLFDT($$GET1^DIQ(396.3,DVBREQID,1,"I"),"1PM"))  ; 2507 Request Date (no seconds)
 .. S $P(DVBCSV,"~",5)=$$CSV^DVBLIBGN($$GET1^DIQ(396.3,DVBREQID,3,"E"))                      ; 2507 Requester
 .. S DVBEXAM="" F DVBCOUNT=0:1 S DVBEXAM=$O(^DVB(396.4,"C",DVBREQID,DVBEXAM)) Q:DVBEXAM=""  ; Count Exams
 .. S $P(DVBCSV,"~",6)=$$CSV^DVBLIBGN(DVBCOUNT)                                              ; Count Exams
 .. S $P(DVBCSV,"~",7)=$$CSV^DVBLIBGN($$GET1^DIQ(396.3,DVBREQID,17,"E")_" ("_$$FMTE^XLFDT($$GET1^DIQ(396.3,DVBREQID,7,"I"),"1P")_")") ; Status (changed date)
 . S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=$TR(DVBCSV,"~",",")
 . Q
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)="------------------------------------------------"
 S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=$$CSV^DVBLIBGN("Complete   : "_DVBPROCESSSTATUS("request")_" request(s) at "_$$FMTE^XLFDT(DVBPROCESSSTATUS("processDTM"),"1PM"))
 D:(DVBPROCESSSTATUS("exportMarkText")'="")
 . S DVBROW=DVBROW+1,@DVBRETURN@(DVBROW)=$$CSV^DVBLIBGN("Last Action: "_DVBPROCESSSTATUS("exportMarkText"))
 ;If status is 'new', change export status to 'opened'.
 D:("new opened"[DVBPROCESSSTATUS("exportMark"))
 . S DVBPROCESSSTORE=$$GETNAMEDVALUE^DVBLIBTM("DVBA CAPRI NRE PROCESS TM","DVBANREPROC("_DVBPROCESSID_")")
 . S $P(DVBPROCESSSTORE,"|",4)="opened"
 . S $P(DVBPROCESSSTORE,"|",7)=$$NOW^XLFDT
 . S $P(DVBPROCESSSTORE,"|",8)=DUZ
 . D SETNAMEDVALUE^DVBLIBTM("DVBA CAPRI NRE PROCESS TM","DVBANREPROC("_DVBPROCESSID_")",DVBPROCESSSTORE)
 . Q
 Q
 ;
 ;
RUNNOWRPC(DVBSAVERESPONSE,DVBDIVSAVESTRING) ;CAPRI-12378:NGC -  Execute an export in real dvbTime with the current configuration as modified in CAPRI
 ;Parameters  - dvbDivSaveString : divId ^ timeList ^ rowGroup
 ;Returns     - status ^ notification text ^ next run text ~ outstanding count
 N DVBDIVSTATUS,DVBDIVID
 S DVBDIVID=$P(DVBDIVSAVESTRING,"^",1)
 D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 S DVBDIVSTATUS("divRowGroup")=$P(DVBDIVSAVESTRING,"^",3)
 D PROCESSEXPORT^DVBANREP(DVBDIVID,.DVBDIVSTATUS,"AdHoc")
 D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 S DVBSAVERESPONSE=""
 S $P(DVBSAVERESPONSE,"^",1)=0
 S $P(DVBSAVERESPONSE,"^",2)="Run Complete"
 S $P(DVBSAVERESPONSE,"^",3)=DVBDIVSTATUS("summary")
 Q
 ;
 ;
SAVERPC(DVBSAVERESPONSE,DVBDIVSAVESTRING) ;CAPRI-12376:NGC -  Save configuration for a division
 ;Parameters  - dvbDivSaveString : divId ^ timeList ^ rowGroup
 ;Returns     - status ^ notification text ^ next run text ~ outstanding count
 N DVBDIVID,DVBDIVSTORE,DVBERROR,DVBDIVSTATUS
 S DVBDIVID=$P(DVBDIVSAVESTRING,"^",1)
 S DVBERROR=$$VALSAVESTRING^DVBANREP(.DVBDIVSAVESTRING)
 D:(DVBERROR="")  ;no error => perform save
 . S DVBDIVSTORE=$$GETNAMEDVALUE^DVBLIBTM("DVBA CAPRI NRE PROCESS TM","DVBANREDIV("_DVBDIVID_")")
 . S $P(DVBDIVSTORE,"|",1)=DVBDIVID
 . S $P(DVBDIVSTORE,"|",2)=$P(DVBDIVSAVESTRING,"^",2)
 . S $P(DVBDIVSTORE,"|",3)=''$P(DVBDIVSAVESTRING,"^",3)
 . D SETNAMEDVALUE^DVBLIBTM("DVBA CAPRI NRE PROCESS TM","DVBANREDIV("_DVBDIVID_")",DVBDIVSTORE)
 . Q
 ;Generate response string (if error or no error)
 D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 S DVBSAVERESPONSE=""
 S $P(DVBSAVERESPONSE,"^",1)=$S(DVBERROR="":0,1:-1)
 S $P(DVBSAVERESPONSE,"^",2)=$S(DVBERROR="":"Configuration saved",1:DVBERROR)
 S $P(DVBSAVERESPONSE,"^",3)=DVBDIVSTATUS("summary")
 Q
 ;
 ;
STATICRPC(DVBSOLNSTATIC) ;CAPRI-12375:NGC - Return static meta data to allow the report form to be drawn
 ;for RPC DVBA CAPRI NRE STATIC
 ;Parameters  - None
 ;Return      - division list ^ range list ^ purgeInterval
 N DVBDIVID,DVBDIVLIST,DVBRANGELIST,DVBPURGE,DVBRANGE
 S DVBDIVLIST=""
 S DVBDIVID="" F  S DVBDIVID=$O(^DVB(396.1,1,3,"B",DVBDIVID)) Q:DVBDIVID=""  D
 . S DVBDIVLIST=DVBDIVLIST_$S(DVBDIVLIST="":"",1:",")_DVBDIVID_"~"_$$GET1^DIQ(40.8,DVBDIVID,.01)
 S DVBPURGE=$$GET^XPAR("PKG","DVBAB CAPRI NRE PURGE") S:(DVBPURGE="") DVBPURGE=30
 S DVBRANGELIST="1~Yesterday and Today~1"
 F DVBRANGE=7,14,30 S:DVBPURGE>DVBRANGE DVBRANGELIST=DVBRANGELIST_","_DVBRANGE_"~Last "_DVBRANGE_" days"
 S DVBRANGELIST=DVBRANGELIST_","_DVBPURGE_"~Last "_DVBPURGE_" days"
 S DVBSOLNSTATIC=""
 S $P(DVBSOLNSTATIC,"^",1)=DVBDIVLIST                                      ; division list
 S $P(DVBSOLNSTATIC,"^",2)=DVBRANGELIST                                    ; range list
 ;CAPRI-23935 NGC 12/25 - Removed 4 pieces returning no longer needed data
 S $P(DVBSOLNSTATIC,"^",3)=DVBPURGE                                        ; purge interval
 Q
 ;
 ;
SUMMARYRPC(DVBRETURN) ;CAPRI-12374:NGC - return a summary, per division : last run summary, next run summary, outstanding requests
 ;Parameters  - None
 ;Result      - DVBSUMMARY : array of string 
 ;Output - for each division, name, last run, next run, outstanding count
 N DVBDIVID,DVBDIVSTATUS,DVBROW
 K DVBRETURN
 S DVBROW=0,DVBRETURN(DVBROW)="C&P New Requests Export"
 S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=""
 S DVBDIVID="" F  S DVBDIVID=$O(^DVB(396.1,1,3,"B",DVBDIVID)) Q:DVBDIVID=""  D
 . D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=""
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=DVBDIVSTATUS("name")
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=$TR($J("",$L(DVBDIVSTATUS("name")))," ","-")
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)="  Last Run:  "_DVBDIVSTATUS("lastRunText")
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)="  Next Run:  "_DVBDIVSTATUS("nextRunText")
 . S DVBROW=DVBROW+1,DVBRETURN(DVBROW)="  Currently: "_DVBDIVSTATUS("nextRunCount")_" request(s) pending for export."
 S:(DVBROW<7) DVBROW=DVBROW+1,DVBRETURN(DVBROW)="No active divisions found for site."
 S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=""
 S DVBROW=DVBROW+1,DVBRETURN(DVBROW)=$$FMTE^XLFDT($$NOW^XLFDT,"1PM") ;format example:  Jan 10, 2025 11:19 am
 Q
 ;
 ;
TMPROCESS  ;CAPRI-12378:NGC - Endpoint for 'DVBA CAPRI NRE PROCESS TM' Taskman call
 N DVBDIVID,DVBDIVSTATUS,DVBNOWTIME
 S DVBDIVID=""
 S DVBNOWTIME=$$NOW^XLFDT
 F  S DVBDIVID=$O(^DVB(396.1,1,3,"B",DVBDIVID)) Q:(DVBDIVID="")  D
 . D DIVSTATUS^DVBANREP(DVBDIVID,.DVBDIVSTATUS)
 . Q:(DVBDIVSTATUS("nextRunDTM")>DVBNOWTIME)
 . D PROCESSEXPORT^DVBANREP(DVBDIVID,.DVBDIVSTATUS,"Scheduled")
 . Q
 Q
 ;
 ;
TMPURGE  ;CAPRI-12378:NGC - Endpoint for 'DVBA CAPRI NRE PURGE TM' taskman job
 N DVBOPTIONDA,DVBPURGE,DVBFROMDATE,DVBPAIRNAME,DVBPROCESSID,DVBPROCESSSTATUS
 S DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA)
 S DVBPURGE=$$GET^XPAR("PKG","DVBAB CAPRI NRE PURGE") S:(DVBPURGE="") DVBPURGE=30
 S DVBFROMDATE=$$FMADD^XLFDT($$NOW^XLFDT,-DVBPURGE)
 S DVBPAIRNAME=""
 F  S DVBPAIRNAME=$O(^DIC(19.2,DVBOPTIONDA,2,"B",DVBPAIRNAME)) Q:(DVBPAIRNAME="")  D:(DVBPAIRNAME?1"DVBANREPROC".E)
 . S DVBPROCESSID=$P($P(DVBPAIRNAME,"(",2),")",1)
 . D PROCESSSTATUS^DVBANREP(DVBPROCESSID,.DVBPROCESSSTATUS)
 . D:(DVBPROCESSSTATUS("processDate")<DVBFROMDATE) DELNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,DVBPAIRNAME)
 . Q
 Q

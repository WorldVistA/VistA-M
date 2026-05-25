DVBANREP  ;ALB/NGC - New Requests Export - Processes ; August 1, 2023; 8/13/2024
 ;;2.7;AMIE;**255**;Apr 10, 1995;Build 21
 ;Per VHA Directive 6402 this routine should not be modified
 ;ICRs 
 ; Reference to $$SITE^VASITE in ICR #10112
 ; Reference to File 200 ^VA(200) in ICR #170
 ; Reference to File 40.8 ^DIC(40.8) in ICR #728
 ; Reference to NOW^XLFDT in ICR #10103
 ; Reference to FMTE^XLFDT in ICR #10103
 ; Reference to FMADD^XLFDT in ICR #10103
 ; Reference to TITLE^XLFSTR in ICR #10104
 ; Reference to GET1^DIQ in ICR #10004
 ; Reference to ^DIE in ICR #10018
 ;
 Q  ;no direct entry
 ;
 ;
LOOKBACKINTERVAL()  ;CAPRI-12374:NGC - Lookback interval in days for 2507s to be considered (blank reported date) for export.  i.e. new 2507 older than nn days aren't included
 Q 10
 ;
 ;
DIVSTATUS(DVBDIVID,DVBDIVSTATUS)  ;CAPRI-12374:NGC - return an array of name/value pairs for a division. One-stop-shop for division information.
 ;Parameters  - DVBDIVID : division Id
 ;            - ByRef DVBDIVSTATUS : returned array - all data points included even if blank
 N DVBDIVSTORE,DVBOPTIONDA,DVBV,DVBVAR,DVBVARS,DVBEXISTS
 K DVBDIVSTATUS
 S DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA) 0
 ;
 ;div configuration
 S DVBDIVSTORE=$$GETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREDIV("_DVBDIVID_")")
 S DVBDIVSTATUS("divStore")=DVBDIVSTORE
 S DVBVARS="divId|divTimeList|divRowGroup|||||||lastProcessId|lastRunDTM|lastRunCount"
 F DVBV=1:1:$L(DVBVARS,"|") S DVBVAR=$P(DVBVARS,"|",DVBV) S:(DVBVAR'="") DVBDIVSTATUS(DVBVAR)=$P(DVBDIVSTORE,"|",DVBV)
 ;
 ;additional metrics
 S DVBDIVSTATUS("lastRunText")=$S(DVBDIVSTATUS("lastRunDTM")="":"No previous run",1:$$FMTE^XLFDT(DVBDIVSTATUS("lastRunDTM"),"1PM")_" - "_(+DVBDIVSTATUS("lastRunCount"))_" request(s) exported.")
 S DVBDIVSTATUS("name")=$$GET1^DIQ(40.8,DVBDIVID,.01)
 S DVBDIVSTATUS("nextRunDTM")=$$GETNEXTRUN(DVBDIVID)
 S DVBDIVSTATUS("nextRunText")=$$FMTE^XLFDT(DVBDIVSTATUS("nextRunDTM"),"1PM")
 S DVBDIVSTATUS("nextRunCount")=$$GETREQUESTLIST(DVBDIVID)
 S DVBDIVSTATUS("summary")="Next scheduled export "_$$FMTE^XLFDT(DVBDIVSTATUS("nextRunDTM"),"1PM")_"~"_DVBDIVSTATUS("nextRunCount")
 S DVBDIVSTATUS("optionDA")=DVBOPTIONDA
 Q (DVBDIVSTORE'="")
 ;
 ;
PROCESSSTATUS(DVBPROCESSID,DVBPROCESSSTATUS) ;CAPRI-12377:NGC - return an array of metrics for a process event
 ;Parameters - DVBPROCESSID - process Id created at each export
 ;Returns    - ByRef DVBPROCESSSTATUS - array of process metrics
 N DVBOPTIONDA,DVBPROCESSSTORE,DVBVARS,DVBV,DVBVAR,DVBPRIO,DVBREQID,DVBADPGBL,DVBTEXT,DVBREQUESTLIST
 ;
 K DVBPROCESSSTATUS
 S DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA)
 ;
 ;Retrieve stored data fields
 S DVBPROCESSSTORE=$$GETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREPROC("_DVBPROCESSID_")")
 Q:(DVBPROCESSSTORE="")
 S DVBVARS="processId|divId|processDTM|exportMark|prevProcessDTM|runMethod|exportMarkDTM|exportMarkUser|runMethodUser"
 F DVBV=1:1:$L(DVBVARS,"|") S DVBVAR=$P(DVBVARS,"|",DVBV) S:DVBVAR'="" DVBPROCESSSTATUS(DVBVAR)=$P(DVBPROCESSSTORE,"|",DVBV)
 S DVBPROCESSSTATUS("processDate")=$P(DVBPROCESSSTATUS("processDTM"),".")
 ;
 ;Formulate a descriptive 'text' with the Informational Mark.   <dateTime> <mark> by <userName> (not for 'new')
 S DVBTEXT=""  ;this will stay blank for the 'new' status.  Only updated for View/In-Progress/Complete
 D:(DVBPROCESSSTATUS("exportMarkDTM")'="")
 . S DVBTEXT=$$FMTE^XLFDT(DVBPROCESSSTATUS("exportMarkDTM"),"1PM")_". "
 . I (DVBPROCESSSTATUS("exportMark")="opened") S DVBTEXT=DVBTEXT_"Opened "
 . E  S DVBTEXT=DVBTEXT_"Marked as '"_$$TITLE^XLFSTR(DVBPROCESSSTATUS("exportMark"))_"' "
 . S DVBTEXT=DVBTEXT_"by "_$$GET1^DIQ(200,DVBPROCESSSTATUS("exportMarkUser"),.01,"I")
 S DVBPROCESSSTATUS("exportMarkText")=DVBTEXT
 ;
 ;Information on how export was created 'Scheduled' (i.e. taskman), or AdHoc (by <userName>)
 S DVBTEXT=DVBPROCESSSTATUS("runMethod") S:(DVBTEXT'="Scheduled") DVBTEXT=DVBTEXT_" by "_$$GET1^DIQ(200,DVBPROCESSSTATUS("runMethodUser"),.01,"I")
 S DVBPROCESSSTATUS("runMethodText")=DVBTEXT
 ;
 ;Exported Request list
 D GETEXPORTEDLIST(DVBPROCESSSTATUS("divId"),DVBPROCESSSTATUS("processDTM"),.DVBREQUESTLIST)
 M DVBPROCESSSTATUS("request")=DVBREQUESTLIST
 Q
 ;
 ;
GETREQUESTLIST(DVBDIVID,DVBREQUESTLIST) ;CAPRI-12374:NGC - Get a list of requests to be included for a division export
 ;Parameters   - DVBDIVID : division Id (an active division at site)
 ;             - ByRef DVBREQUESTLIST : returned list of request Ids
 ;Returns      - DVBCOUNT of requests in returned DVBREQUESTLIST
 ;Algorithm    - Algorithm based on +42 - +64^DVBCREQP.
 ;               for each request cross reference index (new,modified,examAdded,reRouted) 
 ;                 for all requests in last nn days for the division
 ;                   Exclude from report if "Date sent to MAS" is not blank (already reported)
 ;                   If rerouted type, then exclude if this is the original site and the request has been accepted downstream
 ;                   if included, add to list
 N DVBCURRENTSITE,DVBDATE,DVBINDEX,DVBREQID,DVBREQREC,DVBLATESTREROUTE,DVBLATESTSTATUS
 K DVBREQUESTLIST
 S DVBCURRENTSITE=$P($$SITE^VASITE,"^",3)
 F DVBINDEX="C","AC","AD","AR" D
 . S DVBDATE=$$FMADD^XLFDT(DT,-$$LOOKBACKINTERVAL())
 . ;for each date in the range under consideration
 . F  S DVBDATE=$O(^DVB(396.3,DVBINDEX,DVBDATE)) Q:DVBDATE=""  D
 .. ;for each request on that date
 .. S DVBREQID="" F  S DVBREQID=$O(^DVB(396.3,DVBINDEX,DVBDATE,DVBREQID)) Q:DVBREQID=""  D
 ... S DVBREQREC=^DVB(396.3,DVBREQID,0)
 ... ;request is not included if has a (Date Reported to MAS) or (not for the division selected)
 ... Q:($P(DVBREQREC,"^",5)'="")  Q:($P($G(^DVB(396.3,DVBREQID,1)),"^",4)'=DVBDIVID)
 ... ;request is not included if rerouted from this site and accepted elsewhere
 ... S DVBLATESTREROUTE=$O(^DVB(396.3,DVBREQID,6,99999),-1),DVBLATESTSTATUS="X"
 ... S:(DVBLATESTREROUTE'="") DVBLATESTSTATUS=$O(^DVB(396.3,DVBREQID,6,DVBLATESTREROUTE,1,99999),-1)
 ... Q:(DVBCURRENTSITE=$P($G(^DVB(396.3,DVBREQID,6,1,2)),"^",4))&("NA"[DVBLATESTSTATUS)  ;rerouted from here and not rejected (ie. New or Accepted)
 ... S DVBREQUESTLIST(DVBREQID)=""
 ... Q
 .. Q
 . Q
 ;Count final requests
 S DVBREQID="" F DVBREQUESTLIST=0:1 S DVBREQID=$O(DVBREQUESTLIST(DVBREQID)) Q:DVBREQID=""
 Q DVBREQUESTLIST
 ;
 ;
GETNEXTRUN(DVBDIVID)  ;CAPRI-12374:NGC - Get the Date,Time of the next scheduled run for a division.
 ;Algorithm (See also NRE Soln Technical Document)
 ;          Take Date,Time of next run from Taskman properties if no entry use dvbTime now.
 ;          deduct five minutes - or to midnight - which give the time of the last run,
 ;          return the first entry in the export schedule beyond this dvbTime.
 N DVBDIVSTORE,DVBDIVTIMELIST,DVBHRS,DVBMINS,DVBNOWTIME,DVBOPTIONDA,DVBSCHEDNEXTDATE,DVBSCHEDNEXTTIME,DVBLASTTIME,DVBTIMEINDEX,DVBTIMEITEM,DVBTIMEARRAY
 S DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA) ""
 ; subtract solution run interval from now which should be last time taskman ran this job
 S DVBNOWTIME=$P($$NOW^XLFDT,".",2),DVBHRS=$E(DVBNOWTIME,1,2),DVBMINS=$E(DVBNOWTIME,3,4)
 S DVBMINS=DVBMINS-1 S:DVBMINS<0 DVBHRS=DVBHRS-1,DVBMINS=DVBMINS+60 S:DVBHRS<0 DVBHRS=0,DVBMINS=0
 S DVBLASTTIME="#"_$TR($J(DVBHRS,2)," ",0)_$TR($J(DVBMINS,2)," ",0) ; add # to prevent stripping leading zeroes
 ;retrieve date and dvbTime of last process
 S DVBDIVSTORE=$$GETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREDIV("_DVBDIVID_")")
 ;create an array of schedule times
 S DVBDIVTIMELIST=$P(DVBDIVSTORE,"|",2),DVBSCHEDNEXTDATE=$P(DT,".",1) S:DVBDIVTIMELIST="" DVBDIVTIMELIST="0800"
 F DVBTIMEINDEX=1:1 S DVBTIMEITEM=$P(DVBDIVTIMELIST,",",DVBTIMEINDEX) Q:DVBTIMEITEM=""  S DVBTIMEARRAY("#"_DVBTIMEITEM)=""
 ;$O to get the next run time starting at now-1minutes.  If not found choose first time tomorrow
 S DVBSCHEDNEXTTIME=$O(DVBTIMEARRAY(DVBLASTTIME)) S:DVBSCHEDNEXTTIME="" DVBSCHEDNEXTDATE=DVBSCHEDNEXTDATE+1,DVBSCHEDNEXTTIME=$O(DVBTIMEARRAY(""))
 Q DVBSCHEDNEXTDATE_"."_$E(DVBSCHEDNEXTTIME,2,5)
 ;
 ;
GETEXPORTEDLIST(DVBDIVID,DVBEXPORTDTM,DVBREQUESTLIST) ;CAPRI-12377:NGC - Get list of requests 'exported' at the specified DVBEXPORTDTM
 ;Algorithm.  Because ^DVB(396.3,"ADP",<dateReported>,<prio>,<requestId>) index is not reliable . . .
 ; Recreate list of requests considered in the original export process.  i.e. requests upto <lookBackInterval> days before process date in each of 4 indexes
 ; Include in the export list if the Date/Time reported to MAS is for the export
 N DVBINDEX,DVBDATE,DVBREQID
 K DVBREQUESTLIST
 F DVBINDEX="C","AC","AD","AR" D
 . S DVBDATE=$$FMADD^XLFDT($P(DVBEXPORTDTM,"."),-$$LOOKBACKINTERVAL,0,0,0)
 . F  S DVBDATE=$O(^DVB(396.3,DVBINDEX,DVBDATE)) Q:DVBDATE=""  D
 .. S DVBREQID="" F  S DVBREQID=$O(^DVB(396.3,DVBINDEX,DVBDATE,DVBREQID)) Q:DVBREQID=""  D
 ... Q:($P($G(^DVB(396.3,DVBREQID,1)),"^",4)'=DVBDIVID)  ; request not for the division selected
 ... S:($P(^DVB(396.3,DVBREQID,0),"^",5)=DVBEXPORTDTM) DVBREQUESTLIST(DVBREQID)=$G(DVBREQUESTLIST(DVBREQID))_" "_DVBINDEX_" "
 ... Q
 .. Q
 . Q
 ;Count requests
 S DVBREQID="" F DVBREQUESTLIST=0:1 S DVBREQID=$O(DVBREQUESTLIST(DVBREQID)) Q:DVBREQID=""
 Q
 ;
 ;
PROCESSEXPORT(DVBDIVID,DVBDIVSTATUS,DVBRUNMETHOD)  ;CAPRI-12378:NGC - called by TMPROCESS above and also when doing ad-hoc export
 ;Algorithm
 ;  Get List of included dvbRequests (GETREQUESTLIST)
 ;  Reorder into a sorted list (keyed on category if so configured)
 ;  Get next process Id and update in file
 ;  Create the export file
 ;  Store the new process record
 N DVBCSVROW,DVBFILENAME,DVBNOWTIME,DVBOPTIONDA,DVBPROCESSID,DVBPROCESSSTORE,DVBREQSTT,DVBDIVSTORE
 N DVBREQCAT,DVBREQDTM,DVBREQID,DVBREQLIST,DVBREQREC
 N DVBSOLUTIONSTORE,DVBSORTKEY,DVBSORTLIST,DVBSORTREC,DVBSTATUSSORT
 ;
 S DVBNOWTIME=$$NOW^XLFDT
 S DVBOPTIONDA=$$FINDIDBYNAME^DVBLIBTM("DVBA CAPRI NRE PROCESS TM") Q:('+DVBOPTIONDA)
 D:($O(DVBDIVSTATUS(""))="") DIVSTATUS(DVBDIVID,.DVBDIVSTATUS)
 D GETREQUESTLIST(DVBDIVID,.DVBREQLIST)
 ;
 S DVBREQID=""
 F  S DVBREQID=$O(DVBREQLIST(DVBREQID)) Q:DVBREQID=""  D
 . K DIC,DIE,DA,DR,X,Y
 . S DVBREQCAT=DVBREQLIST(DVBREQID)
 . S DVBREQREC=^DVB(396.3,DVBREQID,0),DVBREQSTT=$P(DVBREQREC,"^",18)
 . ;Update Status and Date reported to MAS (only status changes as below - fileMan will update the status change date)
 . I DVBREQSTT=1 S DIE="^DVB(396.3,",DA=DVBREQID,DR="17////2" D ^DIE    ; New -> Pending,Reported 
 . I DVBREQSTT=9 S DIE="^DVB(396.3,",DA=DVBREQID,DR="17////2" D ^DIE    ; New,Transferred In -> Pending,Reported
 . I DVBREQSTT=11 S DIE="^DVB(396.3,",DA=DVBREQID,DR="17////14" D ^DIE  ; New,Rerouted -> Rerouted,Pending Acceptance
 . S DIE="^DVB(396.3,",DA=DVBREQID,DR="4////"_DVBNOWTIME D ^DIE         ; date reported to MAS.  All 2507s get this
 . K DIC,DIE,DA,DR,X,Y
 . Q
 ;
 ;get and update the next DVBPROCESSID
 S DVBSOLUTIONSTORE=$$GETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANRESOLN")
 S DVBPROCESSID=$P(DVBSOLUTIONSTORE,"|",1) S:DVBPROCESSID="" DVBPROCESSID=1000000 S DVBPROCESSID=DVBPROCESSID+1
 S $P(DVBSOLUTIONSTORE,"|",1)=DVBPROCESSID
 D SETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANRESOLN",DVBSOLUTIONSTORE)
 ;
 ;Create Process Record for this export
 S DVBDIVSTORE=DVBDIVSTATUS("divStore")
 S DVBPROCESSSTORE="" ; processId | divId |  dateTime | exportMark | prevRunDTM | runMethod |exportMarkDTM | exportMarkUser | runMethodUser
 S $P(DVBPROCESSSTORE,"|",1)=DVBPROCESSID
 S $P(DVBPROCESSSTORE,"|",2)=DVBDIVID
 S $P(DVBPROCESSSTORE,"|",3)=DVBNOWTIME
 S $P(DVBPROCESSSTORE,"|",4)="new"
 S $P(DVBPROCESSSTORE,"|",5)=$P(DVBDIVSTORE,"|",11) ; prev run DTM
 S $P(DVBPROCESSSTORE,"|",6)=DVBRUNMETHOD
 S $P(DVBPROCESSSTORE,"|",7)="" ; mark DTM blank for new entries
 S $P(DVBPROCESSSTORE,"|",8)="" ; mark User blank for new entries
 S $P(DVBPROCESSSTORE,"|",9)=DUZ ; processing User
 D SETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREPROC("_DVBPROCESSID_")",DVBPROCESSSTORE)
 ;
 ;Update Division record with the 'last process id', 'process time' and 'request counts' fields
 S $P(DVBDIVSTORE,"|",10)=DVBPROCESSID
 S $P(DVBDIVSTORE,"|",11)=$E(DVBNOWTIME_"0000",1,12)
 S $P(DVBDIVSTORE,"|",12)=DVBREQLIST
 D SETNAMEDVALUE^DVBLIBTM(DVBOPTIONDA,"DVBANREDIV("_DVBDIVID_")",DVBDIVSTORE)
 Q
 ;
 ;
VALSAVESTRING(DVBDIVSAVESTRING)  ;CAPRI-12376:NGC - validate the save string , updating if needed.  Return errorText or null
 ;Parameters - DVBDIVSAVESTRING - the (^) delimited string from CAPRI
 ;Returns    - Error String or ""
 N DIVID,DVBTIMELIST,DVBTIMEARRAY,DVBTIMEITEM,DVBINDEX,DVBERROR
 S DVBTIMELIST=$TR($P(DVBDIVSAVESTRING,"^",2),": "),DVBERROR=""
 S DIVID=$P(DVBDIVSAVESTRING,"^",1)
 ;Validate divId
 Q:(DIVID="") "Invalid Division Id (Blank) in save instruction"
 Q:('$D(^DVB(396.1,1,3,"B",DVBDIVID))) "Invalid Division Id ("_DIVID_") in save instruction"
 ;Validate timeList
 Q:(DVBTIMELIST="") "Run Times is a required entry"
 F DVBINDEX=1:1 S DVBTIMEITEM=$P(DVBTIMELIST,",",DVBINDEX) Q:DVBTIMEITEM=""  D
 . I (DVBTIMEITEM'?4N)!($E(DVBTIMEITEM,1,2)>23)!($E(DVBTIMEITEM,3,4)>59) S DVBERROR="Time item '"_DVBTIMEITEM_"' is not valid"
 . E  S DVBTIMEARRAY("#"_DVBTIMEITEM)=""
 S DVBTIMELIST="",DVBTIMEITEM=""
 F  S DVBTIMEITEM=$O(DVBTIMEARRAY(DVBTIMEITEM)) Q:DVBTIMEITEM=""  S DVBTIMELIST=DVBTIMELIST_$S(DVBTIMELIST="":"",1:",")_$E(DVBTIMEITEM,2,5)
 S $P(DVBDIVSAVESTRING,"^",2)=DVBTIMELIST
 Q DVBERROR

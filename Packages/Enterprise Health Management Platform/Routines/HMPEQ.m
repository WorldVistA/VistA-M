HMPEQ ;SLC/MJK,ASMR/RRB - HMP Freshness Utilities;02-JUL-2014
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; -- go to event queue viewer (convenience tag)
 D EN^HMPEQLM
 Q
 ;
EVTS(DATA,PARAMS) ; -- return events for server's last stream in inverse sequence # order
 ; input: PARAMS("server") := ien of 800000
 ;               "filter") := event state filter [ P:processed | W:waiting ]
 ;               "domain") := domain of interest or "ALL'
 ;                  "dfn") := dfn of desired patient
 ;                  "max") := max number events to return
 ;
 ; output: @DATA@("stream") := name of stream for server
 ;                 "count") := number of events returned
 ; "events",<n>,"sequence") := sequence # / node in stream for event
 ;     "events",<n>,"node") := event node for sequence
 ;
 N STREAM,DOMAIN,FILTER,PAT,SEQ,MAX,CNT,X
 S STREAM=$$LSTREAM^HMPDJFSM(+$G(PARAMS("server")))
 S DOMAIN=$G(PARAMS("domain"))
 S FILTER=$G(PARAMS("filter"))
 S PAT=+$G(PARAMS("dfn"))
 S MAX=$G(PARAMS("max"),10)
 S CNT=0
 S SEQ=" "
 F  S SEQ=$O(^XTMP(STREAM,SEQ),-1) Q:'SEQ  S X=^(SEQ) D  Q:CNT=MAX
 . I DOMAIN'="ALL",DOMAIN'=$P(X,"^",2) Q
 . ; quit if waiting and want processed
 . I FILTER["P",'$P(X,"^",6) Q
 . ; quit if processed and want waiting
 . I FILTER["W",'$P(X,"^",6) Q
 . ; quit if not patient desired
 . I PAT,PAT'=+X Q
 . S CNT=CNT+1
 . S @DATA@("events",CNT,"sequence")=SEQ
 . S @DATA@("events",CNT,"node")=X
 ;
 S @DATA@("stream")=STREAM
 S @DATA@("count")=CNT
 Q
 ;
GETEVTS(RET,PARAMS) ; -- get events for server's last stream in inverse sequence # order
 ; RPC: HMPM EVT QUE GET EVTS (future)
 N HMPDATA,HMPERR
 S HMPDATA=$NA(^TMP("HMPM EVT QUE GET EVTS",$J))
 K @HMPDATA
 D EVTS(HMPDATA,.PARAMS)
 D ENCODE^HMPJSON(HMPDATA,RET,"HMPERR")
 K @HMPDATA
 Q
 ;
SRVS(DATA) ; -- loop thru & sort by server names and return summary freshness queue info for each
 ; output:        @DATA@("servers",<n>,"name")      := server name
 ;                       "server",<n>,"lastUpdate") := date server last updated
 ;                       "server",<n>,"repeated")   := how many times updated
 ;                       "server",<n>,"stream")     := stream name
 ;                       "server",<n>,"queueEnd")   := current end of queue
 ;         "server",<n>,"extracts",<n>,"domain")    := domain name
 ;         "server",<n>,"extracts",<n>,"tasks")     := tasks waiting to be processed
 ;         "server",<n>,"extracts",<n>,"waiting")   := how many seconds waiting
 ;         "server",<n>,"extracts",<n>,"lastCount") := last count retrieved or <finished>
 ;
 N HMPSRVNM,HMPCNT,IEN
 S HMPSRVNM=""
 S HMPCNT=0
 F  S HMPSRVNM=$O(^HMP(800000,"B",HMPSRVNM)) Q:HMPSRVNM=""  S IEN=$O(^(HMPSRVNM,"")) D
 . S HMPCNT=HMPCNT+1
 . D SRV($NA(@DATA@("servers",HMPCNT)),IEN)
 Q
 ;
SRV(DATA,SRV) ; -- process one server
 N X0,ROOT,BATCH,STREAM,SRVNM,TASK,TASKS,ENDQ,EXTRACT,CNT
 S X0=$G(^HMP(800000,SRV,0))
 Q:X0=""
 S SRVNM=$P(X0,"^")
 S @DATA@("name")=$P(X0,"^")
 S @DATA@("lastUpdate")=$P(X0,"^",2)
 S @DATA@("repeated")=$P(X0,"^",4)
 S STREAM=$$LSTREAM^HMPDJFSM(SRV)
 S @DATA@("stream")=STREAM
 S @DATA@("queueEnd")=$S($D(^XTMP(STREAM)):$P(STREAM,"~",3)_"-"_$G(^XTMP(STREAM,"last")),1:"")
 ;
 ; -- loop thru extracts for this server
 S ROOT="HMPFX~"_SRVNM_"~"
 S BATCH=ROOT
 S CNT=0
 F  S BATCH=$O(^XTMP(BATCH)) Q:$E(BATCH,1,$L(ROOT))'=ROOT  D
 . S CNT=CNT+1
 . S @DATA@("extracts",CNT,"domain")=$P(BATCH,"~",3)
 . S TASK=0,TASKS=""
 . F  S TASK=$O(^XTMP(BATCH,0,"task",TASK)) Q:'TASK  S TASKS=TASKS_$S($L(TASKS):",",1:"")_TASK
 . S @DATA@("extracts",CNT,"tasks")=TASKS
 . I '$D(^XTMP(BATCH,0,"wait")) S @DATA@("extracts",CNT,"waiting")=$$WAIT^HMPDJFSM(BATCH) Q
 . S @DATA@("extracts",CNT,"lastCount")=$$LOBJ^HMPDJFSM(BATCH,TASK)
 Q
 ;
GETSRVS(RET) ; -- get summary freshness event queue info for all servers
 ; RPC: HMPM EVT QUE GET SVRS (future)
 N HMPDATA,HMPERR
 S HMPDATA=$NA(^TMP("HMPM EVT QUE GET SVRS",$J))
 K @HMPDATA
 D SRVS(HMPDATA)
 D ENCODE^HMPJSON(HMPDATA,RET,"HMPERR")
 K @HMPDATA
 Q
 ;
GLBS(DATA) ; -- return summary info on HMP related temp globals
 ; output: @HMPDATA@(    "xtmpNodes",<n>,"server")     := server name
 ;                       "xtmpNodes",<n>,"rootNode")   := ^XTMP root node for server/stream
 ;                       "xtmpNodes",<n>,"lastNode")   := last sequence in root structure
 ;
 ;                       "tmpJobNodes",<n>,"rootNode") := root ^TMP("HMP*",$J) node
 ;                       "tmpJobNodes",<n>,"lastNode") := last sequence in root structure
 ;
 ;                       "jobTmpNodes",<n>,"rootNode") := root ^TMP($J,"HMP*") node
 ;                       "jobTmpNodes",<n>,"lastNode") := last sequence in root structure
 ;
 N HMPX,CNT,J,Y,RNODE
 S HMPX="VPQ~"
 S CNT=0
 F  S HMPX=$O(^XTMP(HMPX)) Q:$E(HMPX,1,3)'="HMP"  D
 . S CNT=CNT+1
 . S @DATA@("xtmpNodes",CNT,"server")=$P(HMPX,"~",2)
 . S @DATA@("xtmpNodes",CNT,"rootNode")="^XTMP("""_HMPX_""")"
 . S Y=$O(^XTMP(HMPX," "),-1)
 . S:'$L(Y) Y=$O(^XTMP(HMPX,""),-1)
 . S @DATA@("xtmpNodes",CNT,"lastNode")=Y
 ;
 S HMPX="VPQ~"
 S CNT=0
 F  S HMPX=$O(^TMP(HMPX)) Q:$E(HMPX,1,3)'="HMP"  D
 . S J=0
 . F  S J=$O(^TMP(HMPX,J)) Q:'J  D
 . . ; -- don't include this report's ^TMP
 . . S RNODE="^TMP("""_HMPX_""","_J_")"
 . . I RNODE=DATA,J=$J Q
 . . S CNT=CNT+1
 . . S @DATA@("tmpJobNodes",CNT,"rootNode")=RNODE
 . . S Y=$O(^TMP(HMPX,J," "),-1)
 . . S:'$L(Y) Y=$O(^TMP(HMPX,J,""),-1)
 . . S @DATA@("tmpJobNodes",CNT,"lastNode")=Y
 ;
 S (J,CNT)=0
 F  S J=$O(^TMP(J)) Q:'J  D
 . S HMPX="VPQ~"
 . F  S HMPX=$O(^TMP(J,HMPX)) Q:$E(HMPX,1,3)'="HMP"  D
 . . S CNT=CNT+1
 . . S @DATA@("jobTmpNodes",CNT,"rootNode")="^TMP("_J_","""_HMPX_""")"
 . . S Y=$O(^TMP(J,HMPX," "),-1)
 . . S:'$L(Y) Y=$O(^TMP(J,HMPX,""),-1)
 . . S @DATA@("jobTmpNodes",CNT,"lastNode")=Y
 ;
 Q
 ;
GETGLBS(RET) ; -- get summary info on HMP related temp globals
 ; RPC: HMPM EVT QUE GET GLBS (future)
 N HMPDATA,HMPERR
 S HMPDATA=$NA(^TMP("HMPM EVT QUE GET GLBS",$J))
 K @HMPDATA
 D GLBS(HMPDATA)
 D ENCODE^HMPJSON(HMPDATA,RET,"HMPERR")
 K @HMPDATA
 Q
 ;
NOROWS(MSG) ; -- add standard text lines to indicate no rows to display
 S VALMCNT=1
 S @VALMAR@(VALMCNT,0)=""
 S VALMCNT=2
 S @VALMAR@(VALMCNT,0)="     o  "_MSG
 D CNTRL^VALM10(VALMCNT,2,78,IOINHI,IOINORM)
 Q
 ;

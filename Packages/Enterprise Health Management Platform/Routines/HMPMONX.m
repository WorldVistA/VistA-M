HMPMONX ;asmr-ven/toad-dashboard: xtmp size ;2016-06-29 19:42Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONX
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; original authors: Melanie Buechler (mkb) & Kevin Meldrum (kcm)
 ; other authors: Jamshid Denegarian (jd) & Raymond Hsu (hsu)
 ; original org: U.S. Department of Veterans Affairs (va)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2015-11-02/2016-02-29 va/hsu: refine HMPTOOLS, then develop
 ; HMPDBMN1.
 ;
 ; 2016-03-21/04-14 asmr-ven/toad: create routine HMPMONX from
 ; HMPTOOLS; add $$XTMPSIZE to include calculation and units;
 ; replace write @IOF with do FORMFEED^HMPMONL; eliminate MON (old
 ; XTMP monitor option will be retired), refactor top to bottom,
 ; repair $$GETSIZE based on version in HMPUTILS; update comments to
 ; capture calls into SIZE and $$GETSIZE; fix org & history.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; $$XTMPSIZE = approximate size of ehmp's xtmp use in kb
 ; SIZE: remote procedure HMP GLOBAL SIZE: return ^XTMP size
 ; $$GETSIZE = size of extracts waiting to send
 ; $$WALK = walk domain objects in task to get actual size
 ; CHKXTMP: remote procedure HMP CHKXTMP: return ^XTMP state
 ;
 ;
 ; to do
 ;
 ; convert hard-coded text to Dialog file entries
 ; replace writes with new writer that can reroute output to arrays
 ; replace reader calls with new reader that can:
 ;   1. take pre-answers from arrays
 ;   2. write all outputs to arrays
 ;   3. with each feature independently adjustable
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
XTMPSIZE() ; approximate size of ehmp's xtmp use in kb
 ;ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   $$SXTMPSIZ^HMPMOND: screen-field xtmp-size
 ; calls:
 ;   $$GETSIZE = size of extracts waiting to send
 ; input:
 ; output = size in kb
 ; examples:
 ;   [develop examples]
 ;
 new XTMPKB set XTMPKB=$$GETSIZE("actual")/1000+.5 ; kilobytes
 set XTMPKB=XTMPKB_" KB"
 ;
 quit XTMPKB ; return size of xtmp ; end of $$XTMPSIZE
 ;
 ;
SIZE(RESULT) ; remote procedure HMP GLOBAL SIZE: return ^XTMP size
 ;islc/mkb&kcm,ven/toad;private;procedure;clean;silent;sac
 ; called by:
 ;   remote procedure HMP GLOBAL SIZE
 ; calls:
 ;   $$GETSIZE = size of extracts waiting to send
 ; input:
 ;   from the database, within $$GETSIZE
 ; output:
 ;  .RESULT
 ; examples:
 ;   [develop examples]
 ;
 set RESULT(1)=$piece($$GETSIZE("actual"),"^")
 ;
 quit
 ;
 ;
GETSIZE(MODE,SERVER) ; size of extracts waiting to send
 ;islc/mkb&kcm,ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   $$XTMPSIZE = approximate size of ehmp's xtmp use in kb
 ;   SIZE: remote procedure HMP GLOBAL SIZE: return ^XTMP size
 ;   $$CHKSIZE^HMPDJFSP: Aggregate extract ^XTMP size strategy
 ;   MESNOK^HMPMETA: Mail message if ^XTMP too big
 ; calls:
 ;   GETLST^XPAR: get typical sizes of ehmp domains
 ;   $$WALK = walk domain objects in task to get actual size
 ; input:
 ;    MODE = "estimate" = use estimated domain average sizes, default
 ;           "actual" = walk object nodes to calculate using $length
 ;    SERVER = name of ehmp server, defaults to all ehmp servers
 ; output = size in bytes ^ object count
 ; examples:
 ;   [develop examples]
 ;
 set MODE=$get(MODE,"estimate")
 new OBJSIZES
 if MODE="estimate" do
 . do GETLST^XPAR(.OBJSIZES,"PKG","HMP DOMAIN SIZES","I")
 . quit
 ;
 new SIZE set SIZE=0
 new OBJECTS set OBJECTS=0
 new DONE set DONE=0
 ;
 set SERVER=$get(SERVER)
 new ROOT set ROOT="HMPFX~" ; root for all servers
 if SERVER'="" do  ; if size for just one server
 . set ROOT=ROOT_SERVER_"~" ; change root
 . quit
 new BATCH set BATCH=ROOT
 ;
 for  do  quit:DONE  ; traverse extracts
 . set BATCH=$order(^XTMP(BATCH)) ; get next extract
 . set DONE=BATCH="" ; out of ^XTMP nodes?
 . quit:DONE
 . ;
 . set DONE=$extract(BATCH,1,$length(ROOT))'=ROOT
 . set DONE=$piece(BATCH,ROOT)'="" ; out of nodes with root prefix?
 . quit:DONE
 . ;
 . new TASK set TASK=0
 . for  do  quit:'TASK  ; traverse extract tasks
 . . set TASK=$order(^XTMP(BATCH,TASK)) ; get next task
 . . quit:'TASK
 . . ;
 . . new DOMAIN set DOMAIN=""
 . . for  do  quit:DOMAIN=""  ; traverse domains
 . . . set DOMAIN=$order(^XTMP(BATCH,TASK,DOMAIN)) ; get next domain
 . . . quit:DOMAIN=""
 . . . ;
 . . . new DOMOBJS
 . . . set DOMOBJS=+$order(^XTMP(BATCH,TASK,DOMAIN," "),-1)
 . . . set OBJECTS=OBJECTS+DOMOBJS
 . . . ;
 . . . if MODE="actual" do  ; for actual-mode
 . . . . set SIZE=SIZE+$$WALK(BATCH,TASK,DOMAIN)
 . . . . quit
 . . . else  do  ; for estimate-mode
 . . . . new DOMNAME set DOMNAME=$piece(DOMAIN,"#")
 . . . . new DOMSIZE set DOMSIZE=$get(OBJSIZES(DOMNAME),1000)
 . . . . set SIZE=DOMOBJS*DOMSIZE+SIZE
 . . . . quit
 . . . quit
 . . quit
 . quit
 ;
 quit SIZE_"^"_OBJECTS
 ;
 ;
WALK(BATCH,TASK,DOMAIN) ; walk domain objects in task to get actual size
 ;islc/mkb&kcm,ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   $$GETSIZE = size of extracts waiting to send
 ; calls: none
 ; input:
 ;   BATCH = extract-batch id
 ;   TASK = extract-batch task #
 ;   DOMAIN = extract-batch domain id
 ; output = size of domain objects
 ; examples:
 ;   [develop examples]
 ;
 new SIZE set SIZE=0
 new OBJECT set OBJECT=0
 for  do  quit:'OBJECT
 . set OBJECT=$order(^XTMP(BATCH,TASK,DOMAIN,OBJECT))
 . quit:'OBJECT
 . new NODE set NODE=0
 . for  do  quit:'NODE
 . . set NODE=$order(^XTMP(BATCH,TASK,DOMAIN,OBJECT,NODE))
 . . quit:'NODE
 . . set SIZE=SIZE+$length($get(^XTMP(BATCH,TASK,DOMAIN,OBJECT,NODE)))
 . . quit
 . quit
 ;
 quit SIZE ; return size of domain objects ; end of $$WALK
 ;
 ;
CHKXTMP(RESULT) ; remote procedure HMP CHKXTMP: return ^XTMP state
 ;islc/mkb&kcm,ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   remote procedure HMP CHKXTMP
 ;   $$SQUEUE^HMPMOND: screen-field queue status
 ; calls: none
 ; input:
 ; output:
 ;  .RESULT = return erray
 ;        "There are a total of xxx patients in queue.  yyy Complete"
 ;        "zzz Staging", where xxx,yyy, and zzz are zero or greater.
 ;        note: if xxx is zero, the sentence after "queue." will not
 ;        be displayed
 ; examples:
 ;   [develop examples]
 ;
 ; Goes through ^XTMP and figures out the total number of patients, how many
 ; have completed data staging, and how many are still staging.
 ; There is code to allow a bit more information than requested to be stored
 ; in a global (^TMP("FINDSTATUS",$J)) for future needs (e.g. Complete/staging
 ; is broken down by domain).  *** This currently commented out ***.
 ;
 ; ^XTMP("HMPFX~<server id>~DFN",0,"status",<domain>) = status, where
 ; status = 1 means data is completely staged and 0 means data is being
 ; staged but not complete yet.
 ;
 ; GLB      = ^TMP("FINDSTATUS",$job)  (FUTURE USE)
 ; BATCH    = "HMPFX~<sever id>~DFN"
 ; PATDONE  = Number of patients who have completed staging
 ; DOMDONE  = Number of domains that have completed staging for a patient
 ; DOMSTAT  = Domain status (1 = complete; 0 = staging)
 ; PATIENT  = Patient IEN
 ; DOMAIN   = Patient domain (e.g. lab, med, allergy, etc.)
 ; PATSTAGE = Number of patients who are still in the staging state
 ; DOMSTAGE = Number of domains that are still staging for a patient
 ; TOTAL    = PATDONE+PATSTAGE
 ;
 ; new GLB set GLB=$name(^TMP("FINDSTATUS",$job))
 ; kill @GLB
 new PATDONE set PATDONE=0
 new PATSTAGE set PATSTAGE=0
 new EXIT set EXIT=0
 new BATCH set BATCH="HMPFX"
 for  do  quit:EXIT
 . set BATCH=$order(^XTMP(BATCH))
 . set EXIT=BATCH="" ; out of ^xtmp nodes
 . quit:EXIT
 . ;
 . set EXIT=$piece(BATCH,"HMPFX")'=""
 . quit:EXIT
 . ;
 . new PATIENT set PATIENT=$piece(BATCH,"~",3)
 . new DOMDONE set DOMDONE=0
 . new DOMSTAGE set DOMSTAGE=0
 . quit:PATIENT'=+PATIENT  ; patients only
 . ;
 . new DOMAIN set DOMAIN=""
 . for  do  quit:DOMAIN=""
 . . set DOMAIN=$order(^XTMP(BATCH,0,"status",DOMAIN))
 . . quit:DOMAIN=""
 . . new DOMSTAT set DOMSTAT=^XTMP(BATCH,0,"status",DOMAIN)
 . . if DOMSTAT=1 do
 . . . set DOMDONE=DOMDONE+1
 . . . ; set @GLB@(PATIENT,DOMAIN)="Complete"
 . . . quit
 . . if DOMSTAT'=1 do
 . . . set DOMSTAGE=DOMSTAGE+1
 . . . ; set @GLB@(PATIENT,DOMAIN)="Staging"
 . . . quit
 . . quit
 . ;
 . if DOMSTAGE>0 do
 . . set PATSTAGE=PATSTAGE+1
 . . ; set @GLB@(PATIENT)="Staging"
 . . quit
 . if DOMSTAGE'>0 do
 . . set PATDONE=PATDONE+1
 . . ; set @GLB@(PATIENT)="Complete"
 . . quit
 . quit
 ;
 new TOTAL set TOTAL=PATDONE+PATSTAGE
 ;
 kill RESULT
 set RESULT(1)="There are a total of "_TOTAL_" patient"
 set RESULT(1)=RESULT(1)_$select(TOTAL=1:"",1:"s")_" in queue."
 if PATDONE>0 do
 . set RESULT(1)=RESULT(1)_"  "_PATDONE_" Complete"
 . quit
 if PATSTAGE>0 do
 . set RESULT(1)=RESULT(1)_"  "_PATSTAGE_" Staging"
 . quit
 ;
 quit
 ;
 ;
EOR ; end of routine HMPMONX

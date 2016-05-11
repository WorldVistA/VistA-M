HMPTOOLS ;ASMR/JD - More HMP utilities ; 9/25/15 10:59am
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHKXTMP(RSLT) ; RPC(HMP CHKXTMP) to return the state of ^XTMP data
 ; RSLT - Return array:
 ;        "There are a total of xxx patients in queue.  yyy Complete  zzz Staging"
 ;        Where xxx,yyy, and zzz are zero or greater.
 ;        NOTE: If xxx is zero, then the sentence after "queue." will NOT be displayed
 ;
 ; Goes through ^XTMP and figures out the total number of patients, how many
 ; have completed data staging, and how many are still staging.
 ; There is code to allow a bit more information than requested to be stored
 ; in a global (^TMP("FINDSTATUS",$J)) for future needs (e.g. Complete/staging
 ; is broken down by domain).  *** This currently commented out ***.
 ;
 ; ^XTMP("HMPFX~<server id>~DFN",0,"status",<domain>)=STATUS, where STATUS=1 means
 ; data is completely staged and 0 means data is being staged but not complete yet.
 ;
 ; GLB    = ^TMP("FINDSTATUS",$J)  (FUTURE USE)
 ; HMPBAT = "HMPFX~<sever id>~DFN"
 ; HMPCM  = Number of patients who have completed staging
 ; HMPCMP = Number of domains that have completed staging for a patient
 ; HMPCNT = Domain status (1 = complete; 0 = staging)
 ; HMPDFN = Patient IEN
 ; HMPDOM = Patient domain (e.g. lab, med, allergy, etc.)
 ; HMPST  = Number of patients who are still in the staging state
 ; HMPSTG = Number of domains that are still staging for a patient
 ; HMPT   = HMPCM+HMPST
 ;
 N GLB,HMPBAT,HMPCM,HMPCMP,HMPCNT,HMPDFN,HMPDOM,HMPST,HMPSTG,HMPT
 ;S GLB=$NA(^TMP("FINDSTATUS",$J))
 ;K @GLB
 S HMPBAT="HMPFX",(HMPCM,HMPST)=0
 F  S HMPBAT=$O(^XTMP(HMPBAT)) Q:$E(HMPBAT,1,5)'="HMPFX"  D
 .S HMPDOM="",HMPDFN=$P(HMPBAT,"~",3),(HMPCMP,HMPSTG)=0
 .I HMPDFN'=+HMPDFN Q  ; Patients ONLY!
 .F  S HMPDOM=$O(^XTMP(HMPBAT,0,"status",HMPDOM)) Q:HMPDOM']""  D
 ..S HMPCNT=^XTMP(HMPBAT,0,"status",HMPDOM)
 ..I HMPCNT=1 D
 ...S HMPCMP=HMPCMP+1
 ...;S @GLB@(HMPDFN,HMPDOM)="Complete"
 ..I HMPCNT'=1 D
 ...S HMPSTG=HMPSTG+1
 ...;S @GLB@(HMPDFN,HMPDOM)="Staging"
 .I HMPSTG>0 D
 ..S HMPST=HMPST+1
 ..;S @GLB@(HMPDFN)="Staging"
 .I HMPSTG'>0 D
 ..S HMPCM=HMPCM+1
 ..;S @GLB@(HMPDFN)="Complete"
 S HMPT=HMPCM+HMPST
 K RSLT
 S RSLT(1)="There are a total of "_HMPT_" patient"_$S(HMPT=1:"",1:"s")_" in queue."
 I HMPCM>0 S RSLT(1)=RSLT(1)_"  "_HMPCM_" Complete"
 I HMPST>0 S RSLT(1)=RSLT(1)_"  "_HMPST_" Staging"
 Q
 ;
MON ; Monitor the progress of ^XTMP growth.  JD - 6/11/15
 N DONE,SIZE,RES
 D HOME^%ZIS
 S DONE=-1
 F  Q:DONE'=-1  D
 .S SIZE=+$P($P($$GETSIZE(),U)/1000+.5,".")
 .W @IOF,"eHMP usage of ^XTMP = "_SIZE_"  kilo byte(s)"
 .D CHKXTMP(.RES)
 .W !!,RES(1)
 .W !!,"Hit any key to exit the monitor"
 .X "R *DONE:2"
 Q
 ;
SIZE(RSLT) ; calculate the size of XTMP global
 S RSLT(1)=$P($$GETSIZE(),"^")
 Q
 ;
GETSIZE(HMPMODE,HMPSRVN) ; -- returns current aggregate extract size for extracts waiting to be sent to HMP servers
 ; input: HMPMODE := [ estimate - use estimated domain average sizes (default) |
 ;                     actual - walk though object nodes to calculate using $LENGTH ]
 ;        HMPSRVN := name of HMP server [optional - defaults to all HMP servers]
 ; returns: total size in bytes ^ object count
 ;
 ; -- loop thru extracts for server(s) 
 N ROOT,BATCH,TASK,DOMAIN,OBJS,OBJCNT,OBJSIZES,TOTAL
 S (OBJCNT,TOTAL)=0
 S ROOT="HMPFX~"_$S($G(HMPSRVN)]"":HMPSRVN_"~",1:"")
 S BATCH=ROOT
 F  S BATCH=$O(^XTMP(BATCH)) Q:$E(BATCH,1,$L(ROOT))'=ROOT  D
 . S TASK=0 F  S TASK=$O(^XTMP(BATCH,TASK)) Q:'TASK  D
 . . S DOMAIN="" F  S DOMAIN=$O(^XTMP(BATCH,TASK,DOMAIN)) Q:DOMAIN=""  D
 . . . S OBJS=+$O(^XTMP(BATCH,TASK,DOMAIN," "),-1)
 . . . S OBJCNT=OBJCNT+OBJS
 . . . S TOTAL=TOTAL+$$WALK(BATCH,TASK,DOMAIN) Q
 . . . S TOTAL=TOTAL+(OBJS*$G(OBJSIZES($P(DOMAIN,"#")),1000))
 Q TOTAL_"^"_OBJCNT
 ;
WALK(BATCH,TASK,DOMAIN) ; -- walk through domain objectS in task to get actual size
 N OBJ,SIZE,NODE
 S (OBJ,SIZE)=0
 F  S OBJ=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ)) Q:'OBJ  D
 . S NODE=0 F  S NODE=$O(^XTMP(BATCH,TASK,DOMAIN,OBJ,NODE)) Q:'NODE  S SIZE=SIZE+$L($G(^(NODE)))
 Q SIZE

HMPDJFSG ;SLC/KCM,ASMR/RRB,CPC,JD,ASF,CK -- GET for Extract and Freshness Stream;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; US3907 - Allow for jobId and rootJobId to be retrieved from ^XTMP.  JD - 1/20/15
 ; DE2818 - SQA findings. Newed ERRCNT in BLDSERR+2.  RRB - 10/24/2015
 ; DE3869 - Remove the freshness stream entries with undefined DFNs.  JD - 3/4/16
 ;
 ; --- retrieve updates for an HMP server's subscriptions
 ;
GETSUB(HMPFRSP,ARGS) ; retrieve items from stream
 ;      GET from: /hmp/subscription/{hmpSrvId}/{last}?limit={limit}
 ; ARGS("last") : date-seq of last item retrieved (ex. 3131206-27)
 ; ARGS("max")    : maximum number of items to return (default 99999)   *S68-JCH*
 ; ARGS("maxSize"): approximate number bytes to return                  *S68-JCH*
 ;
 ; HMPFSYS : the id (hash) of the VistA system
 ; HMPFHMP : the name of the HMP server 
 ; HMPFSEQ : final sequence (becomes next LASTSEQ)
 ; HMPFIDX : index to iterate from LASTSEQ to final sequence
 ; HMPFLAST: used to clean up extracts prior to this
 ; HMPFSTRM: the extract/freshness stream (HMPFS~hmpSrvId~fmDate) 
 ; (most variables namespaced since calling variety of extracts)
 ;
 K ^TMP("HMPF",$J)
 N HMPFSYS,HMPFSTRM,HMPFLAST,HMPFDT,HMPFLIM,HMPFMAX,HMPFSIZE,HMPCLFLG
 N HMPFSEQ,HMPFIDX,HMPFCNT,SNODE,STYPE,HMPFERR,HMPDEL,HMPERR,HMPSTGET,HMPLITEM  ;*S68-JCH*, DE3502
 S HMPFRSP=$NA(^TMP("HMPF",$J))
 ; Next line added for US6734 - Make sure OPD metastamp data has been completed before fetching.
 I '$$OPD^HMPMETA(HMPFHMP) S @HMPFRSP@(1)="{""warning"":""Staging is not complete yet!""}" Q
 ;
 S HMPFSYS=$$SYS^HMPUTILS
 S HMPFHMP("ien")=$O(^HMP(800000,"B",HMPFHMP,0))
 S HMPFDT=$P($G(ARGS("lastUpdate")),"-")
 S HMPFSEQ=+$P($G(ARGS("lastUpdate")),"-",2)
 S HMPSTGET=$G(ARGS("getStatus"))
 S HMPLITEM="" ; DE3502 initialise tracking of last item type
 ; stream goes back a maximum of 8 days
 I HMPFDT<$$FMADD^XLFDT($$DT^XLFDT,-8) S HMPFDT=$$HTFM^XLFDT(+$H-8),HMPFSEQ=0
 S HMPFLAST=HMPFDT_"-"_HMPFSEQ
 D LASTUPD(HMPFHMP,HMPFLAST)
 D SETLIMIT(.ARGS)                            ; set HMPFLIM, HMPFMAX, HMPFSIZE ;*S68-PJH*
 S HMPFLIM=$G(ARGS("max"),99999)
 S HMPFSTRM="HMPFS~"_HMPFHMP_"~"_HMPFDT       ; stream identifier
 I '$D(^XTMP(HMPFSTRM,"job",$J)) S ^XTMP(HMPFSTRM,"job",$J,"start")=$H
 S ^XTMP(HMPFSTRM,"job",$J)=$H                ; record connection info
 I '$$VERMATCH(HMPFHMP("ien"),$G(ARGS("extractSchema"))) D NOOP(HMPFLAST) QUIT
 S HMPFCNT=0,HMPFIDX=HMPFSEQ
 F  D  Q:HMPFSIZE'<HMPFMAX  D NXTSTRM Q:HMPFSTRM=""  ; *S68-JCH*
 . F  S HMPFIDX=$O(^XTMP(HMPFSTRM,HMPFIDX)) Q:'HMPFIDX  D  Q:HMPFCNT'<HMPFLIM
 ..  S SNODE=^XTMP(HMPFSTRM,HMPFIDX),STYPE=$P(SNODE,U,2)
 ..  ;===JD START===
 ..  K ARGS("hmp-fst") I $P(SNODE,U,4)="@" S ARGS("hmp-fst")=$P(SNODE,U,5)
 ..  ;===JD END===
 ..  S $P(^XTMP(HMPFSTRM,HMPFIDX),U,6)=$P($H,",",2) ; timestamp when sent
 ..  I STYPE="syncNoop" Q                      ; skip, patient was unsubscribed
 ..  I STYPE="syncDomain" D DOMITMS Q          ; add multiple extract items
 ..  S HMPFSEQ=HMPFIDX
 ..  I STYPE="syncCommand" D SYNCCMD(SNODE) Q  ; command to middle tier
 ..  I STYPE="syncError" D SYNCERR(SNODE,.HMPERR) Q
 ..  I STYPE="syncStart" D SYNCSTRT(SNODE) S HMPLITEM="SYNC" Q  ; begin initial extraction ;DE3502
 ..  I STYPE="syncMeta" D SYNCMETA(SNODE) S HMPLITEM="SYNC" Q   ; US11019 - Build replacement syncstart ;DE3502
 ..  I STYPE="syncDone" D SYNCDONE(SNODE) S HMPLITEM="SYNC" Q   ; end of initial extraction ;DE3502
 ..  D FRESHITM(SNODE,.HMPDEL,.HMPERR) S HMPLITEM="FRESH"       ; otherwise, freshness item ;DE3502
 Q:$G(HMPFERR)
 D FINISH(.HMPDEL,.HMPERR)
 ;Check if HMP GLOBAL USAGE MONITOR mail message is required - US8228
 D CHECK^HMPMETA(HMPFHMP) ; US8228
 Q
DOMITMS ; loop thru extract items, OFFSET is last sent
 ; expects HMPFSTRM,HMPFIDX,HMPFHMP,HMPFSYS
 ; changes HMPFSEQ,HMPFCNT,HMPFSIZE as each item added  ; *S68-JCH*
 N X,OFFSET,DFN,PIDS,DOMAIN,TASK,BATCH,COUNT,ITEMNUM,DOMSIZE,SECSIZE
 S X=^XTMP(HMPFSTRM,HMPFIDX),DFN=$P(X,U),X=$P(X,U,3)
 S PIDS=$S(DFN:$$PIDS^HMPDJFS(DFN),1:"")
 S DOMAIN=$P(X,":")               ; domain{#sectionNumber}
 S TASK=$P(X,":",2)               ; task number in ^XTMP
 S COUNT=$P(X,":",3)              ; count in this section
 S DOMSIZE=$P(X,":",4)            ; estimated total for the domain
 S SECSIZE=$P(X,":",5)            ; section size (for operational)
 S BATCH="HMPFX~"_HMPFHMP_"~"_DFN ; extract node in ^XTMP
 S OFFSET=COUNT-(HMPFIDX-HMPFSEQ)
 F  S OFFSET=$O(^XTMP(BATCH,TASK,DOMAIN,OFFSET)) Q:'OFFSET  D  Q:HMPFCNT'<HMPFLIM
 . ;;PJH;;S HMPFCNT=HMPFCNT+1            ; increment the count of returned items
 . S HMPFSEQ=HMPFSEQ+1            ; increment the sequence number in the stream
 . S HMPFSIZE=$$INCITEM($P(DOMAIN,"#"))  ;                  *S68-JCH*
 . S ITEMNUM=OFFSET+($P(DOMAIN,"#",2)*SECSIZE)
 . M ^TMP("HMPF",$J,HMPFCNT)=^XTMP(BATCH,TASK,DOMAIN,OFFSET)
 . ;S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER(DOMAIN,PIDS,$S('COUNT:0,1:ITEMNUM),+DOMSIZE)
 . S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER(DOMAIN,PIDS,$S('COUNT:0,1:ITEMNUM),+DOMSIZE,1)  ; *S68-JCH*
 . S HMPLITEM="SYNC",HMPCLFLG=0 ; DE3502
 Q
MIDXTRCT() ; Return true if mid-extract
 ; from GETSUB expects HMPFSTRM,HMPFSEQ
 I 'HMPFSEQ Q 0
 I '$D(^XTMP(HMPFSTRM,HMPFSEQ)) Q 1                  ; middle of extract
 I $P(^XTMP(HMPFSTRM,HMPFSEQ),U,2)="syncDomain" Q 1  ; just starting extract
 Q 0
 ;
NXTSTRM ; Reset variables for next date in this HMP stream
 ; from GETSUB expects HMPFSTRM,HMPFDT,HMPFIDX
 ; HMPFSTRM set to "" if no next stream
 ; HMPFIDX  set to 0 if next stream, or left as is
 ; HMPFDT   set to last date actually used
 N NEXTDT,DONE
 S NEXTDT=HMPFDT,DONE=0
 F  D  Q:DONE
 . S NEXTDT=$$FMADD^XLFDT(NEXTDT,1)
 . I NEXTDT>$$DT^XLFDT S HMPFSTRM="" S DONE=1 Q
 . S $P(HMPFSTRM,"~",3)=NEXTDT
 . I '+$O(^XTMP(HMPFSTRM,0)) Q  ; nothing here, try next date
 . S HMPFDT=NEXTDT,HMPFIDX=0,HMPFSEQ=0,DONE=1
 Q
 ;
SETLIMIT(ARGS) ; sets HMPFLIM, HMPFMAX, HMPFSIZE variables  *BEGIN*S68-JCH*
 I $G(ARGS("maxSize")) D  Q
 . S HMPFLIM="s"
 . S HMPFMAX=ARGS("maxSize")
 . D GETLST^XPAR(.HMPFSIZE,"PKG","HMP DOMAIN SIZES","I")
 . S HMPFSIZE=0
 ; otherwise
 S HMPFLIM="c"
 S HMPFMAX=$G(ARGS("max"),99999)
 S HMPFSIZE=0
 Q
 ;
INCITEM(DOMAIN) ; increment counters as item added *BEGIN*S68-JCH*
 S HMPFCNT=HMPFCNT+1
 I HMPFLIM="s" Q HMPFSIZE+$G(HMPFSIZE(DOMAIN),1200)
 I HMPFLIM="c" Q HMPFCNT
 Q 0
 ;                                                     *END*S68-JCH*
 ;
FINISH(HMPDEL,HMPERR) ;reset the FIRST object delimiter, add header and tail
 ; expects HMPFCNT,HMPFDT,HMPFSEQ,HMPFHMP,HMPFLAST
 N CLOSE,I,START,TEXT,UID,X,II
 S X=$G(^TMP("HMPF",$J,1,.3))
 I $E(X,1,2)="}," S X=$E(X,3,$L(X)),^TMP("HMPF",$J,1,.3)=X
 S ^TMP("HMPF",$J,.5)=$$APIHDR(HMPFCNT,HMPFDT_"-"_HMPFSEQ)
 I $D(HMPERR) D
 .S CLOSE=$S(HMPFCNT:"},",1:""),START=1
 .S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)=CLOSE_"{""error"":["
 .S I=0 F  S I=$O(HMPERR(I)) Q:I'>0  D
 ..S TEXT=HMPERR(I)
 ..S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)=$S(START:"",1:",")_TEXT S START=0
 .S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)="]"
 ; operational sync item or patient
 ; Check for closing flag & HMPFCNT and if it doesn't exist add a closing brace, always close array
 S ^TMP("HMPF",$J,HMPFCNT+1)=$S(HMPFCNT&('$G(HMPCLFLG)):"}",1:"")_"]",HMPFCNT=HMPFCNT+1
 ; modified
 I $G(HMPSTGET)="true" D  ; true if "getStatus" argument passed in
 . S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)=",""syncStatii"":[",START=1
 . S I=0 F  S I=$O(^HMP(800000,I)) Q:+I=0  D
 . . I $P($G(^HMP(800000,I,0)),"^",1)=HMPFHMP D
 . . . S II=0 F  S II=$O(^HMP(800000,I,1,II)) Q:+II=0  D
 . . . . S TEXT="{""pid"":"_II_",""status"":"_$P(^HMP(800000,I,1,II,0),"^",2)_"}"
 . . . . S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)=$S(START:"",1:",")_TEXT S START=0
 . S HMPFCNT=HMPFCNT+1,^TMP("HMPF",$J,HMPFCNT)="]"
 ;
 S ^TMP("HMPF",$J,HMPFCNT+1)="}}"
 ; remove any ^XTMP nodes that have been successfully sent based on LAST
 N DATE,SEQ,LASTDT,LASTSEQ,STRM,LSTRM,RSTRM
 S LASTDT=+$P(HMPFLAST,"-"),LASTSEQ=+$P(HMPFLAST,"-",2)
 S RSTRM="HMPFS~"_HMPFHMP_"~",LSTRM=$L(RSTRM),STRM=RSTRM
 F  S STRM=$O(^XTMP(STRM)) Q:'$L(STRM)  Q:$E(STRM,1,LSTRM)'=RSTRM  D
 . S DATE=$P(STRM,"~",3) Q:DATE>LASTDT
 . S SEQ=0 F  S SEQ=$O(^XTMP(STRM,"tidy",SEQ)) Q:'SEQ  Q:(DATE=LASTDT)&(SEQ>LASTSEQ)  D TIDYX(STRM,SEQ)
 Q
TIDYX(STREAM,SEQ) ; clean up extracts after they have been retrieved
 ; from FINISH
 N BATCH,DOMAIN,TASK
 S BATCH=^XTMP(STREAM,"tidy",SEQ,"batch")
 S DOMAIN=^XTMP(STREAM,"tidy",SEQ,"domain")
 S TASK=^XTMP(STREAM,"tidy",SEQ,"task")
 I DOMAIN="<done>" K ^XTMP(BATCH) I 1
 E  K ^XTMP(BATCH,TASK,DOMAIN)
 K ^XTMP(STREAM,"tidy",SEQ)
 Q
SYNCCMD(SEQNODE) ; Build syncCommand object and stick in ^TMP
 ; expects: HMPSYS, HMPFCNT
 N DFN,CMD,CMDJSON,ERR
 S DFN=+SEQNODE
 S CMD("command")=$P($P(SEQNODE,U,3),":")
 S CMD("domain")=$P($P(SEQNODE,U,3),":",2)
 S:DFN CMD("pid")=$$PID^HMPDJFS(DFN)
 S CMD("system")=HMPSYS
 D ENCODE^HMPJSON("CMD","CMDJSON","ERR")
 I $D(ERR) S $EC=",UJSON encode error," Q
 S HMPFSIZE=$$INCITEM("syncCommand")  ; *S68-JCH*
 M ^TMP("HMPF",$J,HMPFCNT)=CMDJSON
 S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER("syncCommand",$$PIDS^HMPDJFS(DFN),1,1)
 Q
SYNCSTRT(SEQNODE) ; Build syncStart object with demograhics
 ; expects HMPFSYS, HMPFHMP, HMPFCNT, HMPFSIZE   *S68-JCH*
 S HMPFSIZE=$$INCITEM("patient")  ;              *S68-JCH*
 N DFN,FILTER,DFN,WRAP
 S DFN=$P($P(SEQNODE,U,3),"~",3) ; HMPFX~hmpSrvId~dfn
 I DFN D
 . N RSLT ;cpc 2015/10/01
 . S FILTER("patientId")=DFN,FILTER("domain")="patient"
 . D GET^HMPDJ(.RSLT,.FILTER)
 . M ^TMP("HMPF",$J,HMPFCNT)=^TMP("HMP",$J,1)
 ; for OPD there is no object, so 4th argument is 0 
 S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER("syncStart",$$PIDS^HMPDJFS(DFN),$S(DFN:1,1:-1),$S(DFN:1,1:-1))
 Q
SYNCDONE(SEQNODE) ; Build syncStatus object and stick in ^TMP
 ;  expects: HMPFSYS, HMPFCNT, HMPFHMP, HMPFSIZE  *S68-JCH*
 N HMPBATCH,DFN,STS,STSJSON,X,ERR
 S HMPBATCH=$P(SEQNODE,U,3) ; HMPFX~hmpSrvId~dfn
 S DFN=$P(HMPBATCH,"~",3)
 S STS("uid")="urn:va:syncStatus:"_HMPFSYS_":"_DFN
 S STS("initialized")="true"
 I DFN S STS("localId")=DFN
 S X="" F  S X=$O(^XTMP(HMPBATCH,0,"count",X)) Q:'$L(X)  D
 . S STS("domainTotals",X)=^XTMP(HMPBATCH,0,"count",X)
 ;===JD START===
 ; If resubscribing a patient, just send demographics
 I DFN'="OPD",$D(^HMP(800000,"AITEM",DFN)) D
 . N HMP99
 . S HMP99=""
 . ; Reset all domain counts to zero except for demographics
 . F  S HMP99=$O(STS("domainTotals",HMP99)) Q:'HMP99  I HMP99'="patient" S STS("domainTotals",HMP99)=0
 ;===JD   END===
 D ENCODE^HMPJSON("STS","STSJSON","ERR")
 I $D(ERR) S $EC=",UJSON encode error," Q
 S HMPFSIZE=$$INCITEM("syncstatus")  ; *S68-JCH*
 M ^TMP("HMPF",$J,HMPFCNT)=STSJSON
 S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER("syncStatus",$$PIDS^HMPDJFS(DFN),1,1)
 Q
 ;
SYNCMETA(SNODE) ; US11019 Build NEW syncStart object
 ; expects HMPFSYS, HMPFHMP, HMPFCNT
 ; need to rebuild SNODE because WRAPPER expects it to fall in
 N BATCH,DFN,WRAP,METADOM
 S DFN=$P(SNODE,U,1)
 S METADOM=$P(SNODE,U,3)
 S BATCH="HMPFX~"_HMPFHMP_"~"_DFN
 S $P(SNODE,U,3)=BATCH
 S HMPFSIZE=$$INCITEM("syncmeta") ;need to increment count
 S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAPPER("syncStart"_"#"_METADOM,$$PIDS^HMPDJFS(DFN),$S(DFN:1,1:-1),$S(DFN:1,1:-1))
 S ^TMP("HMPF",$J,HMPFCNT,1)="null" ;always null object with this record
 S HMPCLFLG=0 ; DE3502
 Q
 ;
SYNCERR(SNODE,HMPERR) ;
 N BATCH,CNT,DFN,NUM,OFFSET,PIDS,TASK,TOTAL,X
 S DFN=$P(SNODE,U),X=$P(SNODE,U,3)
 S PIDS=$$PIDS^HMPDJFS(DFN)
 S TASK=$P(X,":",2),TOTAL=$P(X,":",4)
 S BATCH="HMPFX~"_HMPFHMP_"~"_DFN       ; extract node in ^XTMP
 S CNT=$O(HMPERR(""),-1)
 S NUM=0 F  S NUM=$O(^XTMP(BATCH,TASK,"error",NUM)) Q:NUM'>0  D
 .S CNT=CNT+1 S HMPERR(CNT)=$G(^XTMP(BATCH,TASK,"error",NUM,1))
 Q
 ;
FRESHITM(SEQNODE,DELETE,ERROR) ; Get freshness item and stick in ^TMP
 ; expects HMPFSYS, HMPFHMP
 N ACT,DFN,DOMAIN,ECNT,FILTER,ID,RSLT,UID,HMP97,HMPI,WRAP,HMPPAT7,HMPPAT8
 S FILTER("noHead")=1
 S DFN=$P(SEQNODE,U),DOMAIN=$P(SEQNODE,U,2),ID=$P(SEQNODE,U,3),ACT=$P(SEQNODE,U,4)
 ;Next 2 IFs added to prevent <UNDEFINED> in LKUP^HMPDJ00.  JD - 3/4/16. DE3869
 ;Make sure deletes ('@') are not included.
 ;HMPFSTRM and HMPFIDX are defined in the GETSUB section above.
 ;For "pt-select", which is an operational data domain, ID=patient IEN and DFN="OPD".
 ;For ptient domains ID=DFN=patient IEN.
 ;We want the checks to be for all patient domains and pt-select of the operational data domain.
 ;Kill the freshness stream entry with the bad patient IEN.
 I ACT'="@",DFN=+DFN,'$D(^DPT(DFN,0)) K ^XTMP(HMPFSTRM,HMPFIDX) Q  ;For patient domains
 I ACT'="@",DOMAIN="pt-select",ID=+ID,'$D(^DPT(ID,0)) K ^XTMP(HMPFSTRM,HMPFIDX) Q
 ;
 ;==JD START
 ;Create a phantom "patient" if visit is the domain
 I DOMAIN="visit" D
 .S HMPPAT7=HMPFIDX_".99",HMPPAT8=^XTMP(HMPFSTRM,HMPFIDX),$P(HMPPAT8,U,2)="patient"  ;BL;DE2280
 .S ^XTMP(HMPFSTRM,HMPPAT7)=HMPPAT8
 ;==JD END
 ;
 I ACT'="@" D
 . S FILTER("id")=ID
 . S FILTER("domain")=DOMAIN
 . I DFN="OPD" D GET^HMPEF(.RSLT,.FILTER)
 . I +DFN>0 D
 .. S FILTER("patientId")=DFN
 ..  D  ; DE3691, add date/time with seconds to FILTER parameters, Feb 29 2016
 ...  N DAY,SECS,TM S SECS=$P($G(^XTMP(HMPFSTRM,HMPFIDX)),U,5),DAY=$P(HMPFSTRM,"~",3)
 ...  Q:('DAY)!('$L(SECS))  ; must have date and seconds, could be zero seconds (midnight)
 ...  S TM=$S(SECS:SECS#60/100+(SECS#3600\60)/100+(SECS\3600)/100,SECS=0:".000001",1:"")  ; if zero (midnight) push to 1 second after
 ...  Q:'$L(TM)  ; couldn't compute time
 ...  S FILTER("freshnessDateTime")=DAY+TM
 .. D GET^HMPDJ(.RSLT,.FILTER)
 I ACT'="@",$L($G(^TMP("HMP",$J,"error")))>0 D BLDSERR(DFN,.ERROR)  Q
 I '$D(^TMP("HMP",$J,1)) S ACT="@"
 I ACT="@" D
 . S UID=$$SETUID^HMPUTILS(DOMAIN,$S(+DFN>0:DFN,1:""),ID)
 . S HMP97=UID
 . K ^TMP("HMP",$J) S ^TMP("HMP",$J,1)="" ; Need to dummy this up or it will never get set later
 ;
 ;Add syncstart, data and syncstatus to JSON for unsolicited updates - US4588 & US3682
 I (DOMAIN="pt-select")!(DOMAIN="user")!(DOMAIN["asu-")!(DOMAIN="doc-def")!(DFN=+DFN) D  Q
 .D ADHOC^HMPUTIL1(DOMAIN,.HMPFCNT,DFN)
 .I $P(HMPFIDX,".",2)=99 K ^XTMP(HMPFSTRM,HMPFIDX) ;Remove the phantom "patient"; JD
 .S HMPLITEM="FRESH" ; DE3502
 ;
 S WRAP=$$WRAPPER(DOMAIN,$$PIDS^HMPDJFS(DFN),1,1) ; N.B. this updates the .3 node on this HMPFCNT
 F HMPI=1:1 Q:'$D(^TMP("HMP",$J,HMPI))  D
 . S HMPFCNT=HMPFCNT+1
 . M ^TMP("HMPF",$J,HMPFCNT)=^TMP("HMP",$J,HMPI)
 . I HMPLITEM="SYNC" S HMPLITEM="FRESH" I WRAP="," S ^TMP("HMPF",$J,HMPFCNT,.3)="}," Q  ; DE3502 add closing
 . S ^TMP("HMPF",$J,HMPFCNT,.3)=WRAP
 Q
 ;
BLDSERR(DFN,ERROR) ; Create syncError object in ERRJSON
 ; expects: HMPBATCH, HMPFSYS, HMPFZTSK
 N COUNT,ERRVAL,ERROBJ,ERR,ERRCNT,ERRMSG,SYNCERR
 M ERRVAL=^TMP("HMP",$J,"error")
 I $G(ERRVAL)="" Q
 S ERRVAL="{"_ERRVAL_"}"
 D DECODE^HMPJSON("ERRVAL","ERROBJ","ERR")
 I $D(ERR) S $EC=",UJSON decode error,"
 S ERRMSG=ERROBJ("error","message")
 Q:'$L(ERRMSG)
 S SYNCERR("uid")="urn:va:syncError:"_HMPFSYS_":"_DFN_":FRESHNESS"
 S SYNCERR("collection")=DOMAIN
 S SYNCERR("error")=ERRMSG
 D ENCODE^HMPJSON("SYNCERR","ERRJSON","ERR") I $D(ERR) S $EC=",UJSON encode error," Q
 S COUNT=$O(ERROR(""),-1)  ;                      *BEGIN*S68-JCH*
 S ERRCNT=0 F  S ERRCNT=$O(ERRJSON(ERRCNT)) Q:ERRCNT'>0  D
 .S COUNT=COUNT+1 M ERROR(COUNT)=ERRJSON(COUNT)  ;  *END*S68-JCH*
 Q
WRAPPER(DOMAIN,PIDS,OFFSET,DOMSIZE,FROMXTR) ; return JSON wrapper for each item *S68-JCH*
 ; add object tag if extract total not zero or if total passed as -1
 ; seq and total tags only added if non-zero
 N X,Y,Z,HMPSVERS ;US11019
 ; Ensure that X exists
 S X=""
 S Z=$P(SNODE,U,3)
 S HMPSVERS=$G(^XTMP(Z,"HMPSVERS")) ;US11019 If HMPSVERS=0 then running in previous mode
 S HMPSTMP=$G(^XTMP(Z,"HMPSTMP")) ;; PJH - THIS USED ONLY FOR OPD COMPILE IN PRIOR VERSION - NEEDS REMOVING US6734
 ; This was working for operational data, not patient data
 ; DFN will be OPD if this is operational data (non-obvious I know)
 I DFN="OPD" D
 . S:$P($G(DOMAIN),"#")'="syncStart" X="},{""collection"":"""_$P(DOMAIN,"#")_""""_PIDS ;US11019
 E  S X="},{""collection"":"""_$P(DOMAIN,"#")_""""_PIDS  ; If ONLY patient data exists
 I HMPLITEM="FRESH" I $E(X)="}" S X=$E(X,2,$L(X)) ; DE3502 - remove closing when coming from Fresh
 I $P(DOMAIN,"#")="syncStart",$O(^XTMP(Z,0))]"" D  Q X
 .; --- Start US3907 ---
 .; Pass JobId and RootJobId back in the response if we were given them
 .; This bridges the gap between Job status and Sync Status (since VistA will be giving the syncStatus)
 .; US11019 use domain specific Job id
 .S Y=$S($P(DOMAIN,"#",2)="":$G(^XTMP(Z,"JOBID")),1:$G(^XTMP(Z,"JOBID",$P(DOMAIN,"#",2)))) ;US11019
 .I Y]"" S X=X_",""jobId"":"""_Y_""""
 .S Y=$G(^XTMP(Z,"ROOTJOBID"))
 .I Y]"" S X=X_",""rootJobId"":"""_Y_""""
 .; --- End US3907 ---
 .I DFN'="OPD" D METAPT^HMPMETA(SNODE,$S(HMPSVERS:$P(DOMAIN,"#",2),1:"")) Q  ; US11019 extra para ;Collect Patient metastamp data from XTMP - US6734
 .D METAOP^HMPMETA(SNODE) ; Collect OPD metastamp data from XTMP - US6734
 S X=X_","
 ; if batched by extract  *S68-JCH*
 I $G(OFFSET)>-1 S X=X_"""seq"":"_OFFSET_","
 I $G(DOMSIZE)>-1 S X=X_"""total"":"_DOMSIZE_","
 I $G(OFFSET)>-1 S X=X_"""object"":"
 Q X
 ;
APIHDR(COUNT,LASTITM) ; return JSON
 ; expects HMPFSYS
 I $P($G(LASTITM),".",2)="99" S LASTITM=$P(LASTITM,".")  ;make sure lastUpdate is correct;JD;BL;DE2280
 N X
 S X="{""apiVersion"":1.02,""params"":{""domain"":"""_$$KSP^XUPARAM("WHERE")_""""
 S X=X_",""systemId"":"""_HMPFSYS_"""},""data"":{""updated"":"""_$$HL7NOW^HMPDJ_""""
 S X=X_",""totalItems"":"_COUNT_",""lastUpdate"":"""_LASTITM_""""_$$PROGRESS^HMPDJFS(LASTITM)
 S X=X_",""items"":["
 Q X
 ;
NOOP(LASTITM) ; No-op, don't return any items
 S ^TMP("HMPF",$J,.5)=$$APIHDR(0,LASTITM)_"]}}"
 Q
VERMATCH(HMPIEN,VERSION) ; true if middle tier HMP and VistA version match
 ; versions match, queue any patients waiting for match
 I $P($$GET^XPAR("PKG","HMP JSON SCHEMA"),".")=$P(VERSION,".") D  QUIT 1
 . Q:'$G(^XTMP("HMPFS~"_HMPIEN,"waiting"))  ; no patients awaiting queuing
 . S ^XTMP("HMPFS~"_HMPIEN,"waiting")=0
 . N DOMAINS,BATCH,HMPNAME
 . S HMPNAME=$P(^HMP(800000,HMPIEN,0),U)
 . D PTDOMS^HMPDJFSD(.DOMAINS)
 . S DFN=0 F  S DFN=$O(^XTMP("HMPFS~"_HMPIEN,"waiting",DFN)) Q:'DFN  D
 . . Q:'$D(^HMP(800000,HMPIEN,1,DFN))  ; subscription cancelled while waiting  *S68-JCH*
 . . S BATCH="HMPFX~"_HMPNAME_"~"_DFN
 . . D QUINIT^HMPDJFSP(BATCH,DFN,.DOMAINS)
 . K ^XTMP("HMPFS~"_HMPIEN)
 ;
 ; otherwise, hold things
 D NEWXTMP^HMPDJFS("HMPFS~"_HMPIEN,8,"HMP Awaiting Version Match")
 S ^XTMP("HMPFS~"_HMPIEN,"waiting")=1
 Q 0
 ;
LASTUPD(HMPSRV,LASTUPD) ; save the last update
 ; TODO: change this to use Fileman call
 N IEN,CURRUPD,REPEAT
 S IEN=$O(^HMP(800000,"B",HMPSRV,0)) Q:'IEN
 Q:LASTUPD["^"
 S CURRUPD=$P(^HMP(800000,IEN,0),"^",2),REPEAT=$P(^HMP(800000,IEN,0),"^",4)
 I LASTUPD=CURRUPD S $P(^HMP(800000,IEN,0),"^",4)=REPEAT+1 QUIT
 S $P(^HMP(800000,IEN,0),"^",2)=LASTUPD,$P(^HMP(800000,IEN,0),"^",4)=0
 Q
JSONOUT ; Write out JSON in ^TMP
 N X
 S X=$NA(^TMP("HMPF",$J))
 F  S X=$Q(@X) Q:($QS(X,1)'="HMPF")!($QS(X,2)'=$J)  W !,@X
 Q
 ;

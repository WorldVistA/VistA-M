HMPMONE ;asmr-ven/zag&toad-dashboard: error actions ;Aug 25, 2016 21:17:38
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526 - routine refactored, August 25, 2016
 ;
UE ; update error screen
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$LASTREAM^HMPMONL = get last stream name
 ;   $$UHEAD^HMPMONL = calculate header line
 ;   $$OBSCNT
 ;   $$EXTMP
 ;   $$EHMPJB
 ;   $$EHMPFERR
 ;   $$ETMPJOB
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ;   five different error logs
 ; output:
 ;   report counts to current device
 ; examples:
 ;   [develop examples]
 ;
 N STREAM ; freshness stream subscript into ^xtmp
 S STREAM=$$LASTREAM^HMPMONL(HMPSRVR) ; get last freshness stream
 write $$UHEAD^HMPMONL(STREAM,"eHMP Errors"),! ; write header line
 ;
 N ETOTAL S ETOTAL=0 ; total ehmp errors
 ;
 N EXTMP S EXTMP=$$EXTMP ; ehmp errors in xtmp error log
 N ETERR S ETERR=$$EHMPJB ; ehmp errors in hmperr error log
 N ETFERR S ETFERR=$$EHMPFERR ; ehmp errors in hmpferr error log
 N ETSPACE S ETSPACE=$$ETMPJOB ; ehmp errors in hmp error error log
 ;
 S ETOTAL=ETOTAL+EXTMP+ETERR+ETFERR+ETSPACE
 ;
 W !,"                error log   # errors"
 W !,"    ---------------------   --------"
 W !,"                    Total: "_ETOTAL,!
 W !," ^XTMP('HMPXTEMP ERRORS'): "_EXTMP
 W !,"      ^TMP('HMPERR',$job): "_ETERR
 W !,"  ^TMP('HMPFERR',$job,$h): "_ETFERR
 W !,"   ^TMP($job,'HMP ERROR'): "_ETSPACE
 ;
 Q
 ;
 ;
ETOTL() ; count ehmp errors in all error logs
 ; called by:
 ;   SHOWSRVR^HMPMON
 ; calls:
 ;   $$OBSCNT
 ;   $$EXTMP
 ;   $$EHMPJB
 ;   $$EHMPFERR
 ;   $$ETMPJOB
 ; input: ehmp error logs
 ; output = # ehmp errors in all error logs
 ;
 N ETOTAL S ETOTAL=0 ; total ehmp errors
 ;
 N EXTMP S EXTMP=$$EXTMP ; ehmp errors in xtmp error log
 N ETERR S ETERR=$$EHMPJB ; ehmp errors in hmperr error log
 N ETFERR S ETFERR=$$EHMPFERR ; ehmp errors in hmpferr error log
 N ETSPACE S ETSPACE=$$ETMPJOB ; ehmp errors in hmp error error log
 ;
 S ETOTAL=ETOTAL+EXTMP+ETERR+ETFERR+ETSPACE
 ;
 Q ETOTAL ; return # errors
 ;
 ;
EXTMP() ; count errors in ^XTMP("HMPXTEMP ERRORS")
 ; called by:
 ;   UE
 ;   E2
 ; output = # ehmp errors in xtmp error log
 ;
 Q +$O(^XTMP("HMPXTEMP ERRORS",""),-1)
 ;
EHMPJB() ; total errors in ^TMP("HMPERR",$J)
 ; called by:
 ;   UE
 ;   E3
 ;
 N ERRCNT,JB S ERRCNT=0,JB=0
 F  S JB=$O(^TMP("HMPERR",JB)) Q:'JB  S ERRCNT=ERRCNT+$O(^TMP("HMPERR",JB,0))
 ;
 Q ERRCNT
 ;
 ;
EHMPFERR() ; function, count errors in ^TMP("HMPFERR",$J)
 ; called by:
 ;   UE
 ;   E4
 ; calls: none
 ;
 N ERRCNT,JB,HTM
 S ERRCNT=0,JB=0
 F  S JB=$O(^TMP("HMPFERR",JB)) Q:'JB  D
 . S HTM=0 F  S HTM=$O(^TMP("HMPFERR",JB,HTM)) Q:'HTM  S ERRCNT=ERRCNT+1
 ;
 Q ERRCNT ; return total errors
 ;
 ;
ETMPJOB() ; count errors in  ^TMP($J,"HMP ERROR","# of Errors")
 ; called by:
 ;   UE
 ;   E5
 ;
 N ERRCNT,JB S ERRCNT=0,JB=0
 F  S JB=$O(^TMP(JB))  Q:'JB  S ERRCNT=ERRCNT+$G(^TMP(JB,"HMP ERROR","# of Errors"))
 ;
 Q ERRCNT ; return # errors
 ;
 ;
E1 ; obsolete error tag
 W !,"obsolete" Q
 ;
E2 ; examine xtmp error log
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$EXTMP = count of XTMP errors
 ; input: none
 ;
 ;errors from ^XTMP("HMPXTEMP ERRORS")
 ;  errors set in SETERROR^HMPUTILS, called by:
 ;    HMPCRPC1
 ;    HMPDJ
 ;    HMPDJ1
 ;    HMPDJ2
 ;    HMPEF
 ;    HMPPARAM
 ;    HMPPXRM
 ;    HMPUPD
 ;
 ;
 W !,"Total Errors in "_$NA(^XTMP("HMPXTEMP ERRORS"))_": "_$$EXTMP
 Q
 ;
 ;
E3 ; ^TMP("HMPERR",$J) errors
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$EHMPJB = count of ^TMP("HMPERR",$J) errors
 ;
 W !,"Total Errors in "_$NA(^XTMP("HMPERR","job#"))_": "_$$EHMPJB
 ;
 Q
 ;
 ;
E4 ; ^TMP("HMPFERR",$J) errors
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$EHMPFERR = count of HMPFERR errors
 ;
 ; ^TMP("HMPFERR")
 ; ^TMP("HMPFERR",$J,$H)=MSG
 ;    set in routine HMPDJFS
 ;
 ;
 W !,"Total Errors in "_$NA(^XTMP("HMPFERR","job#"))_$$EHMPFERR
 ;
 Q
 ;
 ;
E5 ; examine hmp error error log
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   $$ETMPJOB = count of ^TMP("job#","HMP ERROR") errors
 ;
 ;^TMP($job,"HMP ERROR")
 ;  set in routines:
 ;    HMPDERRH
 ;    HMPDJ
 ;    HMPDJ2
 ;    HMPDJX
 ;    HMPEF
 ;    HMPEF1
 ;
 ;
 W !!,"Total Errors in "_$NA(^TMP("job#","HMP ERROR"))_": "_$$ETMPJOB
 ;
 Q
 ;
ME ; obsolete
 W !,"obsolete line tag ME in routine ^"_$T(+0) Q
 ;

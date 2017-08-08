HMPMONE ;ASMR/BL,JCH, monitor error actions ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 7 September 2016
 ;
UE ; update error screen
 ; input:
 ;   HMPMNTR("server") = # of server record in file HMP Subscription (800000)
 ; output:
 ;   report counts
 N ERRCNT,EXIT,STREAM ; freshness stream subscript in ^XTMP
 S EXIT=0,STREAM=$$LASTREAM^HMPMONL ; get last freshness stream
 F  Q:EXIT  D
 . S HMPMNTR("default")="BM"  ; default for this screen
 . D FORMFEED^HMPMONL W !,$$HDR^HMPMONL("eHMP Errors"),!  ;  header line
 . S ERRCNT("HMPXTEMP ERRORS")=$$EXTMP ; ehmp errors in xtmp error log
 . S ERRCNT("TMP HMPERR")=$$EHMPJB ; ehmp errors in hmperr error log
 . S ERRCNT("HMFERR")=$$EHMPFERR ; ehmp errors in hmpferr error log
 . S ERRCNT("TMP $J HMP ERROR")=$$ETMPJOB ; ehmp errors in hmp error error lo
 . S ERRCNT("TOTAL")=ERRCNT("HMPXTEMP ERRORS")+ERRCNT("TMP HMPERR")+ERRCNT("HMFERR")+ERRCNT("TMP $J HMP ERROR")  ;total ehmp errors
 . W !,"                error log   # errors"
 . W !,"    ---------------------   --------"
 . W !,"                    Total: "_ERRCNT("TOTAL"),!
 . W !," ^XTMP('HMPXTEMP ERRORS'): "_ERRCNT("HMPXTEMP ERRORS")
 . W !,"      ^TMP('HMPERR',$job): "_ERRCNT("TMP HMPERR")
 . W !,"  ^TMP('HMPFERR',$job,$h): "_ERRCNT("HMFERR")
 . W !,"   ^TMP($job,'HMP ERROR'): "_ERRCNT("TMP $J HMP ERROR")
 . D PROMPT^HMPMONA(.HMPACT,"ERR")  ; select prompts from the ERR group
 . I HMPACT="UE" Q  ; update error screen, nothing to do
 . I HMPACT="BM" S EXIT=1 Q  ; back to monitor
 . I $D(DUOUT)!$D(DIROUT)!$D(DTOUT) S EXIT=1 Q  ; handle '^'
 . S LNTAG=$P(HMPCALLS(HMPACT),";",3)
 . D @LNTAG S EXIT=HMPMNTR("exit") Q:HMPMNTR("exit")  ; perform user-selected action, exit if flag set
 . D RTRN2CON^HMPMONL ; return to continue
 Q
 ;
 ;
ETOTL() ; function, count ehmp errors in all error logs
 ; called by:
 ;   SHOWSRVR^HMPMON
 ; output = # ehmp errors in all error logs
 ;
 N ERRCNT
 S ERRCNT("HMPXTEMP ERRORS")=$$EXTMP ; errors in ^XTMP("HMPXTEMP ERRORS")
 S ERRCNT("TMP HMPERR")=$$EHMPJB ; errors in ^TMP("HMPERR",$J)
 S ERRCNT("HMFERR")=$$EHMPFERR ; errors in ^TMP("HMPFERR",$J)
 S ERRCNT("TMP $J HMP ERROR")=$$ETMPJOB ; errors in  ^TMP($J,"HMP ERROR","# of Errors")
 ; return total errors
 Q ERRCNT("HMPXTEMP ERRORS")+ERRCNT("TMP HMPERR")+ERRCNT("HMFERR")+ERRCNT("TMP $J HMP ERROR")
 ;
 ;
EXTMP() ; function, errors in ^XTMP("HMPXTEMP ERRORS")
 ; output = # ehmp errors in xtmp error log
 Q +$O(^XTMP("HMPXTEMP ERRORS",""),-1)
 ;
EHMPJB() ; function, total errors in ^TMP("HMPERR",$J)
 N CNT,JB S CNT=0,JB=0
 F  S JB=$O(^TMP("HMPERR",JB)) Q:'JB  S CNT=CNT+$O(^TMP("HMPERR",JB,0))
 Q CNT
 ;
EHMPFERR() ; function, errors in ^TMP("HMPFERR",$J)
 Q:'$O(^TMP("HMPFERR",0)) 0  ; nothing to count
 N CNT,JB,HTM S CNT=0,JB=0
 F  S JB=$O(^TMP("HMPFERR",JB)) Q:'JB  S HTM=0 F  S HTM=$O(^TMP("HMPFERR",JB,HTM)) Q:'HTM  S CNT=CNT+1
 Q CNT ; return total errors
 ;
 ;
ETMPJOB() ; function, total errors in  ^TMP($J,"HMP ERROR","# of Errors")
 N CNT,JB S CNT=0,JB=0
 F  S JB=$O(^TMP(JB))  Q:'JB  S CNT=CNT+$G(^TMP(JB,"HMP ERROR","# of Errors"))
 Q CNT ; return # errors
 ;
EX ; display ^XTMP error log, called from ^DIR selection in OPTION^HMPMON
 D FORMFEED^HMPMONL W !,$$HDR^HMPMONL("^XTMP errors"),!  ;  header line
 W !,"Total Errors in "_$NA(^XTMP("HMPXTEMP ERRORS"))_": "_$$EXTMP Q
 ;
E3 ; display ^TMP("HMPERR",$J) errors
 D FORMFEED^HMPMONL W !,$$HDR^HMPMONL("^TMP('HMPERR',$J"),!  ;  header line
 W !,"Total Errors in "_$NA(^XTMP("HMPERR","job#"))_": "_$$EHMPJB Q
 ;
E4 ; display ^TMP("HMPFERR",$J) errors, set in routine HMPDJFS
 W !,"Total Errors in "_$NA(^XTMP("HMPFERR","job#"))_$$EHMPFERR Q
 ;
 ;
E5 ; display ^TMP($job,"HMP ERROR") error info, set in routines:
 ;    HMPDERRH
 ;    HMPDJ
 ;    HMPDJ2
 ;    HMPDJX
 ;    HMPEF
 ;    HMPEF1
 D FORMFEED^HMPMONL W !,$$HDR^HMPMONL("^TMP($J,'HMP ERROR'"),!  ;  header line
 W !!,"Total Errors in "_$NA(^TMP("job#","HMP ERROR"))_": "_$$ETMPJOB Q
 ;
LOG ; interactive display of HMP EVENT entry
 D FORMFEED^HMPMONL W !,$$HDR^HMPMONL("HMP EVENT log"),!  ;  header line
 I '$O(^HMPLOG(800003,0)) W !,"The HMP EVENT file (#800003) is *empty*",!! D RTRN2CON^HMPMONL Q
 N DA,DR,DIQ,DIC,X,Y
 S DIC="^HMPLOG(800003,",DIC(0)="AEMQ" D ^DIC
 I '(Y>0) D FORMFEED^HMPMONL Q  ; nothing selected
 S DA=+Y W ! D EN^DIQ  ; DR is undefined to display all fields
 W !!,"* End of HMP EVENT listing "_$$NOW^HMPMONL_" *",! D RTRN2CON^HMPMONL
 Q
 ;

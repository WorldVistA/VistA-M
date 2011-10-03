MHVUL2 ;WAS/GPM - MHV UTILITIES - LOGGING  ; 3/2/06 5:38pm [9/22/06 3:51pm]
 ;;1.0;My HealtheVet;**1,2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
LOG(NAME,DATA,TYPE,LEVEL) ;Log to MHV application log
 ;
 ;  Input:
 ;    NAME - Name to identify log entry
 ;    DATA - Value,Tree, or Name of structure to put in log
 ;    TYPE - Type of log entry
 ;              S:Set Single Value
 ;              M:Merge Tree 
 ;              I:Indirect Merge @
 ;   LEVEL - Level of log entry - ERROR,TRACE,NAMED,DEBUG
 ;
 ;  Output:
 ;    Adds entry to log
 ;
 ; ^XTMP("MHV7LOG",0) - Head of log file
 ; ^XTMP("MHV7LOG",1) - if set indicates that logging is on
 ; ^XTMP("MHV7LOG",1,"LEVEL") - logging level
 ; ^XTMP("MHV7LOG",1,"LEVEL",LEVEL) = rank
 ; ^XTMP("MHV7LOG",1,"NAMES",) - names to log caret delimited string
 ; ^XTMP("MHV7LOG",1,"NAMES",NAME) - name to log
 ; ^XTMP("MHV7LOG",2) - contains the log
 ; ^XTMP("MHV7LOG",2,negated FM timestamp,$J,counter,NAME) - log entry
 ;
 ; ^TMP("MHV7LOG",$J) - Session current log entry (DTM)
 ;
 ;Quit if logging is not turned on
 Q:'$G(^XTMP("MHV7LOG",1))
 N DTM,CNT,LOGLEVEL
 ;
 Q:'$D(DATA)
 Q:$G(TYPE)=""
 Q:$G(NAME)=""
 S NAME=$TR(NAME,"^","-")
 ;
 ;If LEVEL is null or unknown default to DEBUG
 I $G(LEVEL)="" S LEVEL="DEBUG"
 I '$D(^XTMP("MHV7LOG",1,"LEVEL",LEVEL)) S LEVEL="DEBUG"
 ;
 ;Log entries at or lower than the current logging level set
 ;Levels are ranked as follows:
 ;  ^XTMP("MHV7LOG",1,"LEVEL","ERROR")=1
 ;  ^XTMP("MHV7LOG",1,"LEVEL","TRACE")=2
 ;  ^XTMP("MHV7LOG",1,"LEVEL","NAMED")=3
 ;  ^XTMP("MHV7LOG",1,"LEVEL","DEBUG")=4
 ;Named is like a filtered version of debug.
 ;Additional levels may be added, and ranks changed without affecting
 ;the LOG api.  Inserting a level between Named and Debug will require
 ;a change to the conditional below.
 S LOGLEVEL=$G(^XTMP("MHV7LOG",1,"LEVEL"))
 I LOGLEVEL="" S LOGLEVEL="TRACE"
 I $G(^XTMP("MHV7LOG",1,"LEVEL",LEVEL))>$G(^XTMP("MHV7LOG",1,"LEVEL",LOGLEVEL)) Q:LOGLEVEL'="NAMED"  Q:'$D(^XTMP("MHV7LOG",1,"NAMES",NAME))
 ;
 ; Check ^TMP("MHV7LOG",$J) If no current log node start a new node
 I '$G(^TMP("MHV7LOG",$J)) D
 . S DTM=-$$NOW^XLFDT()
 . K ^XTMP("MHV7LOG",2,DTM,$J)
 . S ^TMP("MHV7LOG",$J)=DTM
 . S CNT=1
 . S ^XTMP("MHV7LOG",2,DTM,$J)=CNT
 . D AUTOPRG
 . Q
 E  D
 . S DTM=^TMP("MHV7LOG",$J)
 . S CNT=$G(^XTMP("MHV7LOG",2,DTM,$J))+1
 . S ^XTMP("MHV7LOG",2,DTM,$J)=CNT
 . Q
 ;
 I TYPE="S" S ^XTMP("MHV7LOG",2,DTM,$J,CNT,NAME)=DATA Q
 I TYPE="M" M ^XTMP("MHV7LOG",2,DTM,$J,CNT,NAME)=DATA Q
 I TYPE="I" M ^XTMP("MHV7LOG",2,DTM,$J,CNT,NAME)=@DATA Q
 ;
 Q
 ;
RESET ; Initialize or clear session pointer into log
 K ^TMP("MHV7LOG",$J)
 Q
 ;
AUTOPRG ;
 Q:'$G(^XTMP("MHV7LOG",1,"AUTOPURGE"))
 N DT,DAYS,RESULT
 ; Purge only once per day
 S DT=$$DT^XLFDT
 Q:$G(^XTMP("MHV7LOG",1,"AUTOPURGE","PURGE DATE"))=DT
 ;
 S DAYS=$G(^XTMP("MHV7LOG",1,"AUTOPURGE","DAYS"))
 I DAYS<1 S DAYS=7
 ;
 D LOGPRG^MHVUL1(.RESULT,$$HTFM^XLFDT($H-DAYS,1))
 S ^XTMP("MHV7LOG",1,"AUTOPURGE","PURGE DATE")=DT
 Q
 ;
LOGBROWS ; Browser view of Log
 N LOG,CNT,DTM,JOB,NUM,NAME,DIR,DIRUT,X,Y
 K ^TMP("MHV LOG SUMMARY",$J)
 K ^TMP("MHV LOG DETAIL",$J)
 K ^TMP("MHV LOG BROWSE",$J)
 K ^TMP("MHV LOG BROWSE DETAIL",$J)
 D LOGSUM^MHVUL1(.LOG)
 S CNT=$P(@LOG,"^",2)
 I CNT<1 D  Q
 . W !!,?12,"LOG IS EMPTY"
 . K DIR,DIRUT,X,Y
 . S DIR(0)="E"
 . D ^DIR
 . Q
 F I=1:1:CNT D
 . S DTM=$P(@LOG@(I),"^")
 . S JOB=$P(@LOG@(I),"^",2)
 . S NUM=$P(@LOG@(I),"^",3)
 . S NAME=$E($P(@LOG@(I),"^",4)_$J("",20),1,20)
 . S ^TMP("MHV LOG BROWSE",$J,I)="$.%$CREF$^TMP(""MHV LOG BROWSE DETAIL"",$J,"_I_")$CREF$^"_NAME_"$.%"_$J($$FMTE^XLFDT(-DTM),22)_$J(JOB,13)_"    "_NUM
 . S ^TMP("MHV LOG BROWSE DETAIL",$J,I)="$XC$^D LOGBDET^MHVUL2("_I_","_DTM_","_JOB_")$XC$^"_NAME_"  "_$$FMTE^XLFDT(-DTM)_"  "_JOB
 . Q
 D LOGBTITL
 S TITLE="Log Entry            Timestamp                Job Number   Items"
 D BROWSE^DDBR("^TMP(""MHV LOG BROWSE"",$J)","NA",TITLE_$J("",80-$L(TITLE)),"","",3,24)
 K ^TMP("MHV LOG SUMMARY",$J)
 K ^TMP("MHV LOG DETAIL",$J)
 K ^TMP("MHV LOG BROWSE",$J)
 K ^TMP("MHV LOG BROWSE DETAIL",$J)
 Q
 ;
LOGBTITL ; Build Titles for Browser
 N TITLE,INFO,TLOG,TPRG,TAUT,TLEN
 D LOGINFO^MHVUL1(.INFO)
 S TLOG="Logging: "_$S(INFO("STATE"):"",1:"OFF")
 I INFO("STATE") S TLOG=TLOG_INFO("LEVEL")
 S TAUT="Auto Purge: "_$S(INFO("AUTOPURGE"):"",1:"OFF")
 I INFO("AUTOPURGE") S TAUT=TAUT_+INFO("DAYS")_" days"
 S TPRG="Delete: "_$$FMTE^XLFDT(INFO("DELETE"))
 ;
 S TITLE="MHV APPLICATION LOG"
 S TLEN=$L(TITLE)
 W @IOF,$J(TITLE,TLEN\2+40)_$J(TPRG,40-(TLEN\2))
 S TITLE=$J(TLOG_"   ",15)_$J(TAUT,63)
 W !,TITLE
 Q
 ;
LOGBDET(NODE,DTM,JOB) ; Build document from entry for Browser
 N I,CNT,LINE,ENTRY
 D LOGDET^MHVUL1(.ENTRY,DTM,JOB)
 S I=0
 S CNT=0
 F  S I=$O(@ENTRY@(I)) Q:I=""  D
 . S LINE=@ENTRY@(I)
 . S CNT=CNT+1
 . S ^TMP("MHV LOG BROWSE DETAIL",$J,NODE,CNT)=$E(LINE,1,80)
 . S LINE=$E(LINE,81,999999)
 . F  Q:LINE=""  D
 .. S CNT=CNT+1
 .. S ^TMP("MHV LOG BROWSE DETAIL",$J,NODE,CNT)=$J("",9)_$E(LINE,1,71)
 .. S LINE=$E(LINE,72,999999)
 .. Q
 . Q
 Q
 ;

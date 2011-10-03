MHVUL3 ;WAS/GPM - MHV UTILITIES - LOGGING  ; 3/17/06 12:03am [5/24/06 10:18am]
 ;;1.0;My HealtheVet;**1**;Aug 23, 2005
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; Utilities supporting user options for logging
 ;
LOGONO ; Turn on logging
 N RESULT,DIR,DIRUT,DA,X,Y,DTM,%DT
 D LOGINFOO
 W !
 D LOGINFO^MHVUL1(.RESULT)
 I RESULT("DELETE")="" S RESULT("DELETE")=$$HTFM^XLFDT($H+30,1)
 ;
 ; If logging is already on prompt if want to change deletion date
 I RESULT("STATE") D  Q:$D(DIRUT)!'Y
 . S DIR(0)="Y"
 . S DIR("A",1)="Logging is already turned on."
 . S DIR("A")="Reset deletion date"
 . S DIR("?",1)="MHV application logging is already active."
 . S DIR("?")="You may enter a new deletion date for the log."
 . S DIR("B")="NO"
 . D ^DIR
 . Q
 ;
 ; Prompt for deletion date
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="DA^"_DT_"::TX"
 S DIR("A")="Log Deletion Date: "
 S DIR("?",1)="Enter a future date to delete MHV application log."
 S DIR("?",2)="After this date logging will automatically be stopped,"
 S DIR("?")="and all log entries permanently deleted."
 S DIR("B")=$$FMTE^XLFDT(RESULT("DELETE"),1)
 D ^DIR Q:$D(DIRUT)
 ;
 D LOGON^MHVUL1(.RESULT,Y)
 W !!,"MHV application logging switched on."
 W !,"Log will be deleted on "_$$FMTE^XLFDT($P(RESULT,"^",2),1)_"."
 Q
 ;
LOGSETO ; Set logging parameters
 N RESULT,UPDATE,DIR,DIRUT,DA,X,Y,DTM,%DT,N,I
 D LOGINFOO
 W !
 D LOGINFO^MHVUL1(.UPDATE)
 ;
 ; State ON/OFF
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="SA^1:ON;0:OFF"
 S DIR("A")="Logging: "
 S DIR("?")="Enter ON or OFF"
 S DIR("B")=$S(UPDATE("STATE"):"ON",1:"OFF")
 D ^DIR
 Q:$D(DIRUT)
 S UPDATE("STATE")=Y
 ;
 ; Deletion Date
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="DA^"_DT_"::TX"
 S DIR("A")="Log Deletion Date: "
 S DIR("?",1)="Enter a future date to delete MHV application log."
 S DIR("?",2)="After this date logging will automatically be stopped,"
 S DIR("?")="and all log entries permanently deleted."
 S DIR("B")=$$FMTE^XLFDT(UPDATE("DELETE"))
 D ^DIR Q:$D(DIRUT)
 S UPDATE("DELETE")=Y
 ;
 ; Logging Level
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="SA^E:ERROR;T:TRACE;N:NAMED;D:DEBUG"
 S DIR("A")="Logging Level? "
 S DIR("?",1)="Set logging level"
 S DIR("?",2)="ERROR - only errors logged"
 S DIR("?",3)="TRACE - Trace and errors logged"
 S DIR("?",4)="NAMED - Named entries, trace and errors logged"
 S DIR("?")="DEBUG - All entries logged"
 S DIR("B")=UPDATE("LEVEL")
 D ^DIR
 Q:$D(DIRUT)
 S UPDATE("LEVEL")=Y(0)
 ;
 ; Names
 I UPDATE("LEVEL")="NAMED" D
 . S N=UPDATE("NAMES")
 . F I=2:1:$L(N,"^") S:$P(N,"^",I)'="" UPDATE("NAMES",$P(N,"^",I))=""
 . F  D  Q:$D(DIRUT)
 .. K DIR,DIRUT,DA,X,Y
 .. S DIR(0)="FO^"
 .. S DIR("A")="Entry name"
 .. S DIR("A",1)=UPDATE("NAMES")
 .. S DIR("?",1)="Enter names of entries to log"
 .. S DIR("?")="Remove entries by prefixing with @"
 .. S DIR("B")=""
 .. D ^DIR
 .. Q:$D(DIRUT)
 .. I $E(Y)="@" K UPDATE("NAMES",$E(Y,2,$L(Y)))
 .. E  S UPDATE("NAMES",Y)=""
 .. S UPDATE("NAMES")="^",N=""
 .. F  S N=$O(UPDATE("NAMES",N)) Q:N=""  S UPDATE("NAMES")=UPDATE("NAMES")_N_"^"
 .. Q
 . Q
 ;
 ; Auto Purge ON/OFF
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="SA^1:ON;0:OFF"
 S DIR("A")="Auto Purge: "
 S DIR("?")="Enter ON or OFF"
 S DIR("B")=$S(UPDATE("AUTOPURGE"):"ON",1:"OFF")
 D ^DIR
 Q:$D(DIRUT)
 S UPDATE("AUTOPURGE")=Y
 ;
 ; Days to Keep
 I UPDATE("AUTOPURGE") D  Q:$D(DIRUT)
 . I 'UPDATE("DAYS") S UPDATE("DAYS")=7
 . K DIR,DIRUT,DA,X,Y
 . S DIR(0)="N^1:365"
 . S DIR("A")="Days to Keep"
 . S DIR("?")="Enter number of days to keep log entries"
 . S DIR("B")=UPDATE("DAYS")
 . D ^DIR
 . S UPDATE("DAYS")=Y
 . Q
 ;
 W !!,"New MHV Application Log Settings:"
 D LOGINFOD(.UPDATE)
 W !
 S DIR(0)="Y"
 S DIR("A")="Ok to proceed with update"
 S DIR("?")="Update logging parameters with those shown?"
 S DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)
 I 'Y Q
 ;
 D LOGSET^MHVUL1(.RESULT,.UPDATE)
 W !!,"Logging parameters updated"
 D LOGINFOO
 Q
 ;
LOGOFFO ;Turn off logging
 N RESULT,DIR,DIRUT,DA,X,Y
 D LOGINFOO
 W !
 D LOGINFO^MHVUL1(.RESULT)
 ; Quit if logging is already off
 I 'RESULT("STATE") W !,"Logging is already turned off." Q
 S DIR(0)="Y"
 S DIR("A")="Turn off logging"
 S DIR("?")="Turn off MHV application logging."
 S DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)
 I 'Y Q
 ;
 D LOGOFF^MHVUL1(.RESULT)
 W !!,"MHV application logging switched off."
 W !,"Log will be deleted on "_$$FMTE^XLFDT($P(RESULT,"^",2),1)_"."
 Q
 ;
LOGPRGO ; Purge log
 N RESULT,DIR,DIRUT,DA,X,Y,DTM,%DT
 D LOGINFOO
 W !
 ; Purge from date
 S DIR(0)="D^:"_DT_":TX"
 S DIR("A")="Purge From Date"
 S DIR("?",1)="Enter a past date to purge MHV application log."
 S DIR("?")="All log entries older than this date will be removed."
 S DIR("B")=$$HTE^XLFDT($H-7,1)
 D ^DIR Q:$D(DIRUT)
 S DTM=Y
 ;
 ; Confirm Purge
 K DIR,DIRUT,DA,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Log will be purged from "_$$FMTE^XLFDT(DTM)_"."
 S DIR("A")="OK to proceed"
 S DIR("?")="All log entries older than this date will be removed."
 S DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)
 Q:'Y
 ;
 D LOGPRG^MHVUL1(.RESULT,DTM)
 W !!,"Log purged from "_$$FMTE^XLFDT($P(RESULT,"^",2),1)_"."
 Q
 ;
LOGINFOO ; Display log information
 N RESULT
 D LOGINFO^MHVUL1(.RESULT)
 W !!,"MHV Application Log Settings:"
 D LOGINFOD(.RESULT)
 Q
 ;
LOGINFOD(RESULT) ; Display log
 W !,"    Log Creation Date: ",$$FMTE^XLFDT(RESULT("CREATED"))
 W !,"    Log Deletion Date: ",$$FMTE^XLFDT(RESULT("DELETE"))
 W !,"         Oldest Entry: ",$$FMTE^XLFDT(RESULT("OLDEST"))
 W !,"         Newest Entry: ",$$FMTE^XLFDT(RESULT("NEWEST"))
 W !,"              Logging: ",$S(RESULT("STATE"):"",1:"OFF")
 I RESULT("STATE") D
 . W RESULT("LEVEL")_" mode"
 . I RESULT("LEVEL")="NAMED" W !,?16,"Names: ",RESULT("NAMES")
 . Q
 W !,"           Auto Purge: ",$S(RESULT("AUTOPURGE"):"",1:"OFF")
 I RESULT("AUTOPURGE") W +RESULT("DAYS")," days"
 Q
 ;
LOGSIZEO ; Display log size information
 N RESULT
 D LOGSIZE^MHVUL1(.RESULT)
 W !!,"MHV Application Log Size:"
 D LOGSIZED(.RESULT)
 Q
 ;
LOGSIZED(RESULT) ; Display log size
 W !,"     Number of Entries: ",RESULT("ENTRY COUNT")
 W !,"       Number of Nodes: ",RESULT("NODE COUNT")
 W !,"    Approx. size in KB: ",RESULT("BYTE COUNT")\1024
 Q
 ;
LOGVIEWO ; View log
 N LOG,CNT,DTM,J,ENTRY,RESULT,DIR,DIRUT,DTOUT,DUOUT,DA,X,Y,DTM
 ; Use the browser if supported by emulation
 I $$TEST^DDBRT D LOGBROWS^MHVUL2 Q
 K ^TMP("MHV LOG SUMMARY",$J)
 K ^TMP("MHV LOG DETAIL",$J)
 D LOGSUM^MHVUL1(.LOG)
 S CNT=$P(@LOG,"^",2)
 I CNT<1 D LOGSUMD(LOG) Q
 F  D  Q:$D(DIRUT)
 . D LOGSUMD(LOG) Q:$D(DTOUT)!$D(DUOUT)
 . K DIR,X,DIRUT
 . I 'Y D  Q:$D(DIRUT)
 .. S DIR(0)="N^1:"_CNT
 .. S DIR("A")="Select Entry"
 .. S DIR("?")="Select an entry to display"
 .. D ^DIR
 .. Q
 . ;
 . S DTM=$P(@LOG@(Y),"^")
 . S J=$P(@LOG@(Y),"^",2)
 . D LOGDET^MHVUL1(.ENTRY,DTM,J)
 . D LOGDETD(ENTRY)
 . K @ENTRY
 . Q
 K ^TMP("MHV LOG SUMMARY",$J)
 K ^TMP("MHV LOG DETAIL",$J)
 Q
 ;
LOGSUMD(LOG) ; Display log summary
 N CNT,DTM,J,N
 W !!,"LOG SUMMARY"
 W !,?5,"Entry",?12,"Timestamp",?37,"Job",?50,"Items"
 S CNT=$P(@LOG,"^",2)
 I CNT<1 W !!,?12,"EMPTY" Q
 S Y=0
 K DIRUT,DTOUT,DUOUT
 F I=1:1:CNT D  Q:Y!$D(DTOUT)!$D(DUOUT)
 . I I#22=0 D  Q:Y!$D(DTOUT)!$D(DUOUT)
 .. K DIR,X,Y,DIRUT,DTOUT,DUOUT
 .. S DIR(0)="NO^1:"_CNT
 .. S DIR("A",1)="Press <RETURN> to see more, '^' to exit, OR"
 .. S DIR("A")="Select Entry"
 .. S DIR("?")="Select an entry to display"
 .. D ^DIR
 .. Q
 . S DTM=$$FMTE^XLFDT(-$P(@LOG@(I),"^"))
 . S J=$P(@LOG@(I),"^",2)
 . S N=$P(@LOG@(I),"^",3)
 . W !,?5,I,?12,DTM,?37,J,?50,N
 . Q
 Q
 ;
LOGDETD(ENTRY) ;Display log entry
 N CNT,DTM,J,N
 W !!,"LOG DETAIL"
 S CNT=$P(@ENTRY,"^",2)
 I CNT<1 W !,?12,"EMPTY" Q
 W !,?12,"Timestamp",?37,"Job",?50,"Items",?60,"Nodes"
 S DTM=$$FMTE^XLFDT(-$P(@ENTRY@(0),"^"))
 S J=$P(@ENTRY@(0),"^",2)
 S N=$P(@ENTRY@(0),"^",3)
 W !,?12,DTM,?37,J,?50,N,?60,CNT
 S J=3
 F I=1:1:CNT D  Q:$D(DIRUT)
 . S J=($L(@ENTRY@(I))+5)\80+1+J
 . I J>23 D  Q:$D(DIRUT)
 .. K DIR,X,Y,DIRUT
 .. S DIR(0)="E"
 .. D ^DIR
 .. S J=($L(@ENTRY@(I))+5)\80+1
 .. Q
 . W !,?5,@ENTRY@(I)
 . Q
 ;
 Q:$D(DIRUT)
 K DIR,X,Y,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q
 ;

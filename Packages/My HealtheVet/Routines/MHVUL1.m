MHVUL1 ;WAS/GPM - MHV UTILITIES - LOGGING  ; 3/16/06 10:44pm [4/20/06 11:48am]
 ;;1.0;My HealtheVet;**1**;Aug 23, 2005
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; Utilities supporting options/rpcs for logging
 ;
LOGON(RESULT,DELETE) ;Turn on logging
 ;
 ;  Input:
 ;    DELETE - Deletion Date/Time - optional
 ;             Fileman date/time
 ;             Default 30 days from Today
 ;
 ;  Output:
 ;    RESULT - success flag ^ deletion date/time ^ created date/time
 ;
 N UPDATE
 S UPDATE("STATE")=1
 S UPDATE("DELETE")=$G(DELETE)
 D LOGSET(.RESULT,.UPDATE)
 S RESULT=$P(RESULT,"^",1)_"^"_$P(RESULT,"^",3,4)
 Q
 ;
LOGSET(RESULT,UPDATE) ; Set logging parameters
 ;
 ;  Input:
 ;      UPDATE("STATE") - Flag 0/1
 ;                        On or Off
 ;     UPDATE("DELETE") - Deletion Date/Time
 ;                        Fileman date/time
 ;                        Default 30 days from Today
 ;      UPDATE("LEVEL") - Logging level
 ;                        Error, Trace, Debug, Name
 ;                        Default - Trace
 ;      UPDATE("NAMES") - Caret delimited list of log entry names
 ;  UPDATE("AUTOPURGE") - Flag 0/1
 ;                        Default - 0 Off
 ;       UPDATE("DAYS") - Number of Days to keep
 ;
 ;  Output:
 ;    RESULT - success flag ^ state ^ deletion date/time ^
 ;             created date/time ^ level ^ names ^ autopurge ^ days
 ;
 N I,J,N,%DT,X,Y,STATE,DELETE,CREATED,TITLE,LEVEL,NAMES,AUTOPRG,DAYS,CURRENT
 D LOGINFO(.CURRENT)
 S STATE=$G(UPDATE("STATE"))
 S DELETE=$G(UPDATE("DELETE"))
 S LEVEL=$G(UPDATE("LEVEL"))
 S NAMES=$G(UPDATE("NAMES"))
 S AUTOPRG=$G(UPDATE("AUTOPURGE"))
 S DAYS=$G(UPDATE("DAYS"))
 ;
 ;Set defaults
 I STATE="",CURRENT("STATE")="" S STATE=0
 I DELETE="",CURRENT("DELETE")="" S DELETE="T+30"
 I STATE,DELETE="" S DELETE="T+30"
 I LEVEL="",CURRENT("LEVEL")="" S LEVEL="TRACE"
 I AUTOPRG="",CURRENT("AUTOPURGE")="" S AUTOPRG=0
 ;
 I STATE'="" D
 . S ^XTMP("MHV7LOG",1)=+STATE
 . S $P(RESULT,"^",2)=+STATE
 . Q
 ;
 I DELETE'="" D
 . S X=DELETE,%DT="TX" D ^%DT S DELETE=Y
 . I DELETE<0 S DELETE=$$HTFM^XLFDT($H+30,1)
 . S CREATED=$G(CURRENT("CREATED"))
 . I CREATED="" S CREATED=$$HTFM^XLFDT($H,1)
 . S TITLE=$G(CURRENT("TITLE"))
 . I TITLE="" S TITLE="MHV Application Log"
 . S ^XTMP("MHV7LOG",0)=DELETE_"^"_CREATED_"^"_TITLE
 . S $P(RESULT,"^",3)=DELETE
 . S $P(RESULT,"^",4)=CREATED
 . Q
 ;
 I LEVEL'="" D
 . S ^XTMP("MHV7LOG",1,"LEVEL","ERROR")=1
 . S ^XTMP("MHV7LOG",1,"LEVEL","TRACE")=2
 . S ^XTMP("MHV7LOG",1,"LEVEL","NAMED")=3
 . S ^XTMP("MHV7LOG",1,"LEVEL","DEBUG")=4
 . I ",ERROR,TRACE,NAMED,DEBUG,"'[(","_LEVEL_",") S LEVEL="TRACE"
 . S ^XTMP("MHV7LOG",1,"LEVEL")=LEVEL
 . S $P(RESULT,"^",5)=LEVEL
 . Q
 ;
 I NAMES'="" D
 . K ^XTMP("MHV7LOG",1,"NAMES")
 . S ^XTMP("MHV7LOG",1,"NAMES")=NAMES
 . F I=1:1:$L(NAMES,"^") S N=$P(NAMES,"^",I) S:N'="" ^XTMP("MHV7LOG",1,"NAMES",N)=""
 . S $P(RESULT,"^",6)=NAMES
 . Q
 ;
 I AUTOPRG'="" D
 . I DAYS<1 S DAYS=7
 . S ^XTMP("MHV7LOG",1,"AUTOPURGE")=+AUTOPRG
 . S ^XTMP("MHV7LOG",1,"AUTOPURGE","DAYS")=+DAYS
 . S $P(RESULT,"^",7)=+AUTOPRG
 . S $P(RESULT,"^",8)=+DAYS
 . Q
 ;
 S $P(RESULT,"^",1)=1
 Q
 ;
LOGOFF(RESULT) ; Turn off logging
 ;
 ;  Input: none
 ;
 ;  Output:
 ;    RESULT - success flag ^ deletion date/time
 ;
 S ^XTMP("MHV7LOG",1)=0
 S RESULT="1^"_$P($G(^XTMP("MHV7LOG",0)),"^")
 Q
 ;
LOGPRG(RESULT,DTM) ;Purge MHV application log
 ;
 ;  Input:
 ;    DTM - Purge Date/Time - optional
 ;          Fileman date/time
 ;          Default to older than a week
 ;
 ;  Output:
 ;    RESULT - success flag ^ purge date/time
 ;
 N %DT,X,Y
 S X=$G(DTM),%DT="TX" D ^%DT S DTM=Y
 I DTM<0 S DTM=$$HTFM^XLFDT($H-7,1)
 S RESULT=DTM
 S DTM=-DTM
 F  S DTM=$O(^XTMP("MHV7LOG",2,DTM)) Q:DTM=""  K ^XTMP("MHV7LOG",2,DTM)
 S RESULT="1^"_RESULT
 Q
 ;
LOGINFO(RESULT) ; Get information about log
 ;
 ;  Input: none
 ;
 ;  Output:
 ;    RESULT - log information
 ;
 K RESULT
 S RESULT("HEAD")=$G(^XTMP("MHV7LOG",0))
 S RESULT("DELETE")=$P(RESULT("HEAD"),"^",1)
 S RESULT("CREATED")=$P(RESULT("HEAD"),"^",2)
 S RESULT("TITLE")=$P(RESULT("HEAD"),"^",3)
 S RESULT("STATE")=$G(^XTMP("MHV7LOG",1))
 S RESULT("LEVEL")=$G(^XTMP("MHV7LOG",1,"LEVEL"))
 S RESULT("NAMES")=$G(^XTMP("MHV7LOG",1,"NAMES"))
 S RESULT("NEWEST")=-$O(^XTMP("MHV7LOG",2,""))
 S RESULT("OLDEST")=-$O(^XTMP("MHV7LOG",2,""),-1)
 S RESULT("AUTOPURGE")=$G(^XTMP("MHV7LOG",1,"AUTOPURGE"))
 S RESULT("DAYS")=$G(^XTMP("MHV7LOG",1,"AUTOPURGE","DAYS"))
 Q
 ;
LOGSIZE(RESULT) ; Get log size information
 ;
 ;  Input: none
 ;
 ;  Output:
 ;    RESULT - log size information
 ;
 K RESULT
 S RESULT("ENTRY COUNT")=0
 S RESULT("NODE COUNT")=0
 S RESULT("BYTE COUNT")=0
 N DTM,I,J,BASE,LBASE
 S DTM="",J=""
 F  S DTM=$O(^XTMP("MHV7LOG",2,DTM)) Q:DTM=""  D
 . F  S J=$O(^XTMP("MHV7LOG",2,DTM,J)) Q:J=""  D
 .. S RESULT("ENTRY COUNT")=RESULT("ENTRY COUNT")+1
 .. S BASE="^XTMP(""MHV7LOG"",2,"_DTM_","_J
 .. S I=BASE_")"
 .. S LBASE=$L(BASE)
 .. F  S I=$Q(@I) Q:$E(I,1,LBASE)'=BASE  D
 ... S RESULT("NODE COUNT")=RESULT("NODE COUNT")+1
 ... S RESULT("BYTE COUNT")=RESULT("BYTE COUNT")+$L(I)+$L(@I)-LBASE
 ... Q
 .. Q
 . Q
 Q
 ;
LOGSUM(RESULT) ; Retrieve log summary
 ;
 ;  Input: none
 ;    
 ;  Output:
 ;    RESULT - Global Root of Result Array
 ;             @RESULT - success flag ^ message or entry count ^ name
 ;             @RESULT@(n)=nth entry of log
 ;
 N CNT,DTM,J,NAME,ENTRYCNT
 S RESULT="^TMP(""MHV LOG SUMMARY"",$J)"
 K @RESULT
 S CNT=0,DTM="",J=""
 F  S DTM=$O(^XTMP("MHV7LOG",2,DTM)) Q:DTM=""  D
 . F  S J=$O(^XTMP("MHV7LOG",2,DTM,J)) Q:J=""  D
 .. S CNT=CNT+1
 .. S NAME=$O(^XTMP("MHV7LOG",2,DTM,J,1,""))
 .. S ENTRYCNT=$G(^XTMP("MHV7LOG",2,DTM,J))
 .. S @RESULT@(CNT)=DTM_"^"_J_"^"_ENTRYCNT_"^"_NAME
 .. Q
 . Q
 S @RESULT="1^"_CNT_"^"
 Q
 ;
LOGDET(RESULT,DTM,JOB) ; Retrieve log entry detail
 ;
 ;  Input:
 ;        DTM - Log Entry Date/Time
 ;              - Fileman date/time
 ;        JOB - Job Number
 ;
 ;  Output:
 ;    RESULT - Global Root of Result Array
 ;             @RESULT - success flag ^ message or node count
 ;             @RESULT@(0)= log entry header
 ;             @RESULT@(n)=nth node of entry
 ;
 N CNT,BASE,I,LBASE
 S RESULT="^TMP(""MHV LOG DETAIL"",$J)"
 K @RESULT
 I '$D(^XTMP("MHV7LOG",2,DTM)) S @RESULT="0^NO SUCH ENTRY"
 I '$D(^XTMP("MHV7LOG",2,DTM,JOB)) S @RESULT="0^NO SUCH ENTRY"
 ;
 S BASE="^XTMP(""MHV7LOG"",2,"_DTM_","_JOB
 S I=BASE_")"
 S BASE=BASE_","
 S LBASE=$L(BASE)
 S CNT=0
 S @RESULT@(0)=DTM_"^"_JOB_"^"_$G(^XTMP("MHV7LOG",2,DTM,JOB))
 F  S I=$Q(@I) Q:$E(I,1,LBASE)'=BASE  D
 . S CNT=CNT+1
 . S @RESULT@(CNT)=$P(I,BASE,2)_" = "_@I
 . Q
 S @RESULT="1^"_CNT
 Q
 ;

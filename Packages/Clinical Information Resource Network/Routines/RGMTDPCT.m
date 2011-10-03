RGMTDPCT ;GAI/TMG-Count Entries for ^DPT in Dup. Record file ;3-11-98
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;;  Counts duplicate entries for ^DPT in Duplicate Record file by each
 ;;  of the following and then by the match percentile.
 ;;  - STATUS (verification status)
 ;;                   P = potential duplicate
 ;;                   N = verified, not a duplicate
 ;;                   V = verified duplicate
 ;;                   X = verification in progress
 ;;                   R = required review
 ;;  - MERGE STATUS - 0 = not ready
 ;;                   1 = ready
 ;;                   2 = merged
 ;;                   3 = in progress
 ;;
START W !,"Duplicate Record File Statistics Scan",!
 I '$D(DUZ) W !!,"Your user identification is not set.  Please D ^XUP and try again." Q
 S USER=DUZ,ZTIO="",ZTRTN="SCAN^RGMTDPCT",ZTDESC="Duplicate Record Statistics Search"
 S ZTSAVE("USER")="" D ^%ZTLOAD I $D(ZTSK) W !,"  Task# ",ZTSK," queued to run." D ^%ZISC,KILL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;;
SCAN K ^XTMP("RGMTDPCT") S U="^"
 ;set purge date of XTMP = 30 days
 S ^XTMP("RGMTDPCT",0)=$$FMADD^XLFDT($$NOW^XLFDT,30)_U_$$NOW^XLFDT_U_"DUPLICATE RECORD CHECK"
 S ^XTMP("RGMTDPCT","@@@@","STARTED")=$$NOW^XLFDT
 S (^XTMP("RGMTDPCT","@@@@","SITE"),SITE)=$$SITE^VASITE()
 S IEN=0 F  S IEN=$O(^VA(15,IEN)) Q:+IEN'>0  I $D(^VA(15,+IEN,0)) S NODE0=^(0) D
 .S ^XTMP("RGMTDPCT","@@@@","CURR IEN")=IEN
 .S (VSTAT,MSTAT)="ZZZ" S:$P(NODE0,U,3)'="" VSTAT=$P(NODE0,U,3) S:$P(NODE0,U,5)'="" MSTAT=$P(NODE0,U,5)
 .S MPERC=(($P(NODE0,U,19))\10)*10
 .S:'$D(^XTMP("RGMTDPCT","VERIF",VSTAT,MPERC)) ^XTMP("RGMTDPCT","VERIF",VSTAT,MPERC)=0 S ^XTMP("RGMTDPCT","VERIF",VSTAT,MPERC)=^XTMP("RGMTDPCT","VERIF",VSTAT,MPERC)+1
 .S:'$D(^XTMP("RGMTDPCT","MERGE",MSTAT,MPERC)) ^XTMP("RGMTDPCT","MERGE",MSTAT,MPERC)=0 S ^XTMP("RGMTDPCT","MERGE",MSTAT,MPERC)=^XTMP("RGMTDPCT","MERGE",MSTAT,MPERC)+1
 ;
MSG ;
 S X=^XTMP("RGMTDPCT","@@@@","STARTED")
 S %DT="T" D ^%DT S X=Y X ^DD("DD") S MSGDT=Y
 S BLANKS="                         "
 S TXT(.1)="Duplicate Record (^DPT) Statistics"_$J(" ",15)_"Run Date: "_MSGDT
 S TXT(.2)=""
 S TXT(.3)=$P(SITE,U,2)_" ("_$P(SITE,U)_")"
 S TXT(.4)=""
 S TXT(.5)="  Counts by:  Merge Status and Match Percentile:"
 S LINE=1,STATUS="" F  S STATUS=$O(^XTMP("RGMTDPCT","MERGE",STATUS)) Q:STATUS=""  D
 .S MSGSTAT=$S(STATUS=0:"NOT READY",STATUS=1:"READY",STATUS=2:"MERGED",STATUS=3:"IN PROGRESS",STATUS="ZZZ":"UNKNOWN")
 . S LINE=LINE+.001
 . S TXT(LINE)=""
 . S LINE=LINE+.001 S TXT(LINE)="    Merge Status: "_MSGSTAT
 .S PERC=0 F  S PERC=$O(^XTMP("RGMTDPCT","MERGE",STATUS,PERC)) Q:+PERC'>0  S COUNT=^(PERC) D
 . . S LINE=LINE+.001
 . . S TEXT="      Percentile: "_PERC_BLANKS,TEXT=$E(TEXT,1,30),TEXT=TEXT_COUNT
 . . S TXT(LINE)=TEXT
 S LINE=2,LINE=LINE+.001 S TXT(LINE)=""
 S LINE=LINE+.001
 S TXT(LINE)="  Counts by:  Verification Status and Match Percentile:"
 S STATUS="" F  S STATUS=$O(^XTMP("RGMTDPCT","VERIF",STATUS)) Q:STATUS=""  D
 . S MSGSTAT=$S(STATUS="P":"POTENTIAL DUP., UNVERIF",STATUS="N":"VERIFIED, NOT A DUPLICATE",STATUS="V":"VERIFIED DUPLICATE",STATUS="X":"VERIF. IN PROGRESS",STATUS="R":"REQUIRES RESOLUTION",1:"")
 . S LINE=LINE+.001,TXT(LINE)=""
 . S LINE=LINE+.001,TXT(LINE)="    Verification Status: "_MSGSTAT
 . S PERC=0 F  S PERC=$O(^XTMP("RGMTDPCT","VERIF",STATUS,PERC)) Q:+PERC'>0  S COUNT=^(PERC) D
 . . S LINE=LINE+.001
 . . S TEXT="      Percentile: "_PERC_BLANKS,TEXT=$E(TEXT,1,30),TEXT=TEXT_COUNT
 . . S TXT(LINE)=TEXT
 S (XMY(DUZ),XMY(USER))="",(XMDUZ)=DUZ
 S XMSUB="Duplicate Record Counts: "_$P(SITE,U,2)
 S XMTEXT="TXT(" D ^XMD
 ;
KILL K ^XTMP("RGMTDPCT"),BLANKS,COUNT,IEN,LINE,MPERC,MSGDT,MSGSTAT,MSTAT,NODE0
 K PERC,SITE,STATUS,TEXT,TXT,USER,VSTAT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTSAVE
 K ZTDESC,ZTIO,ZTRTN,ZTSK,%DT
 Q

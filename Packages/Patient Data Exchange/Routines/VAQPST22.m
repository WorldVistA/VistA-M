VAQPST22 ;ALB/JRP - POST INIT (FILE CONVERSION);11-JUN-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PROCESS(REMOTE,RETURN,DEBUG) ;CONVERT REMOTE REQUESTS
 ;INPUT  : REMOTE - Name of local site (used as authorizing site)
 ;         RETURN - Domain of local site (used as authorizing domain)
 ;         DEBUG - Turns on debug mode (info written to screen)
 ;           1 - Debug on
 ;           0 - Debug off (default)
 ;OUTPUT : X - Number of requests successfully converted
 ;        -1^Error_Text - Error (nothing converted)
 ;NOTES  : All remote requests will be stored as requires manual
 ;         processing (even if they are marked for automatic)
 ;
 ;CHECK INPUT
 S REMOTE=$G(REMOTE)
 Q:(REMOTE="") "-1^Did not pass name of local site"
 S RETURN=$G(RETURN)
 Q:(RETURN="") "-1^Did not pass domain of local site"
 S DEBUG=+$G(DEBUG)
 N AUTOPTR,MANPTR,TMP,NODE0,NODE1,PTR10,TRAN10,COUNT
 N REMTRAN,ERRCNT,RELEASE,PATPTR,NAME,SSN,DOB,PID,DATE
 N USER,SITE,PTR15,TRAN15,STATUS,DOMAIN
 ;DETERMIN CONSTANTS
 S AUTOPTR=+$O(^VAT(394.3,"B",20,""))
 Q:('AUTOPTR) "-1^PDX STATUS file (#394.3) did not contain status # 20 (automatic processing)"
 S MANPTR=+$O(^VAT(394.3,"B",17,""))
 Q:('MANPTR) "-1^PDX STATUS file (#394.3) did not contain status # 17 (requires processing)"
 W:(DEBUG) !!!!
 W:(DEBUG) !,"*******************************"
 W:(DEBUG) !,"*                             *"
 W:(DEBUG) !,"*  Remote Request Conversion  *"
 W:(DEBUG) !,"*                             *"
 W:(DEBUG) !,"*******************************"
 W:(DEBUG) !!,"Pointer Information"
 W:(DEBUG) !,"-------------------"
 W:(DEBUG) !,"Automatic Processing Pointer: ",AUTOPTR
 W:(DEBUG) !,"Requires Processing Pointer: ",MANPTR
 ;FILE REMOTE REQUESTS
 W:(DEBUG) !!,"Converting remote requests ",!,"  Time: ",$$NOW^VAQUTL99,!
 S COUNT=0
 S ERRCNT=0
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",AUTOPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",AUTOPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",MANPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",MANPTR,PTR10)
 Q (COUNT-ERRCNT)
 ;
FILE ;FILE REQUESTS
 ;INCREMENT COUNT
 S COUNT=COUNT+1
 I (DEBUG) W:(('(COUNT#5))&(COUNT#100)) "." W:('(COUNT#100)) "#"
 ;GET INFO FROM 1.0 TRANSACTION
 I ('$D(^VAT(394,PTR10))) S ERRCNT=ERRCNT+1 Q
 S NODE0=$G(^VAT(394,PTR10,0))
 S NODE1=$G(^VAT(394,PTR10,1))
 S TRAN10=+$P(NODE0,"^",2)
 I ('TRAN10) S ERRCNT=ERRCNT+1 Q
 S TMP=+$P(NODE0,"^",12)
 I ((TMP'=AUTOPTR)&(TMP'=MANPTR)) S ERRCNT=ERRCNT+1 Q
 S STATUS="VAQ-PROC"
 S PATPTR=$P(NODE0,"^",9)
 S NAME=$P(NODE0,"^",4)
 S DOB=$P(NODE0,"^",7)
 S SSN=$P(NODE0,"^",5)
 S PID=$S(SSN="":"",1:($E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)))
 I (PATPTR="") S:(SSN'="") PATPTR=$O(^DPT("SSN",SSN,""))
 S DATE=$P(NODE0,"^",1)
 S USER=$P(NODE0,"^",19)
 S SITE=$P(NODE0,"^",17)
 I (SITE) D
 .S TMP=+$O(^DIC(4,"D",SITE,""))
 .Q:('TMP)
 .S SITE=$P($G(^DIC(4,TMP,0)),"^",1)
 .S:(SITE="") SITE=$P(NODE0,"^",17)
 S DOMAIN=$P(NODE1,"^",1)
 I (DOMAIN="") S ERRCNT=ERRCNT+1 Q
 S REMTRAN=$P(NODE0,"^",3)
 S RELEASE="VAQ-RQACK"
 ;GO TO CONTINUATION ROUTINE
 D CNVRT^VAQPST24
 Q

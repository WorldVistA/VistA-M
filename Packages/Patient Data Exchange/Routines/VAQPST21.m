VAQPST21 ;ALB/JRP - POST INIT (FILE CONVERSION);11-JUN-93
 ;;1.5;PATIENT DATA EXCHANGE;**1**;NOV 17, 1993
REQUEST(SITE,DOMAIN,OUTARR,DEBUG) ;CONVERT LOCAL REQUESTS
 ;INPUT  : SITE - Name of local site (used as requesting site)
 ;         DOMAIN - Domain of local site (used as requesting domain)
 ;         OUTARR - Where to store correlation of 1.0 request with it's
 ;                  entry in 394.61 (full global reference)
 ;         DEBUG - Turns on debug mode (info written to screen)
 ;           1 - Debug on
 ;           0 - Debug off (default)
 ;OUTPUT : X - Number of requests successfully converted
 ;        -1^Error_Text - Error (nothing converted)
 ;NOTES  : OUTARR will be in the format
 ;           OUTARR(X,Y)=Z
 ;             X = 1.0 request number
 ;             Y = 1.5 request number
 ;             Z = 1.5 IFN
 ;
 ;CHECK INPUT
 S SITE=$G(SITE)
 Q:(SITE="") "-1^Did not pass name of local site"
 S DOMAIN=$G(DOMAIN)
 Q:(DOMAIN="") "-1^Did not pass domain of local site"
 S OUTARR=$G(OUTARR)
 Q:(OUTARR="") "-1^Did not pass reference to output array"
 S DEBUG=+$G(DEBUG)
 N RQSTPTR,ACKPTR,TMP,NODE0,NODE1,PTR10,TRAN10,COUNT
 N REMTRAN,ERRCNT,RELEASE,PATPTR,NAME,SSN,DOB,PID,DATE
 N USER,REMOTE,PTR15,TRAN15,STATUS,RETURN
 ;DETERMIN CONSTANTS
 S RQSTPTR=+$O(^VAT(394.3,"B",10,""))
 Q:('RQSTPTR) "-1^PDX STATUS file (#394.3) did not contain status # 10 (request)"
 S ACKPTR=+$O(^VAT(394.3,"B",19,""))
 Q:('ACKPTR) "-1^PDX  STATUS file (#394.3) did not contain status # 19 (acknowledgement)"
 W:(DEBUG) !!!!
 W:(DEBUG) !,"******************************"
 W:(DEBUG) !,"*                            *"
 W:(DEBUG) !,"*  Local Request Conversion  *"
 W:(DEBUG) !,"*                            *"
 W:(DEBUG) !,"******************************"
 W:(DEBUG) !!,"Pointer Information"
 W:(DEBUG) !,"-------------------"
 W:(DEBUG) !,"Request Pointer: ",RQSTPTR
 W:(DEBUG) !,"Acknowledgement Pointer: ",ACKPTR
 ;FILE REQUESTS
 W:(DEBUG) !!,"Converting local requests",!,"  Time: ",$$NOW^VAQUTL99,!
 S COUNT=0
 S ERRCNT=0
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",RQSTPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",RQSTPTR,PTR10)
 S PTR10=0
 F  S PTR10=+$O(^VAT(394,"AD",ACKPTR,PTR10)) Q:('PTR10)  D FILE K ^VAT(394,"AD",ACKPTR,PTR10)
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
 I ((TMP'=RQSTPTR)&(TMP'=ACKPTR)) S ERRCNT=ERRCNT+1 Q
 S STATUS=$S((TMP=ACKPTR):"VAQ-RQACK",1:"VAQ-RQST")
 S PATPTR=$P(NODE0,"^",9)
 S NAME=$P(NODE0,"^",4)
 S DOB=$P(NODE0,"^",7)
 S SSN=$P(NODE0,"^",5)
 S PID=$S(SSN="":"",1:($E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)))
 I (PATPTR="") S:(SSN'="") PATPTR=$O(^DPT("SSN",SSN,""))
 S DATE=$P(NODE0,"^",1)
 S USER=$P(NODE0,"^",19)
 S REMOTE=$P(NODE0,"^",17)
 I (REMOTE) D
 .S TMP=+$O(^DIC(4,"D",REMOTE,""))
 .Q:('TMP)
 .S REMOTE=$P($G(^DIC(4,TMP,0)),"^",1)
 .S:(REMOTE="") REMOTE=$P(NODE0,"^",17)
 S RELEASE="VAQ-RQST"
 S RETURN=""
 S REMTRAN=""
 ;GO TO CONTINUATION ROUTINE
 D CNVRT^VAQPST24
 ;STORE CORRELATION
 Q:(('TRAN10)!('$G(TRAN15)))
 S @OUTARR@(TRAN10,TRAN15)=PTR15
 Q

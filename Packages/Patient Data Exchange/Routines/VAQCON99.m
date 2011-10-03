VAQCON99 ;ALB/JRP - MESSAGE CONSTRUCTION;14-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
HEAD10(TRANPTR,MESSNUM,ARRAY,OFFSET) ;BUILD HEADER BLOCK FOR VERSION 1.0
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         MESSNUM - Message number to place block into
 ;                   (if 0, block will be placed in ARRAY)
 ;         ARRAY - Array to store block in (full global reference)
 ;         OFFSET - Where to begin placing (default to 0)
 ;OUTPUT : N - Number of lines in block
 ;        -1^Error_Text - Error
 ;NOTES  : If MESSNUM=0, then block will be placed into
 ;           ARRAY(LineNumber)=Line_of_info
 ;         If MESSNUM>0 then the block will be placed into
 ;           ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid pointer to VAQ - TRANSACTION file"
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number or reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N LINE,TYPE,STATUS,PARENT,RQSTNUM,NAME,SSN,DOB,PID,RQSTDUZ,RQSTNAME
 N RQSTSITE,CODE10,STAT10,ATHRDUZ,ATHRNAME,ATHRSITE,DOMAIN,CLAIM
 N DATETIME,COMMENT,TMP,X
 S LINE=OFFSET
 S CLAIM=""
 S CODE10=101
 S COMMENT=""
 S RQSTDUZ=""
 S ATHRDUZ=""
 ;GET STATUS & TYPE
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 Q:($P(TMP,"^",1)="-1") TMP
 S STATUS=$P(TMP,"^",1)
 S TYPE=$P(TMP,"^",2)
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;SET 1.0 STATUS
 S STAT10=0
 S:(STATUS="VAQ-AMBIG") STAT10=11
 S:(STATUS="VAQ-NTFND") STAT10=12
 S:(STATUS="VAQ-REJ") STAT10=13
 S:(STATUS="VAQ-RQACK") STAT10=19
 S:(STATUS="VAQ-RQST") STAT10=10
 S:(STATUS="VAQ-RSLT") STAT10=15
 S:(STATUS="VAQ-UNSOL") STAT10=16
 Q:((STATUS="VAQ-RTRNS")!(STATUS="VAQ-UNACK")) "-1^Version 1.0 does not have an equivalent message"
 Q:((STATUS="VAQ-AUTO")!(STATUS="VAQ-PROC")!(STATUS="VAQ-TUNSL")) "-1^Message not required"
 Q:('STAT10) "-1^Could not determine 1.0 status"
 ;GET PARENT PDX NUMBER
 S:(TYPE="REQ") PARENT=+$G(^VAT(394.61,TRANPTR,0))
 S:((TYPE="RES")!(TYPE="ACK")) PARENT=+$P($G(^VAT(394.61,TRANPTR,0)),"^",6)
 S:(TYPE="UNS") PARENT=""
 Q:('$D(PARENT)) "-1^Could not determine 1.0 parent PDX number"
 ;GET NAME,SSN,DOB,PID
 S TMP=$G(^VAT(394.61,TRANPTR,"QRY"))
 Q:(TMP?1."^") "-1^Patient information not contained in VAQ - TRANSACTION file"
 S NAME=$P(TMP,"^",1)
 S SSN=$P(TMP,"^",2)
 S DOB=$P(TMP,"^",3)
 S PID=$P(TMP,"^",4)
 Q:((NAME="")!(SSN="")) "-1^Transaction did not contain patient's name or SSN"
 ;GET REQUESTER'S NAME
 S RQSTNAME=""
 S RQSTNAME=$P($G(^VAT(394.61,TRANPTR,"RQST1")),"^",2)
 S:(TYPE="UNS") RQSTNAME="UNSOLICITED"
 S:((RQSTNAME="")&(TYPE="REQ")) RQSTNAME=$P($G(^VA(200,(+$G(DUZ)),0)),"^",1)
 Q:((RQSTNAME="")&(TYPE="REQ")) "-1^Could not determine name of requestor"
 ;GET REQUESTING DUZ
 I (TYPE="REQ") D
 .S RQSTDUZ=+$O(^VA(200,"B",RQSTNAME,""))
 .S:('RQSTDUZ) RQSTDUZ=$G(DUZ)
 ;GET DATE TIME (FILEMAN FORMAT)
 S TMP=$$NOW^VAQUTL99(1)
 S:(TYPE="ACK") TMP=+$G(^VAT(394.61,TRANPTR,"RQST1"))
 S DATETIME=TMP
 Q:($P(DATETIME,"^",1)="-1") DATETIME
 ;GET REQUESTING SITE NUMBER
 S RQSTSITE=""
 I ((TYPE="REQ")!(TYPE="UNS")) D  Q:(RQSTSITE="") "-1^Could not determine current site number"
 .S TMP=+$O(^VAT(394.81,0))
 .Q:('TMP)
 .S X=+$G(^DIC(4,+$G(^VAT(394.81,TMP,0)),99))
 .Q:('X)
 .S RQSTSITE=X
 I (TYPE="RES") D
 .S TMP=$P($G(^VAT(394.61,TRANPTR,"RQST2")),"^",1)
 .S:(TMP'="") RQSTSITE=$O(^DIC(4,"B",TMP,""))
 ;GET REQUEST NUMBER
 S:(TYPE="REQ") RQSTNUM=PARENT
 S:((TYPE="UNS")!(TYPE="ACK")) RQSTNUM=""
 S:(TYPE="RES") RQSTNUM=+$G(^VAT(394.61,TRANPTR,0))
 Q:('$D(RQSTNUM)) "-1^Could not determine 1.0 PDX request number"
 ;GET AUTHORIZING NAME
 S ATHRNAME=""
 S ATHRNAME=$P($G(^VAT(394.61,TRANPTR,"ATHR1")),"^",2)
 S:((ATHRNAME="")&((TYPE="UNS")!(TYPE="RES"))) ATHRNAME=$P($G(^VA(200,(+$G(DUZ)),0)),"^",1)
 Q:((ATHRNAME="")&((TYPE="UNS")!(TYPE="RES"))) "-1^Could not determine name of authorizer"
 ;GET AUTHORIZING DUZ
 I ((TYPE="RES")!(TYPE="UNS")) D
 .S ATHRDUZ=+$O(^VA(200,"B",ATHRNAME,""))
 .S:('ATHRDUZ) ATHRDUZ=$G(DUZ)
 ;GET AUTHORIZING SITE NUMBER
 S ATHRSITE=""
 I ((TYPE="RES")!(TYPE="UNS")) D  Q:(ATHRSITE="") "-1^Could not determine current site number"
 .S TMP=+$O(^VAT(394.81,0))
 .Q:('TMP)
 .S X=+$G(^DIC(4,+$G(^VAT(394.81,TMP,0)),99))
 .Q:('X)
 .S ATHRSITE=X
 I (TYPE="REQ") D
 .S TMP=$P($G(^VAT(394.61,TRANPTR,"ATHR2")),"^",1)
 .S:(TMP'="") ATHRSITE=$O(^DIC(4,"B",TMP,""))
 ;SET REMOTE DUZs TO PERSON'S NAME
 S:((TYPE="ACK")!(TYPE="RES")) RQSTDUZ=RQSTNAME
 ;MOVE TO CONTINUATION ROUTINE
 D HEAD10^VAQCON98
 Q (LINE-OFFSET)

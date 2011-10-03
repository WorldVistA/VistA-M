VAQCON1 ;ALB/JRP - MESSAGE CONSTRUCTION;9-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MAKESTUB(XMSUB,XMDUZ) ;CREATE STUB MAILMAN MESSAGE
 ;INPUT  : XMSUB - Subject of message
 ;         XMDUZ - Sender of message; Pointer to NEW PERSON file
 ;                 or text to be used as the sender (defaults to DUZ)
 ;OUTPUT : XMZ - Message number
 ;        -1^Error_Text - Error
 ;
 ;CHECK INPUT
 Q:($G(XMSUB)="") "-1^Subject of message not passed"
 S:($G(XMDUZ)="") XMDUZ=$G(DUZ)
 Q:(XMDUZ="") "-1^Could not determine sender of message"
 ;DECLARE VARIABLES
 N XMZ
 ;CREATE STUB
 D XMZ^XMA2
 S:(XMZ<1) XMZ="-1^Could not create stub message"
 Q XMZ
 ;
ADDLINE(TEXT,MESSAGE,LINE) ;ADD LINE OF TEXT TO MESSAGE
 ;INPUT  : TEXT - Line of text to add
 ;         MESSAGE - Message number
 ;         LINE - Line number
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;NOTES  : NULL lines of text will be converted to <SPACE>
 ;
 ;CHECK INPUT
 S:($G(TEXT)="") TEXT=" "
 S MESSAGE=+$G(MESSAGE)
 Q:(('MESSAGE)!('$D(^XMB(3.9,MESSAGE)))) "-1^Valid message number not passed"
 Q:('(+$G(LINE))) "-1^Line number not passed"
 ;INSERT TEXT
 S ^XMB(3.9,MESSAGE,2,LINE,0)=TEXT
 Q 0
 ;
KILLSTUB(XMZ) ;DELETE STUB MESSAGE
 ;INPUT  : XMZ - Message number
 ;OUTPUT : 0 - "Success"
 ;        -1^Error_Text - Message number not passed
 ;NOTE   : This should be used when errors occur while building
 ;         message
 ;
 ;CHECK INPUT
 S XMZ=+$G(XMZ)
 Q:(('XMZ)!('$D(^XMB(3.9,XMZ)))) "-1^Valid message number not passed"
 ;DECLARE VARIABLES
 N XMDUN,XMY,TMP,ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTSAVE
 ;SET ZERO NODE
 S TMP=$$SETZERO(XMZ,0)
 ;SEND MESSAGE TO POSTMASTER
 S XMDUN="Patient Data eXchange"
 S XMY(.5)=""
 D ENT1^XMD
 ;DELETE MESSAGE FROM POSTMASTER'S BASKET
 ;THIS IS TASKED TO GIVE TIME FOR MESSAGE DELIVERY
 S ZTRTN="KILLMES^VAQCON1"
 S ZTDESC="Killing of bad PDX messages"
 S ZTDTH=$H
 S ZTSAVE("XMZ")=XMZ
 S ZTSAVE("XMDUZ")=.5
 D ^%ZTLOAD
 I ('$D(ZTSK)) Q "-1^Could not task deletion of message"
 Q 0
 ;
KILLMES ;KILL MESSAGES (TASKED)
 ;INPUT  : XMK - Basket number (optional)
 ;         XMZ - Message number
 ;         XMDUZ - User's DUZ
 ;OUTPUT : None
 ;NOTE   : This is used to delete the message by KILLSTUB
 ;       : All input variables are deleted upon exit
 ;
 ;CHECK INPUT
 I (('$G(XMZ))!('$G(XMDUZ))) K XMK,XMZ,XMDUZ Q
 ;KILL MESSAGE
 D KLQ^XMA1B
 K XMK,XMZ,XMDUZ
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
SETZERO(MESSAGE,LINES) ;SET ZERO NODE OF MAILMAN MESSAGE
 ;INPUT  : MESSAGE - Message number
 ;         LINES - Number of lines in message (defaults to 0)
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;
 ;CHECK INPUT
 S MESSAGE=+$G(MESSAGE)
 Q:(('MESSAGE)!('$D(^XMB(3.9,MESSAGE)))) "-1^Valid message number not passed"
 S LINES=+$G(LINES)
 ;SET ZERO NODE
 S ^XMB(3.9,MESSAGE,2,0)="^3.92A^"_LINES_"^"_LINES_"^"_+$G(DT)
 Q 0
 ;
STATYPE(TRAN,CURRENT) ;DETERMINE MESSAGE STATUS & TYPE OF TRANSACTION
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         CURRENT - Flag indicating if which status to use
 ;                   If 0, return release status (default)
 ;                   If 1, return current status
 ;OUTPUT : Message_Status^Message_Type - Success
 ;        -1^Error_Text - Error
 ;CHECK INPUT
 Q:('(+$G(TRAN))) "-1^Did not pass pointer to VAQ - TRANSACTION file"
 S CURRENT=+$G(CURRENT)
 ;DECLARE VARIABLES
 N TMP,STATUS,TYPE
 S TMP=$G(^VAT(394.61,TRAN,0))
 Q:(TMP="") "-1^Did not pass a valid transaction"
 S:(CURRENT) TMP=+$P(TMP,"^",2)
 S:('CURRENT) TMP=+$P(TMP,"^",5)
 Q:('TMP) "-1^Could not determine status of message"
 S STATUS=$P($G(^VAT(394.85,TMP,0)),"^",1)
 Q:(STATUS="") "-1^Could not determine status of message"
 ;DETERMINE MESSAGE TYPE
 S TYPE=0
 S:((STATUS="VAQ-TUNSL")!(STATUS="VAQ-PROC")) TYPE=""
 S:(STATUS="VAQ-RQST") TYPE="REQ"
 S:((STATUS="VAQ-AMBIG")!(STATUS="VAQ-AUTO")!(STATUS="VAQ-NTFND")!(STATUS="VAQ-REJ")!(STATUS="VAQ-RSLT")) TYPE="RES"
 S:(STATUS="VAQ-UNSOL") TYPE="UNS"
 S:((STATUS="VAQ-RQACK")!(STATUS="VAQ-UNACK")) TYPE="ACK"
 S:(STATUS="VAQ-RTRNS") TYPE="RET"
 S:(STATUS="VAQ-RCVE") TYPE="REC"
 Q:(TYPE=0) "-1^Could not determine message type"
 Q STATUS_"^"_TYPE

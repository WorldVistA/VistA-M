VAQPAR1 ;ALB/JRP - MESSAGE PARSING;28-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PREPRS10(ARRAY) ;PRE-PARSE VERSION 1.0 TRANSMISSION
 ;INPUT  : ARRAY - Parsing array (full global reference)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         (Declared in SERVER^VAQADM2)
 ;         XMER, XMRG, XMPOS
 ;OUTPUT : XMER - Exit condition
 ;           0 = Success
 ;           -1^Error_Text = Error
 ;         XMPOS - Last line [number] read in transmission
 ;                 (if NULL end of transmission reached)
 ;
 ;NOTES  : Parsing array will have the following format
 ;           ARRAY(1,BlockName,LineNumber) = Value
 ;       : Calling routine responsible for ARRAY clean up before
 ;         and after call
 ;       : This is not a function
 ;
 ;CHECK INPUT
 I ($G(ARRAY)="") S XMER="-1^Did not pass reference to parsing array" Q
 ;DECLARE VARIABLES
 N LINE,ERR,BLOCK,TMP,X
 S XMER=0
 S LINE=1
 ;READ HEADER
 S BLOCK="HEADER"
 X XMREC
 I ((XMER<0)!(XMRG="")) S XMER="-1^Transmission did not contain any information" Q
 S @ARRAY@(1,BLOCK,LINE)=XMRG
 S LINE=LINE+1
 ;QUIT IF TRANSMISSION IS AN ACK
 Q:($P(XMRG,"^",1)="ACK")
 X XMREC
 I ((XMER<0)!(XMRG="")) S XMER="-1^Transmission was not complete" Q
 S @ARRAY@(1,BLOCK,LINE)=XMRG
 S LINE=LINE+1
 ;CHECK TRANSMISSION TYPE
 S TMP=+$P(@ARRAY@(1,BLOCK,1),"^",12)
 ;TRANSMISSION TYPE NOT SUPPORTED
 I ((TMP=17)!(TMP=19)!(TMP=20)) S XMER="-1^Transmission type not supported" Q
 F X=10:1:21 Q:(TMP=X)
 I (X=21) S XMER="-1^Transmission type not supported" Q
 ;NO DATA BLOCKS IN TRANSMISSION
 Q:((TMP'=15)&(TMP'=16))
 ;READ DATA BLOCKS
 S XMER=0
 F  X XMREC Q:(XMER<0)  D
 .;GET DATA BLOCK TYPE
 .S TMP=$P(XMRG,"^",1)
 .;NEW DATA BLOCK TYPE
 .S:(TMP'=BLOCK) LINE=1
 .;BLOCK NOT SUPPORTED (SKIP)
 .Q:((TMP'="MIN")&(TMP'="MAS")&(TMP'="PHA"))
 .S BLOCK=TMP
 .S @ARRAY@(1,BLOCK,LINE)=$P(XMRG,"^",2,($L(XMRG,"^")))
 .S LINE=LINE+1
 S XMER=0
 Q
 ;
PARSE10(ARRAY) ;PARSE 1.0 MESSAGE
 ;INPUT  : ARRAY - Array containing pre-parsed version 1.0 transmission
 ;                 (full global reference)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         (Declared in SERVER^VAQADM2)
 ;         XMER, XMRG, XMPOS
 ;OUTPUT : XMER - Exit condition
 ;           0 = Success
 ;           -1^Error_Text = Error
 ;NOTES  : Pre-parsed transmsission will be deleted from ARRAY
 ;         and replaced with parsed array.  Parsed array will be same
 ;         as parsed array for version 1.5 message and have the format:
 ;           ARRAY(2,BlockName,BlockSeq,Line)
 ;       : This is not a function
 ;
 ;CHECK INPUT
 I ($G(ARRAY)="") S XMER="-1^Did not pass reference to parsing array" Q
 I ('$D(@ARRAY@(1))) S XMER="-1^Parsing array did not contain pre-parsed transmission" Q
 ;DECLARE VARIABLES
 N TMP,BLOCK,ACK,TYPE,STATUS,X,Y
 S XMER=0
 ;DETERMINE IF MESSAGE IS AN ACKNOWLEDGMENT
 S TMP=$G(@ARRAY@(1,"HEADER",1))
 I (TMP="") S XMER="-1^Header did not exist in pre-parsed message" Q
 S ACK=($P(TMP,"^",1)="ACK")
 ;ACK
 I (ACK) D
 .;MAKE HEADER BLOCK
 .S @ARRAY@(2,"HEADER",1,1)="$HEADER"
 .S @ARRAY@(2,"HEADER",1,2)="ACK"
 .S @ARRAY@(2,"HEADER",1,3)="VAQ-RQACK"
 .S @ARRAY@(2,"HEADER",1,4)=1.0
 .S @ARRAY@(2,"HEADER",1,5)=$$NOW^VAQUTL99(0,0)
 .S @ARRAY@(2,"HEADER",1,6)=$G(XMZ)
 .S @ARRAY@(2,"HEADER",1,7)=$P($G(@ARRAY@(1,"HEADER",1)),"^",2)
 .S @ARRAY@(2,"HEADER",1,8)=""
 .S @ARRAY@(2,"HEADER",1,9)="$$HEADER"
 ;NOT AN ACK
 I ('ACK) D
 .;DETERMINE STATUS & TYPE
 .S TMP=$G(@ARRAY@(1,"HEADER",1))
 .S X=$P(TMP,"^",12)
 .S:(X=10) STATUS="VAQ-RQST",TYPE="REQ"
 .S:(X=11) STATUS="VAQ-AMBIG",TYPE="RES"
 .S:(X=12) STATUS="VAQ-NTFND",TYPE="RES"
 .S:((X=13)!(X=14)!(X=18)) STATUS="VAQ-REJ",TYPE="RES"
 .S:(X=15) STATUS="VAQ-RSLT",TYPE="RES"
 .S:(X=16) STATUS="VAQ-UNSOL",TYPE="UNS"
 .S @ARRAY@(2,"HEADER",1,1)="$HEADER"
 .S @ARRAY@(2,"HEADER",1,2)=TYPE
 .S @ARRAY@(2,"HEADER",1,3)=STATUS
 .S @ARRAY@(2,"HEADER",1,4)=1.0
 .S X=+$P(TMP,"^",9)
 .S Y=$P(X,".",2)
 .S Y=Y_"000000"
 .S $P(X,".",2)=Y
 .S Y=$$DOBFMT^VAQUTL99(X)
 .I (Y'="") D
 ..S X=$P(X,".",2)
 ..S Y=Y_"@"_$E(X,1,2)_":"_$E(X,3,4)_":"_$E(X,5,6)
 .S @ARRAY@(2,"HEADER",1,5)=Y
 .S @ARRAY@(2,"HEADER",1,6)=$G(XMZ)
 .S X=""
 .S:((TYPE="RES")!(TYPE="REQ")) X=+TMP
 .S @ARRAY@(2,"HEADER",1,7)=X
 .S @ARRAY@(2,"HEADER",1,8)=""
 .S @ARRAY@(2,"HEADER",1,9)="$$HEADER"
 ;MAKE DOMAIN BLOCK
 S @ARRAY@(2,"DOMAIN",1,1)="$DOMAIN"
 S X=$P($G(@ARRAY@(1,"HEADER",2)),"^",1)
 S:(X="") X=$P($G(XMFROM),"@",2)
 S @ARRAY@(2,"DOMAIN",1,2)=X
 S @ARRAY@(2,"DOMAIN",1,3)=""
 S @ARRAY@(2,"DOMAIN",1,4)="$$DOMAIN"
 ;DONE IF ACK
 Q:(ACK)
 ;GO TO CONTINUATION ROUTINE
 D PARCON^VAQPAR10
 Q

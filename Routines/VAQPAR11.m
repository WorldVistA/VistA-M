VAQPAR11 ;ALB/JRP - MESSAGE PARSING;10-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DATA10(ARRAY,BLOCK,BLOCKNUM) ;PARSE DATA BLOCKS FOR 1.0 MESSAGE
 ;INPUT  : ARRAY - Array containing pre-parsed version 1.0 transmission
 ;                 (full global reference)
 ;         BLOCK - Version 1.0 block name (MIN,MAS,PHA)
 ;         BLOCKNUM - Block sequence number (defaults to 1)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         (Declared in SERVER^VAQADM2)
 ;         XMER, XMRG, XMPOS
 ;OUTPUT : XMER - Exit condition
 ;           0 = Success
 ;           -1^Error_Text = Error
 ;         Parsed array will be same as parsed array for version
 ;         1.5 message and have the format:
 ;           ARRAY(2,"DATA",BLOCKNUM,Line)
 ;
 ;CHECK INPUT
 I ($G(ARRAY)="") S XMER="-1^Did not pass reference to parsing array" Q
 I ('$D(@ARRAY@(1))) S XMER="-1^Parsing array did not contain pre-parsed transmission" Q
 I ($G(BLOCK)="") S XMER="-1^Did not pass data block name" Q
 I ((BLOCK'="MIN")&(BLOCK'="MAS")&(BLOCK'="PHA")) S XMER="-1^Did not pass valid version 1.0 data block name" Q
 S:($G(BLOCKNUM)="") BLOCKNUM=1
 ;DECLARE VARIABLES
 N LINE,X,Y,TMP,OFFSET,FILE,FIELD,FIELDS,VALUES,SEQ,TMPARR
 N FLDCNT,VALCNT,LOOP1,LOOP2,REPCNT,ID,PATNAME,RXNUM,VALUE
 ;GET PATIENT'S NAME
 S PATNAME=$G(@ARRAY@(2,"PATIENT",1,3))
 I (PATNAME="") S XMER="-1^Patient's name was not contained in the transmission" Q
 ;SET UP TEMPORARY PARSING ARRAY
 S TMP=$P(ARRAY,"(",1)
 S X=$P(ARRAY,"(",2)
 S Y=$P(X,")",1)
 S:(Y="") TMPARR=TMP_"("_3_")"
 S:(Y'="") TMPARR=TMP_"("_Y_","_3_")"
 K @TMPARR
 S XMER=0
 ;LINE 1
 S @ARRAY@(2,"DATA",BLOCKNUM,1)="$DATA"
 S X="PDX*"_BLOCK
 S:(BLOCK="PHA") X="PDX*MPL"
 S @ARRAY@(2,"DATA",BLOCKNUM,2)=X
 ;PRE-PARSE DATA BLOCK
 S OFFSET=""
 F  S OFFSET=$O(@ARRAY@(1,BLOCK,OFFSET)) Q:(OFFSET="")  D
 .S TMP=$G(@ARRAY@(1,BLOCK,OFFSET))
 .Q:(TMP="")
 .S FILE=$P(TMP,"^",1)
 .S FIELDS=$P(TMP,"^",2)
 .S VALUES=$P(TMP,"^",3,($L(TMP,"^")))
 .S RXNUM=""
 .I (FILE=52.1) D
 ..S RXNUM=$P(FIELDS,"~",2)
 ..S FIELDS=$P(FIELDS,"~",1)
 .I ((FILE=52)&($P(FIELDS,";",1)=.01)) D
 ..S RXNUM=$P(VALUES,"^",1)
 .S FLDCNT=$L(FIELDS,";")
 .S VALCNT=$L(VALUES,"^")
 .S REPCNT=(VALCNT\FLDCNT)-1
 .S:(REPCNT<0) REPCNT=0
 .F LOOP1=0:1:REPCNT D
 ..F LOOP2=1:1:FLDCNT D
 ...S FIELD=$P(FIELDS,";",LOOP2)
 ...S VALUE=$P(VALUES,"^",((LOOP1*FLDCNT)+LOOP2))
 ...;CONVERT DATES
 ...S:($P($G(^DD(FILE,FIELD,0)),"^",2)["D") VALUE=$$DOBFMT^VAQUTL99(VALUE,1)
 ...;CONVERT STATES
 ...I ((+$P($P($G(^DD(FILE,FIELD,0)),"^",2),"P",2))=5) D
 ....Q:(VALUE="")
 ....S X=$O(^DIC(5,"C",VALUE,""))
 ....I (X="") S VALUE="" Q
 ....S VALUE=$P($G(^DIC(5,X,0)),"^",1)
 ...S SEQ=""
 ...F  Q:($O(@TMPARR@("VALUE",FILE,FIELD,SEQ))="")  S SEQ=$O(@TMPARR@("VALUE",FILE,FIELD,SEQ))  Q:((FILE=52)&(FIELD=.01)&($G(@TMPARR@("VALUE",FILE,FIELD,SEQ))=VALUE))
 ...S SEQ=$S((SEQ=""):0,((FILE=52)&(FIELD=.01)&($G(@TMPARR@("VALUE",FILE,FIELD,SEQ))=VALUE)):SEQ,1:SEQ+1)
 ...S @TMPARR@("VALUE",FILE,FIELD,SEQ)=VALUE
 ...I (BLOCK="MIN") S ID=PATNAME
 ...I (BLOCK="PHA") D
 ....I (FILE=52) S ID=$S((FIELD=.01):PATNAME,1:RXNUM) Q
 ....I (FILE=52.1) S ID=RXNUM Q
 ....I ((FILE=2)!(FILE=55)) S ID=PATNAME Q
 ....I (FIELD=.01) S ID=PATNAME Q
 ....S ID=$G(@TMPARR@("VALUE",FILE,.01,SEQ))
 ...I (BLOCK="MAS") D
 ....I (FILE=2) S ID=PATNAME Q
 ....I (FILE=2.98) S ID=$S((FIELD=.001):PATNAME,1:$G(@TMPARR@("VALUE",2.98,.001,SEQ))) Q
 ....I (FIELD=.01) S ID=PATNAME Q
 ....I (FILE=36) S ID=$G(@TMPARR@("VALUE",2.312,.01,SEQ)) Q
 ....S ID=$G(@TMPARR@("VALUE",FILE,.01,SEQ))
 ...S @TMPARR@("ID",FILE,FIELD,SEQ)=ID
 ;STORE INTO PARSE ARRAY
 S LINE=3
 S FILE=""
 F  S FILE=$O(@TMPARR@("VALUE",FILE)) Q:(FILE="")  D
 .S FIELD=""
 .F  S FIELD=$O(@TMPARR@("VALUE",FILE,FIELD)) Q:(FIELD="")  D
 ..S VALUES=0
 ..F  Q:($O(@TMPARR@("VALUE",FILE,FIELD,VALUES))="")  S VALUES=$O(@TMPARR@("VALUE",FILE,FIELD,VALUES))
 ..S VALUES=VALUES+1
 ..S @ARRAY@(2,"DATA",BLOCKNUM,LINE)=0_"^"_FILE_"^"_FIELD_"^"_VALUES
 ..S LINE=LINE+1
 ..S SEQ=""
 ..F  S SEQ=$O(@TMPARR@("VALUE",FILE,FIELD,SEQ)) Q:(SEQ="")  D
 ...S VALUE=$G(@TMPARR@("VALUE",FILE,FIELD,SEQ))
 ...S @ARRAY@(2,"DATA",BLOCKNUM,LINE)=VALUE
 ...S LINE=LINE+1
 ...S ID=$G(@TMPARR@("ID",FILE,FIELD,SEQ))
 ...S @ARRAY@(2,"DATA",BLOCKNUM,LINE)=ID
 ...S LINE=LINE+1
 ;DONE
 S @ARRAY@(2,"DATA",BLOCKNUM,LINE)="$$DATA"
 K @TMPARR
 Q

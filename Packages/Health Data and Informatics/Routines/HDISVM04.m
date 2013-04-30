HDISVM04 ;BPFO/JRP - UUDECODE;5/31/2007
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
DECODE(IN,OUT,FIND,ZERO) ;UUDecode contents of text
 ; Input: IN = Array containing lines of text to encode
 ;             (FULL GLOBAL REFERENCE)
 ;          IN(1) = "begin 644 FILENAME"
 ;          IN(2..n) = UUEncoded line of text
 ;          IN(n+1) = "`"
 ;          IN(n+2) = "end"
 ;        OUT = Array to put uudecoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;        FIND = Flag indicating if the "begin 644 FILENAME" line
 ;               must be found.  A value of 1 will cause this utility
 ;               to order through the nodes of the array until the
 ;               beginning line is found.  A value of 0 will cause
 ;               this utility to assume that node IN(1) is the
 ;               beginning node.
 ;               (DEFAULTS TO 0)
 ;        ZERO = Flag indicating if the input array stores it's data
 ;               on a zero node.  A value of 1 denotes that the
 ;               uuencoded data is stored in IN(node,0).  A value of
 ;               0 denotes that the uuencoded data is not.
 ;               (DEFAULTS TO 0)
 ;Output: None
 ;        OUT will be set as follows:
 ;          OUT(0) = File name from encoded text
 ;          OUT(1..n) = Lines of text
 ;          OUT(n,1..m) = Continuation of text when length of line
 ;                        is longer than 245 characters
 ;
 ; Notes: It is assumed that all input is defined
 ;      : The OUT array will be initialized (KILLed) on input.
 ;      : It is assumed that IN is not an empty arrary (i.e. there's
 ;        data to be uudecoded in it).
 ;      : A carriage return, line feed, or carriage return plus line
 ;        feed will move storing of the decoded text to the next node
 ;        of the output array
 ;
 NEW NODE,CR,LF,UUENC,LOOP,LENGTH,OUTNODE,WORKING,TEXT
 NEW CRSPOT,LFSPOT,TMPTXT,TMPLEN,CREND
 KILL @OUT
 SET FIND=+$GET(FIND)
 SET ZERO=+$GET(ZERO)
 SET CR=$CHAR(13)
 SET LF=$CHAR(10)
 SET CREND=0
 ;Move to beginning of encoded text
 SET NODE=1
 IF (FIND) DO  QUIT:('NODE)
 .NEW STOP
 .SET STOP=0
 .SET NODE=0
 .FOR  SET NODE=+$ORDER(@IN@(NODE)) QUIT:('NODE)  DO  QUIT:(STOP)
 ..SET TEXT=$SELECT(ZERO:@IN@(NODE,0),1:@IN@(NODE))
 ..IF ($TRANSLATE(TEXT,0)["begin 644") SET STOP=1
 ..QUIT
 .IF ('STOP) SET NODE=0
 .QUIT
 ;Put file name into output array
 SET TEXT=$SELECT(ZERO:@IN@(NODE,0),1:@IN@(NODE))
 SET @OUT@(0)=$PIECE(TEXT,"644 ",2)
 ;Loop through input array
 SET OUTNODE=1
 SET WORKING=""
 FOR  SET NODE=+$ORDER(@IN@(NODE)) QUIT:('NODE)  DO
 .SET UUENC=$SELECT(ZERO:@IN@(NODE,0),1:@IN@(NODE))
 .;End of encoded input - force outer loop to quit
 .IF ((UUENC="`")!(UUENC=" ")) SET NODE=+$ORDER(@IN@(""),-1) QUIT
 .;Get length of encoded text
 .SET LENGTH=$ASCII($EXTRACT(UUENC,1))-32
 .;UUDecode 4 characters at a time
 .SET TEXT=""
 .FOR LOOP=2:4:$LENGTH(UUENC) DO
 ..SET TEXT=TEXT_$$UUD4($EXTRACT(UUENC,LOOP,LOOP+3))
 ..QUIT
 .;Remove extra characters from end of text
 .SET TEXT=$EXTRACT(TEXT,1,LENGTH)
 .;First character is LF and last character of previous line was CR
 .;Drop the LF since the CR/LF was done on previous line
 .IF ($EXTRACT(TEXT,1)=LF) IF (CREND) SET TEXT=$EXTRACT(TEXT,2,$LENGTH(TEXT))
 .;Remember if last character is CR
 .SET CREND=0
 .IF ($EXTRACT(TEXT,$LENGTH(TEXT))=CR) SET CREND=1
 .;Check for CR/LF in text
 .IF ((TEXT[CR)!(TEXT[LF)) FOR  DO  QUIT:((TEXT'[CR)&(TEXT'[LF))
 ..SET CRSPOT=$FIND(TEXT,CR)-1
 ..SET:(CRSPOT<0) CRSPOT=0
 ..SET LFSPOT=$FIND(TEXT,LF)-1
 ..SET:(LFSPOT<0) LFSPOT=0
 ..IF (LFSPOT=(CRSPOT+1)) DO  QUIT
 ...;CR/LF pair
 ...SET TMPTXT=$EXTRACT(TEXT,1,CRSPOT-1)
 ...SET TEXT=$EXTRACT(TEXT,LFSPOT+1,$LENGTH(TEXT))
 ...;Add to output array & increment subscript
 ...DO APPEND(TMPTXT,.WORKING,OUT,.OUTNODE,1)
 ...QUIT
 ..ELSE  IF ((('CRSPOT)&(LFSPOT))!((LFSPOT)&(LFSPOT<CRSPOT))) DO  QUIT
 ...;LF before CR
 ...SET TMPTXT=$EXTRACT(TEXT,1,LFSPOT-1)
 ...SET TEXT=$EXTRACT(TEXT,LFSPOT+1,$LENGTH(TEXT))
 ...;Add to output array & increment subscript
 ...DO APPEND(TMPTXT,.WORKING,OUT,.OUTNODE,1)
 ...QUIT
 ..ELSE  IF ((('LFSPOT)&(CRSPOT))!((CRSPOT)&(CRSPOT<LFSPOT))) DO  QUIT
 ...;LF after CR (but not CR/LF pair)
 ...SET TMPTXT=$EXTRACT(TEXT,1,CRSPOT-1)
 ...SET TEXT=$EXTRACT(TEXT,CRSPOT+1,$LENGTH(TEXT))
 ...;Add to output array & increment subscript
 ...DO APPEND(TMPTXT,.WORKING,OUT,.OUTNODE,1)
 ...QUIT
 ..QUIT
 .;Add text to output
 .DO APPEND(TEXT,.WORKING,OUT,.OUTNODE,0)
 .QUIT
 ;Add remaining text to output
 IF $LENGTH(WORKING) DO
 .DO STORE(WORKING,OUT,OUTNODE)
 QUIT
 ;
UUD4(CHARS) ;UUDecode 4 characters
 ; Input: CHARS = Characters to uudecode
 ;Output: UUDecoded text
 ; Notes: It is assumed that all input is defined
 ;      : It is assumed that CHARS is exactly 4 characters in length
 ;
 NEW DEC1,DEC2,DEC3,BIN1,BIN2,BIN3
 NEW BIN1A,BIN2A,BIN3A,BIN4A,DEC1A,DEC2A,DEC3A,DEC4A
 SET DEC1A=$ASCII($EXTRACT(CHARS,1))-32
 SET DEC2A=$ASCII($EXTRACT(CHARS,2))-32
 SET DEC3A=$ASCII($EXTRACT(CHARS,3))-32
 SET DEC4A=$ASCII($EXTRACT(CHARS,4))-32
 SET BIN1A=$$RJ^XLFSTR($$CNV^XLFUTL(DEC1A,2),6,"0")
 SET BIN1A=$EXTRACT(BIN1A,($LENGTH(BIN1A)-5),$LENGTH(BIN1A))
 SET BIN2A=$$RJ^XLFSTR($$CNV^XLFUTL(DEC2A,2),6,"0")
 SET BIN2A=$EXTRACT(BIN2A,($LENGTH(BIN2A)-5),$LENGTH(BIN2A))
 SET BIN3A=$$RJ^XLFSTR($$CNV^XLFUTL(DEC3A,2),6,"0")
 SET BIN3A=$EXTRACT(BIN3A,($LENGTH(BIN3A)-5),$LENGTH(BIN3A))
 SET BIN4A=$$RJ^XLFSTR($$CNV^XLFUTL(DEC4A,2),6,"0")
 SET BIN4A=$EXTRACT(BIN4A,($LENGTH(BIN4A)-5),$LENGTH(BIN4A))
 SET BIN1=BIN1A_$EXTRACT(BIN2A,1,2)
 SET BIN2=$EXTRACT(BIN2A,3,6)_$EXTRACT(BIN3A,1,4)
 SET BIN3=$EXTRACT(BIN3A,5,6)_BIN4A
 SET DEC1=$$DEC^XLFUTL(BIN1,2)
 SET DEC2=$$DEC^XLFUTL(BIN2,2)
 SET DEC3=$$DEC^XLFUTL(BIN3,2)
 QUIT $CHAR(DEC1,DEC2,DEC3)
 ;
APPEND(TEXT,WORKING,OUT,OUTNODE,FORCE) ;Append text to running text
 ; Input: TEXT = Text to append to uudecoded output array
 ;        WORKING = Text that hasn't been added to output array yet
 ;                  but is uudencoded.  Text is added to the output
 ;                  array 245 characters at a time.
 ;                  (PASS BY REFERENCE)
 ;        OUT = Array to put uudecoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;        OUTNODE = Node in OUT to store uudecoded text into
 ;                  (PASS BY REFERENCE)
 ;        FORCE = Flag indicating that a carriage return / line feed
 ;               was encountered and all of the uudecoded text passed
 ;               in should be stored in the output array.  Passing a
 ;               value of 1 will force storage and incrementing of
 ;               OUTNODE.  Passing a value of 0 will only store data
 ;               in the output array if the running text exceeds 245
 ;               characters.
 ;               (DEFAULTS TO 0)
 ;Output: None
 ;        WORKING = Text that was not added to output array
 ;        OUTNODE = Next node in OUT to store uudecoded text into
 ;                  (this is incremented if FORCE = 1)
 ;        OUT will be set as follows (if applicable):
 ;          OUT(1..n) = Lines of text
 ;          OUT(n,1..m) = Continuation of text when length of line
 ;                        is longer than 245 characters
 ; Notes: It is assumed that all input (except CRLF) is defined
 ;
 NEW LENWORK,LENTEXT
 SET FORCE=+$GET(FORCE)
 SET LENWORK=$LENGTH(WORKING)
 SET LENTEXT=$LENGTH(TEXT)
 ;Length of running text and new text won't exceed 245
 IF ((LENWORK+LENTEXT)<245) DO
 .SET WORKING=WORKING_TEXT
 .QUIT
 ;Length of running text and new text exceeds or equals 245
 IF ((LENWORK+LENTEXT)>244) DO
 .;Store combined text in output array
 .SET WORKING=WORKING_$EXTRACT(TEXT,1,(245-LENWORK))
 .DO STORE(WORKING,OUT,OUTNODE)
 .;Set new working text
 .SET WORKING=$EXTRACT(TEXT,(245-LENWORK+1),LENTEXT)
 ;Carriage return / line feed request
 IF (FORCE) DO
 .;Store working text
 .DO STORE(WORKING,OUT,OUTNODE)
 .;Increment subscript value & clear working text
 .SET OUTNODE=OUTNODE+1
 .SET WORKING=""
 .QUIT
 QUIT
 ;
STORE(TEXT,OUT,NODE) ;Store text in uudecoded array
 ; Input: TEXT = Text to append to uudecoded output array
 ;        OUT = Array to put uudecoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;        NODE = Node in OUT to store uudecoded text into
 ;Output: None
 ;        OUT will be set as follows:
 ;          OUT(1..n) = Lines of text
 ;          OUT(n,1..m) = Continuation of text when length of line
 ;                        is longer than 245 characters
 ; Notes: It is assumed that all input is defined
 ;
 ;Store text on main node
 IF ('$DATA(@OUT@(NODE))) DO  QUIT
 .SET @OUT@(NODE)=TEXT
 .QUIT
 ;Store combined text on continuation node
 SET @OUT@(NODE,(1+$ORDER(@OUT@(NODE,""),-1)))=TEXT
 QUIT

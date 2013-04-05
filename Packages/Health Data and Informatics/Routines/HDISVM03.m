HDISVM03 ;BPFO/JRP,HRN/ART - UUENCODE;5/31/2007
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
ENCODE(IN,OUT,ZERO) ;UUEncode contents of array
 ; Input: IN = Array containing lines of text to encode
 ;             (FULL GLOBAL REFERENCE)
 ;           IN(0) = File name for encoded text
 ;                   (used when uudecoding)
 ;           IN(1..n) = Lines of text
 ;           IN(n,1..m) = Continuation of text when length of line
 ;                        is longer than 245 characters
 ;        OUT = Array to put uuencoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;        ZERO = Flag indicating if the main nodes in the input array
 ;               store their text on a zero node.  A value of 1
 ;               denotes that the text is stored in IN(node,0).  A
 ;               value of 0 denotes that the text is not.  This only
 ;               applies to the main nodes; IN(0) and continuation
 ;               nodes are assumed to not use a zero node (i.e.
 ;               IN(0,0) and IN(node,cont,0) are not valid).
 ;               (DEFAULTS TO 0)
 ;
 ;Output: None
 ;        OUT will be set as follows:
 ;          OUT(1) = "begin 644 FILENAME"
 ;          OUT(2..n) = UUEncoded line of text
 ;          OUT(n+1) = "`"
 ;          OUT(n+2) = "end"
 ;
 ; Notes: It is assumed that all input is defined
 ;      : The OUT array will be initialized (KILLed) on input.
 ;      : It is assumed that IN is not an empty arrary (i.e. there's
 ;        data to be uuencoded in it).
 ;      : A carriage return & line feed will be inserted between each
 ;        line of text [after all continuation nodes have been
 ;        appended].
 ;      : FILENAME in node OUT(1) will be replaced by the value from
 ;        input node IN(0).  TEXT.TXT will be used as the filename
 ;        if IN(0) is not defined or empty.
 ;
 NEW NODE,CONT,TEXT,WORKING,OUTNODE,CRLF
 KILL @OUT
 SET ZERO=+$GET(ZERO)
 SET CRLF=$CHAR(13,10)
 SET WORKING=""
 ;Append beginning uuencoding designation to output array
 SET TEXT=@IN@(0)
 SET:(TEXT="") TEXT="TEXT.TXT"
 SET @OUT@(1)="begin 644 "_TEXT
 SET OUTNODE=2
 ;Loop through input array
 SET NODE=0
 FOR  SET NODE=+$ORDER(@IN@(NODE)) QUIT:('NODE)  DO
 .SET TEXT=$SELECT(ZERO:@IN@(NODE,0),1:@IN@(NODE))
 .DO UUEWORK(TEXT,.WORKING,OUT,.OUTNODE)
 .;Loop through continuation nodes
 .SET CONT=0
 .FOR  SET CONT=+$ORDER(@IN@(NODE,CONT)) QUIT:('CONT)  DO
 ..SET TEXT=@IN@(NODE,CONT)
 ..DO UUEWORK(TEXT,.WORKING,OUT,.OUTNODE)
 ..QUIT
 .;Append CR-LF between main nodes
 .DO UUEWORK(CRLF,.WORKING,OUT,.OUTNODE)
 .QUIT
 ;Encode remaining text
 IF $LENGTH(WORKING) DO
 .SET @OUT@(OUTNODE)=$$UUE45(WORKING)
 .SET OUTNODE=OUTNODE+1
 .QUIT
 ;Append end uuencoding designation to output array
 SET @OUT@(OUTNODE)="`"
 SET @OUT@(OUTNODE+1)="end"
 QUIT
 ;
ENCGRID(IN,OUT,DELIMITR) ;UUEncode contents of a grid
 ; Input: IN = Array containing grid cells of text to encode
 ;             (FULL GLOBAL REFERENCE)
 ;          IN(0) = File name for encoded text
 ;                  (used when uudecoding)
 ;          IN(1..n,1..n) = Grid cells of text - IN(row,col)=value
 ;          IN(n,n,1..m) = Continuation of text when length of line
 ;                         is longer than 245 characters
 ;        OUT = Array to put uuencoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;   DELIMITR = Delimiter character (DEFAULTS TO | (pipe))
 ;
 ;Output: None
 ;        OUT will be set as follows:
 ;          OUT(1) = "begin 644 FILENAME"
 ;          OUT(2..n) = UUEncoded line of text
 ;          OUT(n+1) = "`"
 ;          OUT(n+2) = "end"
 ;
 ; Notes: It is assumed that all input is defined
 ;      : The input grid array will be 1 based - no subscripts with value
 ;        of zero (0), except IN(0) which contains the file name
 ;        IN(0) and continuation nodes are assumed to not use a zero node
 ;        (i.e. IN(0,0) and IN(row,col,cont,0) are not valid).
 ;      : The input grid array must include empty cells - no missing nodes
 ;      : If column headings are included, they must be in row 1 - IN(1,1..n)
 ;      : The OUT array will be initialized (KILLed) on input.
 ;      : It is assumed that IN is not an empty arrary (i.e. there's
 ;        data to be uuencoded in it).
 ;      : A carriage return & line feed will be inserted between each
 ;        line of text [after all continuation nodes have been
 ;        appended].
 ;      : FILENAME in node OUT(1) will be replaced by the value from
 ;        input node IN(0).  TEXT.TXT will be used as the filename
 ;        if IN(0) is not defined or empty.
 ;
 NEW RNODE,CNODE,CONT,TEXT,WORKING,OUTNODE,CRLF
 KILL @OUT
 SET:($G(DELIMITR)="") DELIMITR="|"
 SET CRLF=$CHAR(13,10)
 SET WORKING=""
 ;Append beginning uuencoding designation to output array
 SET TEXT=@IN@(0)
 SET:(TEXT="") TEXT="TEXT.TXT"
 SET @OUT@(1)="begin 644 "_TEXT
 SET OUTNODE=2
 ;Loop through input array
 SET RNODE=0
 FOR  SET RNODE=+$ORDER(@IN@(RNODE)) QUIT:('RNODE)  DO
 .SET CNODE=0
 .FOR  SET CNODE=+$ORDER(@IN@(RNODE,CNODE)) QUIT:('CNODE)  DO
 ..SET TEXT=@IN@(RNODE,CNODE)
 ..DO UUEWORK(TEXT,.WORKING,OUT,.OUTNODE)
 ..;Loop through continuation nodes
 ..SET CONT=0
 ..FOR  SET CONT=+$ORDER(@IN@(RNODE,CNODE,CONT)) QUIT:('CONT)  DO
 ...SET TEXT=@IN@(RNODE,CNODE,CONT)
 ...DO UUEWORK(TEXT,.WORKING,OUT,.OUTNODE)
 ...QUIT
 ..;Append delimiter between cell nodes
 ..DO UUEWORK(DELIMITR,.WORKING,OUT,.OUTNODE)
 ..QUIT
 .;Append CR-LF between main nodes
 .DO UUEWORK(CRLF,.WORKING,OUT,.OUTNODE)
 .QUIT
 ;Encode remaining text
 IF $LENGTH(WORKING) DO
 .SET @OUT@(OUTNODE)=$$UUE45(WORKING)
 .SET OUTNODE=OUTNODE+1
 .QUIT
 ;Append end uuencoding designation to output array
 SET @OUT@(OUTNODE)="`"
 SET @OUT@(OUTNODE+1)="end"
 QUIT
 ;
UUEWORK(TEXT,WORKING,OUT,OUTNODE) ;UUEncode text & add to output
 ; Input: TEXT = Text to append to uuencoded output array
 ;        WORKING = Text that hasn't been uuencoded yet as
 ;                  uuencoding is done against 45 characters
 ;                  at a time
 ;                  (PASS BY REFERENCE)
 ;        OUT = Array to put uuencoded text into
 ;              (FULL GLOBAL REFERENCE)
 ;        OUTNODE = Node in OUT to store uuencoded text into
 ;                  (PASS BY REFERENCE)
 ;Output: None
 ;        WORKING = Text that was not uuencoded
 ;        OUTNODE = Next node in OUT to store uuencoded text into
 ;        OUT will be set as follows:
 ;          OUT(OUTNODE..n) = UUEncoded line of text
 ; Notes: It is assumed that all input is defined
 ;
 NEW STOP,LENWORK
 SET STOP=0
 ;UUEncode 45 characters at a time
 FOR  DO  QUIT:(STOP)
 .;Combine text with left over text to make 45 character string
 .SET LENWORK=$LENGTH(WORKING)
 .SET WORKING=WORKING_$EXTRACT(TEXT,1,(45-LENWORK))
 .SET TEXT=$EXTRACT(TEXT,(45-LENWORK+1),$LENGTH(TEXT))
 .IF $LENGTH(WORKING)<45 SET STOP=1 QUIT
 .;UUEncode and store in output array
 .SET @OUT@(OUTNODE)=$$UUE45(WORKING)
 .;Increment subscript value and reset left over text
 .SET OUTNODE=OUTNODE+1
 .SET WORKING=""
 .QUIT
 QUIT
 ;
UUE45(TEXT) ;UUEncode a string of 45 characters
 ; Input: TEXT = String of text to uuencode (up to 45 characters)
 ;Output: UUEncoded text including length character
 ; Notes: It is assumed that all input is defined
 ;      : It is assumed that TEXT will not be greater than 45
 ;        characters in length.
 ;
 NEW LOOP,LENGTH,UUENC
 SET TEXT=$GET(TEXT)
 SET LENGTH=$LENGTH(TEXT)
 SET UUENC="" SET:(LENGTH=0) UUENC=$$UUE3("")
 FOR LOOP=1:3:LENGTH SET UUENC=UUENC_$$UUE3($EXTRACT(TEXT,LOOP,LOOP+2))
 QUIT $CHAR(32+LENGTH)_UUENC
 ;
UUE3(CHARS) ;UUEncode 3 characters
 ; Input: CHARS = Characters to uuencode (up to 3 characters)
 ;Output: UUEncoded text
 ; Notes: It is assumed that all input is defined
 ;      : It is assumed that CHARS will not be greater than 3
 ;        characters in length.
 ;      : CHARS will be right padded with spaces to make it 3
 ;        characters in length.
 ;
 NEW DEC1,DEC2,DEC3,BIN1,BIN2,BIN3
 NEW BIN1A,BIN2A,BIN3A,BIN4A,DEC1A,DEC2A,DEC3A,DEC4A
 SET CHARS=$EXTRACT($GET(CHARS)_"   ",1,3)
 SET DEC1=$ASCII($EXTRACT(CHARS,1))
 SET DEC2=$ASCII($EXTRACT(CHARS,2))
 SET DEC3=$ASCII($EXTRACT(CHARS,3))
 SET BIN1=$$RJ^XLFSTR($$CNV^XLFUTL(DEC1,2),8,"0")
 SET BIN1=$EXTRACT(BIN1,($LENGTH(BIN1)-7),$LENGTH(BIN1))
 SET BIN2=$$RJ^XLFSTR($$CNV^XLFUTL(DEC2,2),8,"0")
 SET BIN2=$EXTRACT(BIN2,($LENGTH(BIN2)-7),$LENGTH(BIN2))
 SET BIN3=$$RJ^XLFSTR($$CNV^XLFUTL(DEC3,2),8,"0")
 SET BIN3=$EXTRACT(BIN3,($LENGTH(BIN3)-7),$LENGTH(BIN3))
 SET BIN1A=$EXTRACT(BIN1,1,6)
 SET BIN2A=$EXTRACT(BIN1,7,8)_$EXTRACT(BIN2,1,4)
 SET BIN3A=$EXTRACT(BIN2,5,8)_$EXTRACT(BIN3,1,2)
 SET BIN4A=$EXTRACT(BIN3,3,8)
 SET DEC1A=$$DEC^XLFUTL(BIN1A,2)+32
 SET DEC2A=$$DEC^XLFUTL(BIN2A,2)+32
 SET DEC3A=$$DEC^XLFUTL(BIN3A,2)+32
 SET DEC4A=$$DEC^XLFUTL(BIN4A,2)+32
 QUIT $CHAR(DEC1A,DEC2A,DEC3A,DEC4A)

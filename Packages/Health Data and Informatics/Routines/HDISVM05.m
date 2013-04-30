HDISVM05 ;BPFO/JRP - PARSE DELIMITTED TEXT;6/26/2007
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
 ;**
 ;**  The following code was copied from SCMSVUT5, which I
 ;**  originally wrote in July of 2002.  It was copied to
 ;**  prevent the dependancy on the Scheduling package, which
 ;**  may not exist on all systems.
 ;**
 ;**  It has also been modified to handle fields that contain
 ;**  the separator character.  These fields are surrounded by
 ;**  quotation marks (ex: ...^"Field ^ With ^ Separator"^...).
 ;**  This was done because the original parser was written for
 ;**  parsing HL7 messages and this parser is meant for parsing
 ;**  delimitted text (ie spreadsheets).
 ;**
 ;
PARSE(INARR,OUTARR,SEP,SUB,MAX) ;Parse array into individual fields
 ;Input  : INARR - Array containing data to parse (full global ref)
 ;                   INARR = First 245 characters of data
 ;                   INARR(1..n) = Continuation nodes
 ;                        OR
 ;                   INARR(x) = First 245 characters of data
 ;                   INARR(x,1..n) = Continuation nodes
 ;         OUTARR - Array to put parsed data into (full global ref)
 ;         SEP - Field separator (defaults to ^) (1 character)
 ;         SUB - Starting subscript of OUTARR (defaults to 0)
 ;         MAX - Maximum length of output node (defaults to 245)
 ;Output : None
 ;         OUTARR(SUB) = First piece (MAX characters)
 ;         OUTARR(SUB,1..n) = Continuation nodes
 ;         OUTARR(SUB+X) = Xth piece (MAX characters)
 ;         OUTARR(SUB+X,1..n) = Continuation nodes
 ;Notes  : OUTARR is initialized (KILLed) on entry
 ;       : Assumes that INARR and OUTARR are defined and valid
 ;
 ;Declare variables
 NEW NODE,STOP,DATA,INFO,FLD,SEPCNT,CN,OUT,TMP,ROOT,OUTNODE
 NEW QUOTE,HASQ,ADDSEP
 KILL @OUTARR
 SET SEP=$GET(SEP) SET SEP=$EXTRACT(SEP,1) SET:SEP="" SEP="^"
 SET SUB=+$GET(SUB)
 SET MAX=+$GET(MAX) SET:'MAX MAX=245
 SET NODE=INARR
 SET INFO=$GET(@NODE)
 SET ROOT=$$OREF^DILF(INARR)
 SET FLD=1
 SET SEPCNT=$LENGTH(INFO,SEP)
 SET STOP=0
 SET OUTNODE=$NAME(@OUTARR@(SUB))
 SET QUOTE=$CHAR(34)
 SET HASQ=0
 SET ADDSEP=0
 SET CN=0
 ;Loop through all columns in all nodes
 FOR  SET DATA=$PIECE(INFO,SEP,FLD) DO  QUIT:STOP
 .;Check for data in double quotes
 .IF (DATA[QUOTE) IF (($LENGTH(DATA,QUOTE)-1)#2) DO
 ..;Check for leading double quote
 ..IF ('HASQ) DO
 ...;Separator on next node (don't append now in case it isn't)
 ...IF (FLD=SEPCNT) SET ADDSEP=1 QUIT
 ...;Append separator
 ...SET DATA=DATA_SEP
 ...SET ADDSEP=0
 ...QUIT
 ..SET HASQ='HASQ
 ..QUIT
 .;Need to append separator when the leading quotation mark was
 .;on the previous node AND the next separator is encounterd
 .IF (ADDSEP) IF (HASQ) IF (DATA'=QUOTE) IF (INFO[SEP) IF (FLD'=SEPCNT) DO
 ..SET DATA=DATA_SEP
 ..SET ADDSEP=0
 ..QUIT
 .;End of line - store in output global
 .IF FLD=SEPCNT DO  QUIT
 ..DO ADDNODE
 ..;Get next line of data from input global
 ..SET NODE=$QUERY(@NODE)
 ..;No more data - stop outer loop
 ..IF (NODE="")!(NODE'[ROOT) SET STOP=1 QUIT
 ..;Set text and column variables
 ..SET INFO=$GET(@NODE)
 ..SET SEPCNT=$LENGTH(INFO,SEP)
 ..SET FLD=1
 ..QUIT
 .;Add column to output global
 .DO ADDNODE
 .;Increment subscript if not in middle of double quotes
 .IF ('HASQ) SET SUB=SUB+1
 .;Set next storage node to use
 .SET OUTNODE=$NAME(@OUTARR@(SUB))
 .;Increment column number
 .SET FLD=FLD+1
 .;Reset continuation node number
 .SET CN=0
 .QUIT
 QUIT
ADDNODE ;Used by PARSE to add data to output node
 ;Get currently stored column value
 SET TMP=$GET(@OUTNODE)
 ;Length of node won't go over max value - append
 IF ($LENGTH(TMP)+$LENGTH(DATA))<(MAX+1) SET @OUTNODE=TMP_DATA QUIT
 ;Append as much as stored column value can take
 SET @OUTNODE=TMP_$EXTRACT(DATA,1,(MAX-$LENGTH(TMP)))
 ;Increment continuation node number
 SET CN=CN+1
 ;Recursively call self to store remaining text
 SET DATA=$EXTRACT(DATA,(MAX-$LENGTH(TMP)+1),$LENGTH(DATA))
 SET OUTNODE=$NAME(@OUTARR@(SUB,CN))
 IF DATA'="" DO ADDNODE
 QUIT

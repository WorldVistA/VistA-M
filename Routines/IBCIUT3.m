IBCIUT3 ;DSI/ESG - TCP/IP UTILITIES FOR CLAIMSMANAGER INTERFACE ;4-JAN-2001
 ;;2.0;INTEGRATED BILLING;**161,226**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Can't call from the top
 Q
 ;
READ(Z,PROBLEM,IBCISOCK) ; ClaimsManager read message/close port/unlock port utility
 ;
 ; A utility to read the ACK/NAK, read the ClaimsManager response,
 ; write the ACK, close the port, and unlock the port.
 ;
 ; Data will get returned in the Z array and if there's a problem
 ; of any kind, it will get returned in variable PROBLEM which is just
 ; a number.
 ;
 ; IBCISOCK is the current tcp/ip port number that is being passed in
 ; here so this port can be unlocked after reading is complete.
 ;
 NEW ACK,CH,CHAR,CNT,DATA,ERRLN,ERRTXT,INGTO,J,K,MAXSIZE,MINSTORE,NAK
 NEW POP,RESP,SEGMENT,SEGNUM,SEQ,SGT,SGTNUM,STOP,STORERR,SUB2,Z0
 NEW $ESTACK,$ETRAP S $ETRAP="D ERRTRP^IBCIUT3" ; ib*226 TJH/EG
 ;
 ; Initialize variables
 ; INGTO - Ingenix ClaimsManager read time-out
 ; MINSTORE - minimum local symbol table size
 ; ACK/NAK - Ingenix ClaimsManager positive/negative acknowledgement
 ; STORERR - local storage error flag
 ; PROBLEM - parameter which stores the problem#
 ;
 S INGTO=300,MINSTORE=11000,ACK=$C(1,6,3),NAK=$C(15),STORERR=0,PROBLEM=0
 KILL Z,^TMP($J,"CMRESP2")
 ;
 ; Read #1
 ; Quit if we encounter a time-out, an ascii-3, or storage problems
 S RESP(1)=""
 F CNT=1:1:100 R CH#1:INGTO S RESP(1)=RESP(1)_CH Q:'$T  Q:$A(CH)=3  Q:$S<MINSTORE
 ;
 ; If time-out situation or storage error, get out
 I '$T S PROBLEM=1,Z="INCOMPLETE RESPONSE",Z(1,1)=RESP(1) G DONE
 I $S<MINSTORE S STORERR=1,PROBLEM=2 G DONE
 ;
 ; If we receive something other than an ACK, then it must be a NAK
 ; and we should get out.
 I RESP(1)'=ACK D  G DONE
 . S Z="TCP/IP READ ERROR:  DIDN'T RECEIVE AN ACK MESSAGE FIRST"
 . I $E(RESP(1),2)=NAK S Z="RECEIVED A NAK",RESP(1)=$TR(RESP(1),$C(1,3,15))
 . S Z(1,1)=RESP(1)
 . S PROBLEM=3
 . Q
 ;
 ; Read #2
 ; Quit if we encounter a time-out, an ascii-3, or storage problems
 S RESP(2)="",SUB2=0
 F CNT=1:1 R CH#1:INGTO S RESP(2)=RESP(2)_CH Q:'$T  Q:$A(CH)=3  Q:$S<MINSTORE  I CNT#200=0 S SUB2=SUB2+1,^TMP($J,"CMRESP2",SUB2)=RESP(2),RESP(2)=""
 ;
 ; We're done reading so file in the scratch global any additional
 ; characters read in.  Be very careful not to modify the value of $T.
 S:RESP(2)'="" SUB2=SUB2+1,^TMP($J,"CMRESP2",SUB2)=RESP(2)
 ;
 ; If time-out situation or storage error, get out
 I '$T S PROBLEM=4,Z="INCOMPLETE RESPONSE",Z(1,1)=$G(^TMP($J,"CMRESP2",1)) G DONE
 I $S<MINSTORE S STORERR=1,PROBLEM=5 G DONE
 ;
 ; This should be the RESULTREC message.  If it's something else, then
 ; log an error and get out.
 I $E(^TMP($J,"CMRESP2",1),1,17)'=($C(1,28,29,30)_"^'%RESULTREC"_$C(28)) D  G DONE
 . S Z="TCP/IP READ ERROR:  DIDN'T RECEIVE A RESULTREC MESSAGE 2ND"
 . S Z(1,1)=^TMP($J,"CMRESP2",1)
 . S PROBLEM=6
 . Q
 ;
DONE ; We're done with reading stuff.....Finish up with tcp/ip
 ;
 ; Write the final ACK only if no problems with the first read
 I '$F(".1.2.3.","."_PROBLEM_".") W ACK,!
 ;
 DO CLOSE^%ZISTCP         ; close the tcp/ip port
 L -^IBCITCP(IBCISOCK)    ; unlock the port
 ;
 ; If there's some problem, then get out now
 I PROBLEM G READX
 ;
 ; Process the results and build the "Z" array
 ;
 ; We should see the following segments in this order:
 ;    RT - Route Segment (single occurrence)
 ;    HD - Header Segment (single occurrence)
 ;    RL - Result Line Segment (repeating)
 ;    LN - Line Segment (repeating)
 ; We will not process the Line Segments because these are the
 ; same data that we sent to ClaimsManager.  We will stop processing
 ; when we get into the Line Segments.
 ;
 ; Variables SEGMENT and SEGNUM indicate what we're currently processing.
 ;
 ; MAXSIZE is the number of characters of error text per line,
 ;         although we won't break the line in the middle of a word.
 ;
 S SGT="RT^HD^RL^LN",SEGMENT="RT",SEGNUM=1,SGTNUM=1,Z("RT",1)=""
 S MAXSIZE=62,^TMP($J,"CMRESP2",1)=$E(^TMP($J,"CMRESP2",1),18,999),J="",STOP=0
 ;
 ; Loop through and process every character received by the read loop
 F  S J=$O(^TMP($J,"CMRESP2",J)) Q:J=""!STOP  F K=1:1:$L(^TMP($J,"CMRESP2",J)) S CHAR=$E(^TMP($J,"CMRESP2",J),K) D  Q:STOP
 . ; new segment type coming up.  Initialize and begin to process the next segment.  Stop if we're into the Line segments.
 . I CHAR=$C(28) D  Q
 .. S SGTNUM=SGTNUM+1
 .. I SGTNUM>3 S STOP=1 Q
 .. S SEGMENT=$P(SGT,U,SGTNUM),SEGNUM=1,Z(SEGMENT,SEGNUM)=""
 .. I SEGMENT="RL" S SEQ=1,Z(SEGMENT,SEGNUM,SEQ)=""
 .. Q
 . ; another segment of the same type coming up.  This is the segment repetition character.  Just increment the segment number and keep the segment type the same.
 . I CHAR=$C(29) D  Q
 .. S SEGNUM=SEGNUM+1,Z(SEGMENT,SEGNUM)=""
 .. I SEGMENT="RL" S SEQ=1,Z(SEGMENT,SEGNUM,SEQ)=""
 .. Q
 . ; If we're processing the route or the header segments, then just add the character and quit.  No maxstring problems with these segments.
 . I SEGMENT'="RL" S Z(SEGMENT,SEGNUM)=Z(SEGMENT,SEGNUM)_CHAR Q
 . ; At this point, we're processing a Result Line segment.
 . ; Here is the field delimiter character.  Increment the SEQuence id# and initialize the array entry and quit.
 . I CHAR=$C(30) S SEQ=SEQ+1,Z(SEGMENT,SEGNUM,SEQ)="" Q
 . ; If the sequence number is 1-3, then we don't have a problem with maxstring errors so go ahead and add the character and quit.
 . I SEQ<4 S Z(SEGMENT,SEGNUM,SEQ)=Z(SEGMENT,SEGNUM,SEQ)_CHAR Q
 . ; Now we know we're processing the 2000 character EditDescription field in the Result Line segment.  If we're OK length-wise or the character isn't a space or a hyphen or a comma, then just add it like normal and quit.
 . I $L(Z(SEGMENT,SEGNUM,SEQ))<MAXSIZE!(" -,"'[CHAR) S Z(SEGMENT,SEGNUM,SEQ)=Z(SEGMENT,SEGNUM,SEQ)_CHAR Q
 . ; Here, we know the length is >= to the max size & the character is a space/hyphen/comma so it's a perfect time to split the text onto a new node. Add this character to the current string, increment the SEQ by .01 and init and quit.
 . S Z(SEGMENT,SEGNUM,SEQ)=Z(SEGMENT,SEGNUM,SEQ)_CHAR,SEQ=SEQ+.01,Z(SEGMENT,SEGNUM,SEQ)="" Q
 . Q
 ;
 ; Do some more processing to the Result Line segment data and
 ; clean it up a bit.
 ;
 S SEGMENT="RL",SEGNUM=""
 F  S SEGNUM=$O(Z(SEGMENT,SEGNUM)) Q:SEGNUM=""  D
 . S DATA=$G(Z(SEGMENT,SEGNUM,1))
 . S Z(SEGMENT,SEGNUM,0)=$$TRIM($E(DATA,1,25))_U_$$TRIM($E(DATA,26,45))_U_$$TRIM($E(DATA,46,50))_U_$$TRIM($E(DATA,131))_U_$$TRIM($E(DATA,132,141))_U_$$TRIM(Z(SEGMENT,SEGNUM,2))
 . S Z0=Z(SEGMENT,SEGNUM,0)
 . ;
 . ; now loop thru the SEQ #4 data (EditDescription) and build
 . ; the "E" area of the array.  This replaces the 4* nodes so we
 . ; can kill this area as we go.
 . S SEQ=3
 . F  S SEQ=$O(Z(SEGMENT,SEGNUM,SEQ)) Q:$E(SEQ)'=4  D
 .. S ERRTXT=Z(SEGMENT,SEGNUM,SEQ)
 .. S ERRTXT=$TR(ERRTXT,$C(10))
 .. KILL Z(SEGMENT,SEGNUM,SEQ)
 .. I $TR(ERRTXT," ")="" Q
 .. S (ERRLN,Z(SEGMENT,SEGNUM,"E",0))=$G(Z(SEGMENT,SEGNUM,"E",0))+1
 .. S Z(SEGMENT,SEGNUM,"E",ERRLN)=ERRTXT
 .. Q
 . ;
 . ; Now append the AutoFix data if it exists
 . I $P(Z0,U,4)="Y",$P(Z0,U,6)'="" D AUTOFIX
 . Q
 ;
READX ;
 KILL ^TMP($J,"CMRESP2")
 Q
 ;
 ; For speed reasons, code taken from TRIM^XLFSTR
TRIM(X,SIDE,CHAR) ;Trim chars from left/right of string
 NEW LEFT,RIGHT
 I X="" Q X
 S SIDE=$G(SIDE,"LR"),CHAR=$G(CHAR," "),LEFT=1,RIGHT=$L(X)
 I X=CHAR Q ""
 I SIDE["R" F RIGHT=$L(X):-1:1 Q:$E(X,RIGHT)'=CHAR
 I SIDE["L" F LEFT=1:1:$L(X) Q:$E(X,LEFT)'=CHAR
 Q $E(X,LEFT,RIGHT)
 ;
 ;
AUTOFIX ; Append the AutoFix data to the rest of the error message
 NEW AFMSG,AFT,AFW,AFV,AF,AFLN
 ; first two autofix lines here
 S (ERRLN,Z(SEGMENT,SEGNUM,"E",0))=$G(Z(SEGMENT,SEGNUM,"E",0))+1
 S Z(SEGMENT,SEGNUM,"E",ERRLN)=" "     ; blank line here
 S (ERRLN,Z(SEGMENT,SEGNUM,"E",0))=$G(Z(SEGMENT,SEGNUM,"E",0))+1
 S Z(SEGMENT,SEGNUM,"E",ERRLN)="*** ClaimsManager AutoFix Indicated ***"
 ; construct the actual message
 S AFMSG="A possible fix for Line Item "_$P(Z0,U,1)_" is to "
 S AFT=$E($P(Z0,U,5),1,3),AFW=$E($P(Z0,U,5),4,99),AFV=$P(Z0,U,6)
 S AFMSG=AFMSG_$S(AFT="ADD":"add",AFT="DEL":"delete",AFT="CHG":"change",1:$P(Z0,U,5))_" the "
 S AFMSG=AFMSG_$S(AFW="PROC":"procedure code",AFW="MOD":"modifier",1:$P(Z0,U,5))_" "
 I AFT="CHG" S AFMSG=AFMSG_"to be "_AFV_" instead."
 E  S AFMSG=AFMSG_AFV_"."
 ;
 ; call an IB utility to parse AFMSG into lines of acceptable length
 D FSTRNG(AFMSG,MAXSIZE,.AF)
 ;
 ; put the data into the Z array
 F AFLN=1:1:AF D
 . S (ERRLN,Z(SEGMENT,SEGNUM,"E",0))=$G(Z(SEGMENT,SEGNUM,"E",0))+1
 . S Z(SEGMENT,SEGNUM,"E",ERRLN)=AF(AFLN)
 . Q
AFX ;
 Q
 ;
FSTRNG(STR,WD,ARRAY) ; please see IBJU1 for documentation
 NEW %,DIW,DIWI,DIWT,DIWTC,DIWX,DN,I,Z
 D FSTRNG^IBJU1(STR,WD,.ARRAY)
 Q
 ;
ERRTRP ; Error trap processing ; ib*226 TJH/EG
 S Z(1,1)=$$EC^%ZOSV ; mumps error location and description
 S Z="A SYSTEM ERROR HAS BEEN DETECTED AT THE FOLLOWING LOCATION"
 S PROBLEM=7
 D CLOSE^%ZISTCP ; close the tcp/ip port
 L -^IBCITCP(IBCISOCK) ; unlock the current port
 K ^TMP($J,"CMRESP2") ; kill scratch global
 D ^%ZTER ; record the error in the trap
 G UNWIND^%ZTER ; unwind stack levels
 ;

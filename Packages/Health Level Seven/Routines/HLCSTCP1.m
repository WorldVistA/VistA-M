HLCSTCP1 ;SFIRMFO/RSD - BI-DIRECTIONAL TCP ;07/08/2009  15:27
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,57,64,71,133,132,122,140,142,145**;OCT 13,1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Receiver
 ;connection is initiated by sender and listener accepts connection
 ;and calls this routine
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^HLCSTCP1"
 N HLMIEN,HLASTMSG
 ;
 ; patch HL*1.6*140, save IO
 S HLTCPORT("IO")=IO ;RWF
 ; patch HL*1.6*122 start
 ; variable to replace ^TMP
 N HLTMBUF
 ;
 ; for HL7 application proxy user
 ;; N HLDUZ,DUZ  ; patch HL*1.6*122 TEST v2: DUZ code removed
 N HLDUZ
 S HLDUZ=+$G(DUZ)
 ;
 D MON^HLCSTCP("Open")
 ; K ^TMP("HLCSTCP",$J,0)
 S HLMIEN=0,HLASTMSG=""
 ;
 ; patch HL*1.6*122 TEST v2: DUZ code removed
 ; set DUZ for application proxy user
 ;; D PROXY^HLCSTCP4
 ;
 F  D  Q:$$STOP^HLCSTCP  I 'HLMIEN D MON^HLCSTCP("Idle") H 3
 . ; clean variables
 . D CLEANVAR^HLCSTCP4
 . ; patch HL*1.6*140, restore the saved IO
 . S IO=HLTCPORT("IO") ;RWF
 . S HLMIEN=$$READ
 . Q:'HLMIEN
 . ;
 . ; patch HL*1.6*122 TEST v2: DUZ code removed
 . ; DUZ comparison/reset for application proxy user
 . ;; D HLDUZ^HLCSTCP4
 . D HLDUZ2^HLCSTCP4
 . ; protect HLDUZ
 . N HLDUZ
 . D PROCESS
 ; patch HL*1.6*122 end
 Q
 ;
PROCESS ;check message and reply
 ;HLDP=LL in 870
 N HLTCP,HLTCPI,HLTCPO
 S HLTCP="",HLTCPO=HLDP,HLTCPI=+HLMIEN
 ; patch HL*1.6*145 start
 ; variable HLDP("HLLINK") will be used as the client link ien,
 ; in which the incoming original messages received by listener
 ; will be stored and the messages in the client link queue will
 ; be processed by incoming filer.
 ; variable HLDP("SETINQUE")=1 to indicate the x-ref
 ; ^HLMA("AC","I",<ien of link>,<ien of message>) is set.
 ; initilizes to 0.
 S HLDP("HLLINK")=0
 S HLDP("SETINQUE")=0
 ; patch HL*1.6*145 end
 ;
 ;update monitor, msg. received
 D LLCNT^HLCSTCP(HLDP,1)
 D NEW^HLTP3(HLMIEN)
 ;
 ; patch HL*1.6*145 start
 ; quit if x-ref ^HLMA("AC","I",<ien of link>,<ien of message>)
 ; was set, and counter will be incrmented later after message
 ; being processed.
 Q:HLDP("SETINQUE")
 ;update monitor, msg. processed
 I HLDP("HLLINK") D LLCNT^HLCSTCP(HLDP("HLLINK"),2) Q
 D LLCNT^HLCSTCP(HLDP,2)
 ; patch HL*1.6*145 end
 Q
 ;
READ() ;read 1 message, returns ien in 773^ien in 772 for message
 D MON^HLCSTCP("Reading")
 N HLDB,HLDT,HLDEND,HLACKWT,HLDSTRT,HLHDR,HLIND1,HLINE,HLMSG,HLRDOUT,HLRS,HLX,X
 ;HLDSTRT=start char., HLDEND=end char., HLRS=record separator
 S HLDSTRT=$C(11),HLDEND=$C(28),HLRS=$C(13)
 ;HLRDOUT=exit read loop, HLINE=line count, HLIND1=ien 773^ien 772
 ;HLHDR=have a header, HLTMBUF()=excess from last read, HLACKWT=wait for ack
 ; HL*1.6*122 start
 ; S (HLRDOUT,HLINE,HLIND1,HLHDR)=0,HLX=$G(^TMP("HLCSTCP",$J,0)),HLACKWT=HLDBACK
 S (HLRDOUT,HLINE,HLIND1,HLHDR)=0,HLX=$G(HLTMBUF(0)),HLACKWT=HLDBACK
 N HLBUFF,HLXX,MAXWAIT
 ; based on patch 132 for readtime
 S MAXWAIT=$S((HLACKWT>HLDREAD):HLACKWT,1:HLDREAD)
 S HLRS("START-FLAG")=0
 S HLTMBUF(0)=""
 ; variable used to store data in HLBUFF
 S HLX(1)=$G(HLTMBUF(1))
 S HLTMBUF(1)=""
 S HLBUFF("START")=0
 S HLBUFF("END")=0
 I (HLX]"")!(HLX(1)]"") D
 . I (HLX[HLDSTRT)!(HLX(1)[HLDSTRT) D
 .. S HLBUFF("START")=1
 . I (HLX[HLDEND)!(HLX(1)[HLDEND) D
 .. S HLBUFF("END")=1
 F  D RDBLK Q:HLRDOUT
 ;**132**
 ;switch to null device if opened to prevent 'leakage'
 I $G(IO(0))]"",IO(0)'=IO U IO(0)
 ;
 ;save any excess for next time
 S:HLX]"" HLTMBUF(0)=HLX
 S:HLX(1)]"" HLTMBUF(1)=HLX(1)
 I +HLIND1,'$P(HLIND1,U,3) D DELMSG(HLIND1) S HLIND1=0
 Q HLIND1
 ;
RDBLK ;
 ; initialize
 S HLBUFF=""
 ;
 ;S HLDB=HLDBSIZE-$L(HLX)
 ; store the total length of HLX and HLX(1) in HLDB(1)
 S HLDB(1)=$L(HLX)+$L(HLX(1))
 ;
 ;**132 **
 ;U IO R X#HLDB:HLDREAD
 ; U IO R X#HLDB:MAXWAIT
 ;
 ; remove the readcount to speedup GT.M
 U IO
 R:(HLDB(1)<HLDBSIZE) HLBUFF:MAXWAIT
 ;
 I HLBUFF]"" D
 . I HLBUFF[HLDSTRT,(HLBUFF("START")=0) D
 .. ; remove the extraneous text prefixing the "START" char
 .. I $P(HLBUFF,HLDSTRT)]"" S HLBUFF=HLDSTRT_$P(HLBUFF,HLDSTRT,2,99)
 .. S HLBUFF("START")=1
 . ;
 . I HLBUFF[HLDEND,(HLBUFF("END")=0) S HLBUFF("END")=1
 ; detect disconnect for GT.M
 I $G(^%ZOSF("OS"))["GT.M",$DEVICE S $ECODE=",UREAD,"
 ; timedout, <clean up>, quit
 ;I '$T,X="",HLX="" S HLACKWT=HLACKWT-HLDREAD D:HLACKWT<0&'HLHDR CLEAN Q
 ;I '$T,X="",HLX="" D:'HLHDR CLEAN Q
 ; patch HL*1.6*140
 ; I '$T,HLBUFF="",HLX="",HLX(1)="" D  Q
 I HLBUFF="",HLX="",HLX(1)="" D  Q
 . D:('HLHDR)&('HLIND1) CLEAN
 ;add incoming line to what wasn't processed in last read
 ;S HLX=$G(HLX)_X
 ; get block of characters from read buffer HLBUFF
 ; every 'for-loop' deal with one read at most, and one message at most
 ; if HLX is not empty, loop continues even no data is read
 ; quit, if both HLDBUFF and HLX(1) are empty, means one read is done
 ; quit, when HLRDOUT is set to 1, means one message is encountered
 ; an "end"
 ; F  D  Q:HLXX=""!(HLRDOUT)
 F  D  Q:(HLRDOUT)!(HLBUFF=""&(HLX(1)=""))
 . ;
 . ; if HLX(1) is not empty
 . I HLX(1)]"" D
 .. ; hldb(2) is the number of characters extracted from hlx(1)
 .. ; to be concatenated with hlx
 .. S HLDB(2)=HLDBSIZE-$L(HLX)
 .. ; hlx(2) stores the first hldb(2) characters extracted
 .. ; from hlx(1)
 .. S HLX(2)=$E(HLX(1),1,HLDB(2))
 .. S HLX(1)=$E(HLX(1),HLDB(2)+1,$L(HLX(1)))
 .. S HLX=$G(HLX)_HLX(2)
 . ;
 . ; if HLX(1) is empty, and HLBUFF contains data
 . ; all the data in hlx(1) need to be extracted first
 . I HLX(1)="",HLBUFF]"" D
 .. S HLDB=HLDBSIZE-$L(HLX)
 .. S HLXX=$E(HLBUFF,1,HLDB)
 .. S HLBUFF=$E(HLBUFF,HLDB+1,$L(HLBUFF))
 .. S HLX=$G(HLX)_HLXX
 . ; quit when HLX is empty
 . Q:(HLX="")
 . ; ** 132 **
 . ; if no segment end, HLX not full, go back for more
 . I $L(HLX)<HLDBSIZE,HLX'[HLRS,HLX'[HLDEND Q
 . ;add incoming line to what wasn't processed
 . D RDBLK2
 ;
 ; it is possible one message is encountered an "end" and other
 ; messages left in buffer,HLBUFF, save it in HLX for next run
 I HLBUFF]"" D
 . ; variable HLBUFF may remain data with size more than HLDBSIZE
 . ; variable HLBUFF is not empty, only if the total length of
 . ; HLX and HLX(1) is less than HLDBSIZE and HLX(1) should be
 . ; empty when the command s hlx(1)=$g(hlx(1))_hlbuff is executed
 . ; use hlx(1) to store the data of hlbuff to avoid "MAXTRING" error
 . S HLX(1)=$G(HLX(1))_HLBUFF
 . S HLBUFF=""
 Q
 ;
RDBLK2 ;data stream: <sb>dddd<cr><eb><cr>
 ; HL*1.6*122 end
 ; look for segment= <CR>
 F  Q:HLX'[HLRS  D  Q:HLRDOUT
 . ; Get the first piece, save the rest of the line
 . S HLINE=HLINE+1,HLMSG(HLINE,0)=$P(HLX,HLRS),HLX=$P(HLX,HLRS,2,999)
 . ; check for start block, Quit if no ien
 . I HLMSG(HLINE,0)[HLDSTRT!HLHDR D  Q
 .. S HLRS("START-FLAG")=1 ; HL*1.6*122
 .. D:HLMSG(HLINE,0)[HLDSTRT
 ... S X=$L(HLMSG(HLINE,0),HLDSTRT)
 ... S:X>2 HLMSG(HLINE,0)=HLDSTRT_$P(HLMSG(HLINE,0),HLDSTRT,X)
 ... S HLMSG(HLINE,0)=$P(HLMSG(HLINE,0),HLDSTRT,2)
 ... D RESET:(HLINE>1)
 .. ;
 .. ; patch HL*1.6*122
 .. ; if the first line less than 10 characters
 .. I HLHDR,$L(HLMSG(1,0))<10,$D(HLMSG(2,0)) D
 ... S HLMSG(1,0)=HLMSG(1,0)_$E(HLMSG(2,0),1,10)
 ... S HLMSG(2,0)=$E(HLMSG(2,0),11,9999999)
 .. ;
 .. ;ping message
 .. I $E(HLMSG(1,0),1,9)="MSH^PING^" D PING Q
 .. ; get next ien to store
 .. D MIEN^HLCSTCP4
 .. K HLMSG
 .. S (HLINE,HLHDR)=0
 . ; check for end block; <eb><cr>
 . I HLMSG(HLINE,0)[HLDEND D
 .. ; patch HL*1.6*122 start
 .. ;no msg. ien
 .. ; Q:'HLIND1
 .. I 'HLIND1 D CLEAN Q
 .. ; Kill just the last line if no data before HLDEND
 .. I $P(HLMSG(HLINE,0),HLDEND)']"" D
 ... K HLMSG(HLINE,0) S HLINE=HLINE-1
 .. E  S HLMSG(HLINE,0)=$P(HLMSG(HLINE,0),HLDEND)
 .. ; patch HL*1.6*122 end
 .. ;
 .. ; move into 772
 .. D SAVE(.HLMSG,"^HL(772,"_+$P(HLIND1,U,2)_",""IN"")")
 .. ;mark that end block has been received
 .. ;HLIND1=ien in 773^ien in 772^1 if end block was received
 .. S $P(HLIND1,U,3)=1
 .. S HLBUFF("HLIND1")=HLIND1
 .. ;reset variables for next message
 .. D CLEAN
 . ;add blank line for carriage return
 . I HLINE'=0,HLMSG(HLINE,0)]"" S HLINE=HLINE+1,HLMSG(HLINE,0)=""
 Q:HLRDOUT
 ;If the line is long and no <CR> move it into the array.
 I ($L(HLX)=HLDBSIZE),(HLX'[HLRS),(HLX'[HLDEND),(HLX'[HLDSTRT) D  Q
 . S HLINE=HLINE+1,HLMSG(HLINE,0)=HLX,HLX=""
 ;have start block but no record separator
 I HLX[HLDSTRT D  Q
 . ;check for more than 1 start block
 . S X=$L(HLX,HLDSTRT) S:X>2 HLX=HLDSTRT_$P(HLX,HLDSTRT,X)
 . ;
 . ; patch HL*1.6*122
 . ; S:$L($P(HLX,HLDSTRT,2))>8 HLINE=HLINE+1,HLMSG(HLINE,0)=$P(HLX,HLDSTRT,2),HLX="",HLHDR=1
 . S HLINE=HLINE+1,HLMSG(HLINE,0)=$P(HLX,HLDSTRT,2),HLX="",HLHDR=1
 . ;
 . D RESET:(HLHDR&(HLINE>1))
 ;if no ien, reset
 ; patch HL*1.6*122
 ; I 'HLIND1 D CLEAN Q
 I (HLRS("START-FLAG")=1),'HLIND1 D CLEAN Q
 ; big message-merge from local to global every 100 lines
 I (HLINE-$O(HLMSG(0)))>100 D
 . M ^HL(772,+$P(HLIND1,U,2),"IN")=HLMSG
 . ; reset working array
 . K HLMSG
 Q
 ;
SAVE(SRC,DEST) ;save into global & set top node
 ;SRC=source array (passed by ref.), DEST=destination global
 ;
 ; patch HL*1.6*122: MPI-client/server
 I DEST["HLMA" D
 . F  L +^HLMA(+HLIND1):10 Q:$T  H 1
 E  D
 . F  L +^HL(772,+$P(HLIND1,U,2)):10 Q:$T  H 1
 ;
 M @DEST=SRC
 S @DEST@(0)="^^"_HLINE_"^"_HLINE_"^"_DT_"^"
 ;
 I DEST["HLMA" L -^HLMA(+HLIND1)
 E  L -^HL(772,+$P(HLIND1,U,2))
 ;
 Q
 ;
DELMSG(HLMAMT) ;delete message from Message Administration/Message Text files.
 N DIK,DA
 S DA=+HLMAMT,DIK="^HLMA("
 D ^DIK
 S DA=$P(HLMAMT,U,2),DIK="^HL(772,"
 D ^DIK
 Q
PING ;process PING message
 S X=HLMSG(1,0)
 ; patch HL*1.6*140, flush character- HLTCPLNK("IOF")
 ; I X[HLDEND U IO W X,! D
 ; I X[HLDEND U IO W X,HLTCPLNK("IOF") D
 ; patch HL*1.6*142
 I X[HLDEND U IO W X,@HLTCPLNK("IOF") D
 . ; switch to null device if opened to prevent 'leakage'
 . I $G(IO(0))]"",$G(IO(0))'=IO U IO(0)
CLEAN ;reset var. for next message
 K HLMSG
 S HLINE=0,HLRDOUT=1
 Q
 ;
ERROR ; Error trap for disconnect error and return back to the read loop.
 ; patch HL*1.6*122
 ; move to routine HLCSTCP4 (splitted-size over 10000)
 D ERROR1^HLCSTCP4
 Q
 ;
CC(X) ;cleanup and close
 D MON^HLCSTCP(X)
 H 2
 Q
RESET ;reset info as a result of no end block
 N %
 S HLMSG(1,0)=HLMSG(HLINE,0)
 F %=2:1:HLINE K HLMSG(%,0)
 S HLINE=1
 Q

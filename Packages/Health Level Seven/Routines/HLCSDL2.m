HLCSDL2 ;ALB/MTC/JC - X3.28 LOWER LAYER PROTOCOL UTILITIES 2.2 - 2/28/95 ;04/25/96  10:52
 ;;1.6;HEALTH LEVEL SEVEN;**2**;Oct 13, 1995
 Q
 ;
SENDNAK ;-- This function will send an nack for the block specified
 ;  by the parameter HLBK.
 ; OUTPUT: NONE
 ;
 ;
 U IO
 W $C(HLNAK)_$C(HLTERM)
 D LOG^HLCSDL1($C(HLNAK)_$C(HLTERM),"WRITE: ")
 Q
 ;
SENDACK(HLBK) ;-- This function will send an ack for the block specified
 ;  by the parameter HLBK.
 ;  INPUT : HLBK current sequence (block)
 ; OUTPUT: NONE
 ;
 N HLACKN
 ;
 S HLACKN="HLACK"_(HLBK#8)
 U IO W $C(HLDLE)_$C(@(HLACKN))_$C(HLTERM)
 D LOG^HLCSDL1($C(HLDLE)_$C(@(HLACKN))_$C(HLTERM),"WRITE: ")
 Q
 ;
READACK(HLBK) ;-- This function will read the input device for an ackN
 ;  specified by HLBK.
 ;   INPUT : HLBK - Expected AckN
 ;   OUTPUT: 1- Ok 0-Fails
 ;
 N HLACKN,X,Y,RESULT,HLTRM
 ;
 S RESULT=0,HLTRM=""
 S HLACKN=@("HLACK"_(HLBK#8))
 ;-- do read for HLDLE
 S X=$$READ^HLCSUTL(HLTIMA,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(X_$C(HLTRM),"READ: ")
 D TRACE^HLCSDL2("FINISHED READ FOR DLE:"_HLTRM_U_X_U)
 I HLTRM'=HLDLE G RDACKQ
 S X=$$READ^HLCSUTL(HLTIMA,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(X_$C(HLTRM),"READ: ")
 I X'=$C(HLACKN),HLTRM'=HLTERM G RDACKQ
 S RESULT=1
 ;
RDACKQ Q RESULT
 ;
READENQ() ;-- This function will read the input device for an ENQ
 ;
 ;   INPUT : NONE
 ;   OUTPUT: 1- Ok 0-Fails
 ;
 N X,Y,RESULT,HLTRM,HLX
 ;
 S HLX=0
RETRY S RESULT=0,HLTRM=""
 ;-- do read for HLENQ
 S X=$$READ^HLCSUTL(HLTIMA,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(X_$C(HLTRM),"READ: ")
 D TRACE^HLCSDL2("FINISHED READ FOR ENQ:"_HLTRM_U_X_U)
 S HLX=HLX+1 I HLX>5 G RDENQ
 I HLTRM'=+HLENQ G RETRY
 ;-- do read for HLTERM
 S X=$$READ^HLCSUTL(HLTIMA,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(X_$C(HLTRM),"READ: ")
 I HLTRM'=+HLTERM G RDENQ
 S RESULT=1
 ;
RDENQ Q RESULT
 ;
READBK(HLTEXT,LEN,BLOCK,CHKSUM,BTERM) ; This function will read a block of data from the input device
 ; and store the result in the array specified by HLTEXT.
 ;    INPUT : HLTEXT - Array reference to store data
 ;            LEN    - Passed by reference will get message lenght
 ;            BLOCK  - Passed by refence will get message block #
 ;            CHKSUM - Passed by refence will get message BCC
 ;            BTERM  - Passed by reference will block termination char
 ;   OUTPUT : 1 - OK, 0 - Fails
 ;            If EOT is encountered HLTEXT=EOT
 ;            If TimeOut is encountered then HLTEXT="-1^TIMEOUT"
 ;
 N RESULT,HLX,HLTRM
 S (RESULT,LEN,CHKSUM,BTERM,BLOCK)=0
 ;-- read expect either SOH or STX will ignore header info
 S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ")
 ;-- check for timeout
 I HLX["TIMEOUT" S @HLTEXT=HLX G READBKQ
 ;-- check for eot
 I HLTRM=+HLEOT S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM),@HLTEXT=HLEOT,RESULT=1 D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ") G READBKQ
 ;-- if header read and ignore
 I HLTRM=+HLSOH S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM) D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ") I HLX["TIMEOUT" S @HLTEXT=HLX
 ;-- start of data block
 I HLTRM'=+HLSTX G READBKQ
 ;-- read expect either HLDBLOCK characters or CR for end of data
 S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ")
 ;-- check for timeout
 I HLX["TIMEOUT" S @HLTEXT=HLX G READBKQ
 ;-- get block and length -- <blk><len><data><cr>
 S HLI=0
 S BLOCK=$E(HLX),LEN=$E(HLX,2,6)
 ;
BLOOP ;-- block read loop
 ;
 ;-- first pass get data leave blk and lenght
 I HLI=0 S HLX=$E(HLX,7,$L(HLX))
 ;-- save data
BLOOP2 S HLI=HLI+1,@HLTEXT@(HLI)=HLX
 ;-- long line
 I HLTRM=0 D
 . S HLDONE=0,HLJ=0
 . F  S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM) D  I HLDONE Q
 .. D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ")
 .. I +HLX<0 S HLDONE=1 Q
 .. S HLJ=HLJ+1,@HLTEXT@(HLI,HLJ)=HLX
 .. I HLTRM=+HLTERM S HLDONE=1
 ;
 ;-- read upto next ctrl char
 S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM)
 D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ")
 ;-- check for timeout
 I HLX["TIMEOUT" S @HLTEXT=HLX G READBKQ
 ;-- more data to read
 I (HLTRM=+HLTERM)!(HLTRM=0) G BLOOP2
 ;-- read expect ETX or ETB
 I (HLTRM=+HLETB)!(HLTRM=+HLETX) S BTERM=HLTRM D
 .;-- read expect <BCC><TERM>
 . S HLX=$$READ^HLCSUTL(HLTIMB,HLDBLOCK,.HLTRM)
 . D LOG^HLCSDL1(HLX_$C(HLTRM),"READ: ")
 .;-- get BCC
 . S CHKSUM=HLX
 ;-- OK
 S RESULT=1
 ;
READBKQ Q RESULT
 ;
BUILD(HLTEXT,HLSEQ,HLEND,HLHEAD,HLFOOT) ;-- This function will build the block to write.
 ; INPUT : HLTEXT - Array to write/format
 ;       : HLSEQ  - Sequence in message
 ;       : HLEND  - ETX or ETB
 ;       : HLHEAD - Passed by reference - will be the header portion
 ;       : HLFOOT - Passed by reference - will be the footer portion
 ;
 ; OUTPUT: HLHEAD = <STX><BLK><LENGTH>
 ;         HLFOOT = <ETX or ETB><BCC><TERM>
 ;
 N HLBL,HLHEX,X,Y
 ;-- get checksum information
 S HLCHK=$$CHKSUM^HLCSUTL(HLTEXT)
 ;-- determine block number
 S HLBL=HLSEQ#8
 ;-- determine length
 S HLLN=$P(HLCHK,U,2)
 S HLLN=$E("00000",1,5-$L(HLLN))_$P(HLCHK,U,2)
 S X=HLBL_HLLN_$C($P(HLCHK,U))_$C(HLEND) X ^%ZOSF("LPC")
 ;-- build two byte check sum
 S HLHEX=$$HEXCON(Y)
 ;-- build string
 S HLHEAD=$C(HLSTX)_HLBL_HLLN,HLFOOT=$C(HLEND)_HLHEX_$C(HLTERM)
 Q
 ;
ENQ ;-- this function will send an ENQ to the secondary station
 ;   to establish a master/slave relationship for transmissions.
 ;
 U IO
 W $C(HLENQ)_$C(HLTERM)
 D LOG^HLCSDL1($C(HLENQ)_$C(HLTERM),"WRITE: ")
 Q
 ;
EOT ;-- this function will send an EOT to the secondary station
 ;   to end the master/stave relationship.
 ;
 U IO
 W $C(HLEOT)_$C(HLTERM)
 D LOG^HLCSDL1($C(HLEOT)_$C(HLTERM),"WRITE: ")
 Q
 ;
HEXCON(%) ;-- converts a decimal #<128 to a two byte hex #
 ; INPUT : % - Decimal to convert
 ;
 ;
 N H,H1,H2
 ;-- error if # not between 0 - 127
 I (%<0)!(%>127)!(%'=+%) S (H1,H2)=0 G HEXQ
 I %<10 S H1=0,H2=% G HEXQ
 S H=%\16 S:H>9 H=$E("         ABCDEF",H) S H1=H
 S H=%#16 S:H>9 H=$E("         ABCDEF",H) S H2=H
HEXQ Q H1_H2
 ;
RUN() ;-- This function will determine if this occurance of the LLP
 ;   should still be running.
 ; INPUT : NONE
 ;OUTPUT : 1 - Yes, 0 No
 ;
 N RESULT
 ;-- default to Yes
 S RESULT=1
 ;-- check if should shut down
 I $P($G(^HLCS(870,HLDP,0)),U,15)=1 S RESULT=0
 ;-- if running in forground ask
 I $G(HLTRACE) U IO(0) W !,"Type Q to Quit: " R X:1 I $G(X)'=""&("Qq"[X) S $P(^HLCS(870,HLDP,0),U,15)=1,RESULT=0
 ;
 Q RESULT
 ;
VALID(HLTEXT,HLBLK,LEN,BLOCK,CHKSUM,BTERM) ;-- This function will validate the incoming message as in should
 ;  conform to the X3.28 protocol. No other error checking is perfomred
 ;  for this validation. If this function is successful a
 ;  1 is returned else 0.
 ;  INPUT : HLTEXT - The block that was read in from the device
 ;        : HLBLK  - Current block expected
 ;        : LEN - xmitted length
 ;        : BLOCK - xmitted block number
 ;        : CHKSUM - xmitted checksum
 ;        : BTERM - Block termination char (ETX or ETB)
 ; OUTPUT : 1 ok, 0 fails
 ;
 ; The following validation checks are made by this function:
 ;  1 - BCC matches calculated BCC
 ;  2 - Message lenght matches calculated message length
 ;  3 - Block matches the expected block number
 ;  4 - Block termination is either ETX or ETB
 ;
 N HLBCC,HLLEN,HLBCC1,RESULT,X,Y
 S RESULT=0
 ;-- calculate checksum
 S HLBCC=$$CHKSUM2^HLCSUTL(HLTEXT)
 ;-- add in BLOCK LEN and BTERM
 S X=BLOCK_LEN_$C($P(HLBCC,U))_$C(BTERM) X ^%ZOSF("LPC") S HLBCC1=Y
 ;-- convert to hex
 S HLBCC1=$$HEXCON(HLBCC1)
 ;-- checksum
 I HLBCC1'=CHKSUM G VALIDQ
 ;-- length
 I $P(HLBCC,U,2)'=+LEN G VALIDQ
 ;-- block
 I HLBLK'=BLOCK G VALIDQ
 ;-- ok
 S RESULT=1
 ;
VALIDQ Q RESULT
 ;
TRACE(HLSTATE) ;-- This function is used during for debug. It will print
 ; the current state of the X3.28 protocol. Each state is passed in
 ; through the variable HLSTATE
 ;
 ; INPUT  - HLSTATE : Current state of FSM
 ; OUTPUT - If HLTRACE is defined then write HLSTATE to IO(0)
 ;
 I '$G(HLTRACE) Q
 U IO(0)
 W !,"In State : ",HLSTATE
 Q
 ;

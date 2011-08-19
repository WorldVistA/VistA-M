HLCSDR2 ;ALB/RJS - HYBRID LOWER LAYER PROTOCOL UTILITIES 2.2 - ;08/22/2001  11:23
 ;;1.6;HEALTH LEVEL SEVEN;**2,9,62,109**;Oct 13, 1995
 Q
WRITE(HLDOUT0,HLDOUT1) ; This function writes a message from the Logical
 ; Link file (#870) to the specified device in the following format:
 ; <Start Block><Data Block><End Block>
 ; The data block is the complete HL7 message terminated by a <CR>.
 ; INPUT : HLDOUT0 - IFN of file 870
 ;         HLDOUT1 - IFN of Out Queue Multiple
 ; OUTPUT: None
 I HLDOUT0']""!(HLDOUT1']"") Q
 ;-- HLLINE,HLC1,HLC2 are initialized in INITIZE
 N HLCLN,HLCHK,I,X
 D INITIZE
 ;
 ;-- write start block
 S X=$C(HLDSTRT)_"D"_HLDVER_$C(13) D CHKSUM
 U IO W X
 ;
 S HLWFLG=0
 ;-- process and write data block
 F  S HLLINE=$$NEXTLINE^HLCSUTL(HLDOUT0,HLDOUT1,HLLINE,"HLCLN","OUT") Q:'HLLINE  D
 . S HLCHK=$$CHKSUM^HLCSUTL("HLCLN")
 . S HLC2=HLC2_$C($P(HLCHK,U)),HLC1=HLC1+$P(HLCHK,U,2)
 . I $E(HLCLN(1),1,3)="MSA" S HLWFLG=1
 . ;U IO
 . S I=0 F  S I=$O(HLCLN(I)) Q:'I  W $G(HLCLN(I))
 . K HLCLN,HLCHK
 ;
 D CHKSUM1
 ;-- store checksum values
 D MONITOR(HLC1,4,HLDP,HLDOUT1,"OUT"),MONITOR(HLC2,5,HLDP,HLDOUT1,"OUT")
 ;
 S HLC1=$$RJ(HLC1,5)
 S HLC2=$$RJ(HLC2,3)
 ;
 ;-- write end block
 S X=HLC1_HLC2_$C(HLDEND)_$C(13)
 U IO W X
 Q
SETNODE(HLD0,HLD1,CR) ;
 S HLLINE=HLLINE+1,^HLCS(870,HLD0,1,HLD1,1,HLLINE,0)=$G(X)
 I CR="CR" S HLLINE=HLLINE+1,^HLCS(870,HLD0,1,HLD1,1,HLLINE,0)=""
 Q
SETNODE2 ;
 S HLLINE=HLLINE+1,^TMP("HLCSDR1",$J,HLDP,HLLINE)=$G(X)
 Q
TRANS(HLTOUT,HLTRANS) ; This function returns the state of the read operation.
 ;   INPUT : HLTOUT - Data returned from read (Will contain TIMEOUT)
 ;           HLTRANS - Variable passed by reference containing how
 ;                     the read was terminated.
 ;   OUTPUT: HLTRANS - Translation of read termination.
 S HLTRANS=$S($G(HLTOUT)["TIMEOUT":"TIMEOUT",HLTRANS=0:"LONGLINE",HLTRANS=1:"SOH",HLTRANS=4:"EOT",HLTRANS=HLDSTRT:"VT",HLTRANS=13:"CR",HLTRANS=HLDEND:"FS",1:"OTHER")
 I $D(HLTRACE) U IO(0) W !,"HLTRANS=",HLTRANS
 Q
INITIZE ;Initialize Line counter and Checksum variables
 S (HLLINE,HLC1)=0,HLC2=""
 Q
NAK(HLTRANS) ; Send NAK
 N HLDATA
 D INITIZE
 ;-- start block and data
 S (X,HLDATA)=$C(HLDSTRT)_"N"_HLDVER_$C(13)_HLTRANS
 D CHKSUM,CHKSUM1
 S HLC1=$$RJ(HLC1,5)
 S HLC2=$$RJ(HLC2,3)
 ;-- end block
 S X=HLDATA_HLC1_HLC2_$C(HLDEND)_$C(13)
 U IO W X
 Q
ACK ; Send ACK
 N HLDATA
 D INITIZE
 ;-- start block and data
 S (X,HLDATA)=$C(HLDSTRT)_"D"_HLDVER_$C(13)
 D CHKSUM,CHKSUM1
 S HLC1=$$RJ(HLC1,5)
 S HLC2=$$RJ(HLC2,3)
 ;-- end block
 S X=HLDATA_HLC1_HLC2_$C(HLDEND)_$C(13)
 U IO W X
 Q
DUMP ;
 Q:'$D(HLTRACE)
 U IO(0)
 W !,"DUMP"
 I '$D(HLC1) S HLC1=-1
 I '$D(HLC2) S HLC2=-1
 I '$D(HLBLOCK) S HLBLOCK=-1
 I '$D(HLXOR) S HLXOR=-1
 W !,"HLC1=",HLC1," ","HLBLOCK=",HLBLOCK
 W !,"HLC2=",HLC2," ","HLXOR=",HLXOR
 Q
CHKSUM ;
 X ^%ZOSF("LPC") S HLC1=HLC1+$L(X),HLC2=HLC2_$C(Y)
 I $L(HLC2)>240 D CHKSUM1
 Q
CHKSUM1 ;
 S X=HLC2 X ^%ZOSF("LPC") S HLC2=Y
 Q
VALID1(FLAG,CHK,HLIND0,HLIND1) ;
 ;This function extracts the checksum sent with a message and then
 ;compares it to the checksums that have been calculated and stored
 ;in the HLC1 and HLC2 variables. HLC1 and HLC2 are not passed as
 ;parameters, their scope is "communication server-wide"
 ;FLAG tells the function what type of message this is, should the
 ;last block of data be written to an "in queue" ? or a TMP variable ?
 ;this depends on whether the incoming message is a message or just
 ;a lower level acknowledgement "LLP-ACK"
 ;CHK contains the 8 character cheksum that was sent with the message
 ;HLIND0,HLIND1 are just D0 and D1 for the "input queue" in file #870
 N HLBLOCK,HLXOR
 ;WRITE LAST BLOCK 'O DATA TO GLOBAL
 I $G(X)'="",FLAG="INCOMING MESSAGE" D SETNODE(HLIND0,HLIND1,HLTRANS),CHKSUM
 I $G(X)'="",FLAG="LLP-ACK" D SETNODE2,CHKSUM
 ;Extract checksums
 S HLBLOCK=+$E(CHK,1,5),HLXOR=+$E(CHK,6,8)
 D CHKSUM1,DUMP
 S X="$$CHK$$^"_CHK_"^HLCHK^"_$$RJ(HLC1,5)_$$RJ(HLC2,3)
 I FLAG="INCOMING MESSAGE" D MONITOR(HLBLOCK,5,HLDP,HLIND1,"IN"),MONITOR(HLXOR,6,HLDP,HLIND1,"IN"),MONITOR(HLC1,7,HLDP,HLIND1,"IN"),MONITOR(HLC2,8,HLDP,HLIND1,"IN")
 I FLAG="LLP-ACK" D SETNODE2
 I HLXOR="999" Q "VALID"
 I HLBLOCK=HLC1,HLC2=HLXOR Q "VALID"
 I HLBLOCK'=HLC1 Q "C"
 I HLXOR'=HLC2 Q "X"
 Q "G"
TRACE ;When HLTRACE is instantiated this subroutine simply writes out the
 ;states that the finite state machine (Lower Layer Protocol) goes thru
 Q:'$D(HLTRACE)
 U IO(0) W !,"IN STATE ",HLNXST
 Q
MONITOR(VALUE,PIECE,HLD0,HLD1,QUEUE) ;
 ;This subroutine simply updates a particular piece in a global node
 ;in file #870. It can be a zero node, or a node in a queue multiple
 I '$D(^HLCS(870,HLD0,0)) Q
 I $G(HLD1)']"" S $P(^HLCS(870,HLD0,0),U,PIECE)=VALUE Q
 I PIECE=2,$G(QUEUE)="IN" D  Q
 . N HLJ
 . S HLJ(870.019,HLD1_","_HLD0_",",1)=VALUE
 . D FILE^HLDIE("","HLJ","","MONITOR","HLCSDR2") ; HL*1.6*109
 S $P(^HLCS(870,HLD0,$S(QUEUE="IN":1,1:2),HLD1,0),U,PIECE)=VALUE
 Q
FORMAT(HLC,LENGTH) ;Function to stuff leading zeroes for checksums
 ;HLC is the checksum, Length is self-documenting
 Q $E("00000",1,LENGTH-$L(HLC))
RJ(HLC,LENGTH) ;Function to stuff leading zeroes for checksums
 ;HLC is the checksum, Length is self-documenting
 ;Functionally equivalent to $$RJ^XLFSTR(HLC,LENGTH,"0")
 ;Also equivalent to $$FORMAT(HLC,LENGTH)_HLC
 Q $E("00000",1,LENGTH-$L(HLC))_HLC

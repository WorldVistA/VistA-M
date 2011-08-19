HLMA ;AISC/SAW-Message Administration Module ;02/26/2009  15:42
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,58,63,66,82,91,109,115,133,132,122,140,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
GENERATE(HLEID,HLARYTYP,HLFORMAT,HLRESLT,HLMTIEN,HLP) ;
 ;Entry point to generate a deferred message
 ;
 ;This is a subroutine call with parameter passing.  It returns a
 ;value in the variable HLRESLT with 1 to 3 pieces separated by uparrows
 ;as follows:  1st message ID^error code^error description
 ;If no error occurs, only the first piece is returned equal to a unique
 ;ID for the 1st message.  If message was sent to more than 1 subscriber
 ;than the other message IDs will be in the array HLRESLT(n)=ID
 ;Otherwise, three pieces are returned with the
 ;first piece equal to the message ID, if one was assigned, otherwise 0
 ;
 ;Required Input Parameters
 ;     HLEID = Name or IEN of event driver protocol in the Protocol file
 ;  HLARYTYP = Array type.  One of the following codes:
 ;               LM = local array containing a single message
 ;               LB = local array containig a batch of messages
 ;               GM = global array containing a single message
 ;               GB = global array containing a batch of messages
 ;  HLFORMAT = Format of array, 1 for pre-formatted in HL7 format,
 ;               otherwise 0
 ;NOTE:  The parameter HLRESLT must be passed by reference
 ;   HLRESLT = The variable that will be returned to the calling
 ;               application as descibed above
 ;Optional Parameters
 ;   HLMTIEN = IEN of entry in Message Text file where the message
 ;               being generated is to be stored.  This parameter is
 ;               only passed for a batch type message
 ;NOTE:  The parameter HLP used for the following parameters must be
 ;       passed by reference
 ;  HLP("SECURITY") = A 1 to 40 character string
 ;   HLP("CONTPTR") = Continuation pointer, a 1 to 180 character string
 ; HLP("NAMESPACE") = Passed in by application namespace - HL*1.6*91
 ; HLP("EXCLUDE SUBSCRIBER",<n=1,2,3...>)=<subscriber protocol ien> or
 ;   <subscriber protocol name> - A list of protocols to dynamically
 ;   drop from the event protocol's subscriber multiple.
 ;
 ;can't have link open when generating new message
 N HLTCP,HLTCPO,HLPRIO,HLMIDAR
 ; patch HL*1.6*142- to protect application who call this entry
 N HLSUP
 S HLPRIO="D"
 S HLRESLT=""
 ;Check for required parameters
CONT ;
 I $G(HLEID)']""!($G(HLARYTYP)']"")!($G(HLFORMAT)']"") D  G EXIT
 . S HLRESLT="0^7^"_$G(^HL(771.7,7,0))_" at GENERATE^HLMA entry point"
 I 'HLEID S HLEID=$O(^ORD(101,"B",HLEID,0)) I 'HLEID S HLRESLT="0^1^"_$G(^HL(771.7,1,0)) G EXIT
 N HLRESLT1,HLRESLTA S (HLRESLTA,HLRESLT1)=""
 I "GL"'[$E(HLARYTYP) S HLRESLT="0^4^"_$G(^HL(771.7,4,0)) G EXIT
 I $L($G(HLP("SECURITY")))>40 S HLRESLT="0^6^"_$G(^HL(771.7,6,0)) G EXIT
 I $L($G(HLP("CONTPTR")))>180 S HLRESLT="0^11^"_$G(^HL(771.7,11,0)) G EXIT
 I $D(HLL("LINKS")) D  G:$G(HLRESLT)]"" EXIT
 . N I,HLPNAM,HLPIEN,HLLNAM,HLLIEN
 . S I=0
 . F  S I=$O(HLL("LINKS",I)) Q:'I  D  Q:$G(HLRESLT)]""
 . . S HLPNAM=$P(HLL("LINKS",I),U)
 . . S HLPIEN=+$O(^ORD(101,"B",HLPNAM,0))
 . . I $P($G(^ORD(101,HLPIEN,0)),U,4)'="S" S HLRESLT="0^15^Invalid Subscriber Protocol in HLL('LINKS'): "_HLL("LINKS",I) Q
 . . S HLLNAM=$P(HLL("LINKS",I),U,2)
 . . S HLLIEN=+$O(^HLCS(870,"B",HLLNAM,0))
 . . I '$D(^HLCS(870,HLLIEN,0)) S HLRESLT="0^15^Invalid HL Node in HLL('LINKS'): "_HLL("LINKS",I) Q
 ;Extract data from Protocol file
 D EVENT^HLUTIL1(HLEID,"15,20,771",.HLN)
 S HLENROU=$G(HLN(20)),HLEXROU=$G(HLN(15))
 S HLP("GROUTINE")=$G(HLN(771)) K HLN I HLP("GROUTINE")']"",'HLFORMAT S HLRESLT="0^3^"_$G(^HL(771.7,3,0)) G EXIT
 ;Create message ID and Message Text IEN if Message Text IEN not
 ;previously created ('$G(HLMTIEN))
 I '$G(HLMTIEN) D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 ;Get message ID if Message Text IEN already created
 I '$G(HLMID) D
 .S HLDT=$G(^HL(772,HLMTIEN,0)),HLMID=$P(HLDT,"^",6),HLDT=+HLDT
 .S HLDT1=$$HLDATE^HLFNC(HLDT)
 S HLMIDAR=0,HLRESLT=HLMID,HLP("DT")=HLDT,HLP("DTM")=HLDT1
 ;Execute entry action for event driver protocol
 I HLENROU]"" X HLENROU
 ;Invoke transaction processor
 K HLDT,HLDT1,HLENROU
 D GENERATE^HLTP(HLMID,HLMTIEN,HLEID,HLARYTYP,HLFORMAT,.HLRESLT1,.HLP)
 ;HLMIDAR is array of message IDs, only set for broadcast messages
 I HLMIDAR K HLMIDAR("N") M HLRESLT=HLMIDAR
 S HLRESLT=HLRESLT_"^"_HLRESLT1
 ;
 ; patch HL*1.6*122
 S HLRESLT("HLMID")=$G(HLMIDAR("HLMID"))
 S HLRESLT("IEN773")=$G(HLMIDAR("IEN773"))
 ;
 ;Execute exit action for event driver protocol
 I HLEXROU]"" X HLEXROU
EXIT ;Update status if Message Text file entry has been created
 K HLTCP
 I $D(HLMTIEN) D STATUS^HLTF0(HLMTIEN,$S($P(HLRESLT,"^",2):4,1:3),$S($P(HLRESLT,"^",2):$P(HLRESLT,"^",2),1:""),$S($P(HLRESLT,"^",2):$P(HLRESLT,"^",3),1:""))
 K HLDT,HLDT1,HLMID,HLRESLT1,HLENROU,HLEXROU
 Q
DIRECT(HLEID,HLARYTYP,HLFORMAT,HLRESLT,HLMTIENO,HLP) ;
 ;Entry point to generate an immediate message, must be TCP Logical Link
 ;Input:
 ;  The same as GENERATE,with one additional subscript to the HLP input 
 ;  array:
 ; 
 ;  HLP("OPEN TIMEOUT") (optional, pass by reference) a number between 
 ;    1 and 120 that specifies how many seconds the DIRECT CONNECT should
 ;    try to open a connection before failing.  It is killed upon 
 ;    completion.
 ; 
 N HLTCP,HLTCPO,HLPRIO,HLSAN,HLN,HLMIDAR,HLMTIENR,ZMID,HLDIRECT
 ; patch HL*1.6*140- to protect application who call this entry
 N IO,IOF,ION,IOT,IOST,POP
 S HLRESLT=""
 ;HLMTIENO=ien passed in, batch message
 S HLMTIEN=$G(HLMTIENO)
 I $G(HLP("OPEN TIMEOUT")),((HLP("OPEN TIMEOUT")\1)'=+HLP("OPEN TIMEOUT"))!HLP("OPEN TIMEOUT")>120 Q "0^4^INVALID OPEN TIMEOUT PARAMETER"
 I $G(HLP("OPEN TIMEOUT")) D
 .S HLDIRECT("OPEN TIMEOUT")=HLP("OPEN TIMEOUT")
 .K HLP("OPEN TIMEOUT")
 K HL,HLMTIENO
 D INIT^HLFNC2(HLEID,.HL)
 I $G(HL) S HLRESLT="0^"_HL Q
 S HLPRIO="I" D CONT
 ;HLMTIENO=original msg. ien in file 772, HLMTIENR=response ien set in HLMA2
 S HLMTIENO=HLMTIEN,HLMTIEN=$G(HLMTIENR)
 ;Set special HL variables
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 Q
 ;
CLOSE(LOGLINK) ;close connection that was open in tag DIRECT
 Q
PING ;ping another VAMC to test Link
 ;set HLQUIET =1 to skip writes
 ;look for HLTPUT to get turnaround time over network.
 N DA,DIC,HLDP,HLDPNM,HLDPDM,HLCSOUT,HLDBSIZE,HLDREAD,HLOS,HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPORT,HLTCPRET,HLCSFAIL,HLPARAM
 N HCS,HCSCMD,HLCS,HCSDAT,HCSER,HCSEXIT,HCSTRACE,HLDT1,HLDRETR,HLRETRA,HLDBACK,HLDWAIT,HLTCPCS,INPUT,OUTPUT,POP,X,Y,HLX1,HLX2
 S HLQUIET=$G(HLQUIET)
 S HLCS="",HCSTRACE="C: ",POP=1,INPUT="INPUT",OUTPUT="OUTPUT"
 S DIC="^HLCS(870,",DIC(0)="QEAMZ"
 D ^DIC Q:Y<0
 S HLDP=+Y,HLDPNM=Y(0,0),HLDPDM=$P($$PARAM^HLCS2,U,2)
 ;I $P($G(^HLCS(870,HLDP,400)),U)="" W !,"Missing IP Address" Q
 D SETUP^HLCSAC G:HLCS PINGQ
 ; patch HL*1.6*122
 G:$$DONTPING^HLMA4 PINGQ
 ;PING header=MSH^PING^domain^PING^logical link^datetime
 S INPUT(1)="MSH^PING^"_HLDPDM_"^PING^"_HLDPNM_"^"_$$HTE^XLFDT($H)
 D OPEN^HLCSAC
 I HLCS D DNS G:HLCS PINGQ
 D
 . N $ETRAP,$ESTACK S $ETRAP="D PINGERR^HLMA"
 . ;non-standard HL7 header; start block,header,end block
 . S HLX1=$H
 . ;
 . ; HL*1.6*122 start
 . ; replace flush character '!' with @IOF (! or #)
 . ; W $C(11)_INPUT(1)_$C(28)_$C(13),! ;HL*1.6*115, restored ! char
 . ; patch HL*1.6*140, flush character- HLTCPLNK("IOF")
 . ; W $C(11)_INPUT(1)_$C(28)_$C(13),@IOF
 . W $C(11)_INPUT(1)_$C(28)_$C(13),@HLTCPLNK("IOF")
 . ; HL*1.6*122 end
 . ;
 . ;read response
 . R X:HLDREAD
 . S HLX2=$H
 . S X=$P(X,$C(28)),HLCS=$S(X=INPUT(1):"PING worked",X="":"No response",1:"Incorrect response")
 . ;Get roundtrip time
 . K HLTPUT I X]"" S HLTPUT=$$HDIFF^XLFDT(HLX2,HLX1,2)
 D CLOSE^%ZISTCP
PINGQ ;write back status and quit
 I 'HLQUIET W !,HLCS,!
 Q
PINGERR ;process errors from PING
 S $ETRAP="G UNWIND^%ZTER",HLCS="-1^Error"
 ;I $ZE["READ" S HLCS="-1^Error during read"
 ;I $ZE["WRITE" S HLCS="-1^Error during write"
 ; HL*1.6*115, SACC compliance
 I $$EC^%ZOSV["READ" S HLCS="-1^Error during read"
 I $$EC^%ZOSV["WRITE" S HLCS="-1^Error during write"
 G UNWIND^%ZTER
DNS ;
 ;openfail-try DNS lookup-Link must contain point to Domain Name
 S POP=$G(POP)
 S HLQUIET=$G(HLQUIET)
 I 'HLQUIET W !,"Calling DNS"
 N HLDOM,HLIP S HLCS=""
 S HLDOM=$P(^HLCS(870,HLDP,0),U,7)
 ; patch HL*1.6*122 start
 S HLDOM("DNS")=$P($G(^HLCS(870,+$G(HLDP),0)),"^",8)
 ; I 'HLDOM,'HLQUIET W !,"Domain Unknown" Q
 I 'HLDOM,($L(HLDOM("DNS"),".")<3) D  Q
 . I 'HLQUIET W !,"Domain Unknown"
 . S HLCS="-1^Connection Fail"
 ; patch HL*1.6*122 end
 I HLDOM S HLDOM=$P(^DIC(4.2,HLDOM,0),U)
 ; patch HL*1.6*122
 ; I HLDOM]"" D  Q:'POP
 I HLDOM]""!($L(HLDOM("DNS"),".")>2) D  Q:'POP
 . I HLDOM["VA.GOV"&(HLDOM'[".MED.") S HLDOM=$P(HLDOM,".VA.GOV")_".MED.VA.GOV"
 . I HLTCPORT=5000 S HLDOM="HL7."_HLDOM
 . I HLTCPORT=5500 S HLDOM="MPI."_HLDOM
 . ; patch HL*1.6*122
 . I ($L(HLDOM("DNS"),".")>2) S HLDOM=HLDOM("DNS")
 . I 'HLQUIET W !,"Domain, "_HLDOM
 . I 'HLQUIET W !,"Port: ",HLTCPORT
 . S HLIP=$$ADDRESS^XLFNSLK(HLDOM)
 . I HLIP]"",'HLQUIET W !,"DNS Returned: ",HLIP
 . I HLIP]"" D
 . . ;If more than one IP returned, try each, cache successful open
 . . N HLI,HLJ,HLIP1
 . . F HLJ=1:1:$L(HLIP,",") D  Q:'POP
 . . . S HLIP1=$P(HLIP,",",HLJ)
 . . . F HLI=1:1:HLDRETR W:'HLQUIET !,"Trying ",HLIP1 D CALL^%ZISTCP(HLIP1,HLTCPORT,1) Q:'POP
 . . . I 'POP S $P(^HLCS(870,HLDP,400),U)=HLIP1
 . . . U IO
 I POP S HLCS="-1^DNS Lookup Failed"

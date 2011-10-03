HLTP2 ;AISC/SAW-Transaction Processor Module (Cont'd) ;2/22/95  11:35
 ;;1.6;HEALTH LEVEL SEVEN;**34,109**;Oct 13, 1995
PROCACK(HLMTIEN,HLEID,HLRESLT,HL) ;Process acknowledgement message
 ;
 ;This is a subroutine call with parameter passing.  It returns a value
 ;in the variable HLRESLT of null if no error occurs, or the following
 ;two piece value if an error occurs:  error code^error description
 ;
 ;Required Input Parameters
 ; HLMTIEN = The IEN from the Message Text file created when the
 ;             GENERATE^HLMA or SEND^HLMA2 entry points were invoked
 ;   HLEID = The IEN from the Protocol file of the driver event
 ;NOTE:  The variable HLRESLT must be passed by reference
 ; HLRESLT = The variable that will be returned to the calling
 ;             application as descibed above
 ;Optional Input Parameter
 ;      HL = An array of variables to be used in processing the message
 ;
 ;Check for required parameters
 S HLRESLT=""
 I '$G(HLMTIEN)!('$G(HLEID)) S HLRESLT="7^"_$G(^HL(771.7,7,0))_" at PROCACK^HLTP0 entry point" G EXIT
 ;Create HL array of variables if it does not exist
 I '$D(HL) N HL D INIT^HLFNC2(HLEID,.HL)
 ;Set special HL variables if data is in global array
 I '$D(HLA("HLA")) S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ;Get and execute processing routine
 D EVENT^HLUTIL1(HLEID,"15,20,772",.HLN) I $G(HLN(772))]"" D
 .X:$G(HLN(20))]"" $G(HLN(20))
 .N HLERR X HLN(772) I $D(HLERR) S HLRESLT="9^"_$G(^HL(771.7,9,0))
 .X:$G(HLN(15))]"" $G(HLN(15))
 ;Update status of message
 D STATUS^HLTF0(HLMTIEN,$S($D(HLERR):4,1:3),$S($D(HLERR):+HLRESLT,1:""),$S($D(HLERR):HLERR,1:""),,$S($G(HLERR("SKIP_EVENT"))=1:1,1:0))
EXIT K HLN,HLNEXT,HLNODE,HLQUIT
 Q

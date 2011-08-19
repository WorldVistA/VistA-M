HLTP ;AISC/SAW-Transaction Processor Module ;09/13/2006
 ;;1.6;HEALTH LEVEL SEVEN;**14,43,133**;Oct 13, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
GENERATE(HLMID,HLMTIEN,HLEID,HLARYTYP,HLFORMAT,HLRESLT,HLP) ;Generate an
 ;outgoing message
 ;
 ;This is a subroutine call with parameter passing.  It returns a value
 ;in the variable HLRESLT of null if no error occurs, or the following
 ;two piece value if an error occurs:  error code^error description
 ;
 ;Required Input Parameters
 ;     HLMID = Message ID of message being generated
 ;   HLMTIEN = IEN in Message Text file where message being generated
 ;               will be stored
 ;     HLEID = IEN of event driver protocol in the Protocol file
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
 ;  HLP("SECURITY") = A 1 to 40 character string
 ;   HLP("CONTPTR") = Continuation pointer, a 1 to 180 character string
 ;  HLP("GROUTINE") = The M code to execute to generate the HL7 message
 ;
 S HLRESLT=""
 ;
 ;Check for required parameters
 I '$G(HLMID)!('$G(HLMTIEN))!('$G(HLEID))!($G(HLARYTYP)']"")!($G(HLFORMAT)']"") S HLRESLT="7^"_$G(^HL(771.7,7,0))_" at GENERATE^HLTP entry point" G EXIT
 ;Extract data from file 101 and store in separate variables
 D EVENT^HLUTIL1(HLEID,770,.HLN) S HLSAN=$P($G(^HL(771,+$P(HLN(770),"^"),0)),"^"),HLQ=""""""
 S HLP("MSGTYPE")=$E(HLARYTYP,2)
 ;Update zero node of Message Text file
 D UPDATE^HLTF0(HLMTIEN,HLMTIEN,"O",HLEID,"",+$P(HLN(770),"^"),HLPRIO,"","",.HLP)
 ;Update status to Being Generated
 D STATUS^HLTF0(HLMTIEN,8)
 ;Check that local/global array exists and store in Message Text file
 ; if pre-compiled
 I HLFORMAT D  I +$G(HLRESLT) G EXIT
 .I $E(HLARYTYP)="G" D  I +$G(HLRESLT) D STATUS^HLTF0(HLMTIEN,4,+HLRESLT) Q
 ..I $O(^TMP("HLS",$J,0))']"" S HLRESLT="8^"_$G(^HL(771.7,8,0)) Q
 ..D MERGE^HLTF1("G",HLMTIEN,"HLS")
 .I $E(HLARYTYP)="L" D  I +$G(HLRESLT) D STATUS^HLTF0(HLMTIEN,4,+HLRESLT) Q
 ..I $O(HLA("HLS",0))']"" S HLRESLT="8^"_$G(^HL(771.7,8,0)) Q
 ..D MERGE^HLTF1("L",HLMTIEN,"HLS")
 ;If array is not pre-compiled, call message generation routine
 I 'HLFORMAT N HLERR D  I $D(HLERR) S HLRESLT="9^"_HLERR D STATUS^HLTF0(HLMTIEN,4,9,HLERR) G EXIT
 .S HLP("GROUTINE")=HLP("GROUTINE")_"("_HLMID_","_HLMTIEN_","_HLQ_HLARYTYP_HLQ_","_HLSAN_","_$P($G(^HL(771.2,$P(HLN(770),"^",3),0)),"^")_","_$P($G(^HL(779.001,$P(HLN(770),"^",4),0)),"^")_","_HLQ_$TR($P(HLN(770),"^",6),"id","ID")_HLQ_")"
 .X HLP("GROUTINE")
 ;**CIRN**
 S ZMID=HLMID ; Save original parent message IEN
 I $D(HLL("LINKS")),HLPRIO'="I" D FWD^HLCS2 K HLL
 ;Invoke communication server module to
 ;send message to subscribers
 ;K HLARYTYP,HLFORMAT,HLN,HLP,HLQ
 D SEND^HLCS(HLMTIEN,HLEID,.HLRESLT)
EXIT Q

HLMA1 ;AISC/SAW-Message Administration Module (Cont'd) ;09/13/2006
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,91,109,108,133**;Oct 13, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
GENACK(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,HLRESLTA,HLMTIENA,HLP) ;
 ;Entry point to generate an acknowledgement message
 ;
 ;This is a subroutine call with parameter passing.  It returns a value
 ;in the variable HLRESLTA of null if no error occurs, or the following
 ;two piece value if an error occurs:  error code^error description
 ;
 ;Required Input Parameters
 ;     HLEID = IEN of event driver protocol from the Protocol file
 ;  HLMTIENS = IEN of entry in Message Text file for subscriber
 ;               application
 ;    HLEIDS = IEN of subscriber event from the Protocol file
 ;  HLARYTYP = Array type.  One of the following codes:
 ;               LM = local array containing a single message
 ;               LB = local array containig a batch of messages
 ;               GM = global array containing a single message
 ;               GB = global array containing a batch of messages
 ;  HLFORMAT = Format of array, 1 for pre-formatted in HL7 format,
 ;               otherwise 0
 ;NOTE:  The parameter HLRESLTA must be passed by reference
 ;  HLRESLTA = The variable that will be returned to the calling
 ;               application as descibed above
 ;Optional Parameters
 ;  HLMTIENA = IEN of entry in Message Text file where the
 ;               acknowledgement message will be stored.  This
 ;               parameter is only passed for a batch acknowledgment
 ;  HLP("SECURITY") = A 1 to 40 character string
 ; HLP("NAMESPACE") = Passed in by application namespace - HL*1.6*91
 ;
 ;
 ;HLRESLTA is to return the results and should not be initially defined
 N HLRESLT
 S HLRESLT=""
 K HLRESLTA
 ;
 ;Check for required parameters
 I $G(HLEIDS)']""!('$G(HLMTIENS))!($G(HLARYTYP)']"")!($G(HLFORMAT)']"") S HLRESLTA="0^7^"_$G(^HL(771.7,7,0))_" at GENACK^HLMA1 entry point" G EXIT
 I 'HLEIDS S HLEIDS=$O(^ORD(101,"B",HLEIDS,0)) I 'HLEIDS S HLRESLTA="0^1^"_$G(^HL(771.7,1,0)) G EXIT
 ;Extract data from Protocol file
 D EVENT^HLUTIL1(HLEIDS,"15,20,772",.HLN)
 N HLEXROU,HLMIDAR
 S HLMIDAR=0,HLENROU=$G(HLN(20)),HLEXROU=$G(HLN(15))
 S HLP("GROUTINE")=$G(HLN(772)) K HLN I HLP("GROUTINE")']"",'HLFORMAT S HLRESLTA="0^3^"_$G(^HL(771.7,3,0)) G EXIT
 I "GL"'[$E($G(HLARYTYP)) S HLRESLTA="0^4^"_$G(^HL(771.7,4,0)) G EXIT
 I '$D(HLP("SECURITY")) S HLP("SECURITY")=""
 I $L(HLP("SECURITY"))>40 S HLRESLTA="0^6^"_$G(^HL(771.7,6,0)) G EXIT
 ;$D(HLTCP) tcp connection will be used
 I $D(HLTCP) D GENACK^HLTP4 G EXIT
 ;Create message ID and Message Text IEN if Message Text IEN not
 ;previously created ('$G(HLMTIENA))
 I '$G(HLMTIENA) D CREATE^HLTF(.HLMIDA,.HLMTIENA,.HLDTA,.HLDT1A)
 ;Get message ID if Message Text IEN not already created
 I '$G(HLMIDA) D
 .S HLDTA=$G(^HL(772,HLMTIENA,0))
 .S HLDT1A=$$HLDATE^HLFNC(+HLDTA),HLMIDA=$P(HLDTA,"^",6),HLDTA=+HLDTA
 S HLRESLTA=HLMIDA,HLP("DTM")=HLDT1A,HLP("DT")=HLDTA,HLP("MTIENS")=HLMTIENS,HLP("EID")=HLEID
 ;Execute entry action for subscriber protocol
 I HLENROU]"" X HLENROU
 ;Invoke transaction processor to generate acknowledgement
 K HLDTA,HLDT1A,HLEID,HLENROU,HLMTIENS
 S HLRESLT=""
 D GENACK^HLTP1(HLMIDA,HLMTIENA,HLEIDS,HLARYTYP,HLFORMAT,.HLRESLT,.HLP)
 ;HLMIDAR is array of message IDs, only set for broadcast messages
 I HLMIDAR K HLMIDAR("N") M HLRESLTA=HLMIDAR
 S HLRESLTA=HLRESLTA_"^"_HLRESLT
 ;Update status to Awaiting Acknowledgement or Error in Transmission
 D STATUS^HLTF0(HLMTIENA,$S($P(HLRESLTA,"^",2):4,1:3),$S($P(HLRESLTA,"^",2):$P(HLRESLTA,"^",2),1:""),$S($P(HLRESLTA,"^",2):$P(HLRESLTA,"^",3),1:""))
 ;Execute exit action for subscriber protocol
 X:HLEXROU]"" HLEXROU
EXIT K HLDTA,HLDT1A,HLMIDA,HLENROU,HLEXROU
 Q

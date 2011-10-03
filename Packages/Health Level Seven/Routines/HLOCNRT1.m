HLOCNRT1 ;ALB/CJM-Generate HL7 Optimized Message ;12/02/2008
 ;;1.6;HEALTH LEVEL SEVEN;**139**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
HLO(PARAMETERS,TRANSFORM) ;
 ;INPUT -
 ;    PARMAMETERS (optional,pass by reference) The following parameters, 
 ;         if specififed, will override what is specied by the Event and
 ;         Subscriber Protocols.
 ;
 ;  "ACCEPT ACK RESPONSE")=<tag^routine> to call when the commit ack is received (optional)
 ;  "ACCEPT ACK TYPE") = <AL,NE>
 ;  "APP ACK TYPE") = <AL,NE>
 ;  "COUNTRY")=3 character country code
 ;  "CONTINUATION POINTER" -indicates a fragmented message
 ;  "EVENT")=3 character event type
 ;  "FAILURE RESPONSE" - <tag>^<routine> The sending application routine to execute when the transmission of the message fails, i.e., the message can not be sent or no commit ack is received.
 ;  "MESSAGE STRUCTURE" - MSH 9, component 3 - a code from the standard HL7 table
 ;  "MESSAGE TYPE")=3 character message type
 ;  "PROCESSING MODE" - MSH 11, component 2 - a 1 character code
 ;  "QUEUE" - An application can name its own private queue -just a string up to 20 characters, it should be namespaced.
 ;  "SECURITY")=security information to include in the header segment, SEQ 8
 ;  "SEQUENCE QUEUE") The sequence queue to use, up to 30 characters. It should be namespaced.  Requires that application acks be used.
 ;  "SENDING APPLICATION")=name of sending app (60 maximum length)
 ;  "VERSION")=the HL7 Version ID, for example, "2.4"
 ;
 ;     
 ;    TRANSFORM (optional) A routine that will transform the message
 ;          before the message is sent. The routine must 
 ;          have a formal parameter to received the name of the 
 ;          array that contains the message. The array may be either
 ;          local or global.The application references the array
 ;          by indirection to add, edit, or delete segments. The
 ;          application may decide not to send the message, in which
 ;          case it should delete the message array.
 ;       
 ;          An application's TRANSFORM routine can loop through the 
 ;          segments in the message in this way:
 ;          1) The application's TRANSFORM routine should be defined
 ;             to accept an input parameter.  HLO will set the parameter
 ;             to the name of an array that contains the message, one 
 ;             segment per subscript:
 ;               
 ;             MSG(1)=<first segment>
 ;             MSG(2)=<second segment>
 ;              etc.
 ;      
 ;           2) The application's TRANSFORM routine should loop through
 ;              the message array using indirection:
 ;  
 ;              S I=0 F  S I=$O(@MSG@(I)) Q:'I  D <process the segment>
 ;
 ;              *Note:  MSG is show here, but the name of of the variable
 ;               is actually whatever the application routine defined as
 ;               its formal input parameter.
 ;
 ;            3) The segment value is obtained by:
 ;               S SEGMENT=$G(@MSG@(I)) D <process the segment>
 ;
 ;            4) These variables are defined for the application to use
 ;               in parsing segments:
 ;
 ;               FS  - field separator
 ;               CS  - component separator
 ;               SUB - subcomponent separator
 ;               REP - repitition separator
 ;               ESC - escape character 
 ;
 ;
 ;    !!!  CAUTION: This API currently has these limitations: !!!
 ;         1) Each individual segment must fit in a single node.
 ;         2) It can not be used for batch messages.
 ;
 ;OUTPUT:
 ;   Function returns:
 ;           - 0:if the message is not forwarded
 ;           - message ien, file 778: if the message is forwarded
 ;
 ;      Example 1: The application wants to subscribe to an existing
 ;         message produced by the old HL7 1.6 set of messaging APIs,
 ;         but it wants to route the messages via HLO.
 ;         To accomplish that the application needs to create a
 ;         new subscriber protocol with this M code to the ROUTING LOGIC:
 ;          
 ;             D HLO^HLOCNRT1()
 ;        
 ;      Example 2:  Same as example 1, except that the application would
 ;      like to:
 ;   - Change the version of the message to 2.4
 ;   - Strip out the Z segments from the message before sending it. To
 ;     do so, it may devise the following routine:
 ;
 ;      ZSTRIP^ZZRTN(MSG) ;
 ;      N I S I=0
 ;      F  S I=$O(@MSG@(I)) Q:'I  D
 ;      .I $E(@MSG@(I),1)="Z" K @MSG@(I)
 ;      Q
 ;
 ;  Here is the ROUTING LOGIC for the new subscriber protocol:
 ;         
 ;     N PARMS S PARMS("VERSION")=2.4 I $$HLO^CNRT1(.PARMS,"STRIPZ^ZZRTN")
 ;
 ;  Output: none
 ;
 N HLMSTATE,PARMS,WHO,EVENT,SUBSCRIBER,MARY,SUB
 ;
 ;
 S EVENT=$G(HLEID)
 Q:'EVENT 0
 S SUBSCRIBER=$G(HLEIDS)
 Q:'SUBSCRIBER 0
 ;
 Q:'$$GETPARMS(EVENT,SUBSCRIBER,.PARMS,.WHO) 0
 ;
 ;accept parameters passed in via PARMETERS
 F SUB="COUNTRY","CONTINUATION POINTER","EVENT","MESSAGE TYPE","PROCESSING MODE","MESSAGE STRUCTURE","VERSION" I $D(PARAMETERS(SUB)) S PARMS(SUB)=$G(PARAMETERS(SUB))
 ;
 Q:'$$NEWMSG^HLOAPI(.PARMS,.HLMSTATE,.ERROR) 0
 ;
 ;
 ;if there is transform logic, copy the message to a workspace and execute the transform
 I $L($G(TRANSFORM)) D
 .N FROM,I,J
 .I $E($G(HLARYTYP),1)="G" S FROM="^TMP(""HLS"",$J)",MARY="^TMP(""HLO"",$J)"
 .I $E($G(HLARYTYP),1)="L" S FROM="HLA(""HLS"")",MARY="HLA(""HLO"")"
 .Q:'$L($G(MARY))
 .S I=0
 .F  S I=$O(@FROM@(I)) Q:'I  D
 ..S @MARY@(I)=$G(@FROM@(I))
 ..S J=0
 ..F  S J=$O(@MARY@(I,J)) Q:'J  S @MARY@(I)=@MARY@(I)_$G(@FROM@(I,J))
 .;
 .;execute the applications transform logic
 .D
 ..N FS,CS,SUB,REP,ESC,NODE
 ..S NODE=HLMSTATE("HDR","ENCODING CHARACTERS")
 ..S FS=HLMSTATE("HDR","FIELD SEPARATOR")
 ..S CS=$E(NODE,1)
 ..S REP=$E(NODE,2)
 ..S ESC=$E(NODE,3)
 ..S SUB=$E(NODE,4)
 ..X "D "_TRANSFORM_"(MARY)"
 .;
 .;if the application chose not to subscribe, delete the message array
 .I '$D(@MARY) K MARY Q
 .;Move the existing message from array into HL0
 .D MOVEMSG^HLOAPI(.HLMSTATE,MARY)
 .K @MARY
 E  D
 .I $E($G(HLARYTYP),1)="G" S MARY="^TMP(""HLS"",$J)"
 .I $E($G(HLARYTYP),1)="L" S MARY="HLA(""HLS"")"
 .Q:'$L($G(MARY))
 .;Move the existing message from array into HL0
 .D MOVEMSG^HLOAPI(.HLMSTATE,MARY)
 Q:'$L($G(MARY)) 0
 ;
 ;
 ;accept parameters passed in via PARAMETERS
 F SUB="APP ACK RESPONSE","ACCEPT ACK RESPONSE","ACCEPT ACK TYPE","APP ACK TYPE","FAILURE RESPONSE","QUEUE","SECURITY","SEQUENCE QUEUE","SENDING APPLICATION" I $D(PARAMETERS(SUB)) S PARMS(SUB)=$G(PARAMETERS(SUB))
 ;
 Q $$SENDONE^HLOAPI1(.HLMSTATE,.PARMS,.WHO)
 ;
GETPARMS(EVENT,SUBSCRIBER,PARMS,WHO) ;  Set up PARMS & WHO arrays from Protocols
 K PARMS,WHO
 N NODE,APP,LINK
 S NODE=$G(^ORD(101,EVENT,770))
 S PARMS("EVENT")=$P(NODE,"^",4),PARMS("EVENT")=$S(PARMS("EVENT"):$P($G(^HL(779.001,PARMS("EVENT"),0)),"^"),1:"")
 S PARMS("MESSAGE TYPE")=$P(NODE,"^",3),PARMS("MESSAGE TYPE")=$S(PARMS("MESSAGE TYPE"):$P($G(^HL(771.2,PARMS("MESSAGE TYPE"),0)),"^"),1:"")
 S PARMS("APP ACK TYPE")=$P(NODE,"^",9),PARMS("APP ACK TYPE")=$S(PARMS("APP ACK TYPE"):$P($G(^HL(779.003,PARMS("APP ACK TYPE"),0)),"^"),1:"")
 S PARMS("ACCEPT ACK TYPE")=$P(NODE,"^",8),PARMS("ACCEPT ACK TYPE")=$S(PARMS("ACCEPT ACK TYPE"):$P($G(^HL(779.003,PARMS("ACCEPT ACK TYPE"),0)),"^"),1:"")
 S PARMS("VERSION")=$P(NODE,"^",10),PARMS("VERSION")=$S(PARMS("VERSION"):$P($G(^HL(771.5,PARMS("VERSION"),0)),"^"),1:"")
 S PARMS("SENDING APPLICATION")=$P(NODE,"^")
 I PARMS("SENDING APPLICATION") D
 .N COUNTRY
 .S COUNTRY=$P($G(^HL(771,PARMS("SENDING APPLICATION"),0)),"^",7)
 .I $L(COUNTRY) S COUNTRY=$P($G(^HL(779.004,COUNTRY,0)),"^")
 .S PARMS("COUNTRY")=$G(COUNTRY)
 .S PARMS("FIELD SEPARATOR")=$E($G(^HL(771,PARMS("SENDING APPLICATION"),"FS")),1)
 .S:PARMS("FIELD SEPARATOR")="" PARMS("FIELD SEPARATOR")="^"
 .S PARMS("ENCODING CHARACTERS")=$E($G(^HL(771,PARMS("SENDING APPLICATION"),"EC")),1,4)
 .S:PARMS("ENCODING CHARACTERS")="" PARMS("ENCODING CHARACTERS")="~|\&"
 .S PARMS("SENDING APPLICATION")=$P($G(^HL(771,PARMS("SENDING APPLICATION"),0)),"^")
 .I PARMS("SENDING APPLICATION")'="",'$O(^HLD(779.2,"C",PARMS("SENDING APPLICATION"),0)) D
 ..;add the sending applcation to the registry
 ..N DATA,ERROR
 ..S DATA(.01)=PARMS("SENDING APPLICATION")
 ..S DATA(2)=$P($G(^ORD(101,HLEID,0)),"^",12)
 ..I $$ADD^HLOASUB1(779.2,,.DATA,.ERROR)
 E  D
 .S PARMS("SENDING APPLICATION")=""
 .S PARMS("FIELD SEPARATOR")="^"
 .S PARMS("ENCODING CHARACTERS")="~|\&"
 ;
 S NODE=$G(^ORD(101,SUBSCRIBER,770))
 S APP=$P(NODE,"^",2)
 Q:'APP 0
 S LINK=$P(NODE,"^",7)
 Q:'LINK 0
 S WHO("RECEIVING APPLICATION")=$P($G(^HL(771,APP,0)),"^")
 S WHO("FACILITY LINK NAME")=$P($G(^HLCS(870,LINK,0)),"^")
 Q 1
STRIPZ(MSG) ;strips the Z segments from the message
 N I S I=0
 F  S I=$O(@MSG@(I)) Q:'I  D
 .I $E(@MSG@(I),1)="Z" K @MSG@(I)
 Q

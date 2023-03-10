RAHLROUT ;HIRMFO/CRT - Rad/Nuc Med HL7 Interfaces Routing Logic; Aug 28, 2020@10:06:28
 ;;5.0;Radiology/Nuclear Medicine;**25,173**;Mar 16, 1998;Build 1
 ;
RADIV ; Get the Division from the HL7 message, Piece 3 of Piece 21 of OBR.
 ;
 I '$D(HL("FS")) D  ;p173/KLM HL array may have been killed except HL("EIDS")
 .S HL="HLS(""HLS"")"
 .D INIT^HLFNC2($G(RAEID),.HL,$G(INT))
 .Q
 N I,J,RAPC,RAHLAPP
 S RADVSN=0,RAPC=$S(HL("VER")>2.3:22,1:21) ;p173 division moved to OBR21 in v2.4
 I HL("VER")>2.3 N RAECH S RAECH="`"
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D  Q:RADVSN
 .Q:$P(HLNODE,HL("FS"))'="OBR"
 .I $L(HLNODE,HL("FS"))>RAPC D
 ..N X
 ..S X=$P(HLNODE,HL("FS"),RAPC)
 ..D FORMAT^RAHLTCPB
 ..S RADVSN=$S(HL("VER")>2.3:+$P(X,RAECH,3),1:$P(X,$E(HL("ECH")),3)) ;p173 non-standard dilimiter used in v2.4
 ..Q
 .;p173 HLNODE could be split ON the piece we need
 .I $L(HLNODE,HL("FS"))<RAPC D
 ..N RANODE M RANODE=HLNODE
 ..S J=0 F  S J=$O(RANODE(J)) Q:'J  D  Q:$L(RANODE(J),HL("FS"))>RAPC
 ...S RANODE=RANODE_RANODE(J)
 ...Q
 ..N X
 ..S X=$P(RANODE,HL("FS"),RAPC)
 ..D FORMAT^RAHLTCPB
 ..S RADVSN=$S(HL("VER")>2.3:+$P(X,RAECH,3),1:$P(X,$E(HL("ECH")),3)) ;p173 non-standard dilimiter used in v2.4
 ..Q
 .Q
 ;
RAHLL ; Check field .129 in Division File #79 for specific interfaces.
 ; 
 ; If Receiving App listed as interface for this division, set and quit.
 ;
 S RAHLAPP=$P($G(^ORD(101,+HL("EIDS"),770)),"^",2)
 Q:'RAHLAPP
 I $D(^RA(79,+RADVSN,"HL7","B",+RAHLAPP)) D LINK(HL("EIDS")) Q
 ;
 ; Otherwise just QUIT, no message will be created for this SUBSCRIBER.
 Q
 ;
LINK(IEN) ;  Return LINK information for subscriber
 ; INPUT  - IEN: IEN of protocol file
 ; OUTPUT - SUBSCRIBER PROTOCOL^LOGICAL LINK in HLL("LINKS",1)
 ;
 S IEN=$G(IEN) Q:(IEN="")
 ;
 ;  Make sure this is a subscriber type
 Q:$P($G(^ORD(101,IEN,0)),"^",4)'="S"
 ;
 S HLL("LINKS",1)=$P(^ORD(101,IEN,0),"^")_"^"_$P($G(^HLCS(870,+$P(^ORD(101,IEN,770),"^",7),0)),"^")
 Q

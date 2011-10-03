RAHLROUT ;HIRMFO/CRT - Rad/Nuc Med HL7 Interfaces Routing Logic
 ;;5.0;Radiology/Nuclear Medicine;**25**;Mar 16, 1998
 ;
RADIV ; Get the Division from the HL7 message, Piece 3 of Piece 21 of OBR.
 ;
 N I,J,RAPC,RAHLAPP
 S RADVSN=0,RAPC=21
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D  Q:RADVSN
 .Q:$P(HLNODE,HL("FS"))'="OBR"
 .I $L(HLNODE,HL("FS"))'<RAPC D
 ..N X
 ..S X=$P(HLNODE,HL("FS"),RAPC)
 ..D FORMAT^RAHLTCPB
 ..S RADVSN=$P(X,$E(HL("ECH")),3)
 .I $L(HLNODE,HL("FS"))<RAPC D
 ..S RAPC=RAPC+1-$L(HLNODE,HL("FS"))
 ..S J=0 F  S J=$O(HLNODE(J)) Q:'J  Q:$L(HLNODE(J),HL("FS"))'<RAPC  D
 ...S RAPC=RAPC+1-$L(HLNODE(J),HL("FS"))
 ..N X
 ..S X=$P(HLNODE(J),HL("FS"),RAPC)
 ..D FORMAT^RAHLTCPB
 ..S RADVSN=$P(X,$E(HL("ECH")),3)
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

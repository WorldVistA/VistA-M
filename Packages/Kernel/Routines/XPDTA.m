XPDTA ;SFISC/RSD - Build Actions for Kernel Files ;02/14/2006
 ;;8.0;KERNEL;**15,44,58,131,229,393,498,539**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;^XTMP("XPDT",XPDA,"KRN",FILE,DA) is the global root
 ;DA=ien in ^XTMP,XPDNM=package name, XPDA=package ien in ^XPD(9.6,
OPT ;options
 N %,%1,%2
 ;if link, kill everything and just process the menu items
 I XPDFL=2 D  G OPTT
 .S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",19,DA,%)) Q:'%  K:%'=10 ^(%)
 ;resolve Package (0;12), remove Creator (0;5)
 S %=^XTMP("XPDT",XPDA,"KRN",19,DA,0),$P(%,U,12)=$$PT("^DIC(9.4)",$P(%,U,12)),$P(%,U,5)=""
 ;resolve Help Frame (0;7), kill Permitted Devices (3.96;0) & queue node (200)
 S $P(%,U,7)=$$PT("^DIC(9.2)",$P(%,U,7)),^XTMP("XPDT",XPDA,"KRN",19,DA,0)=% K ^(3.96),^(200)
 ;resolve Server Bulletin (220;1), Server Mailgroup (220;3)
 I $D(^XTMP("XPDT",XPDA,"KRN",19,DA,220)) S %=^(220),$P(%,U)=$$PT("^XMB(3.6)",+%),$P(%,U,3)=$$PT("^XMB(3.8)",$P(%,U,3)),^XTMP("XPDT",XPDA,"KRN",19,DA,220)=%
 ;resolve RPC (RPC;0), must be type Broker
 I $D(^XTMP("XPDT",XPDA,"KRN",19,DA,"RPC")) K:$P(^(0),U,4)'="B" ^("RPC") D
 .;kill  "B"=name x-ref, it will be re-indexed when installed
 .K ^XTMP("XPDT",XPDA,"KRN",19,DA,"RPC","B")
 .;loop thru RPCs and resolve (RPC;1)
 .S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",19,DA,"RPC",%)) Q:'%  S %1=$G(^(%,0)) D
 ..S %2=$$PT("^XWB(8994)",+%1)
 ..;if can't resolve then delete
 ..I %2="" K ^XTMP("XPDT",XPDA,"KRN",19,DA,"RPC",%,0) Q
 ..;save the RPC name
 ..S $P(^XTMP("XPDT",XPDA,"KRN",19,DA,"RPC",%,0),U)=%2
 .Q
OPTT ;Menus can only exist for options of type: menu,protocol,protocol menu,
 ;extended action, limited, window suite
 I "LMOQXZ"'[$P(^XTMP("XPDT",XPDA,"KRN",19,DA,0),U,4) K ^(10) Q
 ;kill  "B"=name, "C"=synonyms x-ref, it will be re-indexed when installed
 K ^XTMP("XPDT",XPDA,"KRN",19,DA,10,"B"),^("C")
 ;loop thru 10=Menus and resolve Menu (10;1), kill if it doesn't resolve
 S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",19,DA,10,%)) Q:'%  S %1=$G(^(%,0)) D
 .S %2=$$PT("^DIC(19)",+%1)
 .;items must be sent by themselves, check "B" x-ref
 .I $L(%2),$D(^XPD(9.6,XPDA,"KRN",19,"NM","B",%2)) S ^XTMP("XPDT",XPDA,"KRN",19,DA,10,%,U)=%2 Q
 .;if I couldn't resolve this option, then kill it
 .K ^XTMP("XPDT",XPDA,"KRN",19,DA,10,%)
 Q
 ;
PRO ;protocols
 N %,%1,%2
 ;if link, kill everything and just process the item(10) and subscribers (775) multiples
 I XPDFL=2 D  G PROT
 .S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",101,DA,%)) Q:'%  K:%'=10&(%'=775) ^(%)
 ;resolve Package (0;12), remove Creator (0;5)
 S %=^XTMP("XPDT",XPDA,"KRN",101,DA,0),$P(%,U,12)=$$PT("^DIC(9.4)",$P(%,U,12)),$P(%,U,5)=""
 ;kill under Menus (10), "B"=name, "C"=synonyms
 S ^XTMP("XPDT",XPDA,"KRN",101,DA,0)=%
 ;resolve File Link (5;1), its a variable pointer
 S %=$P($G(^XTMP("XPDT",XPDA,"KRN",101,DA,5)),U),%1=$P(%,";",2)
 I %,$D(@("^"_%1_+%_",0)")) S $P(^XTMP("XPDT",XPDA,"KRN",101,DA,5),U)=$P(^(0),U)_";"_%1
 ;resolve HL7 fields, node 770
 S %=$G(^XTMP("XPDT",XPDA,"KRN",101,DA,770)) I $L(%) D  S ^XTMP("XPDT",XPDA,"KRN",101,DA,770)=%
 .S $P(%,U)=$$PT("^HL(771)",$P(%,U)),$P(%,U,2)=$$PT("^HL(771)",$P(%,U,2))
 .S $P(%,U,3)=$$PT("^HL(771.2)",$P(%,U,3)),$P(%,U,11)=$$PT("^HL(771.2)",$P(%,U,11))
 .S $P(%,U,4)=$$PT("^HL(779.001)",$P(%,U,4)),$P(%,U,7)=$$PT("^HLCS(870)",$P(%,U,7))
 .S $P(%,U,8)=$$PT("^HL(779.003)",$P(%,U,8)),$P(%,U,9)=$$PT("^HL(779.003)",$P(%,U,9))
 .S $P(%,U,10)=$$PT("^HL(771.5)",$P(%,U,10))
PROT ;loop thru 10=ITEM and 775=SUBSCRIBER and resolve Menu (10;1), kill if it doesn't resolve
 ;kill under Menus (10), "B"=name, "C"=synonyms
 I $D(^XTMP("XPDT",XPDA,"KRN",101,DA,10,0)) K ^("B"),^("C")
 S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",101,DA,10,%)) Q:'%  S %1=$G(^(%,0)) D
 .;%2=.01 of Menu(protocol)
 .S %2=$$PT("^ORD(101)",+%1)
 .;Menu must also be sent by itself, check "B" x-ref
 .I $L(%2),$D(^XPD(9.6,XPDA,"KRN",101,"NM","B",%2)) S ^XTMP("XPDT",XPDA,"KRN",101,DA,10,%,U)=%2,$P(^XTMP("XPDT",XPDA,"KRN",101,DA,10,%,0),U,4)=$$PT("^ORD(101)",$P(%1,U,4)) Q
 .K ^XTMP("XPDT",XPDA,"KRN",101,DA,10,%)
 ;If type is Event Driver and sending Subscribers (775)
 I $P(^XTMP("XPDT",XPDA,"KRN",101,DA,0),U,4)="E" D
 . ;kill Menu multiple and Subscriber x-ref "B"=name
 . K ^XTMP("XPDT",XPDA,"KRN",101,DA,10),^(775,"B")
 . ;loop thru 775=Subscribers and resolve pointer (775;1)
 . S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",101,DA,775,%)) Q:'%  S %1=$G(^(%,0)) D
 .. ;%2=.01 of subscriber(protocol)
 .. S %2=$$PT("^ORD(101)",+%1)
 .. ;protocol must also be sent by itself, check "B" x-ref
 .. I $L(%2),$D(^XPD(9.6,XPDA,"KRN",101,"NM","B",%2)) S ^XTMP("XPDT",XPDA,"KRN",101,DA,775,%,U)=%2 Q
 .. K ^XTMP("XPDT",XPDA,"KRN",101,DA,775,%)
 ;quit if no Access multiple
 Q:'$D(^XTMP("XPDT",XPDA,"KRN",101,DA,3,0))  K ^("B")
 ;loop thru Access and resolve (3;1), kill if it doesn't resolve
 S %=0 F  S %=$O(^XTMP("XPDT",XPDA,"KRN",101,DA,3,%)) Q:'%  S %1=$G(^(%,0)) D
 .;%2=.01 of Menu(protocol)
 .S %2=$$PT("^DIC(19.1)",+%1)
 .I $L(%2) S ^XTMP("XPDT",XPDA,"KRN",101,DA,3,%,0)=%2 Q
 .K ^XTMP("XPDT",XPDA,"KRN",101,DA,3,%)
 Q
 ;
RTNE ;routine entry build action
 N %,X,XPD
 ;move routine to ^XTMP("XPDT",DPK1,"RTN",routine name
 ;routines will have the checksum in XTMP("XPDT",XPDA,"RTN",X) & in
 ;Build file
 S X=$P(^XTMP("XPDT",XPDA,"KRN",9.8,DA,0),U),XPD=^(-1)
 Q:X=""  S %=$$LOAD(X,XPD),$P(^XPD(9.6,XPDA,"KRN",9.8,"NM",+$P(XPD,U,2),0),U,4)=%
 K ^XTMP("XPDT",XPDA,"KRN",9.8,DA)
 Q
 ;
RTNF ;routine file build action
 N X,Y,% S Y=0
 ;the routines that are left in XTMP("XPDT",XPDA,"KRN",9.8) are to be
 ;deleted at site, move name field to RTN node
 F  S Y=$O(^XTMP("XPDT",XPDA,"KRN",9.8,Y)) Q:'Y  S %=^(Y,-1),X=^(0) D
 .I +%=1 S ^XTMP("XPDT",XPDA,"RTN",X)=%,^("RTN")=$G(^XTMP("XPDT",XPDA,"RTN"))+1
 ;kill everything
 K ^XTMP("XPDT",XPDA,"KRN",9.8)
 Q
 ;
PT(GR,DA) ;GR=file global ref, DA=ien, return .01 value
 Q:'DA ""
 Q:GR="" ""
 I $D(@GR@(+DA,0))#2 Q $P(^(0),U)
 Q ""
 ;
GR(FN) ;returns closed global root, FN=file number
 N Y
 Q:'$G(FN) ""
 S Y=$G(^DIC(FN,0,"GL")) Q:Y="" ""
 Q $E(Y,1,($L(Y)-1))_$S($L(Y,",")>1:")",1:"")
 ;
LOAD(X,XPD) ;load routine X, XPD=action^ien in Build file
 ;XPD = 0-load, 1-delete, 2-skip, returns checksum
 ;quit if routine is already saved
 Q:$D(^XTMP("XPDT",XPDA,"RTN",X)) $P(^(X),U,3)
 N DIF,XCNP,%N,%A,FDA,IEN,LN2
 S DIF="^XTMP(""XPDT"",XPDA,""RTN"",X,",XCNP=0
 X ^%ZOSF("LOAD")
 S $P(^XTMP("XPDT",XPDA,"RTN",X,2,0),";",7)="Build "_(+^XPD(9.6,XPDA,6.3)),LN2=^XTMP("XPDT",XPDA,"RTN",X,2,0)
 S IEN=$$FIND1^DIC(9.8,"","X",X)
 ;^XTMP("XPDT",XPDA,"RTN",X)=action^ien in Build^checksum
 S %N="B"_$$SUMB^XPDRSUM($NA(^XTMP("XPDT",XPDA,"RTN",X)))
 S $P(XPD,"^",3)=%N ;Make sure the Checksum is in the 3rd piece
 S ^XTMP("XPDT",XPDA,"RTN",X)=XPD
 ;update count node
 S ^("RTN")=$G(^XTMP("XPDT",XPDA,"RTN"))+1
 N XUA,XUB S (XUA,XUB)=""
 ;Update Dev Patch field in Routine file
 I IEN D
 . S XUB=$P(XPDT(XPDT),U,2) S:XUB["*" $P(XUB,"*",2)=+$P(XUB,"*",2)
 . S IEN="?+2,"_IEN_",",FDA(9.819,IEN,.01)=XUB
 . S FDA(9.819,IEN,2)=%N,FDA(9.819,IEN,3)=$P(LN2,";",5)
 . D UPDATE^DIE("","FDA","IEN")
 Q %N

XPDIA ;SFISC/RSD - Install Pre/Post Actions for Kernel Files ;03/27/2000  12:58
 ;;8.0;KERNEL;**10,15,21,28,44,58,68,131,145**;Jul 10, 1995
 Q
OPTF1 ;options file pre
 K ^TMP($J,"XPD")
 Q
OPTE1 ;options entry pre
 N %,I
 ;XPDFL= 0-send,1-delete,2-link,3-merge,4-attach,5-disable
 ;attach & disable never get here
 S ^TMP($J,"XPD",DA)=XPDFL
 ;if Menu linking or merge save menu mult. and process in FPOS code
 I XPDFL>1 M ^TMP($J,"XPD",DA,10)=^XTMP("XPDI",XPDA,"KRN",19,OLDA,10) K ^XTMP("XPDI",XPDA,"KRN",19,OLDA,10)
 ;if Menu link, XPDQUIT prevents data merge
 I XPDFL=2 S XPDQUIT=1 Q
 ;if this is new to the site then disable and quit
 I $G(XPDNEW) D:XPDSET  Q
 .;quit if option already has out of order msg.
 .Q:$P(^XTMP("XPDI",XPDA,"KRN",19,OLDA,0),U,3)]""
 .S $P(^XTMP("XPDI",XPDA,"KRN",19,OLDA,0),U,3)=$P(XPDSET,U,3)
 .D ADD^XQOO1($P(XPDSET,U,2),19,DA)
 S I=^XTMP("XPDI",XPDA,"KRN",19,OLDA,0),%=^DIC(19,DA,0)
 ;$P(%,U,3)=out of order message, keep sending ooo msg
 S:$P(I,U,3)="" $P(I,U,3)=$P(%,U,3)
 ;if there is no new Security Key, save the old Key
 S:$P(I,U,6)="" $P(I,U,6)=$P(%,U,6)
 ;if there is no reverse key, save the old key and flag
 I $P($G(^XTMP("XPDI",XPDA,"KRN",19,OLDA,3)),U)="",$L($P($G(^DIC(19,DA,3)),U)) S $P(I,U,16)=$P(%,U,16),$P(^XTMP("XPDI",XPDA,"KRN",19,OLDA,3),U)=$P(^(3),U)
 S ^XTMP("XPDI",XPDA,"KRN",19,OLDA,0)=I
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",19,OLDA,1,0)) ^DIC(19,DA,1)
 ;kill old RCPs (RPC)
 K ^DIC(19,DA,"RPC")
 ;if Menu Text, (U;1) is different, kill C x-ref
 S I=$G(^DIC(19,DA,"U")) I I]"",I'=$G(^XTMP("XPDI",XPDA,"KRN",19,OLDA,"U")) K ^DIC(19,"C",I)
 S I=0
 ;XPDFL=3-merge menu items, Quit
 ;the new menu items have already been saved into ^TMP, will restore in
 ;the file post action as a relink
 Q:XPDFL=3
 ;we are replacing menu items, kill the old.
 ;loop thru and kill "AD" x-ref., it will be reset with new options
 F  S I=$O(^DIC(19,DA,10,I)) Q:'I  S %=+$G(^(I,0)) K:% ^DIC(19,"AD",%,DA,I)
 ;kill Menus (10)
 K ^DIC(19,DA,10)
 Q
OPTF2 ;options file post
 N ACT,DA,DIK,I,X,Y,Y0
 ;loop thru all the new incomming options
 S DA=0,DIK=DIC F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  S ACT=^(DA) D
 .;if use as link then goto OPTFL, just update menus
 .G:ACT=2 OPTFL
 .;repoint Bulletin (220;1) and Mail Group (220;3)
 .S Y0=$G(^DIC(19,DA,220)) I Y0]"" S $P(Y0,U)=$$LK("^XMB(3.6)",$P(Y0,U)),$P(Y0,U,3)=$$LK("^XMB(3.8)",$P(Y0,U,3)),^DIC(19,DA,220)=Y0
 .;repoint RPC (RPC;1)
 .S (I,X)=0 F  S I=$O(^DIC(19,DA,"RPC",I)) Q:'I  S Y0=$P($G(^(I,0)),U) D
 ..S Y=$$LK("^XWB(8994)",Y0)
 ..I 'Y K ^DIC(19,DA,"RPC",I) D BMES^XPDUTL(" RPC "_Y0_" in Option "_$P(^DIC(19,DA,0),U)_" **NOT FOUND**") Q
 ..S $P(^DIC(19,DA,"RPC",I,0),U)=Y,X=I_U_(X+1)
 .S:X $P(^DIC(19,DA,"RPC",0),U,3,4)=X
 .;repoint Package (0;12) and Help Frame (0;7)
 .S Y0=^DIC(19,DA,0),$P(Y0,U,12)=$$LK("^DIC(9.4)",$P(Y0,U,12)),$P(Y0,U,7)=$$LK("^DIC(9.2)",$P(Y0,U,7)),^DIC(19,DA,0)=Y0
OPTFL .;need to loop through ^TMP($J,"XPD",DA,10,I) these are menus that need to be
 .;merged, they could also be linked menu, but treat like merge
 .S I=0 F  S I=$O(^TMP($J,"XPD",DA,10,I)) Q:'I  S Y0=$G(^(I,0)),X=$G(^(U)) D:X]"" MENU(DA,X,Y0)
 .;loop thru Menu and repoint Option (0;1), text is on ^(U) node
 .;also need to recount all menus and reset zeroth node, use X
 .S (I,X)=0 F  S I=$O(^DIC(19,DA,10,I)) Q:'I  S Y0=$G(^(I,U)) D
 ..I $L(Y0) D  Q:'Y
 ...S Y=$$LK("^DIC(19)",Y0)
 ...K ^DIC(19,DA,10,I,U)
 ...I 'Y K ^DIC(19,DA,10,I) D BMES^XPDUTL(" Option "_Y0_" in Menu "_$P(^DIC(19,DA,0),U)_" **NOT FOUND**") Q
 ...S $P(^DIC(19,DA,10,I,0),U)=Y
 ..S X=I_U_(X+1)
 .S:X $P(^DIC(19,DA,10,0),U,3,4)=X
 .;re-index this option
 .D IX1^DIK
 K ^TMP($J,"XPD")
 Q
OPTDEL ;option delete
 D DEL("^DIC(19,",DUZ)
 D OPT^XPDIA2
 Q
PROF1 ;protocols file pre
 K ^TMP($J,"XPD")
 Q
PROE1 ;protocols entry pre
 G PROE1^XPDIA0
 ;
PROF2 ;protocols file post
 N ACT,DA,DIK,I,X,Y,Y0
 ;loop thru all the new incomming protocols
 S DA=0,DIK=DIC F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  S ACT=^(DA) D
 .;if use as link then goto PROFL, just update menus
 .G:ACT=2 PROFL
 .;repoint Package (0;12)
 .S Y0=^ORD(101,DA,0) S:$L($P(Y0,U,12)) $P(Y0,U,12)=$$LK("^DIC(9.4)",$P(Y0,U,12)),^ORD(101,DA,0)=Y0
 .;repoint File Link (5;1), its a variable pointer
 .S Y0=$P($G(^ORD(101,DA,5)),U),Y=$P(Y0,";",2),Y0=$P(Y0,";")
 .I Y0,$L(Y) S Y0=$O(@("^"_Y_"""B"","""_Y0_""",0)")),$P(^ORD(101,DA,5),U)=$S(Y0:Y0_";"_Y,1:"")
 .;repoint HL7 fields, node 770
 .S Y0=$G(^ORD(101,DA,770)) I $L(Y0) D  S ^ORD(101,DA,770)=Y0
 ..S $P(Y0,U)=$$LK("^HL(771)",$P(Y0,U)),$P(Y0,U,2)=$$LK("^HL(771)",$P(Y0,U,2))
 ..S $P(Y0,U,3)=$$LK("^HL(771.2)",$P(Y0,U,3)),$P(Y0,U,11)=$$LK("^HL(771.2)",$P(Y0,U,11))
 ..S $P(Y0,U,4)=$$LK("^HL(779.001)",$P(Y0,U,4)),$P(Y0,U,7)=$$LK("^HLCS(870)",$P(Y0,U,7))
 ..S $P(Y0,U,8)=$$LK("^HL(779.003)",$P(Y0,U,8)),$P(Y0,U,9)=$$LK("^HL(779.003)",$P(Y0,U,9))
 ..S $P(Y0,U,10)=$$LK("^HL(771.5)",$P(Y0,U,10))
 .;loop thru Access and resolve (3;1), kill if it doesn't resolve
 .S (I,X)=0 F  S I=$O(^ORD(101,DA,3,I)) Q:'I  S Y0=$P($G(^(I,0)),U) D
 ..;Y0=.01 of Access(Security Key)
 ..S Y=$$LK("^DIC(19.1)",Y0)
 ..I 'Y K ^ORD(101,DA,3,I) D BMES^XPDUTL(" Key "_Y0_" in Protocol "_$P(^ORD(101,DA,0),U)_" **NOT FOUND**") Q
 ..S $P(^ORD(101,DA,3,I,0),U)=Y,X=I_U_(X+1)
 .S:X $P(^ORD(101,DA,3,0),U,3,4)=X
PROFL .;need to loop through ^TMP($J,"XPD",DA,10,I) these are menus that need to be
 .;merged, they are also linked menu, but treat like merge
 .S I=0 F  S I=$O(^TMP($J,"XPD",DA,10,I)) Q:'I  S Y0=$G(^(I,0)),X=$G(^(U)) D:X]"" MENU(DA,X,Y0)
 .;loop thru Menu and repoint Option (0;1), text is on ^(U) node
 .;also need to recount all menus and reset zeroth node, use X
 .S (I,X)=0 F  S I=$O(^ORD(101,DA,10,I)) Q:'I  S Y0=$G(^(I,U)) D
 ..I $L(Y0) D  Q:'Y
 ...S Y=$$LK("^ORD(101)",Y0)
 ...K ^ORD(101,DA,10,I,U)
 ...I 'Y K ^ORD(101,DA,10,I) D BMES^XPDUTL(" Protocol "_Y0_" in Protocol Menu "_$P(^ORD(101,DA,0),U)_" **NOT FOUND**") Q
 ...S $P(^ORD(101,DA,10,I,0),U)=Y
 ..S X=I_U_(X+1)
 .S:X $P(^ORD(101,DA,10,0),U,3,4)=X
 .;need to loop through ^TMP($J,"XPD",DA,775,I) these are subscribers that need to be
 .;merged, they are also linked subscriber, but treat like merge
 .S I=0 F  S I=$O(^TMP($J,"XPD",DA,775,I)) Q:'I  S Y0=$G(^(I,0)),X=$G(^(U)) D:X]"" SUBS(DA,X)
 .;loop thru subscriber and repoint Option (0;1), text is on ^(U) node
 .;also need to recount all menus and reset zeroth node, use X
 .S (I,X)=0 F  S I=$O(^ORD(101,DA,775,I)) Q:'I  S Y0=$G(^(I,U)) D
 ..I $L(Y0) D  Q:'Y
 ...S Y=$$LK("^ORD(101)",Y0)
 ...K ^ORD(101,DA,775,I,U)
 ...I 'Y K ^ORD(101,DA,775,I) D BMES^XPDUTL(" Protocol "_Y0_" in Protocol Subscriber "_$P(^ORD(101,DA,0),U)_" **NOT FOUND**") Q
 ...S $P(^ORD(101,DA,775,I,0),U)=Y
 ..S X=I_U_(X+1)
 .S:X $P(^ORD(101,DA,775,0),U,3,4)=X
 .;re-index this option
 .D IX1^DIK
 K ^TMP($J,"XPD")
 Q
PRODEL ;option delete
 D DEL("^ORD(101,",DUZ)
 D PRO^XPDIA2
 Q
LK(GR,X) ;lookup, GR=global root, X=lookup value
 Q:$G(X)="" ""
 N I S I=$O(@GR@("B",X,0))
 I I,$D(@GR@(I,0))#2 Q I
 Q ""
 ;
ADD(XPDSDD,XPDSDA,X) ;add to multiple, XPDSDD=sub DD#, XPDSDA=DA, X=value
 Q:$G(X)=""
 N XPD
 S XPD(XPDSDD,"?+1,"_XPDSDA_",",.01)=X
 D UPDATE^DIE("E","XPD")
 Q
 ;this is used to add menu items to an option or protocol
MENU(DA,X,X0) ;DA=ien of option/protocol, X=Menu item, X0=0 node of menu item
 N DIC,DLAYGO,DIK,D0,D1,I,Y,Y0
 S DIC=$S(XPDFIL=19:"^DIC(19,",1:"^ORD(101,")_DA_",10,",DIC(0)="L",DLAYGO=XPDFIL,(D0,DA(1))=DA
 S:'$D(@(DIC_"0)")) @(DIC_"0)")=U_$P(^DD(XPDFIL,10,0),U,2)
 S:$L($G(X0)) DIC("DR")="2///"_$P(X0,U,2)_";3///"_$P(X0,U,3)_$S($L($P(X0,U,4)):";4///"_$P(X0,U,4)_";5///"_$P(X0,U,5)_";6///"_$P(X0,U,6),1:"")
 D ^DIC
 Q
 ;this is used to add subscriber items to a protocol
SUBS(DA,X) ;DA=ien of protocol, X=subscriber
 N DIC,DLAYGO,DIK,D0,D1,I,Y,Y0
 S DIC="^ORD(101,"_DA_",775,",DIC(0)="L",DLAYGO=XPDFIL,(D0,DA(1))=DA
 S:'$D(@(DIC_"0)")) @(DIC_"0)")=U_$P(^DD(XPDFIL,775,0),U,2)
 D ^DIC
 Q
DEL(DIK,DUZ) ;delete
 N DA,XPDI,XPDF
 S XPDI=0,DUZ(0)="@",XPDF=+$P(DIK,"(",2)
 F  S XPDI=$O(^TMP($J,"XPDEL",XPDI)) Q:'XPDI  D
 .K ^TMP("DIFIXPT",$J) S DA=XPDI
 .D ^DIK ;FIXPT^DIA3("D",XPDF,XPDI)
 .I $D(^TMP("DIFIXPT",$J))  D WP^XPDUTL("^TMP(""DIFIXPT"",$J)")
 Q

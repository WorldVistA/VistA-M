DDGFASUB ;SFISC/MKO-MANAGE "ASUB" ARRAY ;09:36 AM  29 Mar 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ALL ;Get subpages into @DDGFREF@("ASUB")
 N P,B S P=0
 F  S P=$O(^DIST(.403,+DDGFFM,40,P)) Q:'P  D:$P($G(^(P,1)),U,2)]"" ADD(P)
 Q
 ;
ADD(P) ;
 ;Setup @DDGFREF@("ASUB",pg,bk,ddo)=subpage P
 N MP,MB,MF,X
 S MF=$$UC($P(^DIST(.403,+DDGFFM,40,P,1),U,2)) Q:MF=""
 S MP=$P(MF,",",3),MB=$P(MF,",",2),MF=$P(MF,",")
 ;
 S MP=$O(^DIST(.403,+DDGFFM,40,$S(MP=+$P(MP,"E"):"B",1:"C"),MP,""))
 Q:MP=""
 ;
 I MB=+$P(MB,"E") D
 . S MB=$O(^DIST(.403,+DDGFFM,40,MP,40,"AC",MB,""))
 E  D
 . S MB=$O(^DIST(.404,"B",$$UC(MB),"")) Q:MB=""
 . S MB=$O(^DIST(.403,+DDGFFM,40,MP,40,"B",MB,""))
 Q:MB=""
 ;
 S X=$S(MF=+$P(MF,"E"):"B",$D(^DIST(.404,MB,40,"D",MF)):"D",1:"C")
 S MF=$O(^DIST(.404,MB,40,X,MF,"")) Q:MF=""
 S @DDGFREF@("ASUB",MP,MB,MF)=P,@DDGFREF@("ASUB","B",P,MP,MB,MF)=""
 Q
 ;
DEL(P) ;
 ;Delete subpage DDGFPG from @DDGFREF@("ASUB")
 Q:'$D(@DDGFREF@("ASUB","B",P))
 ;
 N MP,MB,MF
 S MP="" F  S MP=$O(@DDGFREF@("ASUB","B",P,MP)) Q:MP=""  D
 . S MB="" F  S MB=$O(@DDGFREF@("ASUB","B",P,MP,MB)) Q:MB=""  D
 .. S MF="" F  S MF=$O(@DDGFREF@("ASUB","B",P,MP,MB,MF)) Q:MF=""  D
 ... K @DDGFREF@("ASUB","B",P,MP,MB,MF),@DDGFREF@("ASUB",MP,MB,MF)
 Q
 ;
EDIT(P) ;
 ;Edit "ASUB" to reflect new parent page
 D DEL(P),ADD(P)
 Q
UC(X) ;
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")

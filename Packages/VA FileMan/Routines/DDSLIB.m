DDSLIB ;SFISC/MKO-LIBRARY FUNCTIONS ;11:55 AM  14 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
FIND(E,C,S) ;Find in expression E, starting from pos S, the char pos
 ;after the next occurrence of char C, ignoring those within quoted
 ;strings.
 N I,J,P
 S:'$D(S) S=1
 F  D  Q:$D(P)
 . S I=$F(E,C,S),J=$F(E,"""",S)
 . I 'I S P=I Q
 . I J,J<I S S=$$AFTQ(E,J-1) Q
 . S P=I
 Q P
 ;
PIECE(E,C,N1,N2) ;Return the N1th to N2th C-piece of E
 ;ignoring those within quoted strings
 ;Start looking from pos 1
 N I,J,S,F
 S:'$D(N1) N1=1 Q:'N1
 S:'$D(N2) N2=N1 Q:N2<N1
 S S=1 F I=1:1:N1-1 S S=$$FIND(E,C,S) Q:'S
 Q:'S $S(N1=1:E,1:"")
 S F=S F I=1:1:N2-N1+1 S F=$$FIND(E,C,F) Q:'F
 Q:'F $E(E,S,999)
 Q $E(E,S,F-2)
 ;
RPAR(E,S) ;Find in expression E, from char pos S (the position
 ;of the left paren) the char pos after the right paren,
 ;ignoring nested parens, or parens within quotes
 N I,L,P,R
 S P=1,I=S+1
 F  D  Q:'P
 . S R=$$FIND(E,")",I),L=$$FIND(E,"(",I)
 . I L,L<R S P=P+1,I=L Q
 . S P=P-1,I=R
 Q I
 ;
AFTQ(E,I) ;Return character position after quoted string
 ;E = string, I=character position of first quote
 S:'$G(I) I=1
 F  S I=$F(E,"""",I+1) Q:$E(E,I)'=""""
 S:'I I=$L(E)+1
 Q I
 ;
QT(X) ;Return X quoted
 Q:$G(X)="" """"""
 S X(X)="",X=$Q(X(""))
 Q $E(X,3,$L(X)-1)
 ;
UQT(X) ;Return quoted string X unquoted
 Q:$G(X)="" ""
 S @("X("_X_")=""""")
 Q $O(X(""))
 ;
FIELD(DDP,FLD) ;Get field number
 N F,P
 I FLD="" D BLD^DIALOG(202,"field") Q ""
 S:$E(FLD)="""" FLD=$$UQT($E(FLD,1,$$AFTQ(FLD)-1))
 S F=FLD,P("FILE")=DDP
 I FLD'=+$P(FLD,"E") D  Q:$G(DIERR) ""
 . S F=$O(^DD(DDP,"B",FLD,""))
 . I F="" S P(1)=FLD D BLD^DIALOG(501,.P)
 ;
 I $D(^DD(DDP,F,0))[0 S P(1)="#"_F D BLD^DIALOG(501,.P) Q ""
 Q F
 ;
GETFLD(FD,BK,PG,DDS,DDSPG,DDSBK,DDSFLG) ;Return "DDO,bk#,pg#"
 ;DDSPG=current page, DDSBK=current block
 ; -- when block and page are optional
 ;PG is required only if block order is sent
 ;DDSFLG["F" means field must be form-only
 N F,B,P,N
 I FD?.N.1"."1.N1",".N.1"."1.N,BK="",PG="" Q FD
 S:$E($G(FD))="""" FD=$$UQT(FD)
 S:$E($G(BK))="""" BK=$$UQT(BK)
 S:$E($G(PG))="""" PG=$$UQT(PG)
 S P=+$G(DDSPG),B=+$G(DDSBK)
 D @$S($G(PG)]"":"PG",$G(BK)]"":"BK",1:"FD") Q:$G(DIERR) ""
 Q F_","_B_","_P
 ;
PG ;Get internal page number
 I '$G(DDS) D BLD^DIALOG(3084) Q
 S N=PG=+$P(PG,"E")
 I N S P=$O(^DIST(.403,+DDS,40,"B",PG,""))
 E  I PG?1"`".N.1"."1.N S P=+$P(PG,"`",2),N=2
 E  S P=$O(^DIST(.403,+DDS,40,"C",$$UPCASE(PG),""))
 ;
 I $D(^DIST(.403,+DDS,40,+P,0))[0 D BLD^DIALOG(3023,$S(N=2:"#",N:"number ",1:"named ")_PG) Q
 ;
 I BK="" D  Q:$G(DIERR)
 . S BK=$O(^DIST(.403,+DDS,40,P,40,"AC",""))
 . I BK="" D BLD^DIALOG(3055,$S(N:"number ",1:"named ")_PG)
 ;
BK ;Get internal block number
 S N=BK=+$P(BK,"E")
 I N D  Q:$G(DIERR)
 . I P S B=$O(^DIST(.403,+DDS,40,P,40,"AC",BK,"")) Q
 . D BLD^DIALOG(3085)
 E  I BK?1"`".N.1"."1.N S B=+$P(BK,"`",2),N=2
 E  D  Q:$G(DIERR)
 . S B=$O(^DIST(.404,"B",BK,""))
 . I B="" D BLD^DIALOG(3051,BK) Q
 . S B=$O(^DIST(.403,+DDS,40,P,40,"B",B,""))
 ;
 I P,$D(^DIST(.403,+DDS,40,P,40,+B,0))[0 D  Q
 . N P1
 . S P1(1)=$S(N=2:"#",N:"order ",1:"")_BK
 . S P1(2)="number "_$P(^DIST(.403,+DDS,40,P,0),U)_$S($G(^(1))]"":" ("_$P(^(1),U)_")",1:"")
 . D BLD^DIALOG(3053,.P1)
 ;
 I FD="" D  Q:$G(DIERR)
 . S FD=$O(^DIST(.404,B,40,"B",""))
 . D:FD="" BLD^DIALOG(3071,$P(^DIST(.404,B,0),U))
 ;
FD ;Get internal field number
 I 'B D BLD^DIALOG(3082) Q
 S N=FD=+$P(FD,"E")
 I N S F=$O(^DIST(.404,B,40,"B",FD,""))
 E  I FD?1"`".N.1"."1.N S F=+$P(FD,"`",2),N=2
 E  D  Q:$G(DIERR)
 . N X
 . S FD=$$UPCASE(FD),X=$S($D(^DIST(.404,B,40,"D",FD)):"D",1:"C")
 . S F=$O(^DIST(.404,B,40,X,FD,""))
 ;
 I $D(^DIST(.404,B,40,+F,0))[0 D
 . N P
 . S P(1)=$S(N=2:"#",N:"order ",1:"with caption or unique name ")_FD
 . S P(2)=$P(^DIST(.404,B,0),U)
 . D BLD^DIALOG(3072,.P)
 ;
 I '$G(DIERR),$G(DDSFLG)["F","^2^4^"'[(U_$P($G(^DIST(.404,B,40,+F,0)),U,3)_U) D BLD^DIALOG(3081)
 Q
 ;
UPCASE(X) ;
 ;Return X in uppercase
 Q $$UP^DILIBF(X)  ;**

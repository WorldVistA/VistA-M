DICATTDM ;GFT ;04:56 PM  17 Dec 2002
 ;;22.0;VA FileMan;**42,118**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SUBDEF ;
 S Y=$O(^DD(DICATTA,"GL",""),-1)
 I $$CHKSUB(Y) Q
NXT I Y S Y=Y+1 Q
 F Y=+$O(^DD(DICATTA,"GL","A"),-1):1 Q:'$D(^(Y))
 Q
 ;
PIECDEF ;
 I $E($G(DICATT2N))="K" S Y="E1,245" Q
 S Y=$$G(16) I Y]"" S Y=$$P(Y)
 Q
 ;
P(Y) ;given SUBSCRIPT Y, return PIECE prompt
 N P,X,%
 S X=0,%=1,P=0
PC S X=$O(^DD(DICATTA,"GL",Y,X)) I X'="" S P=$P(X,",",2),%=$S(%>P:%,1:P+1) G PC
 I P S %="E"_%_","_(DICATTLN+%-1)
 E  S %=$O(^(99999),-1)+1
 Q %
 ;
SUBHELP ;
 S Y=$E($G(DICATT2N))="K" D UNED^DDSUTL(17,"DICATTM",3,Y)
 N X,Y,T
 S X(1)="Enter name of MUMPS Global subscript where this Field's data will be stored."
 S X(2)="Already assigned:"
 S Y="",T=3
 F  S Y=$O(^DD(DICATTA,"GL",Y)) Q:Y=""  S X(T)=$G(X(T))_$J(Y,9) I $L(X(T))>66 S T=T+1
 D HLP^DDSUTL(.X)
 Q
 ;
CHKSUB(X) ;used as INPUT TRANSFORM for Fields 16 & 76
 N M
 S M=$$GET^DDSVALF(20.5,"DICATT",1,"","")
 I $D(^DD(DICATTA,"GL",X)),M Q "Another Field is already stored at '"_X_"'"
 I $D(^(X,0)) Q "A multiple field is already stored at '"_X_"'"
 I $G(DICATTLN),$$MAX(DICATTLN,X)>250 Q "Too much to store at the '"_X_"' subscript"
 Q 1
 ;
MAX(L,Y) ;given L=length of new data, Y=subscript name
 N T,A,DP,N,W
 S A=DICATTA,DP=DICATTF
 D MAX^DICATT1 Q T  ;returns maximum length of subscript's data
 ;
CHKPIEC(P) ;
 N N,S
 S S=$$G(16) I S="" Q S  ;must have subscript
 I P?1"E"1.N1","1.N S N=$P(P,",",2)-$E(P,2,9)+1 G USED:N'<$G(DICATTLN) Q "Can't be less than "_DICATTLN
 I P>0,P<100,P?.N,+P=P G USED
 Q ""
USED I $D(^DD(DICATTA,"GL",S,P)) Q "Already used for '"_$P(^DD(DICATTA,$O(^(P,0)),0),U)_"'"
 I P["E",$O(^(0)) Q "Can't store by $EXTRACT in the same subscript with $PIECES"
 Q 1
 ;
PIECHELP ;
 N X,G,Y,P,T
 S X(1)="Type a number from 1 to 99"
 S G=$$G(16) Q:G=""
 I '$D(^DD(DICATTA,"GL",G)) S X(1)=X(1)_" or an $EXTRACT range such as ""E2,4""." Q
 S X(1)=X(1)_".",X(2)="Currently assigned: ",Y="",T=2
 F  S Y=$O(^DD(DICATTA,"GL",G,Y)) Q:Y=""  S P=$O(^(Y,0)) I $D(^DD(DICATTA,P,0)) S X(T)=$G(X(T))_$J(Y,7) I $L(X(T))>66 S T=T+1
 D HLP^DDSUTL(.X)
 Q
 ;
POST ;POST-ACTION of Page 3
 N %
 S %=$$CHKPIEC($$G(17)) I '% S DDSBR=% K % S %(1)=DDSBR,DDSBR=16 D H(.%)
 Q
 ;
H(%) S %($O(%(""),-1)+1)="$$EOP"
 D HLP^DDSUTL(.%)
 Q
 ;
G(I) Q $$GET^DDSVALF(I,"DICATTM",3,"","")

XWBZ1 ;ISC-SF/EG - DHCP BROKER PROTOYPE TESTER [ 02/22/95  11:07 PM ] ;03/28/97  14:50
 ;;1.1;RPC BROKER;;Mar 28, 1997
ECHO1(Y,X) ;don't call direct
 S Y=X
 Q
 ;
GLOB1(Y,N) ;callback for global parameter - don't call direct
 S Y=$NA(@N)
 Q
 ;
LIST(Y) ; -- return list box with 28 entries
 N I
 F I=1:1:28 S Y(I)="List Item #"_I
 Q
 ;
WP(Y) ; -- return text a word processing (50 lines)
 N I
 F I=1:1:50 S Y(I)="The quick brown fox jumped over the lazy dog."
 S Y(51)="End of document."
 Q
 ;
BIG(Y) ; -- send a 32K string
 N I,Z
 S $P(Z,"D",16)=""
 K ^TMP($J,"XWBBIG")
 F I=1:1:2048 S ^TMP($J,"XWBBIG",I)=Z
 S Y=$NA(^TMP($J,"XWBBIG"))
 Q
 ;
SRT(Y,D,X) ; -- sort array x and return in y
 N I,K,T
 S K=""
 IF D="LO" D  Q
 . F I=1:1 D  Q:K=""
 . . S K=$O(X(K)) Q:K=""
 . . S Y(I)=K
 IF D="HI" D
 . F I=1:1 D  Q:K=""
 . . S K=$O(X(K)) Q:K=""
 . . S T(99999999-I)=K
 . S K=0
 . F I=1:1 D  Q:K=""
 . . S K=$O(T(K)) Q:K=""
 . . S Y(I)=T(K)
 Q
 ;
MEMO(Y,X) ;
 K ^TMP("EG",$J,"MEMO")
 S ^TMP("EG",$J,"MEMO",-9000)="DHCP RECEIVED:"
 M ^TMP("EG",$J,"MEMO")=X
 S Y=$NA(^TMP("EG",$J,"MEMO"))
 Q
 ;

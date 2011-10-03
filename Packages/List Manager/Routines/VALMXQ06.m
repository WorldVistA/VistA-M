VALMXQ06 ; alb/mjk - XQORD for export with LM v1 ; 3/30/93
 ;;1;List Manager;;Aug 13, 1993
 ;
 ;
XQORD ; SLC/KCM - Dialog Utility ;11/19/92  08:27
 ;;6.7;Sidewinder;;Jan 08, 1993
EN D NUL^XQOR2 N DLG,ITM,X ;Process individual prompt
 S DLG=+^TMP("XQORS",$J,XQORS-1,"VPT"),ITM=+^TMP("XQORS",$J,XQORS-1,"ITM",^TMP("XQORS",$J,XQORS-1,"ITM"),"IEN")
 S X=$G(^ORD(101,DLG,10,ITM,1)),X("PRMT")=$P(X,"^",1),X("DFLT")=$P(X,"^",2),X("HELP")=$P(X,"^",3),X("MODE")=$P(X,"^",4)
 S X=$G(^ORD(101,+XQORNOD,101.04)),X("DOM")=$P(X,"^",1),X("PARM")=$P(X,"^",5)
 S:'$L(X("PRMT")) X("PRMT")=$P(X,"^",2) S:'$L(X("DFLT")) X("DFLT")=$P(X,"^",3) S:'$L(X("HELP")) X("HELP")=$P(X,"^",4)
 S XQORDLG(ITM,"PRMT")=X("PRMT")_"^"_X("MODE"),XQORDLG("SEQ",+^TMP("XQORS",$J,XQORS-1,"ITM"))=ITM
 I X("MODE")["E",$D(XQORMSG),XQORMSG="NEW" D  G XEN
 . I '$D(XQORDLG(ITM,1)),$L(X("DFLT")) S XQORDLG(ITM,1,"I")="",XQORDLG(ITM,1,"E")=X("DFLT")
 ;
 ; -- case prompt type (X("DOM"))
 I "DFLNPSY"[X("DOM") D RDR^XQORD1 G C1
 I X("DOM")="W" D WP^XQORD1 G C1
 I X("DOM")="M" D MENU^XQORD1 G C1
C1 ; -- end case prompt type
 ;
 ; -- case up-arrow status (X)
 I $E(X)'="^" D SETANS G C2 ;valid entry
 S X=$P(X,"^",2) I '$L(X) S XQORPOP=1,XQORDLG=-1 G C2 ;up arrow out
 I $D(^TMP("XQORS",$J,XQORS-1,"PMT",$$UP(X))) S ^TMP("XQORS",$J,XQORS-1,"ITM")=$O(^($$UP(X),0))-1 G C2 ;full name jump
 S Y=$O(^TMP("XQORS",$J,XQORS-1,"PMT",$$UP(X))) ;partial name jump
 I $E(Y,1,$L(X))=$$UP(X) S ^TMP("XQORS",$J,XQORS-1,"ITM")=$O(^TMP("XQORS",$J,XQORS-1,"PMT",Y,0))-1 G C2
 W " ??" S ^TMP("XQORS",$J,XQORS-1,"ITM")=^TMP("XQORS",$J,XQORS-1,"ITM")-1 ;otherwise...
C2 ; -- end case up-arrow status
 ;
XEN Q  ;Exit: XQORDLG(n)=external value of response
 ;
SETANS ;Setup answers in array according to type, calling info in X,Y
 ;Entry: .X is external value, .Y is internal value, X("DOM") is prompt type
 S XQORDLG(ITM)=""
 I $L(Y)   DO
 . ; -- case prompt type (X("DOM"))
 . I X("DOM")="D" D DD^%DT S XQORDLG(ITM)=Y G C3 ;date/Time
 . I X("DOM")="F" S XQORDLG(ITM)=Y G C3 ;free Text
 . I X("DOM")="L" S XQORDLG(ITM)=X G C3 ;list/Range
 . I X("DOM")="N" S XQORDLG(ITM)=Y G C3 ;numeric
 . I X("DOM")="P" S XQORDLG(ITM)=$P(Y,"^",2) G C3 ;pointer
 . I X("DOM")="S" S XQORDLG(ITM)=Y(0) G C3 ;set
 . I X("DOM")="Y" S XQORDLG(ITM)=$S(Y=0:"NO",Y=1:"YES",1:"") G C3 ;yes/no
 . I X("DOM")="W" S XQORDLG(ITM)=Y G C3 ;word processing
 . I X("DOM")="M" DO  G C3 ;menu
 . . N I S I=0  F  S I=$O(Y(I)) Q:I<1   DO
 . . . S XQORDLG(ITM)=$P(Y(I),"^",3)_","
 . . S XQORDLG(ITM)=$E(XQORDLG(ITM),1,$L(XQORDLG(ITM))-1)
C3 . ; -- end case prompt type
 . ;
 Q
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")

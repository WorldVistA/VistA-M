XGS ;SFISC/VYD - SCREEN PRIMITIVES ;03/16/95  11:00
 ;;8.0;KERNEL;;Jul 10, 1995
SAY(R,C,S,A) ;use this for coordinate output instead of WRITE
 ;output to screen and update virtual screen (XGSCRN)
 ;params: Row (0-IOSL),Col (0-IOM),string,
 ;scrn attrib ie. I1R0B1 (optional)
 N XGSAVATR,XGESC,XGOUTPUT ;save attribute,escape str,output stream
 N %
 ;set output stream to either XGSCRN (virtual screen) or some window
 S XGOUTPUT=$S($G(XGFLAG("PAINT"),21)=21:"XGSCRN",1:$NA(^TMP("XGS",$J,XGW1)))
 S XGSAVATR=XGCURATR     ;preserve current attribute to restore later
 S $X=C+$L(S)
 S XGESC=$S($L($G(A)):$$CHG^XGSA(A),1:"")
 S $E(@XGOUTPUT@(R,0),(C+1),$X)=S
 S $E(@XGOUTPUT@(R,1),(C+1),$X)=$TR($J("",$L(S))," ",XGCURATR)
 ;S $P(%,XGCURATR,$L(S)+1)="",$E(@XGOUTPUT@(R,1),(C+1),$X)=%
 I XGOUTPUT="XGSCRN" D  I 1 ;if screen painting is to occur
 . ;output string in a proper place in proper attribute and restore attr
 . ;W $$IOXY(R,C)_XGESC_S_$S($L($G(A)):$$SET^XGSA(XGSAVATR),1:"")
 . W $$IOXY(R,C)_XGESC_S_$S(XGSAVATR'=XGCURATR:$$SET^XGSA(XGSAVATR),1:"")
 . S $Y=R,$X=C+$L(S)-1
 E  S XGCURATR=XGSAVATR
 Q
 ;
 ;
SAYU(R,C,S,A) ;use this for coordinate output instead of WRITE
 ;output to screen and update virtual screen (XGSCRN)
 ;params: Row (0-IOSL),Col (0-IOM),string,
 ;scrn attrib ie. I1R0B1 (optional)
 N XGSAVATR,XGESC,XGOUTPUT ;save attribute,escape str,output stream
 N %,%S,P,P1,P2,X ;P1:piece before &, P2:piece from & to the end
 N XGATR
 ;set output stream to either XGSCRN (virtual screen) or some window
 S XGOUTPUT=$S($G(XGFLAG("PAINT"),21)=21:"XGSCRN",1:$NA(^TMP("XGS",$J,XGW1)))
 S P=$L(S,"&&")
 F %=1:1:P S $P(X,$C(1),%)=$P(S,"&&",%) ;replace all && with $C(1)
 I X["&",$G(A)'["U1",'$$STAT^XGSA("U")!($G(A)["U0") D  I 1
 . S XGSAVATR=XGCURATR     ;preserve current attribute to restore later
 . S XGESC=$S($L($G(A)):$$CHG^XGSA(A),1:"")
 . S XGATR=XGCURATR        ;get pre-underline attributes
 . S $X=C+$L(X)-1 ;adjust for a single &, which is not printable
 . ;S $E(XGSCRN(R,0),(C+1),$X)=$TR($TR(X,"&",""),$C(1),"&")
 . S $E(@XGOUTPUT@(R,0),(C+1),$X)=$TR($P(X,"&")_$P(X,"&",2,999),$C(1),"&")
 . S $E(@XGOUTPUT@(R,1),(C+1),$X)=$TR($J("",$X-C)," ",XGCURATR)
 . S P1=$TR($P(X,"&"),$C(1),"&"),P2=$TR($P(X,"&",2,999),$C(1),"&")
 . S %S=P1_$$CHG^XGSA("U1")_$E(P2) ;preunderline_underlinechar
 . S $E(@XGOUTPUT@(R,1),(C+1+$L(P1)))=XGCURATR ;record underlinechar
 . ;S %S=%S_$$CHG^XGSA("U0")_$E(P2,2,999) ;%S_postunderline
 . S %S=%S_$$SET^XGSA(XGATR)_$E(P2,2,999) ;%S_postunderline
 . I XGOUTPUT="XGSCRN" D  I 1
 . . ;output string in a proper place in proper attribute and restore attr
 . . ;W $$IOXY(R,C)_XGESC_%S_$S($L($G(A)):$$SET^XGSA(XGSAVATR),1:"")
 . . W $$IOXY(R,C)_XGESC_%S_$S(XGCURATR'=XGSAVATR:$$SET^XGSA(XGSAVATR),1:"")
 . . S $Y=R,$X=C+$L(X)-2
 . E  S XGCURATR=XGSAVATR
 E  D SAY(R,C,$TR(S,"&"),A):$D(A),SAY(R,C,$TR(S,"&")):'$D(A)
 Q
 ;
 ;
IOXY(R,C) ;cursor positioning WRITE argument instead of execute
 ;Row,Col
 Q $C(27,91)_((R+1))_$C(59)_((C+1))_$C(72)

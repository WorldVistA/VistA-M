XVEMKTR ;DJB/KRN**Txt Scroll-Get REF Number [4/16/95 5:54am];2017-08-15  1:14 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
GETSCR(ND,PKG) ;Get scroll array equivilent for a given node
 ;ND=Node number from VGL display
 I $G(ND)'>0 Q 0
 I $G(PKG)']"" Q 0
 NEW X S X=0
 F  S X=$O(^TMP("XVV",PKG,$J,"SCR",X)) Q:X'>0  Q:^(X)=ND
 Q X
 ;====================================================================
GETREF(PKG) ;Get REF number. Return ^,***, or REF number 
 NEW DX,DY,REF,X I $G(PKG)']"" Q "^"
GETREF1 S DX=0,DY=(XVVT("S2")+XVVT("FT")-1)
 D CURSOR^XVEMKU1(DX,DY,1)
 W ?1,"Enter REF NUMBER: " S REF=$$READ^XVEMKRN()
 I REF="^" Q REF
 I ",<ESC>,<F1E>,<F1Q>,<RET>,<TO>,"[(","_XVV("K")_",") Q "^"
 I XVV("K")="<TAB>" D  Q REF
 . S REF=$G(^TMP("XVV",PKG,$J,"SCR",XVVT("HLN")-1))
 . S:REF']"" REF="***"
 I XVV("K")?1"<A"1U1">" D  G GETREF1
 . I XVV("K")="<AU>" D  Q
 . . I XVVT("HLN")-1=XVVT("TOP") W $C(7) Q
 . . D HIGHLITE^XVEMKTM("OFF")
 . . S XVVT("HLN")=XVVT("HLN")-1,XVVT("H$Y")=XVVT("H$Y")-1
 . . D HIGHLITE^XVEMKTM("ON")
 . I XVV("K")="<AD>" D  Q
 . . I XVVT("HLN")=XVVT("BOT") W $C(7) Q
 . . D HIGHLITE^XVEMKTM("OFF")
 . . S XVVT("HLN")=XVVT("HLN")+1,XVVT("H$Y")=XVVT("H$Y")+1
 . . D HIGHLITE^XVEMKTM("ON")
 . I XVV("K")="<AL>" D  Q
 . . I XVVT("HLN")-1=XVVT("TOP") W $C(7) Q
 . . D HIGHLITE^XVEMKTM("OFF")
 . . S XVVT("HLN")=XVVT("TOP")+1,XVVT("H$Y")=XVVT("S1")
 . . D HIGHLITE^XVEMKTM("ON")
 . I XVV("K")="<AR>" D  Q
 . . I XVVT("HLN")=XVVT("BOT") W $C(7) Q
 . . D HIGHLITE^XVEMKTM("OFF")
 . . S XVVT("HLN")=XVVT("BOT"),XVVT("H$Y")=XVVT("S2")
 . . D HIGHLITE^XVEMKTM("ON")
 I $E(REF)="?"!(XVV("K")="<ESCH>") D MSG(1) G GETREF1
 I REF'>0!(REF'?1.N) W $C(7) D MSG(1) G GETREF1
 Q REF
 ;====================================================================
GETRANG(PKG) ;Get range of nodes. Return ^ or range of REF numbers
 NEW DX,DY,I,REF,REF1,REF2 Q:$G(PKG)']""
GETRANG1 S DX=0,DY=(XVVT("S2")+XVVT("FT")-1)
 D CURSOR^XVEMKU1(DX,DY,1)
 W ?1,"Enter REF NUMBERS(S): "
 R REF:XVV("TIME") S:'$T REF="^" I "^"[REF Q "^"
 I REF?1.N1"-"1.N D  G:REF']"" GETRANG1 Q REF
 . S REF1=$P(REF,"-"),REF2=$P(REF,"-",2)
 . I '$D(^TMP("XVV",PKG,$J,REF1))!('$D(^(REF2)))!(REF1>REF2) S REF="" D MSG(3) Q
 . S REF=REF1_"^"_REF2
 . Q
 I REF["," D  G:REF']"" GETRANG1 Q REF
 . F I=1:1:$L(REF,",") S REF1=$P(REF,",",I) D  Q:REF']""
 . . I REF1'>0 D MSG(1) S REF="" Q
 . . I '$D(^TMP("XVV",PKG,$J,REF1)) D MSG(1) S REF="" Q
 I REF'>0!(REF'?1.N) D  D MSG(4) G GETRANG1
 . Q:$E(REF)="?"!(REF="<ESCH>")  W $C(7)
 I '$D(^TMP("XVV",PKG,$J,REF)) D MSG(2) G GETRANG1
 Q REF_"^"_REF
 ;====================================================================
MSG(NUM) ;Messages
 ;NUM=Subroutine number
 Q:$G(NUM)'>0
 S DX=0,DY=(XVVT("S2")+XVVT("FT")-2)
 D CURSOR^XVEMKU1(DX,DY,1),@NUM
 Q
1 W "Enter REF number from left hand column or <TAB> for highlight." Q
2 W $C(7),"Invalid. Enter number from left hand column" Q
3 W $C(7),"Invalid range" Q
4 W "Enter number from left hand column, or range of numbers (Ex: 3-5 or 1,3,4)" Q

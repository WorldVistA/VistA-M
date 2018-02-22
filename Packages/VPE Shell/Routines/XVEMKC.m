XVEMKC ;DJB/KRN**Select Choices ;2017-08-15  12:50 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
CHOICE(OPTIONS,LEV,DX,DY) ;
 ;;OPTIONS=String containing options. Ex: "YES^NO"
 ;;LEV=Number of option to be highlighted
 ;;DX,DY=Pass DX&DY to place prompts on the screen
 ;
 I $G(OPTIONS)']"" Q 0
 NEW ALLCAPS,ANS,FLAGQ,I,LIMIT,PIECE,XVVS,X
 S FLAGQ=0 D INIT Q:FLAGQ
 D LOCATION
 X XVVS("RM0")
 W @XVVS("COFF")
 D LOOP
 W @XVVS("CON")
 Q LEV
 ;
LOCATION ;Starting location for each piece
 F I=1:1 S X=$P(OPTIONS,"^",I) Q:X=""  D
 . S PIECE(I)=X
 . S ALLCAPS(I)=$$ALLCAPS^XVEMKU(X)
 . I I=1 S DX(I)=(DX+2) Q
 . S DX(I)=(DX(I-1)+$L(PIECE(I-1))+2)
 S LIMIT=(I-1)
 Q
 ;
LOOP ;Get users response
 D DRAW
 S ANS=$$READ^XVEMKRN("",1,1)
 I XVV("K")="<RET>" Q
 I ANS="^"!(",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_XVV("K")_",")) S LEV=0 Q
 I XVV("K")="<AL>" S LEV=LEV-1 S:LEV<1 LEV=1 G LOOP
 I XVV("K")="<AR>" S LEV=LEV+1 S:LEV>LIMIT LEV=LIMIT G LOOP
 I ANS=" " S LEV=LEV+1 S:LEV>LIMIT LEV=1 G LOOP
 S ANS=$$ALLCAPS^XVEMKU(ANS)
 F I=1:1:LIMIT I I'=LEV,ANS=$E(ALLCAPS(I),1) S LEV=I Q
 G LOOP
 ;
DRAW ;Display options
 F I=1:1:LIMIT S DX=DX(I) X XVVS("CRSR") D  ;
 . I I=LEV W @XVV("RON") X XVVS("XY")
 . W PIECE(I) W:I=LEV @XVV("ROFF")
 Q
 ;
INIT ;
 NEW L,TMP
 I '$D(XVV("OS")) D OS^XVEMKY Q:FLAGQ
 D SCRNVAR^XVEMKY2
 D REVVID^XVEMKY2
 D CRSROFF^XVEMKY2
 S:$G(LEV)'>0 LEV=1
 S L=$L(OPTIONS)+(2*$L(OPTIONS,"^"))-(1*($L(OPTIONS,"^")-1))
 S L=XVV("IOM")-1-L
 I $G(DX)>0 S:DX>L DX=0 I 1
 E  S DX=$S($X>L:0,1:$X)
 S TMP=$S($G(XVV("IOSL")):(XVV("IOSL")-1),1:23)
 I $G(DY)>0 S:DY>TMP DY=TMP I 1
 E  S DY=$S($Y>TMP:TMP,1:$Y)
 Q
 ;
PAUSE(LF) ;LF=# of line feeds
 NEW X
 F X=1:1:+$G(LF) W !
 S X=$$CHOICE("<RETURN>",1)
 Q
 ;
PAUSEQ(LF) ;LF=# of line feeds
 NEW X
 F X=1:1:+$G(LF) W !
 S:$$CHOICE("CONTINUE^QUIT",1)'=1 FLAGQ=1
 Q
 ;
PAUSEQE(LF) ;LF=# of line feeds
 NEW X
 F X=1:1:+$G(LF) W !
 S X=$$CHOICE("CONTINUE^QUIT^EXIT",1)
 S:X'=1 FLAGQ=1
 S:X=3 FLAGE=1
 Q

XGF ;SFISC/VYD - Graphics Functions ;11/06/2002  11:10
 ;;8.0;KERNEL;**269**;Jul 10, 1995
PREP ;prepair graphics environment
 D PREP^XGSETUP Q
 ;
 ;
IOXY(R,C) ;cursor positioning R:row, C:col
 D ADJRC
 W $$IOXY^XGS(R,C)
 S $Y=R,$X=C
 Q
 ;
 ;
SAY(R,C,S,A) ;coordinate output instead of WRITE
 D ADJRC
 S:C+$L(S)>IOM S=$E(S,1,IOM-C) ;truncate if longer than screen
 I $L($G(A)) S A=$$UP^XLFSTR(A) D SAY^XGS(R,C,S,$S($$ATRSYNTX(A):A,1:"")) I 1
 E  D SAY^XGS(R,C,S)
 Q
 ;
 ;
SAYU(R,C,S,A) ;coordinate output w/ underline instead of WRITE
 D ADJRC
 I $L($G(A)) S A=$$UP^XLFSTR(A) D SAYU^XGS(R,C,S,$S($$ATRSYNTX(A):A,1:"")) I 1
 E  D SAYU^XGS(R,C,S)
 Q
 ;
 ;
ADJRC ;adjust row and column R and C are assumed to exist
 S R=$S($G(R)="":$Y,1:R),C=$S($G(C)="":$X,1:C) ;use current coords if none are passed
 S:"+-"[$E(R) R=$Y+$S(R="+":1,R="-":-1,1:R) ;increment/decrement
 S:"+-"[$E(C) C=$X+$S(C="+":1,C="-":-1,1:C)
 S R=$S(R<0:0,1:R\1),C=$S(C<0:0,1:C\1) ;make sure only pos int
 Q
 ;
 ;
SETA(XGATR) ;set screen attribute(s) regardless of previous state
 ;XGATR=1 char when converted to binary represents all new attr
 N XGOLDX,XGOLDY
 S XGOLDX=$X,XGOLDY=$Y ;save $X $Y
 W $$SET^XGSA(XGATR)
 S $X=XGOLDX,$Y=XGOLDY ;restore $X $Y
 Q
 ;
 ;
CHGA(XGATR) ;change screen attribute(s) w/ respect to previous state
 ;XGNEWATR=string of attr to change eg. "B0U1" or "E1"
 N XGOLDX,XGOLDY,XGSYNTX,XGACODE,%
 S XGATR=$$UP^XLFSTR(XGATR) ;make sure all attr codes are in upper case
 D:$$ATRSYNTX(XGATR)
 . S XGOLDX=$X,XGOLDY=$Y ;save $X $Y
 . W $$CHG^XGSA(XGATR)
 . S $X=XGOLDX,$Y=XGOLDY ;restore $X $Y
 Q
 ;
 ;
ATRSYNTX(XGATR) ;check attribute code syntax
 ;proper attr is 1 or more (char from {BIRGUE} concat w/ 1 or 0)
 N XGSYNTX,%
 S XGSYNTX=$S($L(XGATR)&($L(XGATR)#2=0):1,1:0) ;even # of chars
 F %=1:2:$L(XGATR) S:"B1B0I1I0R1R0G1G0U1U0E1"'[$E(XGATR,%,%+1) XGSYNTX=0
 Q XGSYNTX
 ;
 ;
RESTORE(S) ;restore screen region TOP,LEFT,BOTTOM,RIGHT,SAVE ROOT
 D RESTORE^XGSW(S) Q
 K @S
 ;
 ;
SAVE(T,L,B,R,S) ;save screen region TOP,LEFT,BOTTOM,RIGHT,SAVE ROOT
 D SAVE^XGSW(T,L,B,R,S) Q
 ;
 ;
WIN(T,L,B,R,S) ;put up a window TOP,LEFT,BOTTOM,RIGHT[,SAVE ROOT]
 ;window style is not yet implemented
 I $L($G(S)) D WIN^XGSW(T,L,B,R,S) I 1
 E  D WIN^XGSW(T,L,B,R)
 Q
 ;
 ;
FRAME(T,L,B,R) ;put a frame without clearing the inside TOP,LEFT,BOTTOM,RIGHT
 D FRAME^XGSBOX(T,L,B,R) Q
 ;
 ;
CLEAR(T,L,B,R) ;clear screen portion TOP,LEFT,BOTTOM,RIGHT
 D CLEAR^XGSBOX(T,L,B,R) Q
 ;
 ;
CLEAN ;clean up and destroy graphics environment
 D CLEAN^XGSETUP Q
 ;
 ;
INITKB(XGTRM) ;initialize keyboard
 ;turn escape processing on, turn on passed terminators (if any)
 D INIT^XGKB($G(XGTRM)) Q
 ;
 ;
READ(XGCHARS,XGTO) ;read the keyboard
 ;XGCHARS:number of chars to read, XGTO:timeout
 Q $$READ^XGKB($G(XGCHARS),$G(XGTO))
 ;
 ;
RESETKB ;reset keyboard(escape processing off, terminators off)
 D EXIT^XGKB Q

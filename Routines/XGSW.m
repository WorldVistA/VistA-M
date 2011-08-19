XGSW ;SFISC/VYD - screen window primitives ;01/11/95  15:58
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
WIN(T,L,B,R,S) ;draw a bordered window
 ;top,left,bottom,right,screen root
 S:B'<IOSL B=IOSL-1,XGFLAG("TOO LONG")=1 ;adjust if longer than screen
 S:R'<IOM R=IOM-1,XGFLAG("TOO WIDE")=1 ;adjust if wider than screen
 D:$D(S) SAVE(T,L,B,R,S)
 N L2,R2,%MIDDLE,%MID0,%MID1,XGSAVATR,%S,Y
 N XGGR0 ;graphics attribute off
 S XGSAVATR=XGCURATR ;save current attr
 W $$CHG^XGSA("G0") S XGGR0=XGCURATR ;store attributes w/out graphics
 W $$CHG^XGSA("G1") ;now turn on gr attr and leave it on
 S %MIDDLE=R-L-1
 S %MID0=IOVL_$J("",%MIDDLE)_$S($D(XGFLAG("TOO WIDE")):" ",1:IOVL)
 S %MID1=XGCURATR_$TR($J("",%MIDDLE)," ",XGGR0)_$S($D(XGFLAG("TOO WIDE")):XGGR0,1:XGCURATR)
 S L2=L+1,R2=R+1
 ;if window for LISTBUTTON gadget, don't draw top of frame
 I $L($G(XGW)),$L($G(XGG)),$G(^TMP("XGW",$J,XGW,"G",XGG,"TYPE"))="LISTBUTTON",$G(XGMENU)="" D
 . S $E(XGSCRN(T,0),L2,R2)=%MID0,%S=%MID0,$E(XGSCRN(T,1),L2,R2)=%MID1
 E  D  ;draw the top of the box
 . S %S=IOTLC_$TR($J("",%MIDDLE)," ",IOHL)_$S($D(XGFLAG("TOO WIDE")):IOHL,1:IOTRC)
 . S $E(XGSCRN(T,0),L2,R2)=%S
 . S $E(XGSCRN(T,1),L2,R2)=$TR($J("",(R-L+1))," ",XGCURATR)
 W $$IOXY^XGS(T,L)_%S
 F Y=T+1:1:$S($D(XGFLAG("TOO LONG")):B,1:B-1) D
 . S $E(XGSCRN(Y,0),L2,R2)=%MID0
 . S $E(XGSCRN(Y,1),L2,R2)=%MID1
 . W $$IOXY^XGS(Y,L)_%MID0
 S %S=$S($D(XGFLAG("TOO LONG")):%MID0,1:IOBLC_$TR($J("",%MIDDLE)," ",IOHL)_$S($D(XGFLAG("TOO WIDE")):IOHL,1:IOBRC))
 S $E(XGSCRN(B,0),L2,R2)=%S
 S $E(XGSCRN(B,1),L2,R2)=$S($D(XGFLAG("TOO LONG")):%MID1,1:$TR($J("",(R-L+1))," ",XGCURATR))
 W $$IOXY^XGS(B,L)_%S
 W $$SET^XGSA(XGSAVATR)
 K XGFLAG("TOO LONG"),XGFLAG("TOO WIDE")
 S $Y=B,$X=R
 Q
 ;
 ;
RESTORE(S) ;restore portion of screen
 ;if S="XGSCRN" then simply refresh the entire screen
 N %,X,Y,%ROW,L2,R2 ;L2 left position in $E  R2 right position in $E
 N T,L,B,R
 N %RCOUNT,%CP,%S,A ;row counter,char pos,string,attr
 N XGSAVATR,XGWIDTH
 S T=$P(@S@("COORDS"),U,1),L2=$P(@S@("COORDS"),U,2)
 S B=$P(@S@("COORDS"),U,3),R2=$P(@S@("COORDS"),U,4)
 S %RCOUNT=0,XGSAVATR=XGCURATR
 S XGWIDTH=R2-L2+1
 F %ROW=T:1:B D
 . S Y=$S($D(T):(T+%RCOUNT),1:%ROW)
 . S XGFLAG("UPDATE")=$S(S="XGSCRN":1,1:0)
 . ;check to see if a line from window needs to be placed on screen
 . ;  and if S="XGSCRN" then don't bother checking, refresh screen anyway
 . I S'="XGSCRN" F X=0,1 I $E(XGSCRN(Y,X),L2,R2)'=$E(@S@(Y,X),L2,R2) S XGFLAG("UPDATE")=1 Q
 . D:XGFLAG("UPDATE")  ;if what's on screen is different from window
 . . I $E(@S@(Y,1),L2,R2)=$TR($J("",XGWIDTH)," ",XGCURATR)&('$D(XGWSTAMP)) S %S=$E(@S@(Y,0),L2,R2)
 . . E  S %S="",%=L2,A=XGCURATR D
 . . . F %CP=L2:1:R2 D:$E(@S@(Y,1),%CP)'=A
 . . . . S A=$E(@S@(Y,1),%CP),%S=%S_$E(@S@(Y,0),%,%CP-1)_$$SET^XGSA(A),%=%CP
 . . . S %S=%S_$E(@S@(Y,0),%,%CP)
 . . S X=$S($D(L):L,1:L2-1)
 . . W $$IOXY^XGS(Y,X)_%S
 . . ;--------------------  put data, attributes and window stamps back
 . . I S'="XGSCRN" F %=0,1 S $E(XGSCRN(Y,%),L2,R2)=$E(@S@(Y,%),L2,R2)
 . S %RCOUNT=%RCOUNT+1
 W $$SET^XGSA(XGSAVATR) ;reset screen & XGCURATR to original
 K XGFLAG("UPDATE")
 ;S $Y=B,$X=R
 Q
 ;
 ;
SAVE(T,L,B,R,S) ;save portion of screen
 N %,Y
 K @S ;clean out the root
 D ADJUST(T,L,B,R,S)    ;adjust and save the coordinates
 S B=$P(@S@("COORDS"),U,3),R=$P(@S@("COORDS"),U,4) ;get new adj coords
 F Y=T:1:B F %=0,1 S @S@(Y,%)=XGSCRN(Y,%)
 Q
 ;
 ;
ADJUST(T,L,B,R,S) ;adjust the coordinates of screen region and if S
 ;is passed, save the coordinates of a window into COORDS node
 ;NOTE:  T,L,B,R may be passed by reference
 S:B'<IOSL B=IOSL-1              ;adjust if longer than screen
 S:R'<IOM R=IOM-1                ;adjust if wider than screen
 S L=L+1                         ;adjust for $E to work correctly
 S R=R+1                         ;adjust for $E to work correctly
 S:$L($G(S)) @S@("COORDS")=T_U_L_U_B_U_R  ;save
 Q

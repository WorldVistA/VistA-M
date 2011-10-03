XGSBOX ;SFISC/VYD - screen rectengular region primitives ;10/31/94  15:38
 ;;8.0;KERNEL;;Jul 10, 1995
FRAME(T,L,B,R,A,C) ;draw a border
 ;TOP,LEFT,BOTTOM,RIGHT,ATTRIBUTE,frame character
 N %,%L2,%R2,M,S,X,Y ;M=middle S=string
 N XGSAVATR
 I B'>T N IOBLC,IOBRC S (IOBLC,IOBRC)=IOHL ;to draw horizontal line
 I R'>L N IOTRC,IOBRC S (IOTRC,IOBRC)=IOVL ;to draw vertical line
 S M=R-L-1
 S %L2=L+1,%R2=R+1
 ;if frame character passed set frame parts to it, disable graphics
 S:$L($G(C)) (IOBLC,IOBRC,IOHL,IOTLC,IOTRC,IOVL)=C
 S XGSAVATR=XGCURATR                     ;save current screen attributes
 W $$CHG^XGSA($G(A)_$S($L($G(C)):"",1:"G1")) ;turn on gr attr & leave on
 S S=IOTLC_$TR($J("",M)," ",IOHL)_IOTRC
 S $E(XGSCRN(T,0),%L2,%R2)=S
 S $E(XGSCRN(T,1),%L2,%R2)=$TR($J("",(R-L+1))," ",XGCURATR)
 W $$IOXY^XGS(T,L)_S ;top line with corners
 F Y=T+1:1:B-1 D
 . F X=%L2,%R2 S $E(XGSCRN(Y,0),X)=IOVL,$E(XGSCRN(Y,1),X)=XGCURATR
 . W $$IOXY^XGS(Y,L)_IOVL_$$IOXY^XGS(Y,R)_IOVL
 S S=IOBLC_$TR($J("",M)," ",IOHL)_IOBRC
 S $E(XGSCRN(B,0),%L2,%R2)=S
 S $E(XGSCRN(B,1),%L2,%R2)=$TR($J("",(R-L+1))," ",XGCURATR)
 W $$IOXY^XGS(B,L)_S ;bottom line with corners
 W $$SET^XGSA(XGSAVATR)      ;restore previous attributes
 D:$L($G(C)) GSET^%ZISS      ;restore line drawing characters
 S $Y=B,$X=R
 Q
 ;
CLEAR(T,L,B,R) ;clear a portion of the screen
 N %L2,%R2,I,M ;M=length of middle
 S %L2=L+1,%R2=R+1,M=R-L+1
 F I=T:1:B D
 . S $E(XGSCRN(I,0),%L2,%R2)=$J("",M)
 . S $E(XGSCRN(I,1),%L2,%R2)=$TR($J("",M)," ",XGCURATR)
 . W $$IOXY^XGS(I,L)_$J("",M)
 S $Y=B,$X=R
 Q

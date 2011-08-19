KMPDUG1 ;OAK/RAK - CM Tools Graph Utility ;2/17/04  09:58
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
DRAW ;-- draw graph
 W @IOF,!,IOG1 S DY=2
 ;  draw top line
 F I=1:1:27 S DX=41+I X IOXY W IOHL S DX=43-I X IOXY W IOHL
 ;  draw top left and right corners
 S DX=15 X IOXY W IOTLC S DX=68 X IOXY W IOTRC,!
 ;  draw sides
 F DY=(DY+1):1:BOTTOM F DX=15,68 X IOXY W IOVL,!
 ;  draw bottom left and right corners
 S DY=BOTTOM,DX=15 X IOXY W IOBLC S DX=68 X IOXY W IOBRC,!
 ;  draw bottom line
 F I=1:1:27 S DX=15+I X IOXY W IOHL S DX=68-I X IOXY W IOHL
 ;  draw 'hash marks' on bottom line for relative values
 S DX=15 X IOXY W IOLT,!
 F DX=20:5:65 X IOXY W IOMT,!
 ;  print grid
 I KMPUOPT["G" D 
 .S DY=2 F DX=20:5:65 X IOXY W IOTT,!
 . F DX=20:5:65 F DY=3:1:(BOTTOM-1) X IOXY W IOVL,!
 W IOG0
 Q
INIT ;-- initialize required variables.
 D GSET^%ZISS S X="IOECH;IORVOFF;IORVON;IOUOFF;IOUON" D ENDR^%ZISS
 ; actual bars representing data
 S BAR(0)="IORVON,"" "",IORVOFF"
 S BAR(1)="IOG1,""a"",IOG0"
 S (DEC,DNUM,MAX,MIN,SCALE,YNUM)=0,GWIDTH=$S(KMPUOPT["V":10,1:50)
 S TITLE=$P($G(KMPUTI),U,1,2)
 S XTITLE=$P($G(KMPUTI),U,3)
 S YTITLE=$P($G(KMPUTI),U,4)
 ; determine maximum and minimum number and decimals (if any).
 S (I,MAX,MIN)=""
 F  S I=$O(@KMPUAR@(I)) Q:I=""  I $D(@KMPUAR@(I,0)) S YNUM=YNUM+1 D 
 .I $P(@KMPUAR@(I,0),U,2)>MAX S MAX=$P(@KMPUAR@(I,0),U,2)
 .I $P(@KMPUAR@(I,0),U,2)<MIN S MIN=$P(@KMPUAR@(I,0),U,2)
 .; determine number of decimal places (if any).
 .S DNUM=$P($P(@KMPUAR@(I,0),U,2),".",2) Q:'DNUM
 .I $L(DNUM)>DEC S DEC=$L(DNUM)
 Q:MAX'>0
 ; get maximum number for graph.
 D MAX
 ; determine if there are decimal places when printed at end of graph
 S I="" F  S I=$O(@KMPUAR@(I)) Q:I=""  I $D(@KMPUAR@(I,0)) D 
 .S Z=$L($P($P(@KMPUAR@(I,0),U,2)/DIV,".",2)) Q:'Z
 .I Z>DEC S DEC=$S(Z>2:2,1:1)
 S BOTTOM=$S(KMPUOPT["D":(YNUM*2+2),1:(YNUM+3))
 S SCALE=((MAX-KMPUSTRT)/10),STEP=((MAX-KMPUSTRT)/GWIDTH)
 S NUM=(SCALE+KMPUSTRT)
 ; determine if relative values have decimal
 S DEC1=0 F I=20:5:65 I $L($P((NUM/DIV),".",2)) D 
 .S DEC1=$S($L($P((NUM/DIV),".",2))>2:2,1:1)
 Q
 ;
MAX ;-- determine 'max' or largest number for graph.
 ;
 S:$G(KMPUMAX) MAX=KMPUMAX
 S DIV=1,MAX=$FN(MAX,"",0)
 I MAX<2 S MAX=1 Q
 S X=1 F I=1:1:$L(MAX)-1 S X=X*10 I MAX=X S X=X/10
 S MAX=$E(MAX-1)+1*X
 I $L(MAX)>4 D 
 .F I=1:1:($L(MAX)-1) S DIV=DIV_"0"
 .I $L(DIV)<7 S DIVT=$S(KMPUOPT["S":"10^"_I,1:(DIV/1000)_"k") Q
 .S DIVT=$S(KMPUOPT["S":"10^"_I,1:(DIV/1000000)_"m")
 Q
 ;
TITLES ;-- print graph titles.
 W IOG0
 ; print first and second line of title
 S DX=(IOM-$L($P(TITLE,U))\2+1),DY=0 X IOXY W $P(TITLE,U),!
 S DX=(IOM-$L($P(TITLE,U,2))\2+1),DY=1 X IOXY W $P(TITLE,U,2),!
 ; print y title
 S DX=(14-$L(YTITLE)) X IOXY W IOUON,YTITLE,IOUOFF,!
 ; print relative values under hash marks
 S NUM=(SCALE+KMPUSTRT)
 S DY=BOTTOM+1,DX=15-$S($L($FN((KMPUSTRT/DIV),"",DEC1))=1:0,1:$L($FN((KMPUSTRT/DIV),"",DEC1))-2) X IOXY W $FN((KMPUSTRT/DIV),"",DEC1),!
 F I=20:5:65 D 
 .I $L($FN((NUM/DIV),"",DEC1))=1 S DX=(I-$L($FN((NUM/DIV),"",DEC1))+1)
 .E  S DX=(I-($L($FN((NUM/DIV),"",DEC1))-2))
 .X IOXY W $FN((NUM/DIV),"",DEC1),! S NUM=NUM+SCALE
 ; if div>1 write (x div)
 I DIV>1 S DX=69 X IOXY W "<x",DIVT,">",!
 ; print x title at bottom
 S DX=(IOM-$L(XTITLE)\2+1),DY=BOTTOM+2 X IOXY W IOUON,XTITLE,IOUOFF,!
 ; print data titles
 S DY=3,I=0 F  S I=$O(@KMPUAR@(I)) Q:'I  I $D(@KMPUAR@(I,0)) D 
 .S YTITLE=$E($P(@KMPUAR@(I,0),U),1,14)
 .S DX=(14-$L(YTITLE)) X IOXY W YTITLE,!
 .S DY=DY+$S(KMPUOPT["D":2,1:1)
 Q

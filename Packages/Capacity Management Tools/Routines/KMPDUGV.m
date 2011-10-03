KMPDUGV ;OAK/RAK - CM Tools Vertical Graph Utility ;2/17/04  10:00
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
EN ;-- entry point.
 D DRAW,TITLES,DATA W IOG0
 I $D(KMPUTAR) D  Q
 .;D WP^KMPDU11(KMPUTAR,5,24,(RIGHT+5),IOM,0,$G(KMPUXIT))
 .D WP^KMPDU11(KMPUTAR,18,22,5,IOM,0,$G(KMPUXIT))
 D:'KMPUXIT CONT^KMPDUG
 Q
 ;
DATA ;-- display data in graph.
 W IOG0 S DX=$S(KMPUOPT["D":9,1:10),BAR=0,I=""
 F  S I=$O(@KMPUAR@(I)) Q:I=""  I $D(@KMPUAR@(I,0)) S DATA=@KMPUAR@(I,0) D 
 .S XCOORD=$P(DATA,U,2),END=(XCOORD-KMPUSTRT) ;-STEP)
 .S DY=14,DX=DX+$S(KMPUOPT["D":2,1:1)
 .; if no data quit
 .Q:$P(@KMPUAR@(I,0),U,2)']""
 .F I1=0:STEP:END X IOXY W @BAR(BAR),! S DY=DY-1 Q:DY=5
 .S BAR=$S(BAR=1:0,1:1)
 Q
 ;
DRAW ;-- draw graph.
 S RIGHT=$S(KMPUOPT["D":(YNUM*2),1:(YNUM+1))+10
 W @IOF,!,IOG1 S DX=10
 ; draw left line
 F I=1:1:6 S DY=4+I X IOXY W IOVL S DY=15-I X IOXY W IOVL
 ; draw left top corner ;and bottom corners
 ;S DY=4 X IOXY W IOTLC ;S DY=15 X IOXY W IOBLC,!
 ; draw top and bottom lines
 ;F DX=(DX+1):1:(RIGHT-1) S DY=5 X IOXY W IOHL,! S DY=15 X IOXY W "s",!
 F DX=(DX+1):1:(RIGHT-1) S DY=14 X IOXY W "s",!
 ; draw right top corner ;and bottom corners
 ;S DX=RIGHT,DY=5 X IOXY W IOTRC ;S DY=15 X IOXY W IOBRC,!
 ; draw right line
 S DX=RIGHT F I=1:1:6 S DY=4+I X IOXY W IOVL S DY=16-I X IOXY W IOVL
 ; draw 'hash marks' on left line for relative values
 S DX=9,DY=14 X IOXY W "s",! ;W IOLT,!
 F DY=13:-1:4 X IOXY W "s",! ;W IOMT,!
 ; print grid
 I KMPUOPT["G" F DY=14:-1:4 F DX=11:1:(RIGHT-1) X IOXY W "s",!
 W IOG0
 Q
 ;
TITLES ;-- print graph titles.
 W IOG0
 ; print first and second line of title
 S DX=(IOM-$L($P(TITLE,U))\2+1),DY=0 X IOXY W $P(TITLE,U),!
 S DX=(IOM-$L($P(TITLE,U,2))\2+1),DY=1 X IOXY W $P(TITLE,U,2),!
 ; print x title at bottom
 S DX=(10-$L(XTITLE)),DY=3 X IOXY W IOUON,XTITLE,IOUOFF
 ; if div>1 write (x div)
 W:DIV>1 " <x",DIVT,">"
 W !
 ; print y title
 S DY=15,DX=$S(KMPUOPT["A":1,1:2)
 F I=1:1:8 D 
 .X IOXY W IOUON,$E(YTITLE,I),IOUOFF,! S DY=DY+1
 .I KMPUOPT["A" S DX=DX+1
 ; print relative values next to hash marks
 S NUM=(SCALE+KMPUSTRT)
 S DY=14,DX=9-$L($FN((KMPUSTRT/DIV),"",DEC1))
 X IOXY W $FN((KMPUSTRT/DIV),"",DEC1),!
 F DY=13:-1:4 D 
 .S DX=(9-$L($FN((NUM/DIV),"",DEC1)))
 .X IOXY W $FN((NUM/DIV),"",DEC1),! S NUM=NUM+SCALE
 ; print data titles
 S ZDX=11,I=""
 F  S I=$O(@KMPUAR@(I)) Q:I=""  I $D(@KMPUAR@(I,0)) D 
 .S YTITLE=$E($P(@KMPUAR@(I,0),U),1,14),DX=ZDX
 .I KMPUOPT["A" F I1=1:1:8 S DY=14+I1 X IOXY W $E(YTITLE,I1),! S DX=DX+1
 .I KMPUOPT'["A" F I1=1:1:8 S DY=14+I1 X IOXY W $E(YTITLE,I1),!
 .S ZDX=ZDX+$S(KMPUOPT["D":2,1:1)
 Q

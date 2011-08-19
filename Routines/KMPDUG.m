KMPDUG ;OAK/RAK - CM Tools Graph Utility ;2/17/04  09:57
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
EN(KMPUAR,KMPUTI,KMPUOPT,KMPUSTRT,KMPUTAR,KMPUXIT,KMPUMAX) ;entry point
 ;-----------------------------------------------------------------------
 ; KMPUAR.. Local or global array (passed by value) that contains graph
 ;          information in the format:
 ;
 ;          KMPUAR(...,0)=DataTitle^DataValue
 ;                        piece 1 - the title of the data
 ;                        piece 2 - the actual value of the data
 ;
 ; KMPUTI.. graph titles in 4 up-arrow pieces
 ;          piece 1 - title of the graph 
 ;          piece 2 - second title of graph (if any)
 ;          piece 3 - x axis title
 ;          piece 4 - y axis title
 ;   
 ; KMPUOPT. (optional) A string of one or more letters representing
 ;          desired options.
 ;          "A" - angle titles (only for vertical graph)
 ;          "D" - double space
 ;          "G" - print grid across graph
 ;          "S" - display entries with MAX>9999 in scientific notation
 ;          "V" - display 'vertical' graph
 ;
 ; KMPUSTRT (optional). Number to start graph.
 ;          if KMPUSTRT=0 first hash mark of graph will equal 0
 ;
 ; KMPUTAR. (optional) Text array. Local or global array that 
 ;          contains text to be displayed with the graph.
 ;
 ;          Example:  KMPUTAR="UTIL($J,"
 ;                    KMPUTAR="^ASK(999999,23,10,"
 ;                    KMPUTAR="^TMP($J,""TEXT"","
 ;
 ; KMPUXIT. (optional) Exit without 'continue' text.  This allows the 
 ;          programmer to use their own display for continuing
 ;           0 - do not exit - display 'continue' text
 ;           1 - exit
 ;
 ; KMPUMAX. (optional) Maximum scale - if not defined, the maximum value
 ;          is determined from the data passed.  If KMPUMAX is defined,
 ;          scale will be adjusted accordingly.
 ;-----------------------------------------------------------------------
 ;
 I '$D(KMPUAR) W !!?7,"...no array data...",!! D CONT Q
 S KMPUSTRT=+$G(KMPUSTRT),KMPUOPT=$$UP^XLFSTR($G(KMPUOPT))
 S KMPUXIT=+$G(KMPUXIT),KMPUMAX=+$G(KMPUMAX)
 K:$G(KMPUTAR)="" KMPUTAR
 I '$D(@KMPUAR) D  Q
 .W *7,!!?7,"...no information to graph...",!!
 .D CONT
 S DTIME=$S($D(DTIME):DTIME,1:600)
 ;
 N BAR,BOTTOM,DATA,DEC,DEC1,DIV,DIVT,DNUM,DX,DY,END,GWIDTH,I,I1,LABEL,MAX
 N MIN,NUM,OFFSET,SCALE,STEP,TEXT,TITLE,X,XCOORD,XTITLE,YNUM,YTITLE,Z
 N IOBLC,IOBRC,IOBT,IOG1,IOG0,IOHL,IOLT,IOMT,IORT,IOTLC,IOTRC,IOTT,IOVL
 N IOINHI,IOINLOW,IORVOFF,IORVON,IOUOFF,IOUON
 ;
 D INIT^KMPDUG1 I KMPUOPT["D",(KMPUOPT'["V"),(YNUM>8) D  Q
 .W *7,!!?7,"...too many data elements to double space on a terminal"
 .W !?7,"   for a Horizontal Graph..."
 .W !!! D CONT
 I KMPUOPT["D",(KMPUOPT["V"),(YNUM>34) D  Q
 .W *7,!!?7,"...too many data elements to double space on a terminal"
 .W !?7,"   for a Vertical Graph..."
 .W !!! D CONT
 ; if not a terminal do printer routine
 I $E(IOST)'="C" Q  ;D EN^KMPUGP Q
 I $G(IOG1)']""!($G(IOG0)']"") D  Q
 .W *7,!!?7,"...unable to place terminal in graphics mode...",!!
 .D CONT
 I 'MAX D  Q
 .W *7,!!?7,"...unable to determine any data to graph or data all zeros...",!!
 .D CONT
 ; if 'vertical' graph
 I KMPUOPT["V" D EN^KMPDUGV Q
 ; draw graph - display titles - display data
 D DRAW^KMPDUG1,TITLES^KMPDUG1,DATA
 ; if text to display.
 I $D(KMPUTAR) D WP^KMPDU11(KMPUTAR,(BOTTOM+5),24) Q
 D:'KMPUXIT CONT
 Q
 ;
CONT ;-- hold screen
 S DX=(IOM-23\2),DY=(IOSL-1) X IOXY
 R "Press <RET> to continue",X:DTIME
 Q
 ;
DATA ;-- display data in graph.
 W IOG0 S DY=$S(KMPUOPT["D":1,1:2),BAR=0,I=""
 F  S I=$O(@KMPUAR@(I)) Q:I=""  I $D(@KMPUAR@(I,0)) S DATA=@KMPUAR@(I,0) D 
 .S XCOORD=$P(DATA,U,2),END=(XCOORD-KMPUSTRT-STEP)
 .S DX=16,DY=DY+$S(KMPUOPT["D":2,1:1)
 .;  if no data quit
 .Q:$P(@KMPUAR@(I,0),U,2)']""
 .F I1=0:STEP:END X IOXY W @BAR(BAR),! S DX=DX+1 Q:DX=68
 .;  print value in parenthesis
 .S DX=69 X IOXY W "<",$J((XCOORD/DIV),$L($FN((MAX/DIV),"",DEC)),DEC),">"
 .S BAR=$S(BAR=1:0,1:1)
 Q

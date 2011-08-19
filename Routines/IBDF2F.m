IBDF2F ;ALB/CJM - ENCOUNTER FORM - PRINT FORM(sends to printer) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,25**;APR 24, 1997
 ;
LNPRINT(IBPFID) ;prints the form
 ;IBPFID is the id for form tracking
 ;
 N CURY,CURX,NXTTXT,NXTX,LINE,NXTUL,PERPAGE,STRING,STARTY,PAGE
 S PAGE=1
 ;
 ;determine if simplex or duplex
 ;
 D
 .I IBFORM("PRINT_MODE")="DUPLEX_LONG",IBDEVICE("DUPLEX_LONG")]"" W IBDEVICE("DUPLEX_LONG") Q
 .I IBFORM("PRINT_MODE")="DUPLEX_SHORT",IBDEVICE("DUPLEX_SHORT")]"" W IBDEVICE("DUPLEX_SHORT") Q
 .I IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX") Q
 .I $Y W @IOF
 ;
 S PERPAGE=IBFORM("PAGE_HT")
 I 'PERPAGE!(PERPAGE>IOSL) S PERPAGE=IOSL
 S NXTUL=$O(@IBARRAY("UNDERLINES")@("")),NXTTXT=$O(@IBARRAY("TEXT")@(""))
 S STARTY=""
 S:NXTTXT'="" LINE=$G(@IBARRAY("TEXT")@(NXTTXT))
 ;
 ;want this rectangular fill area to apply to underlining
 W:IBDEVICE("PCL") $C(27)_"*c35G"
 ;
 D REGISTER^IBDF2F1(PAGE)
 F CURY=0:1 D  I NXTUL'>0,NXTTXT'>0 Q
 .I (CURY>0)&('(CURY#PERPAGE)) D
 ..I ((NXTTXT'="")!(NXTUL'="")) D
 ...D:IBDEVICE("GRAPHICS")&('IBDEVICE("PCL")) PGRPHCS(.STARTY,CURY)
 ...D:IBDEVICE("PCL") DRAW(.STARTY,CURY),WHITEOUT
 ...W:$G(IBDEVICE("TCP")) ! ;if TCP device must use ! to get to TOF
 ...W:'$G(IBDEVICE("TCP")) @IOF
 ...S PAGE=PAGE+1
 ...D REGISTER^IBDF2F1(PAGE)
 .E  I (CURY#PERPAGE) W !
 .I CURY=NXTTXT D
 ..S CURX=0,NXTX="" F  S NXTX=$O(@IBARRAY("CONTROLS")@(NXTTXT,NXTX)) Q:NXTX=""  D
 ...W $E(LINE,+CURX,NXTX),$$CTRLS^IBDFU($G(@IBARRAY("CONTROLS")@(NXTTXT,NXTX)),NXTX,NXTTXT#PERPAGE)
 ...S CURX=NXTX+1
 ..S STRING=$E(LINE,CURX,240) W:STRING'="" STRING
 ..S NXTTXT=$O(@IBARRAY("TEXT")@(NXTTXT)) S:NXTTXT LINE=$G(@IBARRAY("TEXT")@(NXTTXT))
 .I CURY=NXTUL D UNDRLINE
 ;
 ;draw stuff requiring graphics mode - obsoleted by PCL, if available
 D:IBDEVICE("GRAPHICS")&('IBDEVICE("PCL")) PGRPHCS(STARTY,0)
 ;
 ;draw boxes,bubbles, etc. that require PCL
 D:IBDEVICE("PCL") DRAW(STARTY,0),WHITEOUT
 ;
 W:'$G(IBDEVICE("TCP")) @IOF
 ;go back to simplex
 D
 .I IBFORM("PRINT_MODE")="DUPLEX_LONG",IBDEVICE("DUPLEX_LONG")]"",IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX") Q
 .I IBFORM("PRINT_MODE")="DUPLEX_SHORT",IBDEVICE("DUPLEX_SHORT")]"",IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX")
 ;
 ;set the printer for other stuff to print
 S X=IOM X $G(^%ZOSF("RM")) K X ;sets device to wrap
 ;set the printer to 132 col for everything else to print
 I IBDEVICE("PCL") D
 .W $C(27),"E"
 .I $G(IBDEVICE("RESET"))'="" W @IBDEVICE("RESET")
 .W $C(27),"(s0p16.67h8.5v0s0b0T",!,$C(27),"&l6C" S IOSL=80
 Q
 ;
UNDRLINE ;
 Q:IBDEVICE("CRT")
 N UL
 S UL=$G(@IBARRAY("UNDERLINES")@(NXTUL))
 I 'IBDEVICE("PCL") D
 .W:UL'="" $C(13),UL
 ;do it a bit differently if IBDEVICE("PCL")
 I IBDEVICE("PCL") D
 .W:UL'="" $C(13),$C(27)_"*v2t1n0O",UL,$C(27)_"*v0T"
 .;!!!!!!!!! with the area fill command - needed? see above
 .;W:UL'="" $C(13),$C(27)_"*c35G",$C(27)_"*v2t1n0O",UL,$C(27)_"*v0T"
 S NXTUL=$O(@IBARRAY("UNDERLINES")@(NXTUL))
 Q
PGRPHCS(STARTY,LASTY) ;print graphics - only for raster devices
 N DX,DY,GRPHCS,LINE
 W IOG1
 S (DX,DY)=0 X IOXY
 S LINE=STARTY F  S LINE=$O(@IBARRAY("GRAPHICS")@(LINE)) Q:(LINE="")!($G(LASTY)&(LINE'<LASTY))  D
 .S DX="" F  S DX=$O(@IBARRAY("GRAPHICS")@(LINE,DX)) Q:DX=""  S GRPHCS=$G(@IBARRAY("GRAPHICS")@(LINE,DX)),GRPHCS=$$GRPHCS^IBDFU(GRPHCS) I GRPHCS'="" S DY=LINE#PERPAGE W ! X IOXY W GRPHCS
 S STARTY=LASTY-1
 W IOG0
 Q
 ;
DRAW(STARTY,LASTY) ; draws the objects needing HP-GL/2 
 N ROW,COL,BLK,NODE,WIDTH,HT,IEN,PRNTTYPE,PWPARAM,FIPARAM
 W $C(27),"*p0x0Y"
 W $C(27),"*c5760x7200Y"
 W $C(27),"*c0T"
 W $C(27),"%1B"
 W "IN;SP1;"
 W "SC0,5760,7200,0;" ;sets up the coordinate system same as PCL
 W "AD3,16.6;" ;sets the alternate font for the labels
 ;
 ;draw bubbles
 ;W "PW.12;" ;set pen width to .12 mm, patch 3 value
 ;W "SV1,25;" ;set fill to 25%, patch 3 value
 S PWPARAM=$P($G(^IBD(357.09,1,0)),"^",13)
 I PWPARAM="" S PWPARAM=12
 S FIPARAM=$P($G(^IBD(357.09,1,0)),"^",14)
 I FIPARAM="" S FIPARAM=25
 W "PW."_PWPARAM_";" ;set pen width param to file value
 W "SV1,"_FIPARAM_";" ;set the fill to file value
 ;
 S ROW=STARTY
 F  S ROW=$O(@IBARRAY("BUBBLES")@(ROW)) Q:(ROW="")!($G(LASTY)&(ROW'<LASTY))  S COL="" F  S COL=$O(@IBARRAY("BUBBLES")@(ROW,COL)) Q:COL=""  D DRWBBL(ROW#PERPAGE,COL)
 ;
 ;draw boxes
 W "PW.4;" ;set pen width to .4 mm
 W "SV1,100;"  ;set the fill to 100%
 S ROW=STARTY
 F  S ROW=$O(@IBARRAY("BOXES")@(ROW)) Q:(ROW="")!($G(LASTY)&(ROW'<(LASTY)))  S COL="" F  S COL=$O(@IBARRAY("BOXES")@(ROW,COL)) Q:COL=""  S BLK=0 F  S BLK=$O(@IBARRAY("BOXES")@(ROW,COL,BLK)) Q:'BLK  D
 .S NODE=$G(@IBARRAY("BOXES")@(ROW,COL,BLK)) S WIDTH=$P(NODE,"^"),HT=$P(NODE,"^",2) D DRWBOX(ROW#PERPAGE,COL,WIDTH,HT)
 ;
 ;draw hand print fields
 ;W "PW.12;" ;set pen width to .12 mm, patch 3 value
 ;W "SV1,25;" ;set the fill to 25%, patch 3 value
 S PWPARAM=$P($G(^IBD(357.09,1,0)),"^",13)
 I PWPARAM="" S PWPARAM=12
 S FIPARAM=$P($G(^IBD(357.09,1,0)),"^",14)
 I FIPARAM="" S FIPARAM=25
 W "PW."_PWPARAM_";" ;set pen width param to file value
 W "SV1,"_FIPARAM_";" ;set the fill to file value
 ;
 S ROW=STARTY
 F  S ROW=$O(@IBARRAY("HAND_PRINT")@(ROW)) Q:(ROW="")!($G(LASTY)&(ROW'<LASTY))  S COL="" F  S COL=$O(@IBARRAY("HAND_PRINT")@(ROW,COL)) Q:COL=""  S IEN=0 F  S IEN=$O(@IBARRAY("HAND_PRINT")@(ROW,COL,IEN)) Q:'IEN  D
 .S NODE=$G(@IBARRAY("HAND_PRINT")@(ROW,COL,IEN)),WIDTH=+$P(NODE,"^",3),PRNTTYPE=$P(NODE,"^",14) Q:('WIDTH)!('PRNTTYPE)
 .D HANDPRNT(ROW#PERPAGE,COL,WIDTH,$P(NODE,"^",6),PRNTTYPE,$P(NODE,"^",17))
 ;
 S STARTY=LASTY-1
 W $C(27),"%0A"
 Q
 ;
DRWBBL(Y,X) ;
 ; -- position is in terms of col,row - change to decipoints
 S Y=(Y*IBDEVICE("ROW_HT"))+$S(IBFORM("WIDTH")>96:20,IBFORM("WIDTH")>80:30,1:40),X=(X+$S(IBFORM("WIDTH")>96:.5,IBFORM("WIDTH")>80:.75,1:1))*IBDEVICE("COL_WIDTH")
 ;
 ; -- position the pen
 W "PA"_(X)_","_(Y)_";"
 ;
 ; -- draw the bubble (a little box)
 W "EA"_(X+87)_","_(Y+45)_";"
 Q
 ;
DRWBOX(Y,X,WIDTH,HT) ;
 ; -- position is in terms of col,row - change to decipoints
 S Y=((Y+.75)*IBDEVICE("ROW_HT"))+15,X=(X+.5)*IBDEVICE("COL_WIDTH")
 ;
 ;position the pen
 W "PA"_(X)_","_(Y)_";"
 ;
 ;draw the box
 W "EA"_(X+((WIDTH-1)*IBDEVICE("COL_WIDTH")))_","_(Y+((HT-1.7)*IBDEVICE("ROW_HT")))_";"
 Q
 ;
HANDPRNT(Y,X,WIDTH,LINES,PRNTTYPE,TYPEDATA) ; draw hand print area
 ; -- FORMAT - contains overlay for the field
 ; -- UNIT - label to print on the right of print area
 ; -- PRNTTYPE = could be for ICR (print comb) or not ICR (no comb, different size)
 N CHAR,FORMAT,UNIT,NODE
 S NODE=""
 I $G(TYPEDATA) S NODE=$G(^IBE(359.1,TYPEDATA,0))
 ;S FORMAT=$$FRMT(NODE,$G(IBAPPT)),UNIT=$P(NODE,"^",11) ;don't use frmt here, cause pre-slugging of data and read when scanning
 S FORMAT=$P(NODE,"^",5),UNIT=$P(NODE,"^",11)
 S:LINES'>0 LINES=1
 I PRNTTYPE=2 D
 .;change scale from col,row to decipoints
 .S Y=(Y*IBDEVICE("ROW_HT"))+$S(IBFORM("WIDTH")>96:0,IBFORM("WIDTH")>80:15,1:30),X=X*IBDEVICE("COL_WIDTH")
 .F  Q:LINES'>0  D  S LINES=LINES-1,Y=Y+(2*IBDEVICE("ROW_HT"))
 ..;position the pen
 ..W !,"PA"_(X)_","_(Y)_";"
 ..;draw the box
 ..W "EA"_(X+(172.7654*WIDTH))_","_(Y+(180))_";"
 ..;print the unit of measurement
 ..I $L(UNIT) W "SA;","PA"_(X+50+(172.7654*WIDTH))_",",(Y+(120))_";","LB",UNIT,$CHAR(3),"SS;"
 ..;draw the comb
 ..N I F I=1:1:WIDTH-1 W "PA"_(X+(172.7654*I))_",",(Y+(180))_";PD;PR0,-180;PU" S CHAR=$E(FORMAT,I+1) I CHAR'="",CHAR'="_" D
 ...;character pre-slug
 ...W !,"PA"_(X+50+(172.7654*I))_",",(Y+(120))_";"
 ...W "LB",CHAR,$CHAR(3)
 ;
 I PRNTTYPE=1 D
 .;change scale from col,row to decipoints
 .S Y=(Y*IBDEVICE("ROW_HT")),X=X*IBDEVICE("COL_WIDTH")
 .D CNVRTHT^IBDF2D1(LINES,.LINES)
 .;position the pen
 .W "PA"_(X)_","_(Y)_";"
 .;draw the box
 .W "EA"_(X+(103.6593*WIDTH))_","_(Y+(IBDEVICE("ROW_HT")*LINES))_";"
 Q
 ;
FRMT(ND,ADT) ; -- function returns piece 5 on entries from 359.1
 ; -- reformats the Checkout/date format for y2k
 ; -- input    nd  := zero node from 359.1 for entry
 ;            adt  := alternate date (appointment date, when known)
 N FRMT
 S FRMT=$P(ND,"^",5)
 I $P(ND,"^")="CHECKOUT DATE@TIME" S $E(FRMT,5)=$S($G(ADT):$E(ADT,2),1:$E(DT,2))
 Q FRMT
 ;
WHITEOUT ; -- puts white space around the anchors
 ;            helps insure that the anchors can be located
 ;
 Q:'IBFORM("SCAN")  ;if the form isn't scannable there are no anchors
 ;
 W $C(27),"&a0v0H",! ;set top margin to top of page
 W $C(27),"&l0E"
 ;
 ; -- top left corner (ANCHOR 1)
 W $C(27),"&a354v4H",$C(27),"*c200h60v1P"
 ;
 ; -- bottom left (ANCHOR 2)
 W $C(27),"&a7505v4H",$C(27),"*c200h60v1P"
 ;
 ; -- top right (ANCHOR 3)
 W $C(27),"&a354v5450H",$C(27),"*c400h60v1P"
 ;
 ; -- bottom right (ANCHOR 4)
 W $C(27),"&a7505v5450H",$C(27),"*c400h60v1P"
 Q

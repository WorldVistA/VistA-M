IBDF2D1 ;ALB/CJM - ENCOUNTER FORM - PRINT SELECTION LIST (cont'd) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
GETCOL(COL) ;finds next column
 ;COL - array where output data stored,SHOULD BE PASSED BY REFERENCE
 ;COL=last column number processed
 ;COL("Y")=columns starting row relative to block
 ;COL("X")=column's starting column relative to block
 ;COL("H")=column's height, i.e., maximum # of selections
 ;
 S COL=$G(COL)+1
 S NEEDUPR=0
 I COL=1 S COL("H")=+IBLIST("H",1),COL("X")=+IBLIST("X",1),COL("Y")=+IBLIST("Y",1)
 I COL>IBLIST("NUMCOL") S COL=0 Q
 I $G(IBLIST("Y",COL))'=+$G(IBLIST("Y",COL)) D
 .I COL=1 S COL("Y")=$S(IBBLK("HDR")="":BOX,1:2+BOX)
 .I COL'=1 Q  ;leave value from prior col
 E  S COL("Y")=$G(IBLIST("Y",COL))
 I $G(IBLIST("X",COL))'=+$G(IBLIST("X",COL)) D
 .Q:COL=1
 .S COL("X")=COL("X")+CWIDTH+$S(IBLIST("SEP")=" ":2,IBLIST("SEP")="  ":4,1:0)
 E  S COL("X")=$G(IBLIST("X",COL))
 I $G(IBLIST("H",COL))'=+$G(IBLIST("H",COL)) D
 .I COL=1 S COL("H")=IBBLK("H")
 .I COL'=1 Q  ;leave value from prior col
 E  S COL("H")=$G(IBLIST("H",COL))
 I BOX,'LINE,COL("X")=0 S COL("X")=1
 I (COL("X")+CWIDTH+(('LINE)&BOX))>IBBLK("W") S COL=0 Q
 I (COL("Y")+COL("H"))>(IBBLK("H")-(2*BOX)) S COL("H")=(IBBLK("H")-(COL("Y")+BOX))
 S COL("ROWSLEFT")=COL("H"),COL("NEXTROW")=0
 Q
 ;
DRWCOL(COL) ;draws one column of the selection list except for its contents and rows
 N I,OFFSET,WIDTH
 I LINE,(COL("X")'=0)!('BOX),ALL D DRWVLINE^IBDFU($$Y^IBDF2D,$$X^IBDF2D,COL("H"),"|")
 I LINE,('BOX)!(COL("X")+CWIDTH'=IBBLK("W")),ALL D DRWVLINE^IBDFU($$Y^IBDF2D,$$X^IBDF2D+(CWIDTH-1),COL("H"),"|")
 ;
 ;draw the column header
 I IBLIST("HDR")'="",(COL("ROWSLEFT")>0) D:ALL  D DECREASE^IBDF2D(.COL)
 .S IBLIST("DHDR")=$TR(IBLIST("DHDR"),"RS","rs")
 .;only affects forms with big print - bold otherwise not available
 .I (IBLIST("DHDR")["s")!(IBLIST("DHDR")["r"),IBLIST("DHDR")'["B",IBFORM("WIDTH")<100 S IBLIST("DHDR")=IBLIST("DHDR")_"B"
 .I IBFORM("WIDTH")>100 S IBLIST("DHDR")=$TR(IBLIST("DHDR"),"B")
 .;
 .S WIDTH=CWIDTH-(2*LINE)
 .S OFFSET=LINE
 .I IBLIST("DHDR")["C",$L(IBLIST("HDR"))<WIDTH S OFFSET=OFFSET+((WIDTH-$L(IBLIST("HDR")))\2)
 .D DRWSTR^IBDFU($$Y^IBDF2D,($$X^IBDF2D)+LINE,$J("",OFFSET)_IBLIST("HDR"),$TR(IBLIST("DHDR"),"C",""),WIDTH)
 ;
 ;draw the header line for the subcolumns
 I COL("ROWSLEFT")>0,IBLIST("CHDR")]"" D:ALL  D DECREASE^IBDF2D(.COL)
 .S IBLIST("DSCHDR")=$TR(IBLIST("DSCHDR"),"R","r")
 .;only affects forms with big print - bold otherwise not available
 .I IBLIST("DSCHDR")["r",IBLIST("DSCHDR")'["B",IBFORM("WIDTH")<100 S IBLIST("DSCHDR")=IBLIST("DSCHDR")_"B"
 .I IBFORM("WIDTH")>100 S IBLIST("DSCHDR")=$TR(IBLIST("DSCHDR"),"B")
 .;
 .;apply options across entire line?
 .;if nothing else applies uderline SCs (maybe)
 .I IBLIST("ULSLCTNS")!LINE!(BOX&(CWIDTH>(IBBLK("W")-3-(2*(IBLIST("SEP1")))))) D  Q
 ..I IBLIST("DSCHDR")="",IBLIST("ULSLCTNS") S IBLIST("DSCHDR")=IBLIST("DSCHDR")_"U"
 ..D DRWSTR^IBDFU($$Y^IBDF2D,($$X^IBDF2D)+LINE,IBLIST("CHDR"),IBLIST("DSCHDR"),CWIDTH-(2*LINE))
 .;
 .;apply display options just to the text, not accross the column
 .I IBLIST("DSCHDR")="" S IBLIST("DSCHDR")="U"
 .F I=1-IBLIST("SC0"):1:8 I IBLIST("SCTYPE",I)'="",IBLIST("SCHDR",I)'="" D DRWSTR^IBDFU($$Y^IBDF2D,(($$X^IBDF2D)+IBLIST("SCOS",I)),IBLIST("SCHDR",I),IBLIST("DSCHDR"),$L(IBLIST("SCHDR",I)))
 Q
 ;
CNVRTHT(HPLINES,LINES) ;changes HPLINES=number of handprint lines into LINES=print lines on the page
 ;pass LINES by reference
 S LINES=$FN(1.5*HPLINES,"",0)
 Q
 ;
CNVRTLEN(HPWIDTH,WIDTH) ;changes HPWIDTH=width in terms of handprint characters into width in terms of columns(machine print characters)
 ;pass WIDTH by reference
 ;
 N COLWIDTH
 D
 .I IBFORM("WIDTH")>96 S COLWIDTH=720/16.67 Q
 .I IBFORM("WIDTH")>80 S COLWIDTH=60 Q
 .S COLWIDTH=72
 S WIDTH=$FN(.49+((HPWIDTH*103.65924)/COLWIDTH),"",0)
 Q
